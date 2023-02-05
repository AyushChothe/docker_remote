class DockerCerts {
  List<int> rootCACertificate = const <int>[];
  List<int> clientCertificate = const <int>[];
  List<int> privateKey = const <int>[];

  DockerCerts({
    this.rootCACertificate = const <int>[],
    this.clientCertificate = const <int>[],
    this.privateKey = const <int>[],
  });

  DockerCerts.fromJson(Map<String, dynamic> json) {
    rootCACertificate = json['rootCACertificate'].cast<int>();
    clientCertificate = json['clientCertificate'].cast<int>();
    privateKey = json['privateKey'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rootCACertificate'] = rootCACertificate;
    data['clientCertificate'] = clientCertificate;
    data['privateKey'] = privateKey;
    return data;
  }
}
