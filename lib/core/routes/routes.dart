//import '../../domain/mappers/user_mapper.dart';
//../../domain/entity/user.dart
import '../../domain/mappers/user_mapper.dart';
import '../../view/home.dart';
import '../../view/user_details/user_details_view.dart';
import 'package:go_router/go_router.dart';

abstract class RoutesApp {
  static final Route home = Route(name: 'home', path: '/');
  static final Route userDetails =
      Route(name: 'userdetails', path: '/userdetails');
}

class Route {
  final String name;
  final String path;

  Route({required this.name, required this.path});
}

final GoRouter routers = GoRouter(
  routes: [
    GoRoute(
      name: RoutesApp.home.name,
      path: RoutesApp.home.path,
      builder: (context, state) => const MyHomePage(title: 'Usuários'),
    ),
    GoRoute(
      name: RoutesApp.userDetails.name,
      path: RoutesApp.userDetails.path,
      builder: (context, state) {
        //final petJson = state.extra as Map<String, dynamic>;
        final user = UserMapper.fromJsonToEntity(state.extra as String);
        return UserDetailsView(user: user);
      },
    ),
  ],
);
