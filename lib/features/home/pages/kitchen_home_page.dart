import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restotrack_app/core/theme/app_theme.dart';
import 'package:restotrack_app/features/auth/data/models/user_model.dart';
import 'package:restotrack_app/features/auth/data/presentation/bloc/auth_bloc.dart';
import 'package:restotrack_app/features/auth/data/presentation/bloc/auth_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_bloc.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_event.dart';
import 'package:restotrack_app/features/kds/presentation/bloc/kds_state.dart';
import 'package:restotrack_app/features/kds/presentation/pages/kds_page.dart';

class KitchenHomePage extends StatefulWidget {
  const KitchenHomePage({required this.user, super.key});
  final UserModel user;

  @override
  State<KitchenHomePage> createState() => _KitchenHomePageState();
}

class _KitchenHomePageState extends State<KitchenHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<KdsBloc>().add(const KdsLoadOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        _buildStatsRow(),
                        const SizedBox(height: 24),
                        _buildOpenKdsButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kitchen Dashboard',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Welcome back, ${widget.user.firstName}',
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            icon: const Icon(Icons.logout_rounded, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    return BlocBuilder<KdsBloc, KdsState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.payment_rounded,
                iconColor: Colors.blue,
                label: 'Paid',
                value: '${state.confirmedOrders.length}',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.restaurant_rounded,
                iconColor: AppColors.purple,
                label: 'Preparing',
                value: '${state.inPreparationOrders.length}',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_rounded,
                iconColor: AppColors.primaryGreen,
                label: 'Ready',
                value: '${state.readyOrders.length}',
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildOpenKdsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          final kdsBloc = context.read<KdsBloc>();
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => BlocProvider.value(
                value: kdsBloc,
                child: const KdsPage(),
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textPrimary,
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: AppColors.border),
          ),
          elevation: 0,
        ),
        icon: const Icon(Icons.point_of_sale_rounded),
        label: const Text(
          'Open Kitchen Display',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
