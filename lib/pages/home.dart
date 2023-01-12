import 'package:dio/dio.dart';
import 'package:docker_remote/pages/dashboard.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/hosts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hostname = useTextEditingController(text: "127.0.0.1");
    final port = useTextEditingController(text: "2375");

    return Scaffold(
      appBar: AppBar(title: const Text("Servers")),
      body: Center(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: hostname,
                      decoration:
                          const InputDecoration(hintText: "IP Address/Domain"),
                    ),
                  ),
                  IconButton(
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
                                                hostname.text = values[i].ip;
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                      icon: const Icon(Icons.wifi_find_rounded))
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
                    try {
                      final dio = Dio(
                        BaseOptions(
                          baseUrl: "http://${hostname.text}:${port.text}",
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Connecting"),
                        duration: Duration(seconds: 1),
                      ));
                      await dio.get('/version');

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProviderScope(
                            overrides: [dioProvider.overrideWithValue(dio)],
                            child: const DashboardPage(),
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Failed to connect to Server")));
                    }
                  },
                  child: const Text("Connect"))
            ]),
          ),
        ),
      ),
    );
  }
}
