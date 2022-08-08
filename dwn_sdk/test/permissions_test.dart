import 'dart:convert';
import 'dart:typed_data';

import 'package:dwn_sdk/dwn_sdk.dart';
import 'package:dwn_sdk/src/permissions.dart';
import 'package:test/test.dart';

void main() {
  group('PermissionsRequestMessage', () {
    test('Serialize PermissionRequestMessage to JSON', () {
      const PermissionScope scope = PermissionScope(
        method: 'PermissionsRequest',
        schema: 'https://schema.org/HealthData',
      );
      const PermissionConditions conditions = PermissionConditions(
        attestation: PermissionAttestation.optional,
        encryption: PermissionEncryption.optional,
        delegation: true,
      );

      const PermissionsRequestDescriptor descriptor =
          PermissionsRequestDescriptor(
        nonce: '1',
        grantedBy: 'did:example:123456789abcdefghi',
        grantedTo: 'did:example:123456789abcdefghi',
        description: 'Request to do magic',
        scope: scope,
        conditions: conditions,
      );
      final PermissionsRequestMessage message = PermissionsRequestMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final String jsonString = jsonEncode(message.toJson());
      const String expected = '{'
          '"data":"AAAAAAAAAAAAAA==",'
          '"descriptor":'
          '{'
          '"nonce":"1",'
          '"dataCid":null,'
          '"dataFormat":null,'
          '"permissionRequestId":null,'
          '"description":"Request to do magic",'
          '"grantedBy":"did:example:123456789abcdefghi",'
          '"grantedTo":"did:example:123456789abcdefghi",'
          '"scope":'
          '{'
          '"method":"PermissionsRequest",'
          '"schema":"https://schema.org/HealthData"'
          '},'
          '"conditions":'
          '{'
          '"attestation":"optional",'
          '"encryption":"optional",'
          '"delegation":true,'
          '"publication":null,'
          '"sharedAccess":null'
          '}'
          '}'
          '}';

      expect(jsonString, equals(expected));
    });

    test('Deserialize PermissionRequestMessage from JSON', () {
      const String jsonString = '{'
          '"data":"AAAAAAAAAAAAAA==",'
          '"descriptor":'
          '{'
          '"nonce":"1",'
          '"dataCid":null,'
          '"dataFormat":null,'
          '"permissionRequestId":null,'
          '"description":"Request to do magic",'
          '"grantedBy":"did:example:123456789abcdefghi",'
          '"grantedTo":"did:example:123456789abcdefghi",'
          '"scope":'
          '{'
          '"method":"PermissionsRequest",'
          '"schema":"https://schema.org/HealthData"'
          '},'
          '"conditions":'
          '{'
          '"attestation":"optional",'
          '"encryption":"optional",'
          '"delegation":true,'
          '"publication":null,'
          '"sharedAccess":null'
          '}'
          '}'
          '}';

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final PermissionsRequestMessage message =
          PermissionsRequestMessage.fromJson(jsonMap);
      final PermissionsRequestDescriptor md = message.descriptor;

      // Checking message
      // Pew pew

      // Checking Message Descriptor
      expect(md.nonce, equals('1'));
      expect(md.dataCid, isNull);
      expect(md.dataFormat, isNull);
      expect(md.permissionRequestId, isNull);
      expect(md.description, equals('Request to do magic'));
      expect(md.grantedBy, equals('did:example:123456789abcdefghi'));
      expect(md.scope.method, equals('PermissionsRequest'));
      expect(md.scope.schema, equals('https://schema.org/HealthData'));

      expect(
        md.conditions!.attestation,
        equals(PermissionAttestation.optional),
      );
      expect(md.conditions!.encryption, equals(PermissionEncryption.optional));
      expect(md.conditions!.delegation, isTrue);
      expect(md.conditions!.publication, isNull);
      expect(md.conditions!.sharedAccess, isNull);
    });
  });

  group('PermissionsGrantMessage', () {
    test('Serialize PermissionsGrantMessage to JSON', () {
      const PermissionScope scope = PermissionScope(
        method: 'PermissionsGrant',
        schema: 'https://schema.org/HealthData',
      );
      const PermissionConditions conditions = PermissionConditions(
        attestation: PermissionAttestation.optional,
        encryption: PermissionEncryption.optional,
        delegation: true,
      );

      const PermissionsGrantDescriptor descriptor = PermissionsGrantDescriptor(
        nonce: '1',
        grantedBy: 'did:example:123456789abcdefghi',
        grantedTo: 'did:example:123456789abcdefghi',
        description: 'Grant to do magic',
        expiry: '2022-08-02T08:45:21+0000',
        permissionGrantId: '9114a8e4-d1e1-41cc-b52f-41c8cbcc0531',
        scope: scope,
        conditions: conditions,
      );

      final PermissionsGrantMessage message = PermissionsGrantMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final String jsonString = jsonEncode(message.toJson());

      const String expected = '{'
          '"data":"AAAAAAAAAAAAAA==",'
          '"descriptor":'
          '{'
          '"nonce":"1",'
          '"dataCid":null,'
          '"dataFormat":null,'
          '"permissionGrantId":"9114a8e4-d1e1-41cc-b52f-41c8cbcc0531",'
          '"permissionRequestId":null,'
          '"description":"Grant to do magic",'
          '"grantedBy":"did:example:123456789abcdefghi",'
          '"grantedTo":"did:example:123456789abcdefghi",'
          '"delegatedFrom":null,'
          '"expiry":"2022-08-02T08:45:21+0000",'
          '"scope":'
          '{'
          '"method":"PermissionsGrant",'
          '"schema":"https://schema.org/HealthData"'
          '},'
          '"conditions":'
          '{'
          '"attestation":"optional",'
          '"encryption":"optional",'
          '"delegation":true,'
          '"publication":null,'
          '"sharedAccess":null'
          '}'
          '}'
          '}';

      expect(jsonString, equals(expected));
    });

    test('Deserialize PermissionRequestMessage from JSON', () {
      const String jsonString = '{'
          '"data":"AAAAAAAAAAAAAA==",'
          '"descriptor":'
          '{'
          '"nonce":"1",'
          '"dataCid":null,'
          '"dataFormat":null,'
          '"permissionGrantId":"9114a8e4-d1e1-41cc-b52f-41c8cbcc0531",'
          '"permissionRequestId":null,'
          '"description":"Grant to do magic",'
          '"grantedBy":"did:example:123456789abcdefghi",'
          '"grantedTo":"did:example:123456789abcdefghi",'
          '"delegatedFrom":null,'
          '"expiry":"2022-08-02T08:45:21+0000",'
          '"scope":'
          '{'
          '"method":"PermissionsGrant",'
          '"schema":"https://schema.org/HealthData"'
          '},'
          '"conditions":'
          '{'
          '"attestation":"optional",'
          '"encryption":"optional",'
          '"delegation":true,'
          '"publication":null,'
          '"sharedAccess":null'
          '}'
          '}'
          '}';

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final PermissionsGrantMessage message =
          PermissionsGrantMessage.fromJson(jsonMap);
      final PermissionsGrantDescriptor md = message.descriptor;

      // Checking message
      // Pew pew

      // Checking Message Descriptor
      expect(md.nonce, equals('1'));
      expect(md.dataCid, isNull);
      expect(md.dataFormat, isNull);
      expect(
        md.permissionGrantId,
        equals('9114a8e4-d1e1-41cc-b52f-41c8cbcc0531'),
      );
      expect(md.permissionRequestId, isNull);
      expect(md.description, equals('Grant to do magic'));
      expect(md.grantedBy, equals('did:example:123456789abcdefghi'));
      expect(md.delegatedFrom, isNull);
      expect(md.expiry, equals('2022-08-02T08:45:21+0000'));

      expect(md.scope.method, equals('PermissionsGrant'));
      expect(md.scope.schema, equals('https://schema.org/HealthData'));

      expect(
        md.conditions!.attestation,
        equals(PermissionAttestation.optional),
      );
      expect(md.conditions!.encryption, equals(PermissionEncryption.optional));
      expect(md.conditions!.delegation, isTrue);
      expect(md.conditions!.publication, isNull);
      expect(md.conditions!.sharedAccess, isNull);
    });
  });
}
