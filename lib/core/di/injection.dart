import 'package:get_it/get_it.dart';
import 'package:restotrack_app/core/network/api_client.dart';
import 'package:restotrack_app/features/auth/data/presentation/bloc/auth_bloc.dart';
import 'package:restotrack_app/features/auth/data/repositories/auth_repository.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository.dart';
import 'package:restotrack_app/features/cashier/data/repositories/cashier_repository_impl.dart';
import 'package:restotrack_app/features/cashier/presentation/bloc/cashier_bloc.dart';
import 'package:restotrack_app/features/kds/data/repositories/kds_repository.dart';
import 'package:restotrack_app/features/kds/data/repositories/kds_repository_impl.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_bloc.dart';
import 'package:restotrack_app/features/menu/data/repository/menu_repository.dart';
import 'package:restotrack_app/features/menu/data/repository/menu_repository_impl.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:restotrack_app/features/orders/data/repositories/order_repository.dart';
import 'package:restotrack_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_bloc.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/order_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final apiClient = ApiClient();
  await apiClient.init();
  sl..registerLazySingleton<ApiClient>(() => apiClient)

  ..registerLazySingleton<AuthRepository>(
        () => AuthRepository(sl<ApiClient>()),
  )

  ..registerLazySingleton<MenuRepository>(
        () => MenuRepositoryImpl(apiClient: sl<ApiClient>()),
  )

  ..registerLazySingleton<OrderRepository>(
        () => OrderRepositoryImpl(apiClient: sl<ApiClient>()),
  )

  ..registerLazySingleton<KdsRepository>(
        () => KdsRepositoryImpl(apiClient: sl<ApiClient>()),
  )

  ..registerLazySingleton<CashierRepository>(
        () => CashierRepositoryImpl(apiClient: sl<ApiClient>()),
  )

  ..registerLazySingleton<AuthBloc>(
        () => AuthBloc(sl<AuthRepository>()),
  )

  ..registerFactory<MenuBloc>(
        () => MenuBloc(menuRepository: sl<MenuRepository>()),
  )

  ..registerFactory<OrderBloc>(
        () => OrderBloc(orderRepository: sl<OrderRepository>()),
  )

  ..registerFactory<CartBloc>(
        () => CartBloc(orderRepository: sl<OrderRepository>()),
  )

  ..registerFactory<KdsBloc>(
        () => KdsBloc(kdsRepository: sl<KdsRepository>()),
  )

  ..registerFactory<CashierBloc>(
        () => CashierBloc(cashierRepository: sl<CashierRepository>()),
  );
}
