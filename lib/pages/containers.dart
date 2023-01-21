import 'package:docker_remote/pages/exec.dart';
import 'package:docker_remote/pages/logs.dart';
import 'package:docker_remote/providers/container.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainersPage extends HookConsumerWidget {
  const ContainersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossAxisCount =
        (MediaQuery.of(context).size.width / 400).floor().clamp(1, 2);
    final getContainers = ref.watch(getContainersProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getContainersProvider.future),
        child: getContainers.when(
          data: (containers) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.count(
              crossAxisCount: crossAxisCount,
              itemCount: containers.length,
              itemBuilder: (context, i) => Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProviderScope(overrides: [
                            containerProvider.overrideWithValue(containers[i])
                          ], child: const LogsPage()),
                        ),
                      ),
                      leading: const CircleAvatar(
                          child: Icon(Icons.view_in_ar_rounded)),
                      title: Text(containers[i].names?[0] ?? "Name"),
                      subtitle: Text(containers[i].image ?? "Image"),
                      trailing: Chip(
                        label: Text(
                          (containers[i].state ?? "State").toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                    ),
                    const Divider(height: 0),
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (containers[i].state?.toUpperCase() != "RUNNING")
                          OutlinedButton.icon(
                              onPressed: () async {
                                await processAPICall(
                                    context, () => containers[i].start());
                                return ref
                                    .refresh(getContainersProvider.future);
                              },
                              icon: const Icon(Icons.play_arrow_outlined),
                              label: const Text("Start"))
                        else ...[
                          OutlinedButton.icon(
                              onPressed: () async {
                                await processAPICall(
                                    context, () => containers[i].stop());
                                return ref
                                    .refresh(getContainersProvider.future);
                              },
                              icon: const Icon(Icons.stop_outlined),
                              label: const Text("Stop")),
                          OutlinedButton.icon(
                              onPressed: () async {
                                await processAPICall(
                                    context, () => containers[i].restart());
                                return ref
                                    .refresh(getContainersProvider.future);
                              },
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text("Restart")),
                          OutlinedButton.icon(
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
                        ]
                      ],
                    ),
                    // Port Mappings
                    if (containers[i].ports?.isNotEmpty ?? false) ...[
                      const Divider(
                        height: 0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: (containers[i]
                                  .ports
                                  ?.map(
                                    (port) => Chip(
                                      label: Text(
                                          "${port.ip}:${port.publicPort}→${port.privatePort}/${port.type}"),
                                    ),
                                  )
                                  .toList() ??
                              []),
                        ),
                      )
                    ]
                  ],
                ),
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
