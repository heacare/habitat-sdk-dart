import 'collections.dart';
import 'interface.dart';

class CollectionsInterface implements Interface {
  @override
  List<MethodHandler<dynamic>> handlers = <MethodHandler<dynamic>>[
    MethodHandler<CollectionsQueryMessage>(
      name: 'CollectionsQuery',
      fromJson: CollectionsQueryMessage.fromJson,
      handle: (final CollectionsQueryMessage message) {
        print(message);
      },
    ),
    MethodHandler<CollectionsWriteMessage>(
      name: 'CollectionsWrite',
      fromJson: CollectionsWriteMessage.fromJson,
      handle: (final CollectionsWriteMessage message) {
        print(message);
      },
    ),
    MethodHandler<CollectionsCommitMessage>(
      name: 'CollectionsCommit',
      fromJson: CollectionsCommitMessage.fromJson,
      handle: (final CollectionsCommitMessage message) {
        print(message);
      },
    ),
  ];
}
