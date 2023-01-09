class DockerImage {
  String? id;
  String? parentId;
  List<String>? repoTags;
  List<String>? repoDigests;
  int? created;
  int? size;
  int? sharedSize;
  int? virtualSize;
  Map<String, dynamic>? labels;
  int? containers;

  DockerImage(
      {this.id,
      this.parentId,
      this.repoTags,
      this.repoDigests,
      this.created,
      this.size,
      this.sharedSize,
      this.virtualSize,
      this.labels,
      this.containers});

  DockerImage.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    parentId = json['ParentId'];
    repoTags = json['RepoTags']?.cast<String>();
    repoDigests = json['RepoDigests']?.cast<String>();
    created = json['Created'];
    size = json['Size'];
    sharedSize = json['SharedSize'];
    virtualSize = json['VirtualSize'];
    labels = json['Labels'];
    containers = json['Containers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['ParentId'] = parentId;
    data['RepoTags'] = repoTags;
    data['RepoDigests'] = repoDigests;
    data['Created'] = created;
    data['Size'] = size;
    data['SharedSize'] = sharedSize;
    data['VirtualSize'] = virtualSize;
    data['Labels'] = labels;
    data['Containers'] = containers;
    return data;
  }
}
