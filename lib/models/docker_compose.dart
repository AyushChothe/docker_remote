import 'package:docker_remote/models/docker_container.dart';

class DockerComposeStack {
  final String? composeFilePath,
      composeVersion,
      composeWorkingDir,
      composeProject,
      composeService;
  final List<DockerContainer> containers;
  DockerComposeStack({
    this.composeFilePath,
    this.composeVersion,
    this.composeWorkingDir,
    this.composeProject,
    this.composeService,
    this.containers = const [],
  });
}
