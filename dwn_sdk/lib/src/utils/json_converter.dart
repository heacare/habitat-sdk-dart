import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

class JsonBase64UrlConverter extends JsonConverter<Uint8List, String> {
  const JsonBase64UrlConverter();

  final Codec<List<int>, String> _base64codec = const Base64Codec.urlSafe();

  @override
  Uint8List fromJson(final String json) => Uint8List.fromList(_base64codec.decode(json));

  @override
  String toJson(final Uint8List object) => _base64codec.encode(object);
}
