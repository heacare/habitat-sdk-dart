import 'package:json_annotation/json_annotation.dart';

import 'cid.dart';
import 'message.dart';

part 'collections.g.dart';

/// A CollectionsDeleteMessage
@JsonSerializable()
class CollectionsDeleteMessage extends Message<CollectionsDeleteDescriptor> {
  /// Constructs a new CollectionsDelete message
  CollectionsDeleteMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory CollectionsDeleteMessage.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsDeleteMessageFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsDeleteMessageToJson(this);
}

/// A [MessageDescriptor] for a [CollectionsDeleteMessage]
@JsonSerializable()
class CollectionsDeleteDescriptor extends MessageDescriptor {
  /// Constructor
  const CollectionsDeleteDescriptor({
    required final super.nonce,
    required this.recordId,
    final super.dataCid,
    final super.dataFormat,
  }) : super(method: 'CollectionsDelete');

  /// Deserialize object from JSON
  factory CollectionsDeleteDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsDeleteDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsDeleteDescriptorToJson(this);

  /// An UUIDv4 string
  final String recordId;
}

/// A CollectionsCommitMessage
@JsonSerializable()
class CollectionsCommitMessage extends Message<CollectionsCommitDescriptor> {
  /// Constructs a new CollectionsCommit message
  CollectionsCommitMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory CollectionsCommitMessage.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsCommitMessageFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsCommitMessageToJson(this);
}

/// A [MessageDescriptor] for a [CollectionsCommitMessage]
@JsonSerializable()
class CollectionsCommitDescriptor extends MessageDescriptor {
  /// Constructor
  const CollectionsCommitDescriptor({
    required final super.nonce,
    required this.recordId,
    required this.dateCreated,
    final super.dataCid,
    final super.dataFormat,
    this.schema,
    this.dataPublished,
  }) : super(method: 'CollectionsCommit');

  /// Deserialize object from JSON
  factory CollectionsCommitDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsCommitDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsCommitDescriptorToJson(this);

  /// An URI string that ndicates the schema of the associated data.
  final String? schema;

  /// An UUIDv4 string
  final String recordId;

  /// An UNIX Epoch timestamp which is the time when the logical entry is created.
  final String dateCreated;

  /// An UNIX Epoch timestamp which is the time when the logical entry is published.
  final String? dataPublished;
}

/// A CollectionsWriteMessage
@JsonSerializable()
class CollectionsWriteMessage extends Message<CollectionsWriteDescriptor> {
  /// Constructs a new CollectionsWrite message
  CollectionsWriteMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory CollectionsWriteMessage.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsWriteMessageFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsWriteMessageToJson(this);
}

/// A [MessageDescriptor] for a [CollectionsWriteMessage]
@JsonSerializable()
class CollectionsWriteDescriptor extends MessageDescriptor {
  /// Constructor
  const CollectionsWriteDescriptor({
    required final super.nonce,
    required this.recordId,
    required this.dateCreated,
    final super.dataCid,
    final super.dataFormat,
    this.schema,
    this.published,
    this.dataPublished,
  }) : super(method: 'CollectionsWrite');

  /// Deserialize object from JSON
  factory CollectionsWriteDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsWriteDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsWriteDescriptorToJson(this);

  /// An URI string that ndicates the schema of the associated data.
  final String? schema;

  /// An UUIDv4 string
  final String recordId;

  /// The record's publication state.
  ///
  /// ```True``` if the record has been published for public queries and consumption without requiring authorization.
  /// ```False``` if the record MUST NOT be served in response to public queries that lack proper authorization.
  final bool? published;

  /// An UNIX Epoch timestamp which is the time when the logical entry is created.
  final String dateCreated;

  /// An UNIX Epoch timestamp which is the time when the logical entry is published.
  final String? dataPublished;
}

/// A CollectionsQueryMessage
@JsonSerializable()
class CollectionsQueryMessage extends Message<CollectionsQueryDescriptor> {
  /// Constructs a new CollectionsQuery message
  CollectionsQueryMessage({
    final super.data,
    required final super.descriptor,
  });

  /// Deserialize object from JSON
  factory CollectionsQueryMessage.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsQueryMessageFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsQueryMessageToJson(this);
}

/// A [MessageDescriptor] for a [CollectionsQueryMessage]
@JsonSerializable()
class CollectionsQueryDescriptor extends MessageDescriptor {
  /// Constructor
  const CollectionsQueryDescriptor({
    required final super.nonce,
    final super.dataCid,
    final super.dataFormat,
    this.schema,
    this.recordId,
    this.dateSort,
  }) : super(method: 'CollectionsQuery');

  /// Deserialize object from JSON
  factory CollectionsQueryDescriptor.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$CollectionsQueryDescriptorFromJson(json);

  /// Serialize object to JSON
  @override
  Map<String, dynamic> toJson() => _$CollectionsQueryDescriptorToJson(this);

  /// An URI string that ndicates the schema of the associated data.
  final String? schema;

  /// An UUIDv4 string
  final String? recordId;

  /// The format of the data in accordance to MIME type declaration.
  final CollectionDateSort? dateSort;
}

/// The sort order of the returned collection.
@JsonEnum()
enum CollectionDateSort {
  /// Return results in order from the earliest dateCreated value to the latest.
  createdAscending,

  /// Return results in order from the latest dateCreated value to the earliest.
  createdDescending,

  /// Return results in order from the earliest datePublished value to the latest.
  publishedAscending,

  /// Return results in order from the latest datePublished value to the earliest.
  publishedDescending,
}
