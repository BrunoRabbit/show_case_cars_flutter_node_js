// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:showcase_cars_flutter_node_js/features/admin/view/admin_vehicle_management.dart'
    as _i4;
import 'package:showcase_cars_flutter_node_js/features/auth/view/auth_root_view.dart'
    as _i1;
import 'package:showcase_cars_flutter_node_js/features/home/models/car_model.dart'
    as _i7;
import 'package:showcase_cars_flutter_node_js/features/home/view/home_view.dart'
    as _i2;
import 'package:showcase_cars_flutter_node_js/features/home/view/widgets/car_summary_view.dart'
    as _i3;

abstract class $Routes extends _i5.RootStackRouter {
  $Routes({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    AuthRootRoute.name: (routeData) {
      final args = routeData.argsAs<AuthRootRouteArgs>(
          orElse: () => const AuthRootRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.AuthRootView(key: args.key),
      );
    },
    HomeRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomeView(),
      );
    },
    CarSummaryRoute.name: (routeData) {
      final args = routeData.argsAs<CarSummaryRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.CarSummaryView(
          args.item,
          args.index,
          key: args.key,
        ),
      );
    },
    AdminVehicleManagementRoute.name: (routeData) {
      final args = routeData.argsAs<AdminVehicleManagementRouteArgs>();
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.AdminVehicleManagementView(
          key: args.key,
          title: args.title,
          sectionTitle: args.sectionTitle,
          isEditCar: args.isEditCar,
          carModel: args.carModel,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.AuthRootView]
class AuthRootRoute extends _i5.PageRouteInfo<AuthRootRouteArgs> {
  AuthRootRoute({
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AuthRootRoute.name,
          args: AuthRootRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'AuthRootRoute';

  static const _i5.PageInfo<AuthRootRouteArgs> page =
      _i5.PageInfo<AuthRootRouteArgs>(name);
}

class AuthRootRouteArgs {
  const AuthRootRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'AuthRootRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.CarSummaryView]
class CarSummaryRoute extends _i5.PageRouteInfo<CarSummaryRouteArgs> {
  CarSummaryRoute({
    required _i7.CarModel item,
    required int index,
    _i6.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          CarSummaryRoute.name,
          args: CarSummaryRouteArgs(
            item: item,
            index: index,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'CarSummaryRoute';

  static const _i5.PageInfo<CarSummaryRouteArgs> page =
      _i5.PageInfo<CarSummaryRouteArgs>(name);
}

class CarSummaryRouteArgs {
  const CarSummaryRouteArgs({
    required this.item,
    required this.index,
    this.key,
  });

  final _i7.CarModel item;

  final int index;

  final _i6.Key? key;

  @override
  String toString() {
    return 'CarSummaryRouteArgs{item: $item, index: $index, key: $key}';
  }
}

/// generated route for
/// [_i4.AdminVehicleManagementView]
class AdminVehicleManagementRoute
    extends _i5.PageRouteInfo<AdminVehicleManagementRouteArgs> {
  AdminVehicleManagementRoute({
    _i6.Key? key,
    required String title,
    required String sectionTitle,
    required bool isEditCar,
    _i7.CarModel? carModel,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          AdminVehicleManagementRoute.name,
          args: AdminVehicleManagementRouteArgs(
            key: key,
            title: title,
            sectionTitle: sectionTitle,
            isEditCar: isEditCar,
            carModel: carModel,
          ),
          initialChildren: children,
        );

  static const String name = 'AdminVehicleManagementRoute';

  static const _i5.PageInfo<AdminVehicleManagementRouteArgs> page =
      _i5.PageInfo<AdminVehicleManagementRouteArgs>(name);
}

class AdminVehicleManagementRouteArgs {
  const AdminVehicleManagementRouteArgs({
    this.key,
    required this.title,
    required this.sectionTitle,
    required this.isEditCar,
    this.carModel,
  });

  final _i6.Key? key;

  final String title;

  final String sectionTitle;

  final bool isEditCar;

  final _i7.CarModel? carModel;

  @override
  String toString() {
    return 'AdminVehicleManagementRouteArgs{key: $key, title: $title, sectionTitle: $sectionTitle, isEditCar: $isEditCar, carModel: $carModel}';
  }
}
