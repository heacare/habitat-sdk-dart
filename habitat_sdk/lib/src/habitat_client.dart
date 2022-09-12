/// High-level client for Habitat
class HabitatClient implements HabitatRequest {
  /// The current DID in use. Will become read-only in the future
  String? did;

  /// If an account has been connected
  bool get accountConnected => did == null;

  /// Builder for the current did
  @override
  Future<void> write(final String schema, final HabitatData data) {
    assert(accountConnected, 'Account not connected');
    return target(did!).write(schema, data);
  }

  /// Builder for the current did
  @override
  Future<void> queryAll(final String schema) async {
    assert(accountConnected, 'Account not connected');
    return target(did!).queryAll(schema);
  }

  /// Builder for the current did
  @override
  Future<void> permissionsQueryAll() async {
    assert(accountConnected, 'Account not connected');
    return target(did!).permissionsQueryAll();
  }

  /// Builder for a specific target
  HabitatRequest target(final String target) =>
      HabitatRequestClient(this, target: target);

  /// Builder for a set of permissions
  String permissionsRequest(final String method, final String schema) => 'test';
}

/// Request interface for Habitat
abstract class HabitatRequest {
  /// Write to a collection
  Future<void> write(final String schema, final HabitatData data);

  /// Query all data from a collection
  Future<void> queryAll(final String schema);

  /// Query all permissions objects
  Future<void> permissionsQueryAll();
}

/// Request client for Habitat
class HabitatRequestClient implements HabitatRequest {
  /// Construct a request
  const HabitatRequestClient(this.client, {required this.target});

  final HabitatClient client;
  final String target;

  @override
  Future<void> write(final String schema, final HabitatData data) async {}

  @override
  Future<void> queryAll(final String schema) async {}

  @override
  Future<void> permissionsQueryAll() async {}
}

/// Serialiser for message data
class HabitatData {
  /// Construct a message data object
  const HabitatData();
}
