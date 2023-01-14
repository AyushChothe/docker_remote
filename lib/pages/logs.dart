import 'package:docker_remote/providers/container.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LogsPage extends HookConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ref.watch(containerProvider);
    final logs = ref.watch(getLogs(container));
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(
            text: "Logs",
          ),
          TextSpan(
            text: " (${container?.names?[0]})",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ])),
      ),
      body: Center(
        child: logs.when(
            data: (logStream) {
              return StreamBuilder(
                stream: logStream,
                builder: (context, snap) {
                  if (snap.hasData) {
                    final logs = snap.data!
                        .split("\n")
                        .reversed
                        .where((e) => e.trim().isNotEmpty)
                        .toList();
                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, i) => i == 0
                          ? const LinearProgressIndicator()
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                                vertical: 2.0,
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                subtitle: Text("Line ${logs.length - i}"),
                                tileColor: Theme.of(context).primaryColorDark,
                                title: Text(logs[i - 1]),
                                dense: true,
                              ),
                            ),
                    );
                  } else if (snap.hasError) {
                    return const Text("Something went wrong");
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              );
            },
            error: (e, _) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
