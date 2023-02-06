import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/models/docker_certs.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/watch_connection.dart';
import 'package:docker_remote/widgets/watch_server_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WatchDashboardPage extends HookConsumerWidget {
  const WatchDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchConn = ref.watch(watchConnProvider);
    final serverTile = useStream(useMemoized(() => getServerStream(watchConn)));
    debugPrint("WatchDashboardPage Build");
    return Scaffold(body: Center(
      child: Builder(builder: (context) {
        if (serverTile.hasData) {
          final watchContext = serverTile.data!;
          debugPrint(watchContext["name"].toString());
          final Server server = Server()
            ..name = watchContext["name"]
            ..host = watchContext["host"]
            ..port = watchContext["port"];
          return ProviderScope(
            key: ValueKey(server.name),
            overrides: [
              baseUrlProvider.overrideWithValue(watchContext["baseUrl"]),
              certProvider.overrideWithValue(DockerCerts.fromJson(
                  Map<String, dynamic>.from(watchContext["certs"])))
            ],
            child: WatchServerTile(
              server: server,
            ),
          );
        }

        return const WatchStatus(
          msg: "Please select a Server",
        );
      }),
    ));
  }
}

class WatchStatus extends HookConsumerWidget {
  const WatchStatus({
    super.key,
    required this.msg,
  });

  final String msg;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchConn = ref.watch(watchConnProvider);
    final isSupported = useFuture(useMemoized(() => watchConn.isSupported));
    final isPaired = useFuture(useMemoized(() => watchConn.isPaired));
    final isReachable = useFuture(useMemoized(() => watchConn.isReachable));
    debugPrint("WatchStatus Build");
    return Center(
      child: ((isSupported.data ?? false) &&
              (isPaired.data ?? false) &&
              (isReachable.data ?? false))
          ? Text(msg)
          : Column(mainAxisSize: MainAxisSize.min, children: [
              Chip(
                avatar: CircleAvatar(
                  radius: 6,
                  backgroundColor: (isSupported.data ?? false)
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
                label: const Text("Watch Supported"),
              ),
              Chip(
                  avatar: CircleAvatar(
                    radius: 6,
                    backgroundColor: (isPaired.data ?? false)
                        ? Colors.greenAccent
                        : Colors.redAccent,
                  ),
                  label: const Text("Watch Paired")),
              Chip(
                avatar: CircleAvatar(
                  radius: 6,
                  backgroundColor: (isReachable.data ?? false)
                      ? Colors.greenAccent
                      : Colors.redAccent,
                ),
                label: const Text("Phone Reachable"),
              ),
            ]),
    );
  }
}
