import 'package:cryptovista_app/core/constants/font_string.dart';
import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.color,
    this.decorationColor,
    this.size = 14,
    this.align,
    this.maxLines,
    this.family,
    this.weight,
    this.style,
    this.height,
    this.onTap,
    this.overflow,
    this.letterSpacing,
    this.isStrikethrough = false,
    this.shadow = const [],
  });

  const AppText.click(
    this.text, {
    super.key,
    this.color,
    this.decorationColor,
    this.size = 14,
    this.align,
    this.maxLines,
    this.family,
    this.weight,
    this.style,
    this.height,
    required this.onTap,
    this.overflow,
    this.isStrikethrough = false,
    this.letterSpacing,
    this.shadow = const [],
  });

  final dynamic text;
  final String? family;
  final Color? color, decorationColor;
  final double? size;
  final TextAlign? align;
  final int? maxLines;
  final FontWeight? weight;
  final TextStyle? style;
  final double? height;
  final List<Shadow> shadow;
  final void Function()? onTap;
  final TextOverflow? overflow;
  final bool isStrikethrough;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) => onTap != null
      ? InkWell(
          onTap: onTap,
          child: Padding(padding: 4.aPad, child: buildText()),
        )
      : buildText();

  Text buildText() {
    return Text(
      '${text ?? ''}',
      maxLines: maxLines,
      overflow: overflow,
      style:
          style ??
          TextStyle(
            shadows: shadow,
            fontSize: size,
            color: color ?? AppColors.primaryText,
            fontWeight: weight ?? FontWeight.w400,
            fontFamily: family ?? inter,
            height: height,
            letterSpacing: letterSpacing,
            decorationColor: decorationColor ?? color,
            decoration: isStrikethrough ? TextDecoration.lineThrough : null,
          ),
      textAlign: align ?? TextAlign.start,
    );
  }
}
