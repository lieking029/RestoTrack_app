import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/core/di/injection.dart';
import 'package:restotrack_app/features/auth/data/models/user_model.dart';
import 'package:restotrack_app/features/auth/data/presentation/bloc/auth_bloc.dart';
import 'package:restotrack_app/features/auth/data/presentation/bloc/auth_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_bloc.dart';
import 'package:restotrack_app/features/kds/presentation/pages/kds_page.dart';

class KitchenHomePage extends StatelessWidget {
  const KitchenHomePage({required this.user, super.key});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitchen Display'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${user.fullName}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'Role: ${user.primaryRole.toUpperCase()}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (context) => BlocProvider(
                          create: (context) => sl<KdsBloc>(),
                          child: const KdsPage(),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.kitchen, size: 32),
                  label: const Text(
                    'Open Kitchen Display',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
