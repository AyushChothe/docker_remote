import 'dart:io';

import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/pages/dashboard.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/providers/watch_connection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServerTile extends HookConsumerWidget {
  const ServerTile({
    Key? key,
    required this.server,
  }) : super(key: key);

  final Server server;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    final baseUrl = ref.watch(baseUrlProvider);
    final certs = ref.watch(certProvider);
    final isHttps = baseUrl.startsWith("https://");
    final getVersion = ref.watch(getVersionProvider);
    final watchConn = ref.watch(watchConnProvider);

    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.cloud_rounded)),
        onTap: () async {
          try {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Connecting"),
              duration: Duration(seconds: 1),
            ));

            final nav = Navigator.of(context);
            if (Platform.isAndroid) {
              await watchConn.updateApplicationContext({
                "name": server.name,
                "host": server.host,
                "port": server.port,
                "baseUrl": baseUrl,
                "certs": certs.toJson(),
              });
            }
            if (getVersion.hasError) throw getVersion.error!;
            nav.push(
              MaterialPageRoute(
                builder: (_) => ProviderScope(
                    parent: ProviderScope.containerOf(context),
                    child: const DashboardPage()),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Failed to connect to Server")));
          }
        },
        onLongPress: () async {
          final perform = (await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Are you sure?"),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("No")),
                OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Yes"))
              ],
            ),
          ));
          if (perform == true) {
            isar?.writeTxn(() => isar.servers.delete(server.id));
          }
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
              size: 15,
              color: isHttps ? Colors.greenAccent : Colors.redAccent,
            ),
            alignment: PlaceholderAlignment.middle,
          )
        ])),
        subtitle: Text("${server.host}:${server.port}"),
        trailing: getVersion.when(
          data: (snap) => Chip(
            labelPadding: EdgeInsets.zero,
            avatar: const CircleAvatar(
              maxRadius: 6,
              backgroundColor: Colors.greenAccent,
            ),
            label: Text(
              "v${snap.data["Version"]}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          error: (_, __) => const CircleAvatar(
            maxRadius: 6,
            backgroundColor: Colors.redAccent,
          ),
          loading: () => const CircleAvatar(
            maxRadius: 6,
            backgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
