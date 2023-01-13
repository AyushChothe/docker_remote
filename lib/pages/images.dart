import 'package:date_format/date_format.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/utils/utils.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagesPage extends HookConsumerWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getImages = ref.watch(getImagesProvider);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getImagesProvider.future),
        child: getImages.when(
          data: (images) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: images.length + 1,
              itemBuilder: (context, i) => i == images.length
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${images.length} Images"),
                    ))
                  : Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                                child: Icon(Icons.map_rounded)),
                            title: Text(images[i].repoTags?[0] ?? "<none>"),
                            subtitle: Text(formatDate(
                              DateTime.fromMillisecondsSinceEpoch(
                                  (images[i].created ?? 0) * 1000),
                              [dd, "-", mm, "-", yyyy],
                            )),
                            trailing: Chip(
                                label: Text(filesize(images[i].size ?? 0))),
                          ),
                          const Divider(
                            height: 0,
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () async {
                                  await processAPICall(
                                      context, () => images[i].deleteImage());

                                  return ref.refresh(getImagesProvider.future);
                                },
                                icon: const Icon(Icons.delete_outline_rounded),
                                label: const Text("Delete"),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
            ),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
