import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:watch_connectivity/watch_connectivity.dart';

final watchConnProvider = Provider((ref) => WatchConnectivity());

Stream<Map<String, dynamic>> getServerStream(
    WatchConnectivity watchConn) async* {
  debugPrint("Created");
  final watchRecContext = await watchConn.receivedApplicationContexts;
  if (watchRecContext.isNotEmpty) {
    yield watchRecContext.last;
  }
  await for (var watchContext in watchConn.contextStream) {
    debugPrint(watchContext.toString());
    if (watchRecContext.last != watchContext) {
      debugPrint("Data Recieved");
      yield watchContext;
    }
  }
}
