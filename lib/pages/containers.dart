import 'package:docker_remote/models/docker_container.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/widgets/container_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainersPage extends HookConsumerWidget {
  const ContainersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crossAxisCount =
        (MediaQuery.of(context).size.width / 400).floor().clamp(1, 2);
    final getComposeStacks = ref.watch(getComposeContainersProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getComposeContainersProvider.future),
        child: getComposeStacks.when(
          data: (stacks) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: MasonryGridView.count(
              crossAxisCount: crossAxisCount,
              itemCount: stacks.length,
              itemBuilder: (context, i) => Builder(builder: (context) {
                if (stacks[i] is DockerContainer) {
                  final container = stacks[i] as DockerContainer;
                  return ContainerTile(container: container);
                }
                List<DockerContainer> containers = stacks[i].containers;
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const CircleAvatar(
                            child: Icon(Icons.layers_outlined)),
                        title: Text("${stacks[i].composeProject}"),
                        subtitle: Text("${stacks[i].composeWorkingDir}"),
                        trailing:
                            Chip(label: Text("v${stacks[i].composeVersion}")),
                      ),
                      const Divider(
                        height: 0,
                      ),
                      ListView.builder(
                        itemCount: containers.length,
                        shrinkWrap: true,
                        itemBuilder: (context, i) => ContainerTile(
                          container: containers[i],
                        ),
                      ),
                    ],
                  ),
                );
              }),
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
