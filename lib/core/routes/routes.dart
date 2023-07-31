import 'package:auto_route/auto_route.dart';
import 'package:showcase_cars_flutter_node_js/core/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class Routes extends $Routes {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: AuthRootRoute.page),
        AutoRoute(page: AdminVehicleManagementRoute.page),
        AutoRoute(page: CarSummaryRoute.page),
      ];
}
