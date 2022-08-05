/// CID parsing and generation.
class CID {
  /// Construct a new placeholder CID.
  CID();

  /// Parse a CID from a JSON string.
  // ignore: avoid_unused_constructor_parameters
  factory CID.fromJson(final String json) => CID();

  /// Format a CID into a JSON string.
  Map<String, dynamic> toJson() => <String, dynamic>{'oops': 'im dead'};
}
