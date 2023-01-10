import 'dart:async';
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
