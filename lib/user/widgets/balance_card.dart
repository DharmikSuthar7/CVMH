import 'package:flutter/material.dart';
import 'package:splitease_test/core/theme/laser_theme.dart';

// Updated to Laser Aqua theme - use home/widgets/glass_balance_card.dart for the new glassmorphism version
class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double youOwe;
  final double youGet;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.youOwe,
    required this.youGet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0C2B2B), Color(0xFF0A1F1F), Color(0xFF062020)],
        ),
        borderRadius: BorderRadius.circular(LaserTheme.cardRadius),
        boxShadow: [
          BoxShadow(
            color: LaserColors.primary.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(
              color: Colors.white60,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: totalBalance),
            duration: const Duration(milliseconds: 1400),
            curve: Curves.easeOutCubic,
            builder: (context2, value, child2) {
              return ShaderMask(
                shaderCallback: (bounds) =>
                    LaserColors.primaryLinearGradient.createShader(bounds),
                child: Text(
                  '₹${_format(value)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 22),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withValues(alpha: 0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _statColumn(
                  label: 'You Owe',
                  amount: youOwe,
                  color: LaserColors.accentRed,
                  icon: Icons.arrow_upward_rounded,
                ),
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white12,
              ),
              Expanded(
                child: _statColumn(
                  label: 'You Get',
                  amount: youGet,
                  color: LaserColors.accentGreen,
                  icon: Icons.arrow_downward_rounded,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statColumn({
    required String label,
    required double amount,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 14),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '₹${_format(amount)}',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  String _format(double val) {
    if (val >= 1000) {
      return '${(val / 1000).toStringAsFixed(val % 1000 == 0 ? 0 : 1)}K';
    }
    return val.toStringAsFixed(0);
  }
}
