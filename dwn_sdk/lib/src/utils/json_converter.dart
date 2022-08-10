import 'dart:convert';
import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

/// An annotation to turn JSON base64url strings into Uint8List objects.
class JsonBase64UrlConverter extends JsonConverter<Uint8List, String> {
  /// Annotation constructor.
  const JsonBase64UrlConverter();

  static const Codec<List<int>, String> _base64codec = Base64Codec.urlSafe();

  /// Convert from a base64url string to a Uint8List.
  @override
  Uint8List fromJson(final String json) =>
      Uint8List.fromList(_base64codec.decode(json));

  /// Convert into a base64url string from a Uint8List.
  @override
  String toJson(final Uint8List object) => _base64codec.encode(object);
}
