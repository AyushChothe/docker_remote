import 'package:docker_remote/isar/server.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:isar/isar.dart';

final isarProvider = Provider<Isar?>((ref) => null);

final getServersProvider = StreamProvider.autoDispose<List<Server>>((ref) {
  final isar = ref.watch(isarProvider);
  return isar?.servers.where().build().watch(fireImmediately: true) ??
      const Stream.empty();
});
