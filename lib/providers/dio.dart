import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final baseUrlProvider = Provider((_) => "https://127.0.0.1:2375");

final certProvider = FutureProvider((ref) async {
  ByteData rootCACertificate = await rootBundle.load("assets/ca.pem");
  ByteData clientCertificate = await rootBundle.load("assets/cert.pem");
  ByteData privateKey = await rootBundle.load("assets/key.pem");
  return {
    "rootCACertificate": rootCACertificate,
    "clientCertificate": clientCertificate,
    "privateKey": privateKey,
  };
});

final dioProvider = FutureProvider<Dio>((ref) async {
  final baseUrl = ref.watch(baseUrlProvider);
  // final certs = await ref.watch(certProvider.future);
  ByteData rootCACertificate = await rootBundle.load("assets/ca.pem");
  ByteData clientCertificate = await rootBundle.load("assets/cert.pem");
  ByteData privateKey = await rootBundle.load("assets/key.pem");
  final dio = Dio(BaseOptions(
    baseUrl: baseUrl,
  ));
  // if (baseUrl.startsWith("https://")) {
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    SecurityContext context = SecurityContext(withTrustedRoots: true);
    context.setTrustedCertificatesBytes(rootCACertificate.buffer.asUint8List());
    context.useCertificateChainBytes(clientCertificate.buffer.asUint8List());
    context.usePrivateKeyBytes(privateKey.buffer.asUint8List());
    HttpClient httpClient = HttpClient(context: context);

    return httpClient;
  };
  // }
  return dio;
}, dependencies: [baseUrlProvider, certProvider]);
