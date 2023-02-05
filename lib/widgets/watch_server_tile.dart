import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WatchServerTile extends HookConsumerWidget {
  const WatchServerTile({
    Key? key,
    required this.server,
  }) : super(key: key);

  final Server server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final isHttps = baseUrl.startsWith("https://");
    final getVersion = ref.watch(getVersionProvider.future);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: ListTile(
          onTap: () async {
            ref.invalidate(getVersionProvider);
          },
          title: Text.rich(TextSpan(children: [
            TextSpan(text: server.name ?? "Name"),
            const WidgetSpan(
                child: SizedBox(
              width: 4,
            )),
            WidgetSpan(
              child: Icon(
                isHttps ? Icons.https_rounded : Icons.lock_open_rounded,
                size: 12,
                color: isHttps ? Colors.greenAccent : Colors.redAccent,
              ),
              alignment: PlaceholderAlignment.middle,
            )
          ])),
          subtitle: Text("${server.host}:${server.port}"),
          trailing: FutureBuilder(
            future: getVersion,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.grey,
                );
              } else if (snap.hasData) {
                return const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.greenAccent,
                );
              } else {
                return const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.redAccent,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
