import 'package:isar/isar.dart';

part 'server.g.dart';

@collection
class Server {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  @Index(type: IndexType.value)
  String? name, host, port;

  @Index(type: IndexType.value)
  String? sshUsername, sshPassword, sshPort;

  List<int> caCert = <int>[], clientCert = <int>[], privateKey = <int>[];
}
