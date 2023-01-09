import 'package:docker_remote/pages/containers.dart';
import 'package:docker_remote/pages/images.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                },
                icon: const Icon(Icons.refresh_rounded))
          ],
          bottom: const TabBar(tabs: [
            Tab(
              child: Text("Images"),
            ),
            Tab(
              child: Text("Containers"),
            )
          ]),
        ),
        body: const TabBarView(children: [ImagesPage(), ContainersPage()]),
      ),
    );
  }
}
