import 'message.dart';

class MethodHandler<T extends Message<MessageDescriptor>> {
  /// Construct a method handler
  MethodHandler({
    required this.name,
    required this.fromJson,
    required this.handle,
  });

  /// Method name as specified in the descriptor.
  String name;

  /// Message parser function.
  T Function(Map<String, dynamic> json) fromJson;

  /// Method handler function.
  void Function(T message) handle;
}

abstract class Interface {
  /// A list of handlers
  Iterable<MethodHandler<dynamic>> get handlers;
}
