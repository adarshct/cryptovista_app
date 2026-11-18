import 'dart:math' as math;

import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/data/models/coin_chart_model.dart';
import 'package:cryptovista_app/presentation/coin_details/coin_details_cubit.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class PriceChartSection extends StatelessWidget {
  const PriceChartSection({super.key, required this.state});

  final CoinDetailsState state;

  static const periods = [
    {'label': '1D', 'days': 1},
    {'label': '1W', 'days': 7},
    {'label': '1M', 'days': 30},
    {'label': '3M', 'days': 90},
    {'label': '1Y', 'days': 365},
  ];

  @override
  Widget build(BuildContext context) {
    final points = state.chart?.prices ?? [];

    return Column(
      crossAxisAlignment: .start,
      children: [
        const AppText('Price Chart', size: 16, weight: .w700),
        18.hBox,
        Row(
          mainAxisAlignment: .spaceBetween,
          children: periods.map((period) {
            final days = period['days'] as int;
            final isSelected = state.selectedDays == days;

            return GestureDetector(
              onTap: () {
                context.read<CoinDetailsCubit>().changeChartPeriod(days);
              },
              child: Container(
                padding: 12.hPad + 7.vPad,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryGreen.withValues(alpha: 0.13)
                      : Colors.transparent,
                  borderRadius: 8.bRad,
                ),
                child: AppText(
                  period['label'] as String,
                  size: 11,
                  weight: .w600,
                  color: isSelected
                      ? AppColors.primaryGreen
                      : AppColors.secondaryText,
                ),
              ),
            );
          }).toList(),
        ),
        20.hBox,
        Container(
          height: 210,
          width: .infinity,
          padding: 5.aPad,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: 14.bRad,
          ),
          child: _buildChart(points, state),
        ),
      ],
    );
  }

  Widget _buildChart(List<CoinChartPoint> points, CoinDetailsState state) {
    if (state.isChartLoading && points.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGreen),
      );
    }

    if (state.chartError.isNotEmpty && points.isEmpty) {
      return Center(
        child: AppText(
          state.chartError,
          size: 12,
          color: AppColors.secondaryText,
        ),
      );
    }

    if (points.isEmpty) {
      return const Center(
        child: AppText(
          'No chart data available',
          size: 12,
          color: AppColors.secondaryText,
        ),
      );
    }

    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(painter: _PriceChartPainter(points: points)),
        ),
        if (state.isChartLoading)
          const Align(
            alignment: .topRight,
            child: SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primaryGreen,
              ),
            ),
          ),
      ],
    );
  }
}

class _PriceChartPainter extends CustomPainter {
  _PriceChartPainter({required this.points});

  final List<CoinChartPoint> points;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;

    const horizontalPadding = 4.0;
    const verticalPadding = 12.0;

    final chartWidth = size.width - horizontalPadding * 2;
    final chartHeight = size.height - verticalPadding * 2;

    final prices = points.map((point) => point.price).toList();

    final minPrice = prices.reduce(math.min);
    final maxPrice = prices.reduce(math.max);
    final range = maxPrice - minPrice;
    final safeRange = range == 0 ? 1.0 : range;

    final gridPaint = Paint()
      ..color = AppColors.divider.withValues(alpha: 0.65)
      ..strokeWidth = 0.7;

    for (int i = 0; i < 4; i++) {
      final y = verticalPadding + (chartHeight / 3) * i;

      canvas.drawLine(
        Offset(horizontalPadding, y),
        Offset(size.width - horizontalPadding, y),
        gridPaint,
      );
    }

    final path = Path();

    for (int i = 0; i < points.length; i++) {
      final x = horizontalPadding + (i / (points.length - 1)) * chartWidth;

      final y =
          verticalPadding +
          ((maxPrice - points[i].price) / safeRange) * chartHeight;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width - horizontalPadding, size.height)
      ..lineTo(horizontalPadding, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: .topCenter,
        end: .bottomCenter,
        colors: [
          AppColors.primaryGreen.withValues(alpha: 0.22),
          AppColors.primaryGreen.withValues(alpha: 0.01),
        ],
      ).createShader(Offset.zero & size);

    canvas.drawPath(fillPath, fillPaint);

    final linePaint = Paint()
      ..color = AppColors.primaryGreen
      ..strokeWidth = 2.2
      ..style = .stroke
      ..strokeCap = .round
      ..strokeJoin = .round;

    canvas.drawPath(path, linePaint);

    final lastX = horizontalPadding + chartWidth;
    final lastY =
        verticalPadding +
        ((maxPrice - points.last.price) / safeRange) * chartHeight;

    canvas.drawCircle(
      Offset(lastX, lastY),
      4,
      Paint()..color = AppColors.primaryGreen,
    );

    canvas.drawCircle(
      Offset(lastX, lastY),
      7,
      Paint()..color = AppColors.primaryGreen.withValues(alpha: 0.2),
    );
  }

  @override
  bool shouldRepaint(covariant _PriceChartPainter oldDelegate) {
    return oldDelegate.points != points;
  }
}
