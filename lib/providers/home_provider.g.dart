// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$likePostHash() => r'dd7ae5a08e27baa144fcfca319dddc6ee6178101';

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

/// See also [likePost].
@ProviderFor(likePost)
const likePostProvider = LikePostFamily();

/// See also [likePost].
class LikePostFamily extends Family<AsyncValue<bool>> {
  /// See also [likePost].
  const LikePostFamily();

  /// See also [likePost].
  LikePostProvider call({
    required String id,
  }) {
    return LikePostProvider(
      id: id,
    );
  }

  @override
  LikePostProvider getProviderOverride(
    covariant LikePostProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'likePostProvider';
}

/// See also [likePost].
class LikePostProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [likePost].
  LikePostProvider({
    required String id,
  }) : this._internal(
          (ref) => likePost(
            ref as LikePostRef,
            id: id,
          ),
          from: likePostProvider,
          name: r'likePostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$likePostHash,
          dependencies: LikePostFamily._dependencies,
          allTransitiveDependencies: LikePostFamily._allTransitiveDependencies,
          id: id,
        );

  LikePostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<bool> Function(LikePostRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LikePostProvider._internal(
        (ref) => create(ref as LikePostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _LikePostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LikePostProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin LikePostRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _LikePostProviderElement extends AutoDisposeFutureProviderElement<bool>
    with LikePostRef {
  _LikePostProviderElement(super.provider);

  @override
  String get id => (origin as LikePostProvider).id;
}

String _$unLikePostHash() => r'bb95fc646a5f349afcec949e78380dc4c5cb4544';

/// See also [unLikePost].
@ProviderFor(unLikePost)
const unLikePostProvider = UnLikePostFamily();

/// See also [unLikePost].
class UnLikePostFamily extends Family<AsyncValue<bool>> {
  /// See also [unLikePost].
  const UnLikePostFamily();

  /// See also [unLikePost].
  UnLikePostProvider call({
    required String id,
  }) {
    return UnLikePostProvider(
      id: id,
    );
  }

  @override
  UnLikePostProvider getProviderOverride(
    covariant UnLikePostProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'unLikePostProvider';
}

/// See also [unLikePost].
class UnLikePostProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [unLikePost].
  UnLikePostProvider({
    required String id,
  }) : this._internal(
          (ref) => unLikePost(
            ref as UnLikePostRef,
            id: id,
          ),
          from: unLikePostProvider,
          name: r'unLikePostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unLikePostHash,
          dependencies: UnLikePostFamily._dependencies,
          allTransitiveDependencies:
              UnLikePostFamily._allTransitiveDependencies,
          id: id,
        );

  UnLikePostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<bool> Function(UnLikePostRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnLikePostProvider._internal(
        (ref) => create(ref as UnLikePostRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _UnLikePostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnLikePostProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UnLikePostRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UnLikePostProviderElement extends AutoDisposeFutureProviderElement<bool>
    with UnLikePostRef {
  _UnLikePostProviderElement(super.provider);

  @override
  String get id => (origin as UnLikePostProvider).id;
}

String _$postCommentHash() => r'2a185535518bb3992ff6055c50c801028591b50d';

/// See also [postComment].
@ProviderFor(postComment)
const postCommentProvider = PostCommentFamily();

/// See also [postComment].
class PostCommentFamily extends Family<AsyncValue<bool>> {
  /// See also [postComment].
  const PostCommentFamily();

  /// See also [postComment].
  PostCommentProvider call({
    required String postId,
    required String comment,
  }) {
    return PostCommentProvider(
      postId: postId,
      comment: comment,
    );
  }

  @override
  PostCommentProvider getProviderOverride(
    covariant PostCommentProvider provider,
  ) {
    return call(
      postId: provider.postId,
      comment: provider.comment,
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
  String? get name => r'postCommentProvider';
}

/// See also [postComment].
class PostCommentProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [postComment].
  PostCommentProvider({
    required String postId,
    required String comment,
  }) : this._internal(
          (ref) => postComment(
            ref as PostCommentRef,
            postId: postId,
            comment: comment,
          ),
          from: postCommentProvider,
          name: r'postCommentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postCommentHash,
          dependencies: PostCommentFamily._dependencies,
          allTransitiveDependencies:
              PostCommentFamily._allTransitiveDependencies,
          postId: postId,
          comment: comment,
        );

  PostCommentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
    required this.comment,
  }) : super.internal();

  final String postId;
  final String comment;

  @override
  Override overrideWith(
    FutureOr<bool> Function(PostCommentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PostCommentProvider._internal(
        (ref) => create(ref as PostCommentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
        comment: comment,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _PostCommentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentProvider &&
        other.postId == postId &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);
    hash = _SystemHash.combine(hash, comment.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostCommentRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `postId` of this provider.
  String get postId;

  /// The parameter `comment` of this provider.
  String get comment;
}

class _PostCommentProviderElement extends AutoDisposeFutureProviderElement<bool>
    with PostCommentRef {
  _PostCommentProviderElement(super.provider);

  @override
  String get postId => (origin as PostCommentProvider).postId;
  @override
  String get comment => (origin as PostCommentProvider).comment;
}

String _$getCommentsHash() => r'08a9f5079c8026f018ff66093ee06bc8f83666e7';

/// See also [getComments].
@ProviderFor(getComments)
const getCommentsProvider = GetCommentsFamily();

/// See also [getComments].
class GetCommentsFamily extends Family<AsyncValue<List<CommentModel>>> {
  /// See also [getComments].
  const GetCommentsFamily();

  /// See also [getComments].
  GetCommentsProvider call({
    required String postId,
  }) {
    return GetCommentsProvider(
      postId: postId,
    );
  }

  @override
  GetCommentsProvider getProviderOverride(
    covariant GetCommentsProvider provider,
  ) {
    return call(
      postId: provider.postId,
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
  String? get name => r'getCommentsProvider';
}

/// See also [getComments].
class GetCommentsProvider
    extends AutoDisposeFutureProvider<List<CommentModel>> {
  /// See also [getComments].
  GetCommentsProvider({
    required String postId,
  }) : this._internal(
          (ref) => getComments(
            ref as GetCommentsRef,
            postId: postId,
          ),
          from: getCommentsProvider,
          name: r'getCommentsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCommentsHash,
          dependencies: GetCommentsFamily._dependencies,
          allTransitiveDependencies:
              GetCommentsFamily._allTransitiveDependencies,
          postId: postId,
        );

  GetCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Override overrideWith(
    FutureOr<List<CommentModel>> Function(GetCommentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCommentsProvider._internal(
        (ref) => create(ref as GetCommentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CommentModel>> createElement() {
    return _GetCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCommentsProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetCommentsRef on AutoDisposeFutureProviderRef<List<CommentModel>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _GetCommentsProviderElement
    extends AutoDisposeFutureProviderElement<List<CommentModel>>
    with GetCommentsRef {
  _GetCommentsProviderElement(super.provider);

  @override
  String get postId => (origin as GetCommentsProvider).postId;
}

String _$getPostsHash() => r'63ec5fa9d92d21b10b172dcf4b1a0f8cbf487754';

/// See also [getPosts].
@ProviderFor(getPosts)
const getPostsProvider = GetPostsFamily();

/// See also [getPosts].
class GetPostsFamily extends Family<AsyncValue<List<PostModel>>> {
  /// See also [getPosts].
  const GetPostsFamily();

  /// See also [getPosts].
  GetPostsProvider call({
    int page = 1,
  }) {
    return GetPostsProvider(
      page: page,
    );
  }

  @override
  GetPostsProvider getProviderOverride(
    covariant GetPostsProvider provider,
  ) {
    return call(
      page: provider.page,
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
  String? get name => r'getPostsProvider';
}

/// See also [getPosts].
class GetPostsProvider extends AutoDisposeFutureProvider<List<PostModel>> {
  /// See also [getPosts].
  GetPostsProvider({
    int page = 1,
  }) : this._internal(
          (ref) => getPosts(
            ref as GetPostsRef,
            page: page,
          ),
          from: getPostsProvider,
          name: r'getPostsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPostsHash,
          dependencies: GetPostsFamily._dependencies,
          allTransitiveDependencies: GetPostsFamily._allTransitiveDependencies,
          page: page,
        );

  GetPostsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
  }) : super.internal();

  final int page;

  @override
  Override overrideWith(
    FutureOr<List<PostModel>> Function(GetPostsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetPostsProvider._internal(
        (ref) => create(ref as GetPostsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<PostModel>> createElement() {
    return _GetPostsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetPostsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GetPostsRef on AutoDisposeFutureProviderRef<List<PostModel>> {
  /// The parameter `page` of this provider.
  int get page;
}

class _GetPostsProviderElement
    extends AutoDisposeFutureProviderElement<List<PostModel>> with GetPostsRef {
  _GetPostsProviderElement(super.provider);

  @override
  int get page => (origin as GetPostsProvider).page;
}

String _$homeFilterHash() => r'0db2e3841a31e644e8a360bb8183146a221304a9';

/// See also [HomeFilter].
@ProviderFor(HomeFilter)
final homeFilterProvider =
    AutoDisposeNotifierProvider<HomeFilter, String>.internal(
  HomeFilter.new,
  name: r'homeFilterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeFilter = AutoDisposeNotifier<String>;
String _$homePostsNotifierHash() => r'fb4de93f2672c8235cf141a5ee81427cd726fce0';

/// See also [HomePostsNotifier].
@ProviderFor(HomePostsNotifier)
final homePostsNotifierProvider = AutoDisposeAsyncNotifierProvider<
    HomePostsNotifier, List<PostModel>>.internal(
  HomePostsNotifier.new,
  name: r'homePostsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homePostsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomePostsNotifier = AutoDisposeAsyncNotifier<List<PostModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
