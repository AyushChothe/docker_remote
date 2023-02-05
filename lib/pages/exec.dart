import 'package:docker_remote/providers/container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xterm/xterm.dart';

class ExecPage extends HookConsumerWidget {
  const ExecPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ref.watch(containerProvider);
    final cmdCtrl = useTextEditingController(text: "date");
    final output = useState("");
    return Scaffold(
      appBar: AppBar(
        title: Text.rich(TextSpan(children: [
          const TextSpan(
            text: "Exec",
          ),
          TextSpan(
            text: " (${container?.names?[0]})",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ])),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: cmdCtrl,
              decoration: const InputDecoration(hintText: "Command"),
              onFieldSubmitted: ((_) async {
                try {
                  final out = await container?.exec(cmdCtrl.text);
                  output.value = out ?? "";
                } catch (e) {
                  debugPrint(e.toString());
                }
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SizedBox(
                width: double.maxFinite,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TerminalView(
                      Terminal()..write(output.value.replaceAll("\n", "\n\r")),
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
            ),
          ],
        ),
      ),
    );
  }
}
