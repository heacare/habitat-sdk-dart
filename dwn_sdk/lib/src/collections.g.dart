// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionsDeleteMessage _$CollectionsDeleteMessageFromJson(
        Map<String, dynamic> json) =>
    CollectionsDeleteMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: CollectionsDeleteDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionsDeleteMessageToJson(
    CollectionsDeleteMessage instance) {
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

CollectionsDeleteDescriptor _$CollectionsDeleteDescriptorFromJson(
        Map<String, dynamic> json) =>
    CollectionsDeleteDescriptor(
      nonce: json['nonce'] as String,
      recordId: json['recordId'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
    );

Map<String, dynamic> _$CollectionsDeleteDescriptorToJson(
    CollectionsDeleteDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  val['recordId'] = instance.recordId;
  return val;
}

CollectionsCommitMessage _$CollectionsCommitMessageFromJson(
        Map<String, dynamic> json) =>
    CollectionsCommitMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: CollectionsCommitDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionsCommitMessageToJson(
    CollectionsCommitMessage instance) {
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

CollectionsCommitDescriptor _$CollectionsCommitDescriptorFromJson(
        Map<String, dynamic> json) =>
    CollectionsCommitDescriptor(
      nonce: json['nonce'] as String,
      recordId: json['recordId'] as String,
      dateCreated: json['dateCreated'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      schema: json['schema'] as String?,
      dataPublished: json['dataPublished'] as String?,
    );

Map<String, dynamic> _$CollectionsCommitDescriptorToJson(
    CollectionsCommitDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  writeNotNull('schema', instance.schema);
  val['recordId'] = instance.recordId;
  val['dateCreated'] = instance.dateCreated;
  writeNotNull('dataPublished', instance.dataPublished);
  return val;
}

CollectionsWriteMessage _$CollectionsWriteMessageFromJson(
        Map<String, dynamic> json) =>
    CollectionsWriteMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: CollectionsWriteDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionsWriteMessageToJson(
    CollectionsWriteMessage instance) {
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

CollectionsWriteDescriptor _$CollectionsWriteDescriptorFromJson(
        Map<String, dynamic> json) =>
    CollectionsWriteDescriptor(
      nonce: json['nonce'] as String,
      recordId: json['recordId'] as String,
      dateCreated: json['dateCreated'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      schema: json['schema'] as String?,
      published: json['published'] as bool?,
      dataPublished: json['dataPublished'] as String?,
    );

Map<String, dynamic> _$CollectionsWriteDescriptorToJson(
    CollectionsWriteDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  writeNotNull('schema', instance.schema);
  val['recordId'] = instance.recordId;
  writeNotNull('published', instance.published);
  val['dateCreated'] = instance.dateCreated;
  writeNotNull('dataPublished', instance.dataPublished);
  return val;
}

CollectionsQueryMessage _$CollectionsQueryMessageFromJson(
        Map<String, dynamic> json) =>
    CollectionsQueryMessage(
      data: json['data'] == null ? null : MessageData.fromJson(json['data']),
      descriptor: CollectionsQueryDescriptor.fromJson(
          json['descriptor'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CollectionsQueryMessageToJson(
    CollectionsQueryMessage instance) {
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

CollectionsQueryDescriptor _$CollectionsQueryDescriptorFromJson(
        Map<String, dynamic> json) =>
    CollectionsQueryDescriptor(
      nonce: json['nonce'] as String,
      dataCid: json['dataCid'] == null
          ? null
          : CID.fromJson(json['dataCid'] as String),
      dataFormat: json['dataFormat'] as String?,
      schema: json['schema'] as String?,
      recordId: json['recordId'] as String?,
      dateSort:
          $enumDecodeNullable(_$CollectionDateSortEnumMap, json['dateSort']),
    );

Map<String, dynamic> _$CollectionsQueryDescriptorToJson(
    CollectionsQueryDescriptor instance) {
  final val = <String, dynamic>{
    'nonce': instance.nonce,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dataCid', instance.dataCid);
  writeNotNull('dataFormat', instance.dataFormat);
  writeNotNull('schema', instance.schema);
  writeNotNull('recordId', instance.recordId);
  writeNotNull('dateSort', _$CollectionDateSortEnumMap[instance.dateSort]);
  return val;
}

const _$CollectionDateSortEnumMap = {
  CollectionDateSort.createdAscending: 'createdAscending',
  CollectionDateSort.createdDescending: 'createdDescending',
  CollectionDateSort.publishedAscending: 'publishedAscending',
  CollectionDateSort.publishedDescending: 'publishedDescending',
};
