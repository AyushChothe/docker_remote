import 'package:common/providers/container.dart';
import 'package:common/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xterm/xterm.dart';

class LogsPage extends HookConsumerWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ref.watch(containerProvider);
    final logs = ref.watch(getLogs(container));
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(
            text: "Logs",
          ),
          TextSpan(
            text: " (${container?.names?[0]})",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ])),
      ),
      body: Center(
        child: logs.when(
            data: (logStream) {
              return StreamBuilder(
                stream: logStream,
                builder: (context, snap) {
                  if (snap.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TerminalView(
                            Terminal()
                              ..write(
                                  snap.data?.replaceAll("\n", "\n\r") ?? ""),
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
                    );
                  } else if (snap.hasError) {
                    return const Text("Something went wrong");
                  }
                  return const CircularProgressIndicator();
                },
              );
            },
            error: (e, _) => Text(e.toString()),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
