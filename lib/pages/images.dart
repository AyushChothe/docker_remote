import 'package:date_format/date_format.dart';
import 'package:docker_remote/pages/pull_image.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:docker_remote/utils/utils.dart';
import 'package:filesize/filesize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ImagesPage extends HookConsumerWidget {
  const ImagesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final getImages = ref.watch(getImagesProvider);
    final crossAxisCount =
        (MediaQuery.of(context).size.width / 400).floor().clamp(1, 2);

    final imageNameCtrl = useTextEditingController(text: "hello-world:latest");
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getImagesProvider.future),
        child: Center(
          child: getImages.when(
            data: (images) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                crossAxisCount: crossAxisCount,
                itemCount: images.length,
                itemBuilder: (context, i) => Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading:
                            const CircleAvatar(child: Icon(Icons.map_rounded)),
                        title: Text(
                          images[i].repoTags?[0] ?? "<none>",
                        ),
                        subtitle: Text(formatDate(
                          DateTime.fromMillisecondsSinceEpoch(
                              (images[i].created ?? 0) * 1000),
                          [dd, "-", mm, "-", yyyy],
                        )),
                        trailing: Chip(
                          label: Text(filesize(images[i].size ?? 0),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                        ),
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
                                  context, () => images[i].deleteImage(),
                                  confirmation: true);

                              return ref.refresh(getImagesProvider.future);
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                            label: const Text("Remove"),
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
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
              context: context,
              builder: (_) => SimpleDialog(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: imageNameCtrl,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                                ? "Image name is required"
                                : null,
                        decoration: const InputDecoration(
                          label: Text("Image"),
                          hintText: "hello-world:latest",
                          alignLabelWithHint: true,
                        ),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        child: const Text("Cancel"),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.download_rounded),
                        label: const Text("Pull Image"),
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            Navigator.pop(context);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ProviderScope(
                                parent: ProviderScope.containerOf(context),
                                child: PullImagePage(
                                  imageName: imageNameCtrl.text,
                                ),
                              ),
                            ));
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          },
          child: const Icon(Icons.add)),
    );
  }
}
