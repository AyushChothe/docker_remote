import 'package:docker_remote/pages/exec.dart';
import 'package:docker_remote/pages/logs.dart';
import 'package:docker_remote/providers/container.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainersPage extends HookConsumerWidget {
  const ContainersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getContainers = ref.watch(getContainersProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getContainersProvider.future),
        child: getContainers.when(
          data: (containers) => ListView.builder(
            itemCount: containers.length + 1,
            itemBuilder: (context, i) => i == containers.length
                ? Center(
                    child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${containers.length} Containers"),
                  ))
                : Card(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ProviderScope(overrides: [
                                containerProvider
                                    .overrideWithValue(containers[i])
                              ], child: const LogsPage()),
                            ),
                          ),
                          leading: const CircleAvatar(
                              child: Icon(Icons.view_in_ar_rounded)),
                          title: Text(containers[i].names?[0] ?? "Name"),
                          subtitle: Text(containers[i].image ?? "Image"),
                          trailing: Chip(
                            label: Text(
                                (containers[i].state ?? "State").toUpperCase()),
                          ),
                        ),
                        const Divider(height: 0),
                        ButtonBar(
                          alignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (containers[i].state?.toUpperCase() != "RUNNING")
                              TextButton.icon(
                                  onPressed: () async {
                                    await containers[i].start();
                                    return ref
                                        .refresh(getContainersProvider.future);
                                  },
                                  icon: const Icon(Icons.play_arrow_outlined),
                                  label: const Text("Start"))
                            else ...[
                              TextButton.icon(
                                  onPressed: () async {
                                    await containers[i].stop();
                                    return ref
                                        .refresh(getContainersProvider.future);
                                  },
                                  icon: const Icon(Icons.stop_outlined),
                                  label: const Text("Stop")),
                              TextButton.icon(
                                  onPressed: () async {
                                    await containers[i].restart();
                                    return ref
                                        .refresh(getContainersProvider.future);
                                  },
                                  icon: const Icon(Icons.refresh_rounded),
                                  label: const Text("Restart"))
                            ]
                          ],
                        ),
                        if (containers[i].state?.toUpperCase() ==
                            "RUNNING") ...[
                          const Divider(
                            height: 0,
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ProviderScope(overrides: [
                                        containerProvider
                                            .overrideWithValue(containers[i])
                                      ], child: const ExecPage()),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.terminal_rounded),
                                label: const Text("Exec"),
                              ),
                            ],
                          )
                        ],
                      ],
                    ),
                  ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
