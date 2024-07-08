// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i10;
import 'package:setlist/features/auth/presentation/pages/logged_out_page.dart' as _i5;
import 'package:setlist/features/auth/presentation/pages/login_page.dart' as _i6;
import 'package:setlist/features/auth/presentation/pages/sign_up_page.dart' as _i7;
import 'package:setlist/core/domain/entities/band.dart' as _i9;
import 'package:setlist/features/band_details/presentation/pages/band_details_page.dart' as _i1;
import 'package:setlist/features/create_band/presentation/pages/create_band_page.dart' as _i2;
import 'package:setlist/features/dashboard/presentation/pages/dashboard_page.dart' as _i3;
import 'package:setlist/features/dashboard/presentation/pages/home_page.dart' as _i4;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    BandDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<BandDetailsRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.BandDetailsPage(
          band: args.band,
          key: args.key,
        ),
      );
    },
    CreateBandRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CreateBandPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DashboardPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomePage(),
      );
    },
    LoggedOutRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoggedOutPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.SignUpPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BandDetailsPage]
class BandDetailsRoute extends _i8.PageRouteInfo<BandDetailsRouteArgs> {
  BandDetailsRoute({
    required _i9.Band band,
    _i10.Key? key,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          BandDetailsRoute.name,
          args: BandDetailsRouteArgs(
            band: band,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'BandDetailsRoute';

  static const _i8.PageInfo<BandDetailsRouteArgs> page = _i8.PageInfo<BandDetailsRouteArgs>(name);
}

class BandDetailsRouteArgs {
  const BandDetailsRouteArgs({
    required this.band,
    this.key,
  });

  final _i9.Band band;

  final _i10.Key? key;

  @override
  String toString() {
    return 'BandDetailsRouteArgs{band: $band, key: $key}';
  }
}

/// generated route for
/// [_i2.CreateBandPage]
class CreateBandRoute extends _i8.PageRouteInfo<void> {
  const CreateBandRoute({List<_i8.PageRouteInfo>? children})
      : super(
          CreateBandRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateBandRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DashboardPage]
class DashboardRoute extends _i8.PageRouteInfo<void> {
  const DashboardRoute({List<_i8.PageRouteInfo>? children})
      : super(
          DashboardRoute.name,
          initialChildren: children,
        );

  static const String name = 'DashboardRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomePage]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoggedOutPage]
class LoggedOutRoute extends _i8.PageRouteInfo<void> {
  const LoggedOutRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoggedOutRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoggedOutRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginPage]
class LoginRoute extends _i8.PageRouteInfo<void> {
  const LoginRoute({List<_i8.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SignUpPage]
class SignUpRoute extends _i8.PageRouteInfo<void> {
  const SignUpRoute({List<_i8.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}
