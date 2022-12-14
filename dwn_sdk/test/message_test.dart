import 'dart:convert';
import 'dart:typed_data';

import 'package:dwn_sdk/src/cid.dart';
import 'package:dwn_sdk/src/message.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test/test.dart';

part 'message_test.g.dart';

@JsonSerializable()
class TestMessage extends Message<MessageDescriptor> {
  TestMessage({
    super.data,
    required super.descriptor,
    super.authorization,
    super.attestation,
  });
  factory TestMessage.fromJson(final Map<String, dynamic> json) =>
      _$TestMessageFromJson(json);
}

@JsonSerializable()
class Test2Message extends Message<Test2MessageDescriptor> {
  Test2Message({
    super.data,
    required super.descriptor,
    super.authorization,
    super.attestation,
  });
  factory Test2Message.fromJson(final Map<String, dynamic> json) =>
      _$Test2MessageFromJson(json);
}

@JsonSerializable()
class Test2MessageDescriptor extends MessageDescriptor {
  Test2MessageDescriptor({
    required super.nonce,
    required super.method,
    super.dataCid,
    super.dataFormat,
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
    test('Round trip basic message from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
        }
      };
      final TestMessage t = TestMessage.fromJson(json);

      expect(t.data, isNull);
      expect(t.authorization, isNull);
      expect(t.attestation, isNull);
      expect(t.descriptor.method, 'CollectionsQuery');
      expect(
        t.descriptor.nonce,
        '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
      );
      expect(t.descriptor.dataCid, isNull);
      expect(t.descriptor.dataFormat, isNull);

      final Map<String, dynamic> encoded =
          jsonDecode(jsonEncode(t)) as Map<String, dynamic>;
      expect(encoded, json);
    });

    test('Expect unrecognised fields to be dropped', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
          'schema': 'https://schema.org/SocialMediaPosting',
          'unrecognised': null,
        }
      };
      final TestMessage t = TestMessage.fromJson(json);

      final Map<String, dynamic> encoded =
          jsonDecode(jsonEncode(t)) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
        }
      };
      expect(encoded, expected);
    });

    test('Round trip advanced message from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'aGVsbG8gd29ybGQh',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
          'testParameter': 'hello',
          'dataCid': '',
          'dataFormat': 'text/plain',
        }
      };
      final Test2Message t = Test2Message.fromJson(json);

      expect(t.data!.encryptedData, isNull);
      expect(
        t.data!.data,
        Uint8List.fromList(
          <int>[104, 101, 108, 108, 111, 32, 119, 111, 114, 108, 100, 33],
        ),
      );
      expect(t.authorization, isNull);
      expect(t.attestation, isNull);
      expect(t.descriptor.method, 'CollectionsQuery');
      expect(
        t.descriptor.nonce,
        '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
      );
      expect(t.descriptor.testParameter, 'hello');
      expect(t.descriptor.dataCid, isNotNull);
      expect(t.descriptor.dataFormat, 'text/plain');

      final Map<String, dynamic> encoded =
          jsonDecode(jsonEncode(t)) as Map<String, dynamic>;
      expect(encoded, json);
    });

    test('Round trip authorized message from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
        },
        'authorization': <String, dynamic>{
          'payload':
              'eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGF'
                  'tcGxlLmNvbS9pc19yb290Ijp0cnVlfQ',
          'signatures': <dynamic>[
            <String, dynamic>{
              'protected': 'eyJhbGciOiJSUzI1NiJ9',
              'signature': 'cC4hiUPoj9Eetdgtv3hF80EGrhuB__dzERat0XF9g2VtQgr9PJbu3XOiZj5RZ'
                  'mh7AAuHIm4Bh-0Qc_lF5YKt_O8W2Fp5jujGbds9uJdbF9CUAr7t1dnZcAcQjb'
                  'KBYNX4BAynRFdiuB--f_nZLgrnbyTyWzO75vRK5h6xBArLIARNPvkSjtQBMHl'
                  'b1L07Qe7K0GarZRmB_eSN9383LcOLn6_dO--xi12jzDwusC-eOkHWEsqtFZES'
                  'c6BfI7noOPqvhJ1phCnvWh6IeYI2w9QOYEUipUTI8np6LbgGY9Fs98rqVt5AX'
                  'LIhWkWywlVmtVrBp0igcN_IoypGlUPQGe77Rw'
            }
          ]
        }
      };
      final TestMessage t = TestMessage.fromJson(json);

      expect(t.authorization, isNotNull);
      expect(t.attestation, isNull);

      final Map<String, dynamic> encoded =
          jsonDecode(jsonEncode(t)) as Map<String, dynamic>;
      expect(encoded, json);
    });

    test('Round trip signed message from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'method': 'CollectionsQuery',
        },
        'attestation': <String, dynamic>{
          'payload':
              'eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGF'
                  'tcGxlLmNvbS9pc19yb290Ijp0cnVlfQ',
          'signatures': <dynamic>[
            <String, dynamic>{
              'protected': 'eyJhbGciOiJSUzI1NiJ9',
              'signature': 'cC4hiUPoj9Eetdgtv3hF80EGrhuB__dzERat0XF9g2VtQgr9PJbu3XOiZj5RZ'
                  'mh7AAuHIm4Bh-0Qc_lF5YKt_O8W2Fp5jujGbds9uJdbF9CUAr7t1dnZcAcQjb'
                  'KBYNX4BAynRFdiuB--f_nZLgrnbyTyWzO75vRK5h6xBArLIARNPvkSjtQBMHl'
                  'b1L07Qe7K0GarZRmB_eSN9383LcOLn6_dO--xi12jzDwusC-eOkHWEsqtFZES'
                  'c6BfI7noOPqvhJ1phCnvWh6IeYI2w9QOYEUipUTI8np6LbgGY9Fs98rqVt5AX'
                  'LIhWkWywlVmtVrBp0igcN_IoypGlUPQGe77Rw'
            }
          ]
        }
      };
      final TestMessage t = TestMessage.fromJson(json);

      expect(t.authorization, isNull);
      expect(t.attestation, isNotNull);
      expect(t.attestation!.jws.recipients.length, 1);
      expect(t.attestation!.jws.unverifiedPayload, isNotNull);

      final Map<String, dynamic> encoded =
          jsonDecode(jsonEncode(t)) as Map<String, dynamic>;
      expect(encoded, json);
    });
  });
}
