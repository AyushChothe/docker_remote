import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:docker_remote/models/docker_container.dart';
import 'package:docker_remote/models/docker_image.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getImagesProvider = FutureProvider((ref) async {
  final dio = await ref.watch(dioProvider.future);
  Response res = await dio.get('/images/json');
  List<DockerImage> images = (res.data as List<dynamic>)
      .map((e) => DockerImage.fromJson(e as Map<String, dynamic>, dio))
      .toList();
  images.sort(
    (a, b) => b.created?.compareTo(a.created!) ?? 0,
  );
  return images;
}, dependencies: [dioProvider]);

final getContainersProvider = FutureProvider((ref) async {
  final dio = await ref.watch(dioProvider.future);
  Response res =
      await dio.get('/containers/json', queryParameters: {"all": true});
  List<DockerContainer> containers = (res.data as List<dynamic>)
      .map((e) => DockerContainer.fromJson(e as Map<String, dynamic>, dio))
      .toList();
  containers.sort((a, b) => b.status?.compareTo(a.status!) ?? 0);
  return containers;
}, dependencies: [dioProvider]);

final getLogs = FutureProvider.autoDispose.family((ref, DockerContainer? arg) =>
    arg?.logs() ?? Future.value(const Stream<String>.empty()));

final getVersionProvider = FutureProvider.autoDispose((ref) async {
  final dio = await ref.watch(dioProvider.future);
  return await dio.get('/version');
}, dependencies: [dioProvider]);

final pullImage = FutureProvider.family.autoDispose((ref, String image) async {
  try {
    final dio = await ref.watch(dioProvider.future);
    final res = (((await dio.post(
      "/images/create",
      queryParameters: {
        "fromImage": image,
      },
      options: Options(
        responseType: ResponseType.stream,
      ),
    ))
                .data as ResponseBody)
            .stream)
        .map(String.fromCharCodes)
        .map((e) {
      List<String> stats = e.split("\n");
      List<String> status = [];
      for (String stat in stats) {
        try {
          if (stat.trim().isNotEmpty) {
            final out = jsonDecode(stat) as Map<String, dynamic>;
            String str = out["status"];
            if (out.containsKey("progress")) {
              str += "\n\r" "${out["progress"]}";
            }
            status.add(str);
          }
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      return "${status.join('\n\r')}\n\r";
    }).asBroadcastStream();
    return res;
  } on DioError {
    return Future.error("Something went wrong");
  } catch (e) {
    debugPrint(e.toString());
  }
  return Future.value(const Stream.empty());
}, dependencies: [dioProvider]);
