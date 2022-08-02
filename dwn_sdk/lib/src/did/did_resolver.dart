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
  Future<DIDResolutionResult> resolve(final String did) {
    if (useRemote) {
      throw UnimplementedError(
          'Remote DID resolvers have not been implemented yet');
    } else {
      throw UnimplementedError(
          'Local DID resolvers have not been implemented yet');
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
class DIDResolutionResult {
  /// Initialize the [DIDResolutionResult]
  DIDResolutionResult({
    this.context = const <String>['https://www.w3.org/ns/did/v1'],
    required this.didResolutionMetadata,
    this.didDocument,
    this.didDocumentMetadata,
  });

  /// A copy of the context from the DID Document.
  final List<String> context;

  /// The metadata associated to the DID Resolution operation.
  final DIDResolutionMetadata didResolutionMetadata;

  /// The resolved DID Document if successful.
  final DIDDocument? didDocument;

  /// The DID Document metadata associated with the resolved document.
  final DIDDocumentMetadata? didDocumentMetadata;
}

/// A model of a DID Document.
///
/// View https://www.w3.org/TR/did-core/#did-documents
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
class ServiceEndpoint {
  /// Initialize the [ServiceEndpoint] type.
  ServiceEndpoint({
    this.id,
    this.type,
    this.serviceEndpoint,
    this.description,
  });

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
class VerificationMethod {
  /// Initialize the [VerificationMethod] type
  VerificationMethod({
    this.id,
    this.type,
    this.controller,
    this.publicKeyJwk,
    this.publicKeyMultibase,
  });

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

/// The fields of metadata related to a DID Resolution operation.
class DIDResolutionMetadata {
  /// Initialize the [DIDResolutionMetadata] type.
  DIDResolutionMetadata({
    this.contentType,
    this.error,
  });

  /// The contentType of the resolved DID Document.
  final String? contentType;

  /// The error thrown by the DID Resolver.
  final DIDResolutionError? error;
}

/// The errors that might rise from a DID Resolution operation.
enum DIDResolutionError {
  invalidDID,
  notFound,
  representationNotSupported,
  unsupportedDIDMethod
}

/// A model of the metadata attached to a DID Document.
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

  /// The ISO8601 timestamp of the Create operation.
  final String? created;

  /// The ISO8601 timestamp of the last Update operation for the resolved document version.
  final String? updated;

  /// The activity state of the DID.
  final bool? deactivated;

  /// The version of the last Update opeation that was resolved.
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
