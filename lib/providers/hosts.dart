import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lan_scanner/lan_scanner.dart';
import 'package:network_info_plus/network_info_plus.dart';

final hostsProvider = FutureProvider<List<HostModel>>((ref) async {
  try {
    final String address = await NetworkInfo().getWifiIP() ?? "";
    final String subnet = ipToCSubnet(address);
    final hosts =
        await LanScanner(debugLogging: true).icmpScan(subnet).toList();

    return hosts;
  } catch (e) {
    return Future.error("You are Not Connected to WIFI");
  }
});
