// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'did_resolver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DIDResolutionResult _$DIDResolutionResultFromJson(Map<String, dynamic> json) =>
    DIDResolutionResult(
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['https://www.w3.org/ns/did/v1'],
      didResolutionMetadata: DIDResolutionMetadata.fromJson(
          json['didResolutionMetadata'] as Map<String, dynamic>),
      didDocument: json['didDocument'] == null
          ? null
          : DIDDocument.fromJson(json['didDocument'] as Map<String, dynamic>),
      didDocumentMetadata: json['didDocumentMetadata'] == null
          ? null
          : DIDDocumentMetadata.fromJson(
              json['didDocumentMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DIDResolutionResultToJson(
        DIDResolutionResult instance) =>
    <String, dynamic>{
      'context': instance.context,
      'didResolutionMetadata': instance.didResolutionMetadata,
      'didDocument': instance.didDocument,
      'didDocumentMetadata': instance.didDocumentMetadata,
    };

DIDResolutionMetadata _$DIDResolutionMetadataFromJson(
        Map<String, dynamic> json) =>
    DIDResolutionMetadata(
      contentType: json['contentType'] as String?,
      error: $enumDecodeNullable(_$DIDResolutionErrorEnumMap, json['error']),
    );

Map<String, dynamic> _$DIDResolutionMetadataToJson(
        DIDResolutionMetadata instance) =>
    <String, dynamic>{
      'contentType': instance.contentType,
      'error': _$DIDResolutionErrorEnumMap[instance.error],
    };

const _$DIDResolutionErrorEnumMap = {
  DIDResolutionError.invalidDID: 'invalidDID',
  DIDResolutionError.notFound: 'notFound',
  DIDResolutionError.representationNotSupported: 'representationNotSupported',
  DIDResolutionError.unsupportedDIDMethod: 'unsupportedDIDMethod',
};

DIDDocument _$DIDDocumentFromJson(Map<String, dynamic> json) => DIDDocument(
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>['https://www.w3.org/ns/did/v1'],
      id: json['id'] as String,
      alsoKnownAs: json['alsoKnownAs'] as String?,
      controller: (json['controller'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      verificationMethod: (json['verificationMethod'] as List<dynamic>?)
              ?.map(
                  (e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VerificationMethod>[],
      service: (json['service'] as List<dynamic>?)
              ?.map((e) => ServiceEndpoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ServiceEndpoint>[],
      authentication: (json['authentication'] as List<dynamic>?)
              ?.map(
                  (e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VerificationMethod>[],
      keyAgreement: (json['keyAgreement'] as List<dynamic>?)
              ?.map(
                  (e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VerificationMethod>[],
      capabilityInvocation: (json['capabilityInvocation'] as List<dynamic>?)
              ?.map(
                  (e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VerificationMethod>[],
      capabilityDelegation: (json['capabilityDelegation'] as List<dynamic>?)
              ?.map(
                  (e) => VerificationMethod.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <VerificationMethod>[],
    );

Map<String, dynamic> _$DIDDocumentToJson(DIDDocument instance) =>
    <String, dynamic>{
      'context': instance.context,
      'id': instance.id,
      'alsoKnownAs': instance.alsoKnownAs,
      'controller': instance.controller,
      'verificationMethod': instance.verificationMethod,
      'service': instance.service,
      'authentication': instance.authentication,
      'keyAgreement': instance.keyAgreement,
      'capabilityInvocation': instance.capabilityInvocation,
      'capabilityDelegation': instance.capabilityDelegation,
    };

ServiceEndpoint _$ServiceEndpointFromJson(Map<String, dynamic> json) =>
    ServiceEndpoint(
      id: json['id'] as String?,
      type: json['type'] as String?,
      serviceEndpoint: json['serviceEndpoint'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceEndpointToJson(ServiceEndpoint instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'serviceEndpoint': instance.serviceEndpoint,
      'description': instance.description,
    };

VerificationMethod _$VerificationMethodFromJson(Map<String, dynamic> json) =>
    VerificationMethod(
      id: json['id'] as String?,
      type: json['type'] as String?,
      controller: json['controller'] as String?,
      publicKeyJwk: json['publicKeyJwk'] as String?,
      publicKeyMultibase: json['publicKeyMultibase'] as String?,
    );

Map<String, dynamic> _$VerificationMethodToJson(VerificationMethod instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'controller': instance.controller,
      'publicKeyJwk': instance.publicKeyJwk,
      'publicKeyMultibase': instance.publicKeyMultibase,
    };

DIDDocumentMetadata _$DIDDocumentMetadataFromJson(Map<String, dynamic> json) =>
    DIDDocumentMetadata(
      created: json['created'] as String?,
      updated: json['updated'] as String?,
      deactivated: json['deactivated'] as bool?,
      versionId: json['versionId'] as String?,
      nextUpdate: json['nextUpdate'] as String?,
      nextVersionId: json['nextVersionId'] as String?,
      equivalentId: json['equivalentId'] as String?,
      canonicalId: json['canonicalId'] as String?,
    );

Map<String, dynamic> _$DIDDocumentMetadataToJson(
        DIDDocumentMetadata instance) =>
    <String, dynamic>{
      'created': instance.created,
      'updated': instance.updated,
      'deactivated': instance.deactivated,
      'versionId': instance.versionId,
      'nextUpdate': instance.nextUpdate,
      'nextVersionId': instance.nextVersionId,
      'equivalentId': instance.equivalentId,
      'canonicalId': instance.canonicalId,
    };
