import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/core/di/injection.dart';
import 'package:restotrack_app/features/auth/data/models/user_model.dart';
import 'package:restotrack_app/features/cashier/presentation/bloc/cashier_bloc.dart';
import 'package:restotrack_app/features/home/pages/cashier_home_page.dart';
import 'package:restotrack_app/features/home/pages/kitchen_home_page.dart';
import 'package:restotrack_app/features/home/pages/server_home_page.dart';
import 'package:restotrack_app/features/menu/presentation/bloc/menu_bloc.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/cart_bloc.dart';
import 'package:restotrack_app/features/orders/presentation/bloc/order_bloc.dart';

class HomeRouter extends StatelessWidget {
  const HomeRouter({required this.user, super.key});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    if (user.isOrderTaker) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<OrderBloc>()),
          BlocProvider(create: (_) => sl<CartBloc>()),
          BlocProvider(create: (_) => sl<MenuBloc>()),
        ],
        child: ServerHomePage(user: user),
      );
    }

    if (user.isCashier) {
      return BlocProvider(
        create: (_) => sl<CashierBloc>(),
        child: CashierHomePage(user: user),
      );
    }

    if (user.isKitchenStaff) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<OrderBloc>()),
        ],
        child: KitchenHomePage(user: user),
      );
    }

    // Fallback - no role assigned
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.orange),
              const SizedBox(height: 16),
              Text(
                'No role assigned',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Please contact your manager to assign you a role.',
              ),
              Text(
                'Roles: ${user.roleNames.isEmpty ? "None" : user.roleNames.join(", ")}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
