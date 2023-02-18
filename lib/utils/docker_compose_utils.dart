// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:docker_remote/models/command_data.dart';
import 'package:docker_remote/providers/dio.dart';
import 'package:docker_remote/providers/docker_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xterm/xterm.dart';

const DC = "docker compose";
const DC_UP = "up -d";
const DC_DOWN = "down";
const DC_STOP = "stop";
const DC_BUILD = "up -d --build";

final runCommandProvider =
    FutureProvider.family.autoDispose((ref, CommandData data) async {
  try {
    final client = await ref.watch(sshClientProvider.future);
    if (client == null) {
      return Future.error(Exception("SSH details not found!"));
    }
    final shell = await client.execute("$DC -f ${data.filePath} ${data.cmd}");
    Terminal term = Terminal();

    shell.stdout.listen((o) => term
        .write(utf8.decode(o, allowMalformed: true).replaceAll("\n", "\n\r")));
    shell.stderr.listen((e) => term
        .write(utf8.decode(e, allowMalformed: true).replaceAll("\n", "\n\r")));
    shell.done.whenComplete(() {
      ref.invalidate(getImagesProvider);
      ref.invalidate(getContainersProvider);
      ref.invalidate(getComposeContainersProvider);
    });

    return term;
  } on Exception catch (e) {
    return Future.error(e);
  }
}, dependencies: [sshClientProvider]);
