// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mediaServiceHash() => r'3bf2cb53cf35b4c03b13c39f850dc4e5145b0e91';

/// See also [mediaService].
@ProviderFor(mediaService)
final mediaServiceProvider = AutoDisposeProvider<MediaService>.internal(
  mediaService,
  name: r'mediaServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mediaServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MediaServiceRef = AutoDisposeProviderRef<MediaService>;
String _$createPostHash() => r'9677c5a6cfb210fbf6c8a9692b55eaaf0f69b9d8';

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

/// See also [createPost].
@ProviderFor(createPost)
const createPostProvider = CreatePostFamily();

/// See also [createPost].
class CreatePostFamily extends Family<AsyncValue<Object?>> {
  /// See also [createPost].
  const CreatePostFamily();

  /// See also [createPost].
  CreatePostProvider call({
    dynamic body,
  }) {
    return CreatePostProvider(
      body: body,
    );
  }

  @override
  CreatePostProvider getProviderOverride(
    covariant CreatePostProvider provider,
  ) {
    return call(
      body: provider.body,
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
  String? get name => r'createPostProvider';
}

/// See also [createPost].
class CreatePostProvider extends AutoDisposeFutureProvider<Object?> {
  /// See also [createPost].
  CreatePostProvider({
    dynamic body,
  }) : this._internal(
          (ref) => createPost(
            ref as CreatePostRef,
            body: body,
          ),
          from: createPostProvider,
          name: r'createPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createPostHash,
          dependencies: CreatePostFamily._dependencies,
          allTransitiveDependencies:
              CreatePostFamily._allTransitiveDependencies,
          body: body,
        );

  CreatePostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.body,
  }) : super.internal();

  final dynamic body;

  @override
  Override overrideWith(
    FutureOr<Object?> Function(CreatePostRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreatePostProvider._internal(
        (ref) => create(ref as CreatePostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        body: body,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Object?> createElement() {
    return _CreatePostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreatePostProvider && other.body == body;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, body.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreatePostRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `body` of this provider.
  dynamic get body;
}

class _CreatePostProviderElement
    extends AutoDisposeFutureProviderElement<Object?> with CreatePostRef {
  _CreatePostProviderElement(super.provider);

  @override
  dynamic get body => (origin as CreatePostProvider).body;
}

String _$createIncidentHash() => r'65aac97691b8e95e3f327ad1f03d0e4002a278ca';

/// See also [createIncident].
@ProviderFor(createIncident)
const createIncidentProvider = CreateIncidentFamily();

/// See also [createIncident].
class CreateIncidentFamily extends Family<AsyncValue<Object?>> {
  /// See also [createIncident].
  const CreateIncidentFamily();

  /// See also [createIncident].
  CreateIncidentProvider call({
    dynamic body,
  }) {
    return CreateIncidentProvider(
      body: body,
    );
  }

  @override
  CreateIncidentProvider getProviderOverride(
    covariant CreateIncidentProvider provider,
  ) {
    return call(
      body: provider.body,
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
  String? get name => r'createIncidentProvider';
}

/// See also [createIncident].
class CreateIncidentProvider extends AutoDisposeFutureProvider<Object?> {
  /// See also [createIncident].
  CreateIncidentProvider({
    dynamic body,
  }) : this._internal(
          (ref) => createIncident(
            ref as CreateIncidentRef,
            body: body,
          ),
          from: createIncidentProvider,
          name: r'createIncidentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createIncidentHash,
          dependencies: CreateIncidentFamily._dependencies,
          allTransitiveDependencies:
              CreateIncidentFamily._allTransitiveDependencies,
          body: body,
        );

  CreateIncidentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.body,
  }) : super.internal();

  final dynamic body;

  @override
  Override overrideWith(
    FutureOr<Object?> Function(CreateIncidentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateIncidentProvider._internal(
        (ref) => create(ref as CreateIncidentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        body: body,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Object?> createElement() {
    return _CreateIncidentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateIncidentProvider && other.body == body;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, body.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateIncidentRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `body` of this provider.
  dynamic get body;
}

class _CreateIncidentProviderElement
    extends AutoDisposeFutureProviderElement<Object?> with CreateIncidentRef {
  _CreateIncidentProviderElement(super.provider);

  @override
  dynamic get body => (origin as CreateIncidentProvider).body;
}

String _$uploadFilesHash() => r'ce28a59d45d001356e7433604a826447084ae3a2';

/// See also [uploadFiles].
@ProviderFor(uploadFiles)
final uploadFilesProvider = AutoDisposeFutureProvider<List<String>?>.internal(
  uploadFiles,
  name: r'uploadFilesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$uploadFilesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UploadFilesRef = AutoDisposeFutureProviderRef<List<String>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
