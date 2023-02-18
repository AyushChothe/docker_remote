import 'package:docker_remote/models/docker_compose.dart';
import 'package:docker_remote/models/docker_container.dart';
import 'package:docker_remote/pages/docker_compose_ui.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/utils/docker_compose_utils.dart';
import 'package:docker_remote/widgets/container_tile.dart';
import 'package:docker_remote/widgets/docker_compose_button.dart';
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
                DockerComposeStack stack = stacks[i];
                List<DockerContainer> containers = stack.containers;
                return Card(
                  child: ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.layers_outlined)),
                    title: Text("${stack.composeProject}"),
                    subtitle: Text("${stack.composeWorkingDir}"),
                    trailing: Chip(label: Text("v${stack.composeVersion}")),
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DockerComposeButton(
                            stack: stack,
                            cmd: DC_UP,
                            text: "Up",
                            iconData: Icons.arrow_upward_rounded,
                          ),
                          DockerComposeButton(
                            stack: stack,
                            cmd: DC_STOP,
                            text: "Stop",
                            iconData: Icons.arrow_downward_rounded,
                          ),
                          DockerComposeButton(
                            stack: stack,
                            cmd: DC_BUILD,
                            text: "Build",
                            iconData: Icons.restart_alt_rounded,
                          ),
                        ],
                      ),
                      const Divider(
                        height: 0,
                      ),
                      for (DockerContainer container in containers)
                        ContainerTile(
                          container: container,
                          isCompose: true,
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
