import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

class AggregationTransformer
    extends StreamTransformerBase<Uint8List, List<int>> {
  @override
  Stream<List<int>> bind(Stream<Uint8List> base) async* {
    List<int> data = [];
    await for (List<int> chunk in base) {
      data.addAll(chunk);
      yield data;
    }
  }
}

class ConsoleAggregationTransformer
    extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> base) async* {
    List<Map> data = [];
    await for (String chunk in base) {
      List input = chunk.split("}\n").map(jsonDecode).toList();
      for (Map r in input) {
        // Add Status to list in new
        if (!r.containsKey("id")) {
          data.add(r);
          continue;
        }
        // Find status from list
        int idx = data.indexWhere(
          (e) => r.containsKey("id") && (e["id"] == r["id"]),
        );
        // Replace Progress with id or add to list if new
        (idx == -1) ? data.add(r) : data[idx] = r;
      }
      List<String> status = [];
      for (Map out in data) {
        String str = out["status"];
        if (out.containsKey("progress")) {
          str += "\n\r" "${out["progress"]}";
        }
        status.add(str);
      }
      yield "${status.join('\n\r')}" "\n\r";
    }
  }
}
