import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class HighLowItem extends StatelessWidget {
  const HighLowItem({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 7,
          width: 7,
          decoration: BoxDecoration(color: color, shape: .circle),
        ),
        7.wBox,
        Column(
          crossAxisAlignment: .start,
          children: [
            AppText(label, size: 11, color: AppColors.secondaryText),
            5.hBox,
            AppText(value, size: 12, weight: .w600),
          ],
        ),
      ],
    );
  }
}
