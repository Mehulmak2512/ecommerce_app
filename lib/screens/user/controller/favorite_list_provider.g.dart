// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteProductHash() => r'2d23d85005fb8e52fbf3ae5744c5195b3a2547d0';

/// See also [FavoriteProduct].
@ProviderFor(FavoriteProduct)
final favoriteProductProvider = AutoDisposeAsyncNotifierProvider<
    FavoriteProduct, List<Map<String, dynamic>>>.internal(
  FavoriteProduct.new,
  name: r'favoriteProductProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteProductHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteProduct
    = AutoDisposeAsyncNotifier<List<Map<String, dynamic>>>;
String _$favProductIdHash() => r'b8cdc2d4bf912b4a5599fe66a4a0714c79072050';

/// See also [FavProductId].
@ProviderFor(FavProductId)
final favProductIdProvider =
    AutoDisposeNotifierProvider<FavProductId, List<String>?>.internal(
  FavProductId.new,
  name: r'favProductIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$favProductIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavProductId = AutoDisposeNotifier<List<String>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
