import 'dart:convert';
import 'dart:typed_data';

import 'package:dwn_sdk/src/cid.dart';
import 'package:dwn_sdk/src/collections.dart';
import 'package:dwn_sdk/src/message.dart';
import 'package:test/test.dart';

void main() {
  group('CollectionsQueryMessage', () {
    test('Serialize CollectionsQueryMessage (query by recordId) to JSON', () {
      const CollectionsQueryDescriptor descriptor = CollectionsQueryDescriptor(
        nonce:
            '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        recordId: 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        dataCid: CID(),
        dataFormat: '',
      );
      final CollectionsQueryMessage message = CollectionsQueryMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsQuery',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        },
      };

      expect(json, equals(expected));
    });

    test('Deserialize CollectionsQueryMessage (query by recordId) from JSON',
        () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsQuery',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        },
      };

      final CollectionsQueryMessage message =
          CollectionsQueryMessage.fromJson(json);

      expect(
        message.descriptor.nonce,
        equals(
          '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        ),
      );
      expect(message.descriptor.dataCid, isNotNull);
      expect(message.descriptor.dataFormat, '');
      expect(message.descriptor.method, equals('CollectionsQuery'));
      expect(
        message.descriptor.recordId,
        equals('b6464162-84af-4aab-aff5-f1f8438dfc1e'),
      );
    });

    test('Serialize CollectionsQueryMessage (query by schematype) to JSON', () {
      const CollectionsQueryDescriptor descriptor = CollectionsQueryDescriptor(
        nonce:
            '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        schema: 'https://schema.org/MusicPlaylist',
        dataCid: CID(),
        dataFormat: '',
      );
      final CollectionsQueryMessage message = CollectionsQueryMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsQuery',
          'schema': 'https://schema.org/MusicPlaylist',
        },
      };

      expect(json, equals(expected));
    });

    test('Deserialize CollectionsQueryMessage (query by schemaType) from JSON',
        () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsQuery',
          'schema': 'https://schema.org/MusicPlaylist',
        },
      };

      final CollectionsQueryMessage message =
          CollectionsQueryMessage.fromJson(json);

      expect(
        message.descriptor.nonce,
        equals(
          '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        ),
      );
      expect(message.descriptor.dataCid, isNotNull);
      expect(message.descriptor.dataFormat, '');
      expect(message.descriptor.method, equals('CollectionsQuery'));
      expect(
        message.descriptor.schema,
        equals('https://schema.org/MusicPlaylist'),
      );
    });
  });

  group('CollectionsWriteMessage', () {
    test('Serialize CollectionsWriteMessage to JSON', () {
      const CollectionsWriteDescriptor descriptor = CollectionsWriteDescriptor(
        nonce:
            '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        dataCid: CID(),
        dataFormat: '',
        recordId: 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        schema: 'https://schema.org/MusicPlaylist',
        dateCreated: 123456789,
        published: true,
      );
      final CollectionsWriteMessage message = CollectionsWriteMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsWrite',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
          'dateCreated': 123456789,
          'schema': 'https://schema.org/MusicPlaylist',
          'published': true,
        },
      };

      expect(json, equals(expected));
    });

    test('Deserialize CollectionsWriteMessage from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsWrite',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
          'dateCreated': 123456789,
          'schema': 'https://schema.org/MusicPlaylist',
          'published': true,
        },
      };

      final CollectionsWriteMessage message =
          CollectionsWriteMessage.fromJson(json);

      expect(
        message.descriptor.nonce,
        equals(
          '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        ),
      );
      expect(message.descriptor.dataCid, isNotNull);
      expect(message.descriptor.dataFormat, '');
      expect(message.descriptor.method, equals('CollectionsWrite'));
      expect(
        message.descriptor.schema,
        equals('https://schema.org/MusicPlaylist'),
      );
      expect(
        message.descriptor.recordId,
        equals('b6464162-84af-4aab-aff5-f1f8438dfc1e'),
      );
      expect(message.descriptor.dateCreated, equals(123456789));
      expect(message.descriptor.published, isTrue);
    });
  });

  group('CollectionsCommitMessage', () {
    test('Serialize CollectionsCommitMessage to JSON', () {
      const CollectionsCommitDescriptor descriptor =
          CollectionsCommitDescriptor(
        nonce:
            '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        dataCid: CID(),
        dataFormat: '',
        recordId: 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        schema: 'https://schema.org/MusicPlaylist',
        dateCreated: 123456789,
      );
      final CollectionsCommitMessage message = CollectionsCommitMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsCommit',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
          'dateCreated': 123456789,
          'schema': 'https://schema.org/MusicPlaylist',
        },
      };

      expect(json, equals(expected));
    });
    test('Deserialize CollectionsCommitMessage from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsCommit',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
          'dateCreated': 123456789,
          'schema': 'https://schema.org/MusicPlaylist',
        },
      };

      final CollectionsCommitMessage message =
          CollectionsCommitMessage.fromJson(json);

      expect(
        message.descriptor.nonce,
        equals(
          '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        ),
      );
      expect(message.descriptor.dataCid, isNotNull);
      expect(message.descriptor.dataFormat, '');
      expect(message.descriptor.method, equals('CollectionsCommit'));
      expect(
        message.descriptor.schema,
        equals('https://schema.org/MusicPlaylist'),
      );
      expect(
        message.descriptor.recordId,
        equals('b6464162-84af-4aab-aff5-f1f8438dfc1e'),
      );
      expect(message.descriptor.dateCreated, equals(123456789));
    });
  });

  group('CollectionsDeleteMessage', () {
    test('Serialize CollectionsDeleteMessage to JSON', () {
      const CollectionsDeleteDescriptor descriptor =
          CollectionsDeleteDescriptor(
        nonce:
            '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        dataCid: CID(),
        dataFormat: '',
        recordId: 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
      );
      final CollectionsDeleteMessage message = CollectionsDeleteMessage(
        data: MessageData(data: Uint8List(10)),
        descriptor: descriptor,
      );

      final Map<String, dynamic> json =
          jsonDecode(jsonEncode(message.toJson())) as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsDelete',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        },
      };

      expect(json, equals(expected));
    });

    test('Deserialize CollectionsDeleteMessage from JSON', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'data': 'AAAAAAAAAAAAAA==',
        'descriptor': <String, dynamic>{
          'nonce':
              '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
          'dataCid': '',
          'dataFormat': '',
          'method': 'CollectionsDelete',
          'recordId': 'b6464162-84af-4aab-aff5-f1f8438dfc1e',
        },
      };

      final CollectionsDeleteMessage message =
          CollectionsDeleteMessage.fromJson(json);

      expect(
        message.descriptor.nonce,
        equals(
          '9b9c7f1fcabfc471ee2682890b58a427ba2c8db59ddf3c2d5ad16ccc84bb3106',
        ),
      );
      expect(message.descriptor.dataCid, isNotNull);
      expect(message.descriptor.dataFormat, '');
      expect(message.descriptor.method, equals('CollectionsDelete'));
      expect(
        message.descriptor.recordId,
        equals('b6464162-84af-4aab-aff5-f1f8438dfc1e'),
      );
    });
  });
}
