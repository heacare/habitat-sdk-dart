/// These tests ensure all required classes are exported by the API.

import 'package:dwn_sdk/dwn_sdk.dart';
import 'package:test/test.dart';

void main() {
  test('Exports message types', () {
    expect(Message, isNotNull);
    expect(MessageData, isNotNull);
    expect(MessageDescriptor, isNotNull);
  });
  test('Exports cid types', () {
    expect(CID, isNotNull);
  });
}
