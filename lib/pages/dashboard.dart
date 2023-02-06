// ignore_for_file: unused_result

import 'package:docker_remote/pages/containers.dart';
import 'package:docker_remote/pages/images.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getImages = ref.watch(getImagesProvider);
    final getContainers = ref.watch(getContainersProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Dashboard"),
          actions: [
            IconButton(
                onPressed: () {
                  ref.refresh(getImagesProvider.future);
                  ref.refresh(getContainersProvider.future);
                  ref.refresh(getComposeContainersProvider.future);
                },
                icon: const Icon(Icons.refresh_rounded))
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: getImages.maybeWhen(
                    data: (images) => Text("Images (${images.length})"),
                    orElse: (() => const Text("Images"))),
              ),
              Tab(
                child: getContainers.maybeWhen(
                    data: (containers) =>
                        Text("Containers (${containers.length})"),
                    orElse: (() => const Text("Containers"))),
              ),
            ],
          ),
        ),
        body: const TabBarView(children: [
          ImagesPage(),
          ContainersPage(),
        ]),
      ),
    );
  }
}
