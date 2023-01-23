import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final baseUrlProvider = Provider((_) => "https://127.0.0.1:2375");

final certProvider = FutureProvider((ref) async {
  List<int> rootCACertificate = [];
  List<int> clientCertificate = [];
  List<int> privateKey = [];
  return {
    "rootCACertificate": rootCACertificate,
    "clientCertificate": clientCertificate,
    "privateKey": privateKey,
  };
});

final dioProvider = FutureProvider<Dio>((ref) async {
  final baseUrl = ref.watch(baseUrlProvider);
  final certs = await ref.watch(certProvider.future);
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));
  if (baseUrl.startsWith("https://")) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      SecurityContext context = SecurityContext(withTrustedRoots: true);
      context.setTrustedCertificatesBytes(
          Uint8List.fromList(certs["rootCACertificate"]!));
      context.useCertificateChainBytes(
          Uint8List.fromList(certs["clientCertificate"]!));
      context.usePrivateKeyBytes(Uint8List.fromList(certs["privateKey"]!));
      HttpClient httpClient = HttpClient(context: context);

      // httpClient.badCertificateCallback =
      //     (X509Certificate cert, String host, int port) => true;

      return httpClient;
    };
  }
  return dio;
}, dependencies: [baseUrlProvider, certProvider]);
