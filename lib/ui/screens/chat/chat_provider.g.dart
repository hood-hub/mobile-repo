// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getGroupsHash() => r'1e03004f5ff2fa151663026af4d6f022f9a773d5';

/// See also [getGroups].
@ProviderFor(getGroups)
final getGroupsProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  getGroups,
  name: r'getGroupsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getGroupsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetGroupsRef = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getDMsHash() => r'a57f9d63989d37a7736c4eec0105388bd73ab60c';

/// See also [getDMs].
@ProviderFor(getDMs)
final getDMsProvider =
    AutoDisposeFutureProvider<List<Map<String, dynamic>>>.internal(
  getDMs,
  name: r'getDMsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getDMsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetDMsRef = AutoDisposeFutureProviderRef<List<Map<String, dynamic>>>;
String _$getMessagesHash() => r'7c5d48ad9f5b5d30ac2226be83b6d73120dac851';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [getMessages].
@ProviderFor(getMessages)
const getMessagesProvider = GetMessagesFamily();

/// See also [getMessages].
class GetMessagesFamily extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [getMessages].
  const GetMessagesFamily();

  /// See also [getMessages].
  GetMessagesProvider call({
    required String chatId,
    required bool isGroup,
  }) {
    return GetMessagesProvider(
      chatId: chatId,
      isGroup: isGroup,
    );
  }

  @override
  GetMessagesProvider getProviderOverride(
    covariant GetMessagesProvider provider,
  ) {
    return call(
      chatId: provider.chatId,
      isGroup: provider.isGroup,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMessagesProvider';
}

/// See also [getMessages].
class GetMessagesProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [getMessages].
  GetMessagesProvider({
    required String chatId,
    required bool isGroup,
  }) : this._internal(
          (ref) => getMessages(
            ref as GetMessagesRef,
            chatId: chatId,
            isGroup: isGroup,
          ),
          from: getMessagesProvider,
          name: r'getMessagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMessagesHash,
          dependencies: GetMessagesFamily._dependencies,
          allTransitiveDependencies:
              GetMessagesFamily._allTransitiveDependencies,
          chatId: chatId,
          isGroup: isGroup,
        );

  GetMessagesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
    required this.isGroup,
  }) : super.internal();

  final String chatId;
  final bool isGroup;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(GetMessagesRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMessagesProvider._internal(
        (ref) => create(ref as GetMessagesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
        isGroup: isGroup,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _GetMessagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMessagesProvider &&
        other.chatId == chatId &&
        other.isGroup == isGroup;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);
    hash = _SystemHash.combine(hash, isGroup.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMessagesRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `chatId` of this provider.
  String get chatId;

  /// The parameter `isGroup` of this provider.
  bool get isGroup;
}

class _GetMessagesProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with GetMessagesRef {
  _GetMessagesProviderElement(super.provider);

  @override
  String get chatId => (origin as GetMessagesProvider).chatId;
  @override
  bool get isGroup => (origin as GetMessagesProvider).isGroup;
}

String _$getMessagesByGroupHash() =>
    r'01f0c8d4db495510e4c6caa11c484d0366f512e9';

/// See also [getMessagesByGroup].
@ProviderFor(getMessagesByGroup)
const getMessagesByGroupProvider = GetMessagesByGroupFamily();

/// See also [getMessagesByGroup].
class GetMessagesByGroupFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [getMessagesByGroup].
  const GetMessagesByGroupFamily();

  /// See also [getMessagesByGroup].
  GetMessagesByGroupProvider call({
    required String groupId,
  }) {
    return GetMessagesByGroupProvider(
      groupId: groupId,
    );
  }

  @override
  GetMessagesByGroupProvider getProviderOverride(
    covariant GetMessagesByGroupProvider provider,
  ) {
    return call(
      groupId: provider.groupId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMessagesByGroupProvider';
}

/// See also [getMessagesByGroup].
class GetMessagesByGroupProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [getMessagesByGroup].
  GetMessagesByGroupProvider({
    required String groupId,
  }) : this._internal(
          (ref) => getMessagesByGroup(
            ref as GetMessagesByGroupRef,
            groupId: groupId,
          ),
          from: getMessagesByGroupProvider,
          name: r'getMessagesByGroupProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMessagesByGroupHash,
          dependencies: GetMessagesByGroupFamily._dependencies,
          allTransitiveDependencies:
              GetMessagesByGroupFamily._allTransitiveDependencies,
          groupId: groupId,
        );

  GetMessagesByGroupProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupId,
  }) : super.internal();

  final String groupId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(
            GetMessagesByGroupRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMessagesByGroupProvider._internal(
        (ref) => create(ref as GetMessagesByGroupRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupId: groupId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _GetMessagesByGroupProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMessagesByGroupProvider && other.groupId == groupId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMessagesByGroupRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `groupId` of this provider.
  String get groupId;
}

class _GetMessagesByGroupProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with GetMessagesByGroupRef {
  _GetMessagesByGroupProviderElement(super.provider);

  @override
  String get groupId => (origin as GetMessagesByGroupProvider).groupId;
}

String _$getMessagesByDMHash() => r'86ce7c59700c4e280c80d147efbd5158c7753256';

/// See also [getMessagesByDM].
@ProviderFor(getMessagesByDM)
const getMessagesByDMProvider = GetMessagesByDMFamily();

/// See also [getMessagesByDM].
class GetMessagesByDMFamily
    extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [getMessagesByDM].
  const GetMessagesByDMFamily();

  /// See also [getMessagesByDM].
  GetMessagesByDMProvider call({
    required String dmId,
  }) {
    return GetMessagesByDMProvider(
      dmId: dmId,
    );
  }

  @override
  GetMessagesByDMProvider getProviderOverride(
    covariant GetMessagesByDMProvider provider,
  ) {
    return call(
      dmId: provider.dmId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getMessagesByDMProvider';
}

/// See also [getMessagesByDM].
class GetMessagesByDMProvider
    extends AutoDisposeFutureProvider<List<Map<String, dynamic>>> {
  /// See also [getMessagesByDM].
  GetMessagesByDMProvider({
    required String dmId,
  }) : this._internal(
          (ref) => getMessagesByDM(
            ref as GetMessagesByDMRef,
            dmId: dmId,
          ),
          from: getMessagesByDMProvider,
          name: r'getMessagesByDMProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getMessagesByDMHash,
          dependencies: GetMessagesByDMFamily._dependencies,
          allTransitiveDependencies:
              GetMessagesByDMFamily._allTransitiveDependencies,
          dmId: dmId,
        );

  GetMessagesByDMProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dmId,
  }) : super.internal();

  final String dmId;

  @override
  Override overrideWith(
    FutureOr<List<Map<String, dynamic>>> Function(GetMessagesByDMRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetMessagesByDMProvider._internal(
        (ref) => create(ref as GetMessagesByDMRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dmId: dmId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Map<String, dynamic>>> createElement() {
    return _GetMessagesByDMProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetMessagesByDMProvider && other.dmId == dmId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dmId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetMessagesByDMRef
    on AutoDisposeFutureProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `dmId` of this provider.
  String get dmId;
}

class _GetMessagesByDMProviderElement
    extends AutoDisposeFutureProviderElement<List<Map<String, dynamic>>>
    with GetMessagesByDMRef {
  _GetMessagesByDMProviderElement(super.provider);

  @override
  String get dmId => (origin as GetMessagesByDMProvider).dmId;
}

String _$chatFilterHash() => r'139ef32c228df3a71a14f16a5e3deb81b1a85c1f';

/// See also [ChatFilter].
@ProviderFor(ChatFilter)
final chatFilterProvider =
    AutoDisposeNotifierProvider<ChatFilter, String>.internal(
  ChatFilter.new,
  name: r'chatFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatFilter = AutoDisposeNotifier<String>;
String _$groupListNotifierHash() => r'2752730082519867155c66d656b487f53cbcb10c';

/// See also [GroupListNotifier].
@ProviderFor(GroupListNotifier)
final groupListNotifierProvider = AutoDisposeAsyncNotifierProvider<
    GroupListNotifier, List<Map<String, dynamic>>>.internal(
  GroupListNotifier.new,
  name: r'groupListNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$groupListNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GroupListNotifier
    = AutoDisposeAsyncNotifier<List<Map<String, dynamic>>>;
String _$getChatListHash() => r'0b0f5d9ab4b033781b0b4f8aae595655b9edcf4f';

/// See also [GetChatList].
@ProviderFor(GetChatList)
final getChatListProvider = AutoDisposeAsyncNotifierProvider<GetChatList,
    List<Map<String, dynamic>>>.internal(
  GetChatList.new,
  name: r'getChatListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getChatListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GetChatList = AutoDisposeAsyncNotifier<List<Map<String, dynamic>>>;
String _$messageNotifierHash() => r'ce598171e8c5a9ab299f0478bc8832f999d75ba9';

abstract class _$MessageNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<Message>> {
  late final String chatId;
  late final bool isGroup;

  FutureOr<List<Message>> build(
    String chatId,
    bool isGroup,
  );
}

/// See also [MessageNotifier].
@ProviderFor(MessageNotifier)
const messageNotifierProvider = MessageNotifierFamily();

/// See also [MessageNotifier].
class MessageNotifierFamily extends Family<AsyncValue<List<Message>>> {
  /// See also [MessageNotifier].
  const MessageNotifierFamily();

  /// See also [MessageNotifier].
  MessageNotifierProvider call(
    String chatId,
    bool isGroup,
  ) {
    return MessageNotifierProvider(
      chatId,
      isGroup,
    );
  }

  @override
  MessageNotifierProvider getProviderOverride(
    covariant MessageNotifierProvider provider,
  ) {
    return call(
      provider.chatId,
      provider.isGroup,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageNotifierProvider';
}

/// See also [MessageNotifier].
class MessageNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MessageNotifier, List<Message>> {
  /// See also [MessageNotifier].
  MessageNotifierProvider(
    String chatId,
    bool isGroup,
  ) : this._internal(
          () => MessageNotifier()
            ..chatId = chatId
            ..isGroup = isGroup,
          from: messageNotifierProvider,
          name: r'messageNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageNotifierHash,
          dependencies: MessageNotifierFamily._dependencies,
          allTransitiveDependencies:
              MessageNotifierFamily._allTransitiveDependencies,
          chatId: chatId,
          isGroup: isGroup,
        );

  MessageNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
    required this.isGroup,
  }) : super.internal();

  final String chatId;
  final bool isGroup;

  @override
  FutureOr<List<Message>> runNotifierBuild(
    covariant MessageNotifier notifier,
  ) {
    return notifier.build(
      chatId,
      isGroup,
    );
  }

  @override
  Override overrideWith(MessageNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageNotifierProvider._internal(
        () => create()
          ..chatId = chatId
          ..isGroup = isGroup,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
        isGroup: isGroup,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MessageNotifier, List<Message>>
      createElement() {
    return _MessageNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageNotifierProvider &&
        other.chatId == chatId &&
        other.isGroup == isGroup;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);
    hash = _SystemHash.combine(hash, isGroup.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MessageNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<Message>> {
  /// The parameter `chatId` of this provider.
  String get chatId;

  /// The parameter `isGroup` of this provider.
  bool get isGroup;
}

class _MessageNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MessageNotifier,
        List<Message>> with MessageNotifierRef {
  _MessageNotifierProviderElement(super.provider);

  @override
  String get chatId => (origin as MessageNotifierProvider).chatId;
  @override
  bool get isGroup => (origin as MessageNotifierProvider).isGroup;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
