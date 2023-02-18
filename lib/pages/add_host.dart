import 'package:docker_remote/isar/server.dart';
import 'package:docker_remote/providers/db.dart';
import 'package:docker_remote/providers/hosts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/link.dart';

class AddHostPage extends HookConsumerWidget {
  const AddHostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final isar = ref.watch(isarProvider);

    final name = useTextEditingController(text: "My Server");
    final host = useTextEditingController(text: "127.0.0.1");
    final port = useTextEditingController(text: "2375");

    final useTLS = useState(false);
    final caCert = useState(<int>[]);
    final clientCert = useState(<int>[]);
    final privateKey = useState(<int>[]);

    final sshUsername = useTextEditingController(text: "root");
    final sshPassword = useTextEditingController(text: "root");
    final sshPort = useTextEditingController(text: "22");

    return Scaffold(
      appBar: AppBar(title: const Text("Add Server")),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              TextFormField(
                controller: name,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? "Server name is required"
                    : null,
                decoration: const InputDecoration(
                  label: Text("Server Name"),
                  hintText: "My Server",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: host,
                      validator: (value) =>
                          (value == null || value.trim().isEmpty)
                              ? "Host is required"
                              : null,
                      decoration: const InputDecoration(
                        label: Text("Host"),
                        hintText: "127.0.0.1 / localhost",
                        alignLabelWithHint: true,
                      ),
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
                validator: (value) => (value == null ||
                        value.trim().isEmpty ||
                        int.tryParse(value) == null)
                    ? "Port is required and must be numeric"
                    : null,
                decoration: const InputDecoration(
                  label: Text("Docker Port"),
                  hintText: "2376",
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //SSH
              TextFormField(
                controller: sshUsername,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? "Username is required"
                    : null,
                decoration: const InputDecoration(
                  label: Text("SSH Username"),
                  hintText: "root",
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sshPassword,
                validator: (value) => (value == null || value.trim().isEmpty)
                    ? "Password is required"
                    : null,
                decoration: const InputDecoration(
                  label: Text("SSH Password"),
                  hintText: "root",
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: sshPort,
                validator: (value) => (value == null ||
                        value.trim().isEmpty ||
                        int.tryParse(value) == null)
                    ? "Port is required and must be numeric"
                    : null,
                decoration: const InputDecoration(
                  label: Text("SSH Port"),
                  hintText: "22",
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Checkbox(
                    value: useTLS.value,
                    onChanged: ((value) {
                      useTLS.value = value ?? false;
                      if (!useTLS.value) {
                        caCert.value = <int>[];
                        clientCert.value = <int>[];
                        privateKey.value = <int>[];
                      }
                    }),
                  ),
                  const Text("Use TLS (HTTPS)"),
                  Link(
                    uri: Uri.parse(
                        "https://docs.docker.com/engine/security/protect-access/"),
                    builder: (context, followLink) => IconButton(
                      onPressed: followLink,
                      icon: const Icon(Icons.info_outline_rounded),
                    ),
                    target: LinkTarget.blank,
                  )
                ],
              ),
              if (useTLS.value) ...[
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ["pem"],
                        withData: true,
                      );
                      if (result != null && result.count != 0) {
                        caCert.value = result.files.first.bytes ?? <int>[];
                      }
                    },
                    title: const Text("CA Certificate"),
                    subtitle: const Text("ca.pem"),
                    trailing: CircleAvatar(
                      radius: 8,
                      backgroundColor: caCert.value.isEmpty
                          ? Colors.grey
                          : Colors.greenAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ["pem"],
                        withData: true,
                      );
                      if (result != null && result.count != 0) {
                        clientCert.value = result.files.first.bytes ?? <int>[];
                      }
                    },
                    title: const Text("Client Certificate"),
                    subtitle: const Text("cert.pem"),
                    trailing: CircleAvatar(
                      radius: 8,
                      backgroundColor: clientCert.value.isEmpty
                          ? Colors.grey
                          : Colors.greenAccent,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ["pem"],
                        withData: true,
                      );
                      if (result != null && result.count != 0) {
                        privateKey.value = result.files.first.bytes ?? <int>[];
                      }
                    },
                    title: const Text("Private Key"),
                    subtitle: const Text("key.pem"),
                    trailing: CircleAvatar(
                      radius: 8,
                      backgroundColor: privateKey.value.isEmpty
                          ? Colors.grey
                          : Colors.greenAccent,
                    ),
                  ),
                )
              ],
              const SizedBox(
                height: 10,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.cloud_done_rounded),
                    label: const Text("Save"),
                    onPressed: () async {
                      final nav = Navigator.of(context);
                      if (useTLS.value == true &&
                          (caCert.value.isEmpty ||
                              clientCert.value.isEmpty ||
                              privateKey.value.isEmpty)) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "All Certificates are required to use TLS")));
                        return;
                      }
                      if (formKey.currentState?.validate() ?? false) {
                        await isar?.writeTxn(() => isar.servers.put(
                              Server()
                                ..name = name.text
                                ..host = host.text
                                ..port = port.text
                                // Certificate Details
                                ..caCert = caCert.value
                                ..clientCert = clientCert.value
                                ..privateKey = privateKey.value
                                // SSH Details
                                ..sshUsername = sshUsername.text
                                ..sshPassword = sshPassword.text
                                ..sshPort = sshPort.text,
                            ));
                        nav.pop();
                      }
                    },
                  ),
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
