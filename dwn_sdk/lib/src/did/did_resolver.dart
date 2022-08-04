import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

part 'did_resolver.g.dart';

/// The overall resolver for all DIDs across all implemented local and remote methods
///
/// View https://www.w3.org/TR/did-core/#resolution
class DIDResolver {
  /// Initialize the DID Resolver, and load resolvers in the map.
  DIDResolver(
    final List<DIDMethodResolver> resolvers, {
    this.useRemote = true,
    this.remoteUrl,
  }) {
    // Validate that if remote is enabled, the URL is provided
    if (useRemote && remoteUrl == null) {
      throw ArgumentError('Cannot useRemote without remoteUrl');
    }

    for (final DIDMethodResolver resolver in resolvers) {
      // Loading the resolvers into the map
      didMethodResolvers[resolver.method()] = resolver;
    }
  }

  /// The lookup map of methods to resolvers.
  final Map<String, DIDMethodResolver> didMethodResolvers =
      <String, DIDMethodResolver>{};

  /// The choice of whether a remote universal resolver is used.
  ///
  /// View https://github.com/decentralized-identity/universal-resolver
  final bool useRemote;

  /// The URL to access the remote resolver
  final String? remoteUrl;

  /// Resolve a DID with a variety of methods.
  ///
  /// If [useRemote] is True: Uses a remote [Universal Resolver](https://github.com/decentralized-identity/universal-resolver)
  /// If [useRemote] is False: Uses the locally implemented method resolvers
  Future<DIDResolutionResult> resolve(final String did) async {
    if (useRemote) {
      final Uri url = Uri.parse('$remoteUrl/1.0/identifiers/$did');
      final http.Response response =
          await http.get(url, headers: {'Accept': 'application/did+json'});

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final Map<String, dynamic> didResolutionResult =
          jsonDecode(response.body) as Map<String, dynamic>;

      return DIDResolutionResult.fromJson(didResolutionResult);
    } else {
      throw UnimplementedError(
        'Local DID resolvers have not been implemented yet',
      );
    }
  }
}

/// A generic interface that can be implemented for individual DID Methods.
abstract class DIDMethodResolver {
  /// Returns the DID Method supported by [DIDMethodResolver.resolve()].
  String method();

  /// Resolves the provided DID into its respective DID Document.
  Future<DIDResolutionResult> resolve();
}

/// The return format of a DID Resolution operation.
@JsonSerializable()
class DIDResolutionResult {
  /// Initialize the [DIDResolutionResult]
  DIDResolutionResult({
    this.context = const <String>['https://www.w3.org/ns/did/v1'],
    required this.didResolutionMetadata,
    this.didDocument,
    this.didDocumentMetadata,
  });

  /// Deserialize class from JSON
  factory DIDResolutionResult.fromJson(final Map<String, dynamic> json) =>
      _$DIDResolutionResultFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$DIDResolutionResultToJson(this);

  /// A copy of the context from the DID Document.
  final List<String> context;

  /// The metadata associated to the DID Resolution operation.
  final DIDResolutionMetadata didResolutionMetadata;

  /// The resolved DID Document if successful.
  final DIDDocument? didDocument;

  /// The DID Document metadata associated with the resolved document.
  final DIDDocumentMetadata? didDocumentMetadata;
}

/// The fields of metadata related to a DID Resolution operation.
@JsonSerializable()
class DIDResolutionMetadata {
  /// Initialize the [DIDResolutionMetadata] type.
  DIDResolutionMetadata({
    this.contentType,
    this.error,
  });

  /// Deserialize class from JSON
  factory DIDResolutionMetadata.fromJson(final Map<String, dynamic> json) =>
      _$DIDResolutionMetadataFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$DIDResolutionMetadataToJson(this);

  /// The contentType of the resolved DID Document.
  final String? contentType;

  /// The error thrown by the DID Resolver.
  final DIDResolutionError? error;
}

/// The errors that might rise from a DID Resolution operation.
@JsonEnum()
enum DIDResolutionError {
  /// The DID supplied to the DID resolution function does not conform to valid syntax.
  invalidDID,

  /// The DID resolver was unable to find the DID document resulting from this resolution request.
  notFound,

  /// This error code is returned if the representation requested via the accept input metadata
  /// property is not supported by the DID method and/or DID resolver implementation.
  representationNotSupported,

  /// The requested DID method is not supported
  unsupportedDIDMethod
}

/// A model of a DID Document.
///
/// View https://www.w3.org/TR/did-core/#did-documents
@JsonSerializable()
class DIDDocument {
  /// Initialize the [DIDDocument] type.
  DIDDocument({
    this.context = const <String>['https://www.w3.org/ns/did/v1'],
    required this.id,
    this.alsoKnownAs,
    this.controller = const <String>[],
    this.verificationMethod = const <VerificationMethod>[],
    this.service = const <ServiceEndpoint>[],
    this.authentication = const <VerificationMethod>[],
    this.keyAgreement = const <VerificationMethod>[],
    this.capabilityInvocation = const <VerificationMethod>[],
    this.capabilityDelegation = const <VerificationMethod>[],
  });

  /// Deserialize class from JSON
  factory DIDDocument.fromJson(final Map<String, dynamic> json) =>
      _$DIDDocumentFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$DIDDocumentToJson(this);

  final List<String> context;
  final String id;
  final String? alsoKnownAs;
  final List<String> controller;
  final List<VerificationMethod> verificationMethod;
  final List<ServiceEndpoint> service;
  final List<VerificationMethod> authentication;
  final List<VerificationMethod> keyAgreement;
  final List<VerificationMethod> capabilityInvocation;
  final List<VerificationMethod> capabilityDelegation;
}

/// A model of a service endpoint.
///
/// View https://www.w3.org/TR/did-core/#dfn-service-endpoints
@JsonSerializable()
class ServiceEndpoint {
  /// Initialize the [ServiceEndpoint] type.
  ServiceEndpoint({
    this.id,
    this.type,
    this.serviceEndpoint,
    this.description,
  });

  /// Deserialize class from JSON
  factory ServiceEndpoint.fromJson(final Map<String, dynamic> json) =>
      _$ServiceEndpointFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$ServiceEndpointToJson(this);

  /// A DID URL, conformat to the [DID URL Syntax]:https://www.w3.org/TR/did-core/#did-url-syntax.
  final String? id;

  /// The type of the serviceEndpoint.
  final String? type;

  /// The URL endpoint corresponding to the service.
  final String? serviceEndpoint;

  /// The description of the service endpoint.
  final String? description;
}

/// A model of a specific verification method.
///
/// View https://www.w3.org/TR/did-core/#verification-methods
@JsonSerializable()
class VerificationMethod {
  /// Initialize the [VerificationMethod] type
  VerificationMethod({
    this.id,
    this.type,
    this.controller,
    this.publicKeyJwk,
    this.publicKeyMultibase,
  });

  /// Deserialize class from JSON
  factory VerificationMethod.fromJson(final Map<String, dynamic> json) =>
      _$VerificationMethodFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$VerificationMethodToJson(this);

  /// A DID URL, conformat to the [DID URL Syntax]:https://www.w3.org/TR/did-core/#did-url-syntax.
  final String? id;

  /// A verification method type.
  final String? type;

  /// The DID URI pointing to the controller of the resolved DID Document.
  final String? controller;

  /// A JSON Web Key to act a Verification Material.
  final String? publicKeyJwk;

  /// A Public Key Multibase to act as [Verification Material]:https://www.w3.org/TR/did-core/#verification-material.
  final String? publicKeyMultibase;
}

/// A model of the metadata attached to a DID Document.
@JsonSerializable()
class DIDDocumentMetadata {
  /// Initialize the [DIDDocumentMetadata] type.
  DIDDocumentMetadata({
    this.created,
    this.updated,
    this.deactivated,
    this.versionId,
    this.nextUpdate,
    this.nextVersionId,
    this.equivalentId,
    this.canonicalId,
  });

  /// Deserialize class from JSON
  factory DIDDocumentMetadata.fromJson(final Map<String, dynamic> json) =>
      _$DIDDocumentMetadataFromJson(json);

  /// Serialize class to JSON
  Map<String, dynamic> toJson() => _$DIDDocumentMetadataToJson(this);

  /// The ISO8601 timestamp of the Create operation.
  final String? created;

  /// The ISO8601 timestamp of the last Update operation for the resolved document version.
  final String? updated;

  /// The activity state of the DID.
  final bool? deactivated;

  /// The version of the last Update operation that was resolved.
  final String? versionId;

  /// The ISO8601 timestamp of the next Update operation if the resolved document version
  /// is not the latest one.
  final String? nextUpdate;

  /// The version of the next Update operation if the resolved document version
  /// is not the latest one.
  final String? nextVersionId;

  /// See https://www.w3.org/TR/did-core/#dfn-equivalentid
  final String? equivalentId;

  /// See https://www.w3.org/TR/did-core/#dfn-canonicalid
  final String? canonicalId;
}
