// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionsRequestMessage _$PermissionsRequestMessageFromJson(
        Map<String, dynamic> json) =>
    PermissionsRequestMessage(
      data: _$JsonConverterFromJson<String, Uint8List>(
          json['data'], const JsonBase64UrlConverter().fromJson),
      descriptor: PermissionsRequestDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsRequestMessageToJson(
        PermissionsRequestMessage instance) =>
    <String, dynamic>{
      'data': _$JsonConverterToJson<String, Uint8List>(
          instance.data, const JsonBase64UrlConverter().toJson),
      'descriptor': instance.descriptor,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

PermissionsGrantMessage _$PermissionsGrantMessageFromJson(
        Map<String, dynamic> json) =>
    PermissionsGrantMessage(
      data: _$JsonConverterFromJson<String, Uint8List>(
          json['data'], const JsonBase64UrlConverter().fromJson),
      descriptor: PermissionsGrantDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsGrantMessageToJson(
        PermissionsGrantMessage instance) =>
    <String, dynamic>{
      'data': _$JsonConverterToJson<String, Uint8List>(
          instance.data, const JsonBase64UrlConverter().toJson),
      'descriptor': instance.descriptor,
    };

PermissionsRequestDescriptor _$PermissionsRequestDescriptorFromJson(
        Map<String, dynamic> json) =>
    PermissionsRequestDescriptor(
      nonce: json['nonce'] as String,
      grantedBy: json['grantedBy'] as String,
      description: json['description'] as String,
      grantedTo: json['grantedTo'] as String,
      scope: PermissionScope.fromJson(json['scope'] as Map<String, dynamic>),
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as Map<String, dynamic>),
      dataFormat: json['dataFormat'] as String?,
      permissionRequestId: json['permissionRequestId'] as String?,
      conditions: json['conditions'] == null
          ? null
          : PermissionConditions.fromJson(
              json['conditions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsRequestDescriptorToJson(
        PermissionsRequestDescriptor instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'dataCid': instance.dataCid,
      'dataFormat': instance.dataFormat,
      'permissionRequestId': instance.permissionRequestId,
      'description': instance.description,
      'grantedBy': instance.grantedBy,
      'grantedTo': instance.grantedTo,
      'scope': instance.scope,
      'conditions': instance.conditions,
    };

PermissionsGrantDescriptor _$PermissionsGrantDescriptorFromJson(
        Map<String, dynamic> json) =>
    PermissionsGrantDescriptor(
      nonce: json['nonce'] as String,
      permissionGrantId: json['permissionGrantId'] as String,
      grantedBy: json['grantedBy'] as String,
      description: json['description'] as String,
      grantedTo: json['grantedTo'] as String,
      expiry: json['expiry'] as String,
      scope: PermissionScope.fromJson(json['scope'] as Map<String, dynamic>),
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as Map<String, dynamic>),
      dataFormat: json['dataFormat'] as String?,
      permissionRequestId: json['permissionRequestId'] as String?,
      delegatedFrom: json['delegatedFrom'] as String?,
      conditions: json['conditions'] == null
          ? null
          : PermissionConditions.fromJson(
              json['conditions'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsGrantDescriptorToJson(
        PermissionsGrantDescriptor instance) =>
    <String, dynamic>{
      'nonce': instance.nonce,
      'dataCid': instance.dataCid,
      'dataFormat': instance.dataFormat,
      'permissionGrantId': instance.permissionGrantId,
      'permissionRequestId': instance.permissionRequestId,
      'description': instance.description,
      'grantedBy': instance.grantedBy,
      'grantedTo': instance.grantedTo,
      'delegatedFrom': instance.delegatedFrom,
      'expiry': instance.expiry,
      'scope': instance.scope,
      'conditions': instance.conditions,
    };

PermissionScope _$PermissionScopeFromJson(Map<String, dynamic> json) =>
    PermissionScope(
      method: json['method'] as String,
      schema: json['schema'] as String?,
    );

Map<String, dynamic> _$PermissionScopeToJson(PermissionScope instance) =>
    <String, dynamic>{
      'method': instance.method,
      'schema': instance.schema,
    };

PermissionConditions _$PermissionConditionsFromJson(
        Map<String, dynamic> json) =>
    PermissionConditions(
      attestation: $enumDecodeNullable(
          _$PermissionAttestationEnumMap, json['attestation']),
      encryption: $enumDecodeNullable(
          _$PermissionEncryptionEnumMap, json['encryption']),
      delegation: json['delegation'] as bool?,
      publication: json['publication'] as bool?,
      sharedAccess: json['sharedAccess'] as bool?,
    );

Map<String, dynamic> _$PermissionConditionsToJson(
        PermissionConditions instance) =>
    <String, dynamic>{
      'attestation': _$PermissionAttestationEnumMap[instance.attestation],
      'encryption': _$PermissionEncryptionEnumMap[instance.encryption],
      'delegation': instance.delegation,
      'publication': instance.publication,
      'sharedAccess': instance.sharedAccess,
    };

const _$PermissionAttestationEnumMap = {
  PermissionAttestation.prohibited: 'prohibited',
  PermissionAttestation.optional: 'optional',
  PermissionAttestation.required: 'required',
};

const _$PermissionEncryptionEnumMap = {
  PermissionEncryption.optional: 'optional',
  PermissionEncryption.required: 'required',
};
