import 'package:common/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../widgets/watch_listtile.dart';

class WatchContainerView extends HookConsumerWidget {
  const WatchContainerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getContainers = ref.watch(getContainersProvider);
    return Scaffold(
      body: getContainers.maybeWhen(
        data: (containers) => CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: 25),
            ),
            for (int i = 0; i < containers.length; i++)
              WatchListTile(
                fixedHeight: MediaQuery.of(context).size.height / 3.5,
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        containers[0].names?[0] ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        containers[0].image ?? "",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                )),
              ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 25),
            ),
          ],
        ),
        orElse: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
