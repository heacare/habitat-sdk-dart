import 'dart:convert';
import 'package:dwn_sdk/src/did/did_resolver.dart';
import 'package:test/test.dart';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

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

      final String jsonString = jsonEncode(didDocumentMetadata.toJson());
      const String expected = '{'
          '"created":"2022-08-02T08:45:21+0000",'
          '"updated":"2022-08-02T08:45:21+0000",'
          '"deactivated":false,'
          '"versionId":"1.1",'
          '"nextUpdate":null,'
          '"nextVersionId":null,'
          '"equivalentId":null,'
          '"canonicalId":null'
          '}';

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const String jsonString = '{'
          '"created":"2022-08-02T08:45:21+0000",'
          '"updated":"2022-08-02T08:45:21+0000",'
          '"deactivated":false,'
          '"versionId":"1.1",'
          '"nextUpdate":null,'
          '"nextVersionId":null,'
          '"equivalentId":null,'
          '"canonicalId":null'
          '}';

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final DIDDocumentMetadata didDocumentMetadata =
          DIDDocumentMetadata.fromJson(jsonMap);

      final DIDDocumentMetadata expected = DIDDocumentMetadata(
        created: '2022-08-02T08:45:21+0000',
        updated: '2022-08-02T08:45:21+0000',
        deactivated: false,
        versionId: '1.1',
      );

      expect(didDocumentMetadata.created, equals(expected.created));
      expect(didDocumentMetadata.updated, equals(expected.updated));
      expect(didDocumentMetadata.deactivated, equals(expected.deactivated));
      expect(didDocumentMetadata.versionId, equals(expected.versionId));
      expect(didDocumentMetadata.nextUpdate, equals(expected.nextUpdate));
      expect(didDocumentMetadata.nextVersionId, equals(expected.nextVersionId));
      expect(didDocumentMetadata.equivalentId, equals(expected.equivalentId));
      expect(didDocumentMetadata.canonicalId, equals(expected.canonicalId));
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

      final String jsonString = jsonEncode(verificationMethod.toJson());
      const String expected = '{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"Ed25519VerificationKey2020",'
          '"controller":"did:example:123456789abcdefghi",'
          '"publicKeyJwk":null,'
          '"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}';

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const String jsonString = '{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"Ed25519VerificationKey2020",'
          '"controller":"did:example:123456789abcdefghi",'
          '"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}';

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final VerificationMethod verificationMethod =
          VerificationMethod.fromJson(jsonMap);

      final VerificationMethod expected = VerificationMethod(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'Ed25519VerificationKey2020',
        controller: 'did:example:123456789abcdefghi',
        publicKeyMultibase: 'zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV',
      );

      expect(verificationMethod.id, equals(expected.id));
      expect(verificationMethod.type, equals(expected.type));
      expect(verificationMethod.controller, equals(expected.controller));
      expect(verificationMethod.publicKeyJwk, equals(expected.publicKeyJwk));
      expect(
        verificationMethod.publicKeyMultibase,
        equals(expected.publicKeyMultibase),
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

      final String jsonString = jsonEncode(serviceEndpoint.toJson());
      const String expected = '{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"url",'
          '"serviceEndpoint":"https://datahouse.me",'
          '"description":"Health Data Store"}';

      expect(jsonString, equals(expected));
    });

    test('From JSON', () {
      const String jsonString = '{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"url",'
          '"serviceEndpoint":"https://datahouse.me",'
          '"description":"Health Data Store"}';

      final Map<String, dynamic> jsonMap =
          jsonDecode(jsonString) as Map<String, dynamic>;
      final ServiceEndpoint serviceEndpoint = ServiceEndpoint.fromJson(jsonMap);

      final ServiceEndpoint expected = ServiceEndpoint(
        id: 'did:example:123456789abcdefghi#key-1',
        type: 'url',
        serviceEndpoint: 'https://datahouse.me',
        description: 'Health Data Store',
      );

      expect(serviceEndpoint.id, equals(expected.id));
      expect(serviceEndpoint.type, equals(expected.type));
      expect(serviceEndpoint.serviceEndpoint, equals(expected.serviceEndpoint));
      expect(serviceEndpoint.description, equals(expected.description));
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

      final String jsonString = jsonEncode(didDocument.toJson());
      const String expected = '{'
          '"context":["https://www.w3.org/ns/did/v1"],'
          '"id":"did:example:123456789abcdefghi",'
          '"alsoKnownAs":"dave",'
          '"controller":["did:example:123456789abcdefghi"],'
          '"verificationMethod":[{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"Ed25519VerificationKey2020",'
          '"controller":"did:example:123456789abcdefghi",'
          '"publicKeyJwk":null,'
          '"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"'
          '}],'
          '"service":[{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"url","serviceEndpoint":"https://datahouse.me",'
          '"description":"Health Data Store"'
          '}],'
          '"authentication":[{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"Ed25519VerificationKey2020",'
          '"controller":"did:example:123456789abcdefghi",'
          '"publicKeyJwk":null,'
          '"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"'
          '}],'
          '"keyAgreement":[{'
          '"id":"did:example:123456789abcdefghi#key-1",'
          '"type":"Ed25519VerificationKey2020",'
          '"controller":"did:example:123456789abcdefghi",'
          '"publicKeyJwk":null,'
          '"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"'
          '}],'
          '"capabilityInvocation":[],'
          '"capabilityDelegation":[]}';

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

      final String jsonString = jsonEncode(didResolutionMetadata.toJson());
      const String expected = '{"contentType":null,"error":"notFound"}';

      expect(jsonString, equals(expected));
    });

    test('To JSON [invalidDID error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.invalidDID,
      );

      final String jsonString = jsonEncode(didResolutionMetadata.toJson());
      const String expected = '{"contentType":null,"error":"invalidDID"}';

      expect(jsonString, equals(expected));
    });

    test('To JSON [representationNotSupported error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.representationNotSupported,
      );

      final String jsonString = jsonEncode(didResolutionMetadata.toJson());
      const String expected =
          '{"contentType":null,"error":"representationNotSupported"}';

      expect(jsonString, equals(expected));
    });

    test('To JSON [unsupportedDIDMethod error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        error: DIDResolutionError.unsupportedDIDMethod,
      );

      final String jsonString = jsonEncode(didResolutionMetadata.toJson());
      const String expected =
          '{"contentType":null,"error":"unsupportedDIDMethod"}';

      expect(jsonString, equals(expected));
    });

    test('To JSON [no error]', () {
      final DIDResolutionMetadata didResolutionMetadata = DIDResolutionMetadata(
        contentType: 'did+json',
      );

      final String jsonString = jsonEncode(didResolutionMetadata.toJson());
      const String expected = '{"contentType":"did+json","error":null}';

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

      final String jsonString = jsonEncode(didResolutionResult.toJson());
      const String expected =
          '{"context":["https://www.w3.org/ns/did/v1"],"didResolutionMetadata":{"contentType":"did+json","error":null},"didDocument":{"context":["https://www.w3.org/ns/did/v1"],"id":"did:example:123456789abcdefghi","alsoKnownAs":"dave","controller":["did:example:123456789abcdefghi"],"verificationMethod":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"service":[{"id":"did:example:123456789abcdefghi#key-1","type":"url","serviceEndpoint":"https://datahouse.me","description":"Health Data Store"}],"authentication":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"keyAgreement":[{"id":"did:example:123456789abcdefghi#key-1","type":"Ed25519VerificationKey2020","controller":"did:example:123456789abcdefghi","publicKeyJwk":null,"publicKeyMultibase":"zH3C2AVvLMv6gmMNam3uVAjZpfkcJCwDwnZn6z3wXmqPV"}],"capabilityInvocation":[],"capabilityDelegation":[]},"didDocumentMetadata":{"created":"2022-08-02T08:45:21+0000","updated":"2022-08-02T08:45:21+0000","deactivated":false,"versionId":"1.1","nextUpdate":null,"nextVersionId":null,"equivalentId":null,"canonicalId":null}}';

      expect(jsonString, equals(expected));
    });
  });

  group('DIDResolver', () {
    test('Cannot have useRemote without useUrl', () {
      expect(() => DIDResolver(<DIDMethodResolver>[], useRemote: true),
          throwsArgumentError);
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
            headers: {'content-type': 'application/json'});
      });

      final DIDResolver resolver = DIDResolver(<DIDMethodResolver>[],
          useRemote: true, remoteUrl: 'https://datahouse.me', client: client);
      final DIDResolutionResult result =
          await resolver.resolve('did:example:123456789abcdefghi');

      expect(result.didDocument?.id, equals('did:example:123456789abcdefghi'));
    });
  });
}
