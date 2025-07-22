import 'package:hospitality/core/init/cache/onboarding/intro_caching.dart';
import 'package:hospitality/view/_product/enum/route_enum.dart';
import 'package:hospitality/view/home/view/home_page.dart';
import 'package:hospitality/view/introduction/view/introduction_screen.dart';
import 'package:hospitality/view/settings/view/setting_view.dart';
import 'package:go_router/go_router.dart';

class NavigationRouters {
  const NavigationRouters._();

  static final GoRouter router = GoRouter(
    initialLocation: IntroCaching.initialIntro(),
    routes: [
      GoRoute(
        path: RouteEnum.homePage.rawValue,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouteEnum.intro.rawValue,
        builder: (context, state) => Introduction.intro,
      ),
      GoRoute(
        path: RouteEnum.setting.rawValue,
        builder: (context, state) => const SettingView(),
      ),
    ],
  );
}
