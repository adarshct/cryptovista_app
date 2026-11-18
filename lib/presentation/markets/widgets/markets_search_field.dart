import 'package:cryptovista_app/core/constants/font_string.dart';
import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class MarketsSearchField extends StatelessWidget {
  const MarketsSearchField({super.key, this.controller, this.onChanged});

  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: 14.hPad,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: 14.bRad,
        border: .all(color: AppColors.divider, width: 1),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.mutedText,
            size: 22,
          ),
          12.wBox,
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(
                color: AppColors.primaryText,
                fontFamily: inter,
                fontSize: 13,
              ),
              cursorColor: AppColors.primaryGreen,
              decoration: const InputDecoration(
                hintText: 'Search coins...',
                hintStyle: TextStyle(
                  color: AppColors.mutedText,
                  fontSize: 13,
                  fontFamily: inter,
                ),
                border: .none,
                enabledBorder: .none,
                focusedBorder: .none,
                isDense: true,
                contentPadding: .zero,
              ),
            ),
          ),
          if (controller != null)
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller!,
              builder: (context, value, child) {
                if (value.text.isEmpty) {
                  return const SizedBox.shrink();
                }

                return GestureDetector(
                  onTap: () {
                    controller!.clear();
                    onChanged?.call('');
                  },
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.mutedText,
                    size: 20,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
