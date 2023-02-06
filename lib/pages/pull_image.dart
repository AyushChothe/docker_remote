import 'package:docker_remote/providers/docker_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xterm/xterm.dart';

class PullImagePage extends HookConsumerWidget {
  const PullImagePage({super.key, this.imageName = "hello-world:latest"});
  final String imageName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final res = ref.watch(pullImage(imageName));
    return Scaffold(
      appBar: AppBar(title: const Text("Pull Image")),
      body: Center(
        child: res.when(
          data: (stream) {
            final Terminal term = Terminal();
            stream.listen(
              (event) {
                term.eraseDisplay();
                term.setCursor(0, 0);
                term.write(event);
              },
              onDone: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Process Done"),
                  duration: Duration(seconds: 2),
                ),
              ),
            );
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TerminalView(
                    term,
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
          },
          error: (e, __) => Text(e.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
