// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$updateProfileHash() => r'015462e1285fa42a293c206b6c02a63f132456ac';

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

/// See also [updateProfile].
@ProviderFor(updateProfile)
const updateProfileProvider = UpdateProfileFamily();

/// See also [updateProfile].
class UpdateProfileFamily extends Family<AsyncValue<Object?>> {
  /// See also [updateProfile].
  const UpdateProfileFamily();

  /// See also [updateProfile].
  UpdateProfileProvider call({
    dynamic body,
  }) {
    return UpdateProfileProvider(
      body: body,
    );
  }

  @override
  UpdateProfileProvider getProviderOverride(
    covariant UpdateProfileProvider provider,
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
  String? get name => r'updateProfileProvider';
}

/// See also [updateProfile].
class UpdateProfileProvider extends AutoDisposeFutureProvider<Object?> {
  /// See also [updateProfile].
  UpdateProfileProvider({
    dynamic body,
  }) : this._internal(
          (ref) => updateProfile(
            ref as UpdateProfileRef,
            body: body,
          ),
          from: updateProfileProvider,
          name: r'updateProfileProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateProfileHash,
          dependencies: UpdateProfileFamily._dependencies,
          allTransitiveDependencies:
              UpdateProfileFamily._allTransitiveDependencies,
          body: body,
        );

  UpdateProfileProvider._internal(
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
    FutureOr<Object?> Function(UpdateProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateProfileProvider._internal(
        (ref) => create(ref as UpdateProfileRef),
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
    return _UpdateProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateProfileProvider && other.body == body;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, body.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateProfileRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `body` of this provider.
  dynamic get body;
}

class _UpdateProfileProviderElement
    extends AutoDisposeFutureProviderElement<Object?> with UpdateProfileRef {
  _UpdateProfileProviderElement(super.provider);

  @override
  dynamic get body => (origin as UpdateProfileProvider).body;
}

String _$updatePasswordHash() => r'ba5bc150b0ba18c02f2e9b5d7b9d4c0b8e42ed13';

/// See also [updatePassword].
@ProviderFor(updatePassword)
const updatePasswordProvider = UpdatePasswordFamily();

/// See also [updatePassword].
class UpdatePasswordFamily extends Family<AsyncValue<Object?>> {
  /// See also [updatePassword].
  const UpdatePasswordFamily();

  /// See also [updatePassword].
  UpdatePasswordProvider call({
    dynamic body,
  }) {
    return UpdatePasswordProvider(
      body: body,
    );
  }

  @override
  UpdatePasswordProvider getProviderOverride(
    covariant UpdatePasswordProvider provider,
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
  String? get name => r'updatePasswordProvider';
}

/// See also [updatePassword].
class UpdatePasswordProvider extends AutoDisposeFutureProvider<Object?> {
  /// See also [updatePassword].
  UpdatePasswordProvider({
    dynamic body,
  }) : this._internal(
          (ref) => updatePassword(
            ref as UpdatePasswordRef,
            body: body,
          ),
          from: updatePasswordProvider,
          name: r'updatePasswordProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updatePasswordHash,
          dependencies: UpdatePasswordFamily._dependencies,
          allTransitiveDependencies:
              UpdatePasswordFamily._allTransitiveDependencies,
          body: body,
        );

  UpdatePasswordProvider._internal(
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
    FutureOr<Object?> Function(UpdatePasswordRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdatePasswordProvider._internal(
        (ref) => create(ref as UpdatePasswordRef),
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
    return _UpdatePasswordProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdatePasswordProvider && other.body == body;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, body.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdatePasswordRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `body` of this provider.
  dynamic get body;
}

class _UpdatePasswordProviderElement
    extends AutoDisposeFutureProviderElement<Object?> with UpdatePasswordRef {
  _UpdatePasswordProviderElement(super.provider);

  @override
  dynamic get body => (origin as UpdatePasswordProvider).body;
}

String _$updateEmergencyContactHash() =>
    r'b24fbbe159e4da556cbc3923942d64856d167405';

/// See also [updateEmergencyContact].
@ProviderFor(updateEmergencyContact)
const updateEmergencyContactProvider = UpdateEmergencyContactFamily();

/// See also [updateEmergencyContact].
class UpdateEmergencyContactFamily extends Family<AsyncValue<Object?>> {
  /// See also [updateEmergencyContact].
  const UpdateEmergencyContactFamily();

  /// See also [updateEmergencyContact].
  UpdateEmergencyContactProvider call({
    dynamic body,
  }) {
    return UpdateEmergencyContactProvider(
      body: body,
    );
  }

  @override
  UpdateEmergencyContactProvider getProviderOverride(
    covariant UpdateEmergencyContactProvider provider,
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
  String? get name => r'updateEmergencyContactProvider';
}

/// See also [updateEmergencyContact].
class UpdateEmergencyContactProvider
    extends AutoDisposeFutureProvider<Object?> {
  /// See also [updateEmergencyContact].
  UpdateEmergencyContactProvider({
    dynamic body,
  }) : this._internal(
          (ref) => updateEmergencyContact(
            ref as UpdateEmergencyContactRef,
            body: body,
          ),
          from: updateEmergencyContactProvider,
          name: r'updateEmergencyContactProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateEmergencyContactHash,
          dependencies: UpdateEmergencyContactFamily._dependencies,
          allTransitiveDependencies:
              UpdateEmergencyContactFamily._allTransitiveDependencies,
          body: body,
        );

  UpdateEmergencyContactProvider._internal(
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
    FutureOr<Object?> Function(UpdateEmergencyContactRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateEmergencyContactProvider._internal(
        (ref) => create(ref as UpdateEmergencyContactRef),
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
    return _UpdateEmergencyContactProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateEmergencyContactProvider && other.body == body;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, body.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateEmergencyContactRef on AutoDisposeFutureProviderRef<Object?> {
  /// The parameter `body` of this provider.
  dynamic get body;
}

class _UpdateEmergencyContactProviderElement
    extends AutoDisposeFutureProviderElement<Object?>
    with UpdateEmergencyContactRef {
  _UpdateEmergencyContactProviderElement(super.provider);

  @override
  dynamic get body => (origin as UpdateEmergencyContactProvider).body;
}

String _$logoutHash() => r'd0af9d6711651eb4b3beb3ab24240ce6fa5cec89';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<Object?>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutRef = AutoDisposeFutureProviderRef<Object?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
