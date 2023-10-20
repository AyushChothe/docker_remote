import 'package:common/models/command_data.dart';
import 'package:common/utils/docker_compose_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xterm/xterm.dart';

class DockerComposeUI extends HookConsumerWidget {
  const DockerComposeUI({super.key, required this.filePath, required this.cmd});
  final String filePath, cmd;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pro = useMemoized(
        () => runCommandProvider(CommandData(filePath: filePath, cmd: cmd)));
    final getTerminal = ref.watch(pro);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        getTerminal.when(
          data: (terminal) => Expanded(
            child: Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TerminalView(
                  terminal,
                  backgroundOpacity: 0,
                  theme: TerminalThemes.whiteOnBlack,
                  textStyle: TerminalStyle(
                    fontFamily: GoogleFonts.firaCode().fontFamily!,
                  ),
                  readOnly: true,
                  cursorType: TerminalCursorType.underline,
                ),
              ),
            ),
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          error: (e, st) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              e.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
