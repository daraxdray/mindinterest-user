import 'package:go_router/go_router.dart';
import 'package:mindintrest_user/app/route/app_pages.dart';

class AppRouter {
  static final router = GoRouter(
    routes: AppRoutes.routes,
    initialLocation: RoutePaths.splash,
  );
}
