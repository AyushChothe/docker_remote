import 'dart:async';

import 'package:common/isar/server.dart';
import 'package:common/providers/dio.dart';
import 'package:common/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../watch_pages/watch_images.dart';

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
    final getVersion = ref.watch(getVersionProvider);

    final images = ref.watch(getImagesProvider);
    final containers = ref.watch(getContainersProvider);

    useEffect(() {
      final timer = Timer.periodic(
          const Duration(seconds: 5), (_) => ref.refresh(getVersionProvider));
      return () {
        timer.cancel();
      };
    }, const []);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: ListTile(
              onTap: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ProviderScope(
                      parent: ProviderScope.containerOf(context),
                      child: const WatchContainerView(),
                    ),
                  ),
                );
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
              trailing: getVersion.when(
                data: (_) => const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.greenAccent,
                ),
                error: (_, __) => const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.redAccent,
                ),
                loading: () => const CircleAvatar(
                  maxRadius: 4,
                  backgroundColor: Colors.grey,
                ),
              ),
            ),
          ),
          getVersion.maybeWhen(
            data: (value) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Chip(
                    visualDensity: VisualDensity.comfortable,
                    avatar: const CircleAvatar(
                      child: Icon(
                        Icons.map_rounded,
                        size: 16,
                      ),
                    ),
                    label: Text("${images.value?.length ?? 0}")),
                Chip(
                  visualDensity: VisualDensity.comfortable,
                  avatar: const CircleAvatar(
                      child: Icon(
                    Icons.view_in_ar_rounded,
                    size: 16,
                  )),
                  label: Text("${containers.value?.length ?? 0}"),
                ),
              ],
            ),
            orElse: () => const SizedBox.shrink(),
          )
        ],
      ),
    );
  }
}
