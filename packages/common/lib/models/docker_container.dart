import 'dart:async';
import 'dart:convert';

import 'package:common/utils/stream_aggregator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DockerContainer {
  String? id;
  List<String>? names;
  String? image;
  String? imageID;
  String? command;
  int? created;
  String? state;
  String? status;
  List<Ports>? ports;
  Map<String, dynamic>? labels;
  int? sizeRw;
  int? sizeRootFs;
  HostConfig? hostConfig;
  NetworkSettings? networkSettings;
  List<Mounts>? mounts;
  Dio? dio;

  DockerContainer(
      {this.id,
      this.names,
      this.image,
      this.imageID,
      this.command,
      this.created,
      this.state,
      this.status,
      this.ports,
      this.labels,
      this.sizeRw,
      this.sizeRootFs,
      this.hostConfig,
      this.networkSettings,
      this.mounts,
      this.dio});

  Future<String> start() async {
    try {
      await dio?.post("/containers/$id/start");
      return "Container started";
    } on DioException catch (e) {
      return e.response?.data is Map
          ? (e.response?.data["message"])
          : "Container already started";
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String> stop() async {
    try {
      await dio?.post("/containers/$id/stop");
      return "Container stopped";
    } on DioException catch (e) {
      return e.response?.data is Map
          ? (e.response?.data["message"])
          : "Container already stopped";
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String> restart() async {
    try {
      await dio?.post("/containers/$id/restart");
      return "Container restarted";
    } on DioException catch (e) {
      return (e.response?.data["message"]);
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<String> remove() async {
    try {
      await dio?.delete("/containers/$id");
      return "Container removed";
    } on DioException catch (e) {
      return (e.response?.data["message"]);
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<Stream<String>> logs() async {
    try {
      final res = (((await dio?.get(
        "/containers/$id/logs",
        queryParameters: {
          "stdin": true,
          "stdout": true,
          "stderr": true,
          "follow": true,
          "tail": 100
        },
        options: Options(
          responseType: ResponseType.stream,
        ),
      ))
                  ?.data as ResponseBody)
              .stream)
          .transform(AggregationTransformer())
          .map((bytes) => utf8.decode(bytes, allowMalformed: true));
      return res;
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.value(const Stream.empty());
  }

  Future<String> exec(String cmd, [bool detach = false]) async {
    try {
      String execId = (await dio?.post(
        '/containers/$id/exec',
        data: {
          "AttachStdin": false,
          "AttachStdout": true,
          "AttachStderr": true,
          "DetachKeys": "ctrl-c",
          "Tty": false,
          "Cmd": cmd.split(" "),
          // "Env": ["FOO=bar"]
        },
      ))
          ?.data["Id"];
      String response = (await dio?.post("/exec/$execId/start",
              data: {"Detach": detach, "Tty": true}))
          ?.data;
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return Future.value("");
  }

  DockerContainer.fromJson(Map<String, dynamic> json, Dio dioProvider) {
    dio = dioProvider;
    id = json['Id'];
    names = json['Names'].cast<String>();
    image = json['Image'];
    imageID = json['ImageID'];
    command = json['Command'];
    created = json['Created'];
    state = json['State'];
    status = json['Status'];
    if (json['Ports'] != null) {
      ports = <Ports>[];
      json['Ports'].forEach((v) {
        ports!.add(Ports.fromJson(v));
      });
    }
    labels = json['Labels'];
    sizeRw = json['SizeRw'];
    sizeRootFs = json['SizeRootFs'];
    hostConfig = json['HostConfig'] != null
        ? HostConfig.fromJson(json['HostConfig'])
        : null;
    networkSettings = json['NetworkSettings'] != null
        ? NetworkSettings.fromJson(json['NetworkSettings'])
        : null;
    if (json['Mounts'] != null) {
      mounts = <Mounts>[];
      json['Mounts'].forEach((v) {
        mounts!.add(Mounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Names'] = names;
    data['Image'] = image;
    data['ImageID'] = imageID;
    data['Command'] = command;
    data['Created'] = created;
    data['State'] = state;
    data['Status'] = status;
    if (ports != null) {
      data['Ports'] = ports!.map((v) => v.toJson()).toList();
    }
    data['Labels'] = labels;

    data['SizeRw'] = sizeRw;
    data['SizeRootFs'] = sizeRootFs;
    if (hostConfig != null) {
      data['HostConfig'] = hostConfig!.toJson();
    }
    if (networkSettings != null) {
      data['NetworkSettings'] = networkSettings!.toJson();
    }
    if (mounts != null) {
      data['Mounts'] = mounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ports {
  int? privatePort;
  int? publicPort;
  String? ip;
  String? type;

  Ports({this.privatePort, this.publicPort, this.type, this.ip});

  Ports.fromJson(Map<String, dynamic> json) {
    privatePort = json['PrivatePort'];
    publicPort = json['PublicPort'];
    ip = json['IP'];
    type = json['Type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PrivatePort'] = privatePort;
    data['PublicPort'] = publicPort;
    data['Type'] = type;
    data['IP'] = ip;
    return data;
  }
}

class HostConfig {
  String? networkMode;

  HostConfig({this.networkMode});

  HostConfig.fromJson(Map<String, dynamic> json) {
    networkMode = json['NetworkMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NetworkMode'] = networkMode;
    return data;
  }
}

class NetworkSettings {
  Networks? networks;

  NetworkSettings({this.networks});

  NetworkSettings.fromJson(Map<String, dynamic> json) {
    networks =
        json['Networks'] != null ? Networks.fromJson(json['Networks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (networks != null) {
      data['Networks'] = networks!.toJson();
    }
    return data;
  }
}

class Networks {
  Bridge? bridge;

  Networks({this.bridge});

  Networks.fromJson(Map<String, dynamic> json) {
    bridge = json['bridge'] != null ? Bridge.fromJson(json['bridge']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bridge != null) {
      data['bridge'] = bridge!.toJson();
    }
    return data;
  }
}

class Bridge {
  String? networkID;
  String? endpointID;
  String? gateway;
  String? iPAddress;
  int? iPPrefixLen;
  String? iPv6Gateway;
  String? globalIPv6Address;
  int? globalIPv6PrefixLen;
  String? macAddress;

  Bridge(
      {this.networkID,
      this.endpointID,
      this.gateway,
      this.iPAddress,
      this.iPPrefixLen,
      this.iPv6Gateway,
      this.globalIPv6Address,
      this.globalIPv6PrefixLen,
      this.macAddress});

  Bridge.fromJson(Map<String, dynamic> json) {
    networkID = json['NetworkID'];
    endpointID = json['EndpointID'];
    gateway = json['Gateway'];
    iPAddress = json['IPAddress'];
    iPPrefixLen = json['IPPrefixLen'];
    iPv6Gateway = json['IPv6Gateway'];
    globalIPv6Address = json['GlobalIPv6Address'];
    globalIPv6PrefixLen = json['GlobalIPv6PrefixLen'];
    macAddress = json['MacAddress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['NetworkID'] = networkID;
    data['EndpointID'] = endpointID;
    data['Gateway'] = gateway;
    data['IPAddress'] = iPAddress;
    data['IPPrefixLen'] = iPPrefixLen;
    data['IPv6Gateway'] = iPv6Gateway;
    data['GlobalIPv6Address'] = globalIPv6Address;
    data['GlobalIPv6PrefixLen'] = globalIPv6PrefixLen;
    data['MacAddress'] = macAddress;
    return data;
  }
}

class Mounts {
  String? name;
  String? source;
  String? destination;
  String? driver;
  String? mode;
  bool? rW;
  String? propagation;

  Mounts(
      {this.name,
      this.source,
      this.destination,
      this.driver,
      this.mode,
      this.rW,
      this.propagation});

  Mounts.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    source = json['Source'];
    destination = json['Destination'];
    driver = json['Driver'];
    mode = json['Mode'];
    rW = json['RW'];
    propagation = json['Propagation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Source'] = source;
    data['Destination'] = destination;
    data['Driver'] = driver;
    data['Mode'] = mode;
    data['RW'] = rW;
    data['Propagation'] = propagation;
    return data;
  }
}
