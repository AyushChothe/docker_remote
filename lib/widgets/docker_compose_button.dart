import 'package:docker_remote/models/docker_compose.dart';
import 'package:docker_remote/pages/docker_compose_ui.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DockerComposeButton extends StatelessWidget {
  const DockerComposeButton({
    super.key,
    required this.stack,
    required this.text,
    required this.cmd,
    required this.iconData,
  });

  final DockerComposeStack stack;
  final String text, cmd;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              child: ProviderScope(
                parent: ProviderScope.containerOf(context),
                child: DockerComposeUI(
                  filePath: stack.composeFilePath!,
                  cmd: cmd,
                ),
              ),
            ),
          );
        },
        icon: Icon(iconData),
        label: Text(text));
  }
}
