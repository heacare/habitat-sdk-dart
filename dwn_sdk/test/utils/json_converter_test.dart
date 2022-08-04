import 'dart:typed_data';

import 'package:dwn_sdk/src/utils/json_converter.dart';
import 'package:test/test.dart';

void main() {
  group('JSON base64url converter', () {
    const JsonBase64UrlConverter c = JsonBase64UrlConverter();
    test('Convert from JSON type', () {
      final Uint8List r = c.fromJson('aGVsbG8gd29ybGQh');
      expect(
        r,
        Uint8List.fromList(
          <int>[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33],
        ),
      );
    });
    test('Convert to JSON type', () {
      final String r = c.toJson(
        Uint8List.fromList(
          <int>[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33],
        ),
      );
      expect(r, 'aGVsbG8gd29ybGQh');
    });
    test('Convert from JSON type with missing padding', () {
      expect(() => c.fromJson('aGVsbG8gd29ybGQ'), throwsFormatException);
    });
    test('Convert to JSON type expecting padding', () {
      final String r = c.toJson(
        Uint8List.fromList(
          <int>[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100],
        ),
      );
      expect(r, 'aGVsbG8gd29ybGQ=');
    });
  });
}
