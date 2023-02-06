import 'package:docker_remote/models/docker_container.dart';
import 'package:docker_remote/pages/exec.dart';
import 'package:docker_remote/pages/logs.dart';
import 'package:docker_remote/providers/container.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContainerTile extends HookConsumerWidget {
  const ContainerTile({
    super.key,
    required this.container,
  });

  final DockerContainer container;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Column(
        children: [
          ListTile(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => ProviderScope(
                    overrides: [containerProvider.overrideWithValue(container)],
                    child: const LogsPage()),
              ),
            ),
            leading: const CircleAvatar(child: Icon(Icons.view_in_ar_rounded)),
            title: Text(container.names?[0] ?? "Name"),
            subtitle: Text(container.image ?? "Image"),
            trailing: Chip(
              label: Text(
                (container.state ?? "State").toUpperCase(),
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
              if (container.state?.toUpperCase() != "RUNNING") ...[
                OutlinedButton.icon(
                    onPressed: () async {
                      await processAPICall(context, () => container.start());
                      return ref.refresh(getContainersProvider.future);
                    },
                    icon: const Icon(Icons.play_arrow_outlined),
                    label: const Text("Start")),
                OutlinedButton.icon(
                    onPressed: () async {
                      await processAPICall(context, () => container.remove(),
                          confirmation: true);
                      return ref.refresh(getContainersProvider.future);
                    },
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text("Remove"))
              ] else ...[
                OutlinedButton.icon(
                    onPressed: () async {
                      await processAPICall(context, () => container.stop(),
                          confirmation: true);
                      return ref.refresh(getContainersProvider.future);
                    },
                    icon: const Icon(Icons.stop_outlined),
                    label: const Text("Stop")),
                OutlinedButton.icon(
                    onPressed: () async {
                      await processAPICall(context, () => container.restart(),
                          confirmation: true);
                      return ref.refresh(getContainersProvider.future);
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text("Restart")),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProviderScope(overrides: [
                          containerProvider.overrideWithValue(container)
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
          if (container.ports?.isNotEmpty ?? false) ...[
            const Divider(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 5.0,
                runSpacing: 5.0,
                children: (container.ports
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
    );
  }
}
