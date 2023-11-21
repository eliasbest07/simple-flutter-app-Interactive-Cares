import 'package:go_router/go_router.dart';
import 'package:riverpod_recursos_nativos/presentation/screens/biomtrics/biometrics_screen.dart';
import 'package:riverpod_recursos_nativos/presentation/screens/screens.dart';
import 'package:riverpod_recursos_nativos/presentation/screens/section6deeplink/detail_pokemon.dart';
import 'package:riverpod_recursos_nativos/presentation/screens/sensors/accelerometer_screen.dart';
import 'package:riverpod_recursos_nativos/presentation/screens/sensors/gyroscope_screen.dart';

final appRouter = GoRouter(
    // initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const PermisoScreen()),
      GoRoute(
          path: '/permissions',
          builder: (context, state) => const ShowChoosePremiso()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
          path: '/state-provider',
          builder: (context, state) => const StateProviderScreen()),
      GoRoute(
          path: '/pokemon', builder: (context, state) => const PokemonScreen()),
      GoRoute(
          path: '/stream', builder: (context, state) => const StreamScreen()),
      GoRoute(
          path: '/statenotifice',
          builder: (context, state) => const TodoScreen()),
      GoRoute(
          path: '/accelerometro',
          builder: (context, state) => const AccelerometerScreen()),
      GoRoute(
          path: '/magnetron',
          builder: (context, state) => const AccelerometerScreen()),
      GoRoute(
          path: '/giroscopio_ball',
          builder: (context, state) => const AccelerometerScreen()),
      GoRoute(
          path: '/giroscopio',
          builder: (context, state) => const GyroscopeScreen()),
      GoRoute(
          path: '/compass',
          builder: (context, state) => const AccelerometerScreen()),
      GoRoute(
          path: '/pokemons',
          builder: (context, state) => const PokemonScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = state.pathParameters['id'] ?? '1';
                return DetailPokemons(pokemonID: id);
              },
            )
          ]),
        GoRoute(
          path: '/biometrics',
          builder: (context, state) => const BiometricsScreen()),
    ]);
