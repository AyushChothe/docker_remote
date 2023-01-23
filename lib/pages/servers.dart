import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/pages/add_host.dart';
import 'package:docker_remote/pages/dashboard.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServersPage extends HookConsumerWidget {
  const ServersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servers = ref.watch(getServersProvider);
    return Scaffold(
      appBar: AppBar(title: const Text("Servers")),
      body: servers.when(
        data: (servers) => servers.isEmpty
            ? const Center(
                child: Text("No Servers found"),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: () => ref.refresh(getServersProvider.future),
                  child: ListView.builder(
                    itemCount: servers.length,
                    itemBuilder: (context, i) => ServerTile(server: servers[i]),
                  ),
                ),
              ),
        error: (e, _) => Center(child: Text(e.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const AddHostPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ServerTile extends StatelessWidget {
  const ServerTile({
    Key? key,
    required this.server,
  }) : super(key: key);

  final Server server;

  @override
  Widget build(BuildContext context) {
    final overrides = [
      if (server.caCert.isNotEmpty &&
          server.clientCert.isNotEmpty &&
          server.privateKey.isNotEmpty) ...[
        baseUrlProvider
            .overrideWithValue("https://${server.host}:${server.port}"),
        certProvider.overrideWith((ref) => {
              "rootCACertificate": server.caCert,
              "clientCertificate": server.clientCert,
              "privateKey": server.privateKey,
            })
      ] else
        baseUrlProvider
            .overrideWithValue("http://${server.host}:${server.port}"),
    ];
    return ProviderScope(
      overrides: overrides,
      child: Consumer(builder: (context, ref, __) {
        final isar = ref.watch(isarProvider);
        final getVersion = ref.watch(getVersionProvider.future);
        return Card(
          child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.cloud_rounded)),
              onTap: () async {
                try {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Connecting"),
                    duration: Duration(seconds: 1),
                  ));

                  await getVersion;

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProviderScope(
                          overrides: overrides, child: const DashboardPage()),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Failed to connect to Server")));
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
              title: Text(server.name ?? "Name"),
              subtitle: Text("${server.host}:${server.port}"),
              trailing: FutureBuilder(
                future: getVersion,
                builder: (context, snap) {
                  if (snap.hasError) {
                    return const CircleAvatar(
                      maxRadius: 6,
                      backgroundColor: Colors.redAccent,
                    );
                  } else if (snap.hasData) {
                    return Chip(
                      labelPadding: EdgeInsets.zero,
                      avatar: const CircleAvatar(
                        maxRadius: 6,
                        backgroundColor: Colors.greenAccent,
                      ),
                      label: Text(
                        "v${snap.data?.data["Version"]}",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    );
                  } else {
                    return const CircleAvatar(
                      maxRadius: 6,
                      backgroundColor: Colors.grey,
                    );
                  }
                },
              )),
        );
      }),
    );
  }
}
