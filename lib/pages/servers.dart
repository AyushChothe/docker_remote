import 'package:dartssh2/dartssh2.dart';
import 'package:docker_remote/models/docker_certs.dart';
import 'package:docker_remote/pages/add_host.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/widgets/server_tile.dart';
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
                    itemBuilder: (context, i) {
                      final server = servers[i];
                      return ProviderScope(overrides: [
                        if (server.caCert.isNotEmpty &&
                            server.clientCert.isNotEmpty &&
                            server.privateKey.isNotEmpty)
                          baseUrlProvider.overrideWithValue(
                              "https://${server.host}:${server.port}")
                        else
                          baseUrlProvider.overrideWithValue(
                              "http://${server.host}:${server.port}"),
                        certProvider.overrideWithValue(DockerCerts(
                          rootCACertificate: server.caCert,
                          clientCertificate: server.clientCert,
                          privateKey: server.privateKey,
                        )),
                        if (server.sshUsername != null &&
                            server.sshPassword != null &&
                            server.sshPort != null)
                          sshClientProvider.overrideWith(
                            (ref) async => SSHClient(
                              await SSHSocket.connect(
                                server.host!,
                                int.parse(server.sshPort!),
                                timeout: const Duration(seconds: 5),
                              ),
                              username: server.sshUsername!,
                              onPasswordRequest: () => server.sshPassword,
                            ),
                          )
                      ], child: ServerTile(server: server));
                    },
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
