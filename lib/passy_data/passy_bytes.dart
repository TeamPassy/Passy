import 'dart:convert';
import 'dart:typed_data';

import 'passy_entry.dart';

class PassyBytes extends PassyEntry<PassyBytes> {
  Uint8List value;

  PassyBytes(String key, {required this.value}) : super(key);

  PassyBytes.fromJson(Map<String, dynamic> json)
      : value = base64Decode(json['value']),
        super(json['key']);

  PassyBytes.fromCSV(List csv)
      : value = base64Decode(csv[1]),
        super(csv[0]);

  @override
  int compareTo(PassyBytes other) => key.compareTo(other.key);

  @override
  Map<String, dynamic> toJson() => {
        'key': key,
        'value': base64Encode(value),
      };

  @override
  List<List> toCSV() => [
        [
          key,
          base64Encode(value),
        ]
      ];
}
