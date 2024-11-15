// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getNearByUsersHash() => r'647013a10797b5f40686913f0c93c201c340bcff';

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

/// See also [getNearByUsers].
@ProviderFor(getNearByUsers)
const getNearByUsersProvider = GetNearByUsersFamily();

/// See also [getNearByUsers].
class GetNearByUsersFamily extends Family<AsyncValue<List<UserModel>?>> {
  /// See also [getNearByUsers].
  const GetNearByUsersFamily();

  /// See also [getNearByUsers].
  GetNearByUsersProvider call({
    int distance = 20,
  }) {
    return GetNearByUsersProvider(
      distance: distance,
    );
  }

  @override
  GetNearByUsersProvider getProviderOverride(
    covariant GetNearByUsersProvider provider,
  ) {
    return call(
      distance: provider.distance,
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
  String? get name => r'getNearByUsersProvider';
}

/// See also [getNearByUsers].
class GetNearByUsersProvider
    extends AutoDisposeFutureProvider<List<UserModel>?> {
  /// See also [getNearByUsers].
  GetNearByUsersProvider({
    int distance = 20,
  }) : this._internal(
          (ref) => getNearByUsers(
            ref as GetNearByUsersRef,
            distance: distance,
          ),
          from: getNearByUsersProvider,
          name: r'getNearByUsersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getNearByUsersHash,
          dependencies: GetNearByUsersFamily._dependencies,
          allTransitiveDependencies:
              GetNearByUsersFamily._allTransitiveDependencies,
          distance: distance,
        );

  GetNearByUsersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.distance,
  }) : super.internal();

  final int distance;

  @override
  Override overrideWith(
    FutureOr<List<UserModel>?> Function(GetNearByUsersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetNearByUsersProvider._internal(
        (ref) => create(ref as GetNearByUsersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        distance: distance,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserModel>?> createElement() {
    return _GetNearByUsersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetNearByUsersProvider && other.distance == distance;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, distance.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetNearByUsersRef on AutoDisposeFutureProviderRef<List<UserModel>?> {
  /// The parameter `distance` of this provider.
  int get distance;
}

class _GetNearByUsersProviderElement
    extends AutoDisposeFutureProviderElement<List<UserModel>?>
    with GetNearByUsersRef {
  _GetNearByUsersProviderElement(super.provider);

  @override
  int get distance => (origin as GetNearByUsersProvider).distance;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
