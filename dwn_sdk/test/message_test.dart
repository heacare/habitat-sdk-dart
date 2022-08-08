import 'dart:typed_data';

import 'package:dwn_sdk/src/message.dart';
import 'package:jose/jose.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

part 'message_test.g.dart';

@JsonSerializable()
class TestMessage extends Message<MessageDescriptor> {
  TestMessage({
    final super.data,
    required final super.descriptor,
    final super.authorization,
    final super.attestation,
  });
  factory TestMessage.fromJson(final Map<String, dynamic> json) =>
      _$TestMessageFromJson(json);
}

@JsonSerializable()
class Test2Message extends Message<Test2MessageDescriptor> {
  Test2Message({
    final super.data,
    required final super.descriptor,
    final super.authorization,
    final super.attestation,
  });
  factory Test2Message.fromJson(final Map<String, dynamic> json) =>
      _$Test2MessageFromJson(json);
}

@JsonSerializable()
class Test2MessageDescriptor extends MessageDescriptor {
  Test2MessageDescriptor({
    required final super.nonce,
    required final super.method,
    final super.dataCid,
    final super.dataFormat,
    required this.testParameter,
  });
  factory Test2MessageDescriptor.fromJson(final Map<String, dynamic> json) =>
      _$Test2MessageDescriptorFromJson(json);
  final String testParameter;
  @override
  Map<String, dynamic> toJson() => _$Test2MessageDescriptorToJson(this);
}

void main() {
  group('Message', () {
    test('Parse basic message from JSON', () {
      final TestMessage t = TestMessage.fromJson(<String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
          'schema': 'https://schema.org/SocialMediaPosting'
        }
      });

      expect(t.descriptor.method, 'CollectionsQuery');
      expect(
        t.descriptor.nonce,
        '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
      );
      expect(t.descriptor.dataFormat, isNull);
      expect(t.data, isNull);

      expect(t.toJson(), isNotEmpty);
    });
    test('Parse advanced message from JSON', () {
      final Test2Message t = Test2Message.fromJson(<String, dynamic>{
        'data': 'aGVsbG8gd29ybGQh',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
          'testParameter': 'hello',
        }
      });

      expect(t.descriptor.method, 'CollectionsQuery');
      expect(
        t.descriptor.nonce,
        '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
      );
      expect(t.descriptor.testParameter, 'hello');
      expect(
        t.data,
        Uint8List.fromList(
          <int>[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33],
        ),
      );

      final Map<String, dynamic> json = t.toJson();
      expect(json['data'], 'aGVsbG8gd29ybGQh');
      final Map<String, dynamic> jsonDescriptor =
          json['descriptor'] as Map<String, dynamic>;
      expect(jsonDescriptor['testParameter'], 'hello');
    });
  });
}
