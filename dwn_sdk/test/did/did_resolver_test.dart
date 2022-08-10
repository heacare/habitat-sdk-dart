import 'dart:convert';

import 'package:dwn_sdk/src/did/did_resolver.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  // Testing the DIDDocumentMetadata structure
  group('DIDDocumentMetadata', () {
    test('To JSON', () {
      final DIDDocumentMetadata didDocumentMetadata = DIDDocumentMetadata(
        created: '2022-08-02T08:45:21+0000',
        updated: '2022-08-02T08:45:21+0000',
        deactivated: false,
        versionId: '1.1',
      );

      final Map<String, dynamic> jsonString =
          jsonDecode(jsonEncode(didDocumentMetadata.toJson()))
              as Map<String, dynamic>;
      const Map<String, dynamic> expected = <String, dynamic>{
        'created': '2022-08-02T08:45:21+0000',
        'updated': '2022-08-02T08:45:21+0000',
        'deactivated': false,
        'versionId': '1.1',
      };

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const Map<String, dynamic> jsonString = <String, dynamic>{
        'created': '2022-08-02T08:45:21+0000',
        'updated': '2022-08-02T08:45:21+0000',
        'deactivated': false,
        'versionId': '1.1',
        'nextUpdate': null,
        'nextVersionId': null,
        'equivalentId': null,
        'canonicalId': null
      };

      final DIDDocumentMetadata didDocumentMetadata =
          DIDDocumentMetadata.fromJson(jsonString);

      expect(didDocumentMetadata.created, equals('2022-08-02T08:45:21+0000'));
      expect(didDocumentMetadata.updated, equals('2022-08-02T08:45:21+0000'));
      expect(didDocumentMetadata.deactivated, isFalse);
      expect(didDocumentMetadata.versionId, equals('1.1'));
      expect(didDocumentMetadata.nextUpdate, isNull);
      expect(didDocumentMetadata.nextVersionId, isNull);
      expect(didDocumentMetadata.equivalentId, isNull);
      expect(didDocumentMetadata.canonicalId, isNull);
    });
  });

  // Testing the VerificationMethod structure
  group('VerificationMethod', () {
    test('To JSON', () {
      final VerificationMethod verificationMethod = VerificationMethod(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'Ed25519VerificationKey2020',
        controller: 'did:example:123456789abcdefghi',
        publicKeyMultibase: 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
      );

      final Map<String, dynamic> jsonString = verificationMethod.toJson();
      const Map<String, dynamic> expected = <String, dynamic>{
        'id': 'did:example:123456789abcdefghi#key-1',
        'type': 'Ed25519VerificationKey2020',
        'controller': 'did:example:123456789abcdefghi',
        'publicKeyMultibase': 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV'
      };

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const Map<String, dynamic> jsonString = <String, dynamic>{
        'id': 'did:example:123456789abcdefghi#key-1',
        'type': 'Ed25519VerificationKey2020',
        'controller': 'did:example:123456789abcdefghi',
        'publicKeyJwk': null,
        'publicKeyMultibase': 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV'
      };

      final VerificationMethod verificationMethod =
          VerificationMethod.fromJson(jsonString);

      expect(verificationMethod.id,
          equals('did:example:123456789abcdefghi#key-1'));
      expect(verificationMethod.type, equals('Ed25519VerificationKey2020'));
      expect(verificationMethod.controller,
          equals('did:example:123456789abcdefghi'));
      expect(verificationMethod.publicKeyJwk, isNull);
      expect(
        verificationMethod.publicKeyMultibase,
        equals('zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV'),
      );
    });
  });

  group('ServiceEndpoint', () {
    test('To JSON', () {
      final ServiceEndpoint serviceEndpoint = ServiceEndpoint(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'url',
        serviceEndpoint: 'https://datahouse.me',
        description: 'Health Data Store',
      );

      final Map<String, dynamic> jsonString = serviceEndpoint.toJson();
      const Map<String, dynamic> expected = <String, dynamic>{
        'id': 'did:example:123456789abcdefghi#key-1',
        'type': 'url',
        'serviceEndpoint': 'https://datahouse.me',
        'description': 'Health Data Store'
      };

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const Map<String, dynamic> jsonString = <String, dynamic>{
        'id': 'did:example:123456789abcdefghi#key-1',
        'type': 'url',
        'serviceEndpoint': 'https://datahouse.me',
        'description': 'Health Data Store'
      };

      final ServiceEndpoint serviceEndpoint =
          ServiceEndpoint.fromJson(jsonString);

      expect(
          serviceEndpoint.id, equals('did:example:123456789abcdefghi#key-1'));
      expect(serviceEndpoint.type, equals('url'));
      expect(serviceEndpoint.serviceEndpoint, equals('https://datahouse.me'));
      expect(serviceEndpoint.description, equals('Health Data Store'));
    });
  });

  group('DIDDocument', () {
    test('To JSON', () {
      final VerificationMethod verificationMethod = VerificationMethod(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'Ed25519VerificationKey2020',
        controller: 'did:example:123456789abcdefghi',
        publicKeyMultibase: 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
      );

      final ServiceEndpoint serviceEndpoint = ServiceEndpoint(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'url',
        serviceEndpoint: 'https://datahouse.me',
        description: 'Health Data Store',
      );

      final DIDDocument didDocument = DIDDocument(
        context: <String>['https://www.w3.org/ns/did/v1'],
        id: 'did:example:123456789abcdefghi',
        alsoKnownAs: 'dave',
        controller: <String>[
          'did:example:123456789abcdefghi',
        ],
        verificationMethod: <VerificationMethod>[verificationMethod],
        service: <ServiceEndpoint>[serviceEndpoint],
        authentication: <VerificationMethod>[verificationMethod],
        keyAgreement: <VerificationMethod>[verificationMethod],
      );

      final Map<String, dynamic> jsonString =
          jsonDecode(jsonEncode(didDocument.toJson())) as Map<String, dynamic>;
      const Map<String, dynamic> expected = <String, dynamic>{
        'context': <String>['https://www.w3.org/ns/did/v1'],
        'id': 'did:example:123456789abcdefghi',
        'alsoKnownAs': 'dave',
        'controller': <String>['did:example:123456789abcdefghi'],
        'verificationMethod': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'did:example:123456789abcdefghi#key-1',
            'type': 'Ed25519VerificationKey2020',
            'controller': 'did:example:123456789abcdefghi',
            'publicKeyMultibase':
                'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
          }
        ],
        'service': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'did:example:123456789abcdefghi#key-1',
            'type': 'url',
            'serviceEndpoint': 'https://datahouse.me',
            'description': 'Health Data Store',
          }
        ],
        'authentication': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'did:example:123456789abcdefghi#key-1',
            'type': 'Ed25519VerificationKey2020',
            'controller': 'did:example:123456789abcdefghi',
            'publicKeyMultibase':
                'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV'
          }
        ],
        'keyAgreement': <Map<String, dynamic>>[
          <String, dynamic>{
            'id': 'did:example:123456789abcdefghi#key-1',
            'type': 'Ed25519VerificationKey2020',
            'controller': 'did:example:123456789abcdefghi',
            'publicKeyMultibase':
                'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
          }
        ],
        'capabilityInvocation': <Map<String, dynamic>>[],
        'capabilityDelegation': <Map<String, dynamic>>[]
      };

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      // TODO: The JSON parsing test for DIDDocument model is undone
      // Complicated to check equality without manually checking every field, wondering
      // if we can use Equatable to solve that problem in the future
    });
  });

  group('DIDResolutionMetadata', () {
    test('To JSON [notFound error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.notFound,
      );

      const Map<String, dynamic> expected = <String, dynamic>{
        'error': 'notFound',
      };

      final Map<String, dynamic> jsonString = didResolutionMetadata.toJson();

      expect(jsonString, equals(expected));
    });

    test('To JSON [invalidDID error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.invalidDID,
      );

      const Map<String, dynamic> expected = <String, dynamic>{
        'error': 'invalidDID',
      };

      final Map<String, dynamic> jsonString = didResolutionMetadata.toJson();

      expect(jsonString, equals(expected));
    });

    test('To JSON [representationNotSupported error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.representationNotSupported,
      );

      const Map<String, dynamic> expected = <String, dynamic>{
        'error': 'representationNotSupported',
      };

      final Map<String, dynamic> jsonString = didResolutionMetadata.toJson();

      expect(jsonString, equals(expected));
    });

    test('To JSON [unsupportedDIDMethod error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.unsupportedDIDMethod,
      );

      const Map<String, dynamic> expected = <String, dynamic>{
        'error': 'unsupportedDIDMethod',
      };

      final Map<String, dynamic> jsonString = didResolutionMetadata.toJson();

      expect(jsonString, equals(expected));
    });

    test('To JSON [no error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        contentType: 'did+json',
      );

      const Map<String, dynamic> expected = <String, dynamic>{
        'contentType': 'did+json',
      };

      final Map<String, dynamic> jsonString = didResolutionMetadata.toJson();

      expect(jsonString, equals(expected));
    });
  });

  group('DIDResolutionResult', () {
    test('To JSON', () {
      // Creating the DIDOcument
      final VerificationMethod verificationMethod = VerificationMethod(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'Ed25519VerificationKey2020',
        controller: 'did:example:123456789abcdefghi',
        publicKeyMultibase: 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
      );

      final ServiceEndpoint serviceEndpoint = ServiceEndpoint(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'url',
        serviceEndpoint: 'https://datahouse.me',
        description: 'Health Data Store',
      );

      final DIDDocument didDocument = DIDDocument(
        context: <String>['https://www.w3.org/ns/did/v1'],
        id: 'did:example:123456789abcdefghi',
        alsoKnownAs: 'dave',
        controller: <String>[
          'did:example:123456789abcdefghi',
        ],
        verificationMethod: <VerificationMethod>[verificationMethod],
        service: <ServiceEndpoint>[serviceEndpoint],
        authentication: <VerificationMethod>[verificationMethod],
        keyAgreement: <VerificationMethod>[verificationMethod],
      );

      // Creating the DIDResolutionMetadata
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        contentType: 'did+json',
      );

      // Creating DIDDocumentMetadata
      final DIDDocumentMetadata didDocumentMetadata = DIDDocumentMetadata(
        created: '2022-08-02T08:45:21+0000',
        updated: '2022-08-02T08:45:21+0000',
        deactivated: false,
        versionId: '1.1',
      );

      final DIDResolutionResult didResolutionResult = DIDResolutionResult(
        context: <String>['https://www.w3.org/ns/did/v1'],
        didResolutionMetadata: didResolutionMetadata,
        didDocument: didDocument,
        didDocumentMetadata: didDocumentMetadata,
      );

      final Map<String, dynamic> jsonString =
          jsonDecode(jsonEncode(didResolutionResult.toJson()))
              as Map<String, dynamic>;
      final Map<String, dynamic> expected = <String, dynamic>{
        'context': <String>['https://www.w3.org/ns/did/v1'],
        'didResolutionMetadata': <String, dynamic>{
          'contentType': 'did+json',
        },
        'didDocument': <String, dynamic>{
          'context': <String>['https://www.w3.org/ns/did/v1'],
          'id': 'did:example:123456789abcdefghi',
          'alsoKnownAs': 'dave',
          'controller': <String>['did:example:123456789abcdefghi'],
          'verificationMethod': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'did:example:123456789abcdefghi#key-1',
              'type': 'Ed25519VerificationKey2020',
              'controller': 'did:example:123456789abcdefghi',
              'publicKeyMultibase':
                  'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
            }
          ],
          'service': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'did:example:123456789abcdefghi#key-1',
              'type': 'url',
              'serviceEndpoint': 'https://datahouse.me',
              'description': 'Health Data Store',
            }
          ],
          'authentication': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'did:example:123456789abcdefghi#key-1',
              'type': 'Ed25519VerificationKey2020',
              'controller': 'did:example:123456789abcdefghi',
              'publicKeyMultibase':
                  'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV'
            }
          ],
          'keyAgreement': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'did:example:123456789abcdefghi#key-1',
              'type': 'Ed25519VerificationKey2020',
              'controller': 'did:example:123456789abcdefghi',
              'publicKeyMultibase':
                  'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
            }
          ],
          'capabilityInvocation': <Map<String, dynamic>>[],
          'capabilityDelegation': <Map<String, dynamic>>[]
        },
        'didDocumentMetadata': <String, dynamic>{
          'created': '2022-08-02T08:45:21+0000',
          'updated': '2022-08-02T08:45:21+0000',
          'deactivated': false,
          'versionId': '1.1',
        }
      };

      expect(jsonString, equals(expected));
    });
  });

  group('DIDResolver', () {
    test('Cannot have useRemote without useUrl', () {
      expect(
        () => DIDResolver(<DIDMethodResolver>[], useRemote: true),
        throwsArgumentError,
      );
    });

    test('Universal Resolver returns valid DID', () async {
      // Creating mock HTTP client
      final MockClient client = MockClient((final http.Request request) async {
        if (request.url.path !=
            '/1.0/identifiers/did:example:123456789abcdefghi') {
          fail('Wrong endpoint');
        }
        return http.Response(
          '{"context":["https://www.w3.org/ns/did/v1"],"didResolutionMetadata":{"contentType":"did+json","error":null},"didDocument":{"context":["https://www.w3.org/ns/did/v1"],"id":"did:example:123456789abcdefghi","alsoKnownAs":"dave","controller":["did:example:123456789abcdefghi"],"verificationMethod":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"service":[{"id":"did:example:123456789abcdefghi#key-1","type":"url","serviceEndpoint":"https://datahouse.me","description":"Health Data Store"}],"authentication":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"keyAgreement":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"capabilityInvocation":[],"capabilityDelegation":[]},"didDocumentMetadata":{"created":"2022-08-02T08:45:21+0000","updated":"2022-08-02T08:45:21+0000","deactivated":false,"versionId":"1.1","nextUpdate":null,"nextVersionId":null,"equivalentId":null,"canonicalId":null}}',
          200,
          headers: {'content-type': 'application/json'},
        );
      });

      final DIDResolver resolver = DIDResolver(
        <DIDMethodResolver>[],
        useRemote: true,
        remoteUrl: 'https://datahouse.me',
        client: client,
      );
      final DIDResolutionResult result =
          await resolver.resolve('did:example:123456789abcdefghi');

      expect(result.didDocument?.id, equals('did:example:123456789abcdefghi'));
    });
  });
}
