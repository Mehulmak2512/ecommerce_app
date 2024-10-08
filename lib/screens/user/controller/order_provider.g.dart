// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderHash() => r'99a25cd2174b64ceb2dbd1576164e0b0362ad86c';

/// See also [Order].
@ProviderFor(Order)
final orderProvider = AutoDisposeAsyncNotifierProvider<Order,
    List<Map<String, dynamic>>>.internal(
  Order.new,
  name: r'orderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$orderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Order = AutoDisposeAsyncNotifier<List<Map<String, dynamic>>>;
String _$orderItemHash() => r'4c61fe17bee327ee190b0cc9d09d6e451415e1e1';

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

abstract class _$OrderItem
    extends BuildlessAutoDisposeAsyncNotifier<List<Map<String, dynamic>>> {
  late final String orderId;

  FutureOr<List<Map<String, dynamic>>> build(
    String orderId,
  );
}

/// See also [OrderItem].
@ProviderFor(OrderItem)
const orderItemProvider = OrderItemFamily();

/// See also [OrderItem].
class OrderItemFamily extends Family<AsyncValue<List<Map<String, dynamic>>>> {
  /// See also [OrderItem].
  const OrderItemFamily();

  /// See also [OrderItem].
  OrderItemProvider call(
    String orderId,
  ) {
    return OrderItemProvider(
      orderId,
    );
  }

  @override
  OrderItemProvider getProviderOverride(
    covariant OrderItemProvider provider,
  ) {
    return call(
      provider.orderId,
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
  String? get name => r'orderItemProvider';
}

/// See also [OrderItem].
class OrderItemProvider extends AutoDisposeAsyncNotifierProviderImpl<OrderItem,
    List<Map<String, dynamic>>> {
  /// See also [OrderItem].
  OrderItemProvider(
    String orderId,
  ) : this._internal(
          () => OrderItem()..orderId = orderId,
          from: orderItemProvider,
          name: r'orderItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$orderItemHash,
          dependencies: OrderItemFamily._dependencies,
          allTransitiveDependencies: OrderItemFamily._allTransitiveDependencies,
          orderId: orderId,
        );

  OrderItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.orderId,
  }) : super.internal();

  final String orderId;

  @override
  FutureOr<List<Map<String, dynamic>>> runNotifierBuild(
    covariant OrderItem notifier,
  ) {
    return notifier.build(
      orderId,
    );
  }

  @override
  Override overrideWith(OrderItem Function() create) {
    return ProviderOverride(
      origin: this,
      override: OrderItemProvider._internal(
        () => create()..orderId = orderId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        orderId: orderId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<OrderItem, List<Map<String, dynamic>>>
      createElement() {
    return _OrderItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OrderItemProvider && other.orderId == orderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, orderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OrderItemRef
    on AutoDisposeAsyncNotifierProviderRef<List<Map<String, dynamic>>> {
  /// The parameter `orderId` of this provider.
  String get orderId;
}

class _OrderItemProviderElement extends AutoDisposeAsyncNotifierProviderElement<
    OrderItem, List<Map<String, dynamic>>> with OrderItemRef {
  _OrderItemProviderElement(super.provider);

  @override
  String get orderId => (origin as OrderItemProvider).orderId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
