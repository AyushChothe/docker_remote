import 'package:dio/dio.dart';
import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/pages/add_host.dart';
import 'package:docker_remote/pages/dashboard.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServersPage extends HookConsumerWidget {
  const ServersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
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
                    itemBuilder: (context, i) => Card(
                      child: ListTile(
                          leading: const CircleAvatar(
                              child: Icon(Icons.cloud_rounded)),
                          onTap: () async {
                            try {
                              final dio = Dio(
                                BaseOptions(
                                  baseUrl:
                                      "http://${servers[i].host}:${servers[i].port}",
                                ),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Connecting"),
                                duration: Duration(seconds: 1),
                              ));
                              // await dio.get('/version');

                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProviderScope(
                                    overrides: [
                                      baseUrlProvider.overrideWithValue(
                                          "https://${servers[i].host}:${servers[i].port}")
                                    ],
                                    child: const DashboardPage(),
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Failed to connect to Server")));
                            }
                          },
                          onLongPress: () => isar?.writeTxn(
                              () => isar.servers.delete(servers[i].id)),
                          title: Text(servers[i].name ?? "Name"),
                          subtitle:
                              Text("${servers[i].host}:${servers[i].port}"),
                          trailing: FutureBuilder(
                            future: Dio().get(
                                "http://${servers[i].host}:${servers[i].port}/version"),
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
                    ),
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
