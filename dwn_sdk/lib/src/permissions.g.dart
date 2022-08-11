// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'permissions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PermissionsRequestMessage _$PermissionsRequestMessageFromJson(
        Map<String, dynamic> json) =>
    PermissionsRequestMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: PermissionsRequestDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsRequestMessageToJson(
    PermissionsRequestMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['descriptor'] = instance.descriptor;
  return val;
}

PermissionsGrantMessage _$PermissionsGrantMessageFromJson(
        Map<String, dynamic> json) =>
    PermissionsGrantMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: PermissionsGrantDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PermissionsGrantMessageToJson(
    PermissionsGrantMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['descriptor'] = instance.descriptor;
  return val;
}

PermissionsRequestDescriptor _$PermissionsRequestDescriptorFromJson(
        Map<String, dynamic> json) =>
    PermissionsRequestDescriptor(
      nonce: json['nonce'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      grantedBy: json['grantedBy'] as String,
      description: json['description'] as String,
      grantedTo: json['grantedTo'] as String,
      scope: PermissionScope.fromJson(json['scope'] as Map<String, dynamic>),
      permissionRequestId: json['permissionRequestId'] as String?,
      conditions: json['conditions'] == null
          ? null
          : PermissionConditions.fromJson(
              json['conditions'] as Map<String, dynamic>),
      method: json['method'] as String? ?? 'PermissionRequest',
    );

Map<String, dynamic> _$PermissionsRequestDescriptorToJson(
    PermissionsRequestDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
    'method': instance.method,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  writeNotNull('permissionRequestId', instance.permissionRequestId);
  val['description'] = instance.description;
  val['grantedBy'] = instance.grantedBy;
  val['grantedTo'] = instance.grantedTo;
  val['scope'] = instance.scope;
  writeNotNull('conditions', instance.conditions);
  return val;
}

PermissionsGrantDescriptor _$PermissionsGrantDescriptorFromJson(
        Map<String, dynamic> json) =>
    PermissionsGrantDescriptor(
      nonce: json['nonce'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      permissionGrantId: json['permissionGrantId'] as String,
      grantedBy: json['grantedBy'] as String,
      description: json['description'] as String,
      grantedTo: json['grantedTo'] as String,
      expiry: json['expiry'] as String,
      scope: PermissionScope.fromJson(json['scope'] as Map<String, dynamic>),
      permissionRequestId: json['permissionRequestId'] as String?,
      delegatedFrom: json['delegatedFrom'] as String?,
      conditions: json['conditions'] == null
          ? null
          : PermissionConditions.fromJson(
              json['conditions'] as Map<String, dynamic>),
      method: json['method'] as String? ?? 'PermissionsGrant',
    );

Map<String, dynamic> _$PermissionsGrantDescriptorToJson(
    PermissionsGrantDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
    'method': instance.method,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  val['permissionGrantId'] = instance.permissionGrantId;
  writeNotNull('permissionRequestId', instance.permissionRequestId);
  val['description'] = instance.description;
  val['grantedBy'] = instance.grantedBy;
  val['grantedTo'] = instance.grantedTo;
  writeNotNull('delegatedFrom', instance.delegatedFrom);
  val['expiry'] = instance.expiry;
  val['scope'] = instance.scope;
  writeNotNull('conditions', instance.conditions);
  return val;
}

PermissionScope _$PermissionScopeFromJson(Map<String, dynamic> json) =>
    PermissionScope(
      method: json['method'] as String,
      schema: json['schema'] as String?,
    );

Map<String, dynamic> _$PermissionScopeToJson(PermissionScope instance) {
  final val = <String, dynamic>{
    'method': instance.method,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('schema', instance.schema);
  return val;
}

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
    PermissionConditions instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'attestation', _$PermissionAttestationEnumMap[instance.attestation]);
  writeNotNull(
      'encryption', _$PermissionEncryptionEnumMap[instance.encryption]);
  writeNotNull('delegation', instance.delegation);
  writeNotNull('publication', instance.publication);
  writeNotNull('sharedAccess', instance.sharedAccess);
  return val;
}

const _$PermissionAttestationEnumMap = {
  PermissionAttestation.prohibited: 'prohibited',
  PermissionAttestation.optional: 'optional',
  PermissionAttestation.required: 'required',
};

const _$PermissionEncryptionEnumMap = {
  PermissionEncryption.optional: 'optional',
  PermissionEncryption.required: 'required',
};
