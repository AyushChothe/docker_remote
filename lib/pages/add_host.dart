import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/hosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddHostPage extends HookConsumerWidget {
  const AddHostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isar = ref.watch(isarProvider);
    final name = useTextEditingController(text: "localhost");
    final host = useTextEditingController(text: "127.0.0.1");
    final port = useTextEditingController(text: "2375");

    return Scaffold(
      appBar: AppBar(title: const Text("Servers")),
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(hintText: "Server Name"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: host,
                      decoration:
                          const InputDecoration(hintText: "IP Address/Domain"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  Consumer(builder: (context, ref, _) {
                                final hosts = ref.watch(hostsProvider);
                                return Dialog(
                                  child: hosts.when(
                                    data: (values) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RefreshIndicator(
                                        onRefresh: () =>
                                            ref.refresh(hostsProvider.future),
                                        child: ListView.builder(
                                            itemCount: values.length,
                                            itemBuilder: (context, i) {
                                              return Card(
                                                child: ListTile(
                                                  onTap: () {
                                                    host.text = values[i].ip;
                                                    Navigator.pop(context);
                                                  },
                                                  title: Text(values[i].ip),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                    loading: () => const Center(
                                        child: CircularProgressIndicator()),
                                    error: (e, _) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(e.toString()),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                          icon: const Icon(Icons.wifi_find_rounded)),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: port,
                decoration: const InputDecoration(hintText: "Port"),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await isar?.writeTxn(() => isar.servers.put(Server()
                    ..name = name.text
                    ..host = host.text
                    ..port = port.text));
                  Navigator.pop(context);
                },
                child: const Text("Save"),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
