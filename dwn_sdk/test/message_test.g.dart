// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_test.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestMessage _$TestMessageFromJson(Map<String, dynamic> json) => TestMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: MessageDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
      authorization: json['authorization'] == null
          ? null
          : MessageAuthorization.fromJson(
              json['authorization'] as Map<String, dynamic>),
      attestation: json['attestation'] == null
          ? null
          : MessageAttestation.fromJson(
              json['attestation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TestMessageToJson(TestMessage instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['descriptor'] = instance.descriptor;
  writeNotNull('authorization', instance.authorization);
  writeNotNull('attestation', instance.attestation);
  return val;
}

Test2Message _$Test2MessageFromJson(Map<String, dynamic> json) => Test2Message(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: Test2MessageDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
      authorization: json['authorization'] == null
          ? null
          : MessageAuthorization.fromJson(
              json['authorization'] as Map<String, dynamic>),
      attestation: json['attestation'] == null
          ? null
          : MessageAttestation.fromJson(
              json['attestation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$Test2MessageToJson(Test2Message instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  val['descriptor'] = instance.descriptor;
  writeNotNull('authorization', instance.authorization);
  writeNotNull('attestation', instance.attestation);
  return val;
}

Test2MessageDescriptor _$Test2MessageDescriptorFromJson(
        Map<String, dynamic> json) =>
    Test2MessageDescriptor(
      nonce: json['nonce'] as String,
      method: json['method'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      testParameter: json['testParameter'] as String,
    );

Map<String, dynamic> _$Test2MessageDescriptorToJson(
    Test2MessageDescriptor instance) {
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
  val['testParameter'] = instance.testParameter;
  return val;
}
