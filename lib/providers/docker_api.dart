import 'package:dio/dio.dart';
import 'package:docker_remote/models/docker_container.dart';
import 'package:docker_remote/models/docker_image.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getImagesProvider = FutureProvider((ref) async {
  final dio = ref.watch(dioProvider);
  Response res = await dio.get('/images/json');
  List<DockerImage> images = (res.data as List<dynamic>)
      .map((e) => DockerImage.fromJson(e as Map<String, dynamic>))
      .toList();
  return images;
}, dependencies: [dioProvider]);

final getContainersProvider = FutureProvider((ref) async {
  final dio = ref.watch(dioProvider);
  Response res =
      await dio.get('/containers/json', queryParameters: {"all": true});
  List<DockerContainer> containers = (res.data as List<dynamic>)
      .map((e) => DockerContainer.fromJson(e as Map<String, dynamic>, dio))
      .toList();
  return containers;
}, dependencies: [dioProvider]);

final getLogs = FutureProvider.autoDispose.family((ref, DockerContainer? arg) =>
    arg?.logs() ?? Future.value(const Stream<List<int>>.empty()));
