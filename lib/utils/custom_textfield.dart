import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:volex/utils/app_colors.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController? ctrl;
  final double? width;
  final String? label;
  final String? hintText;
  final bool obscureText;
  final String? svgPrefix;
  final String? Function(String?)? validator;
  final bool autoValidate;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final bool showBorder;
  final TextInputType? keyboardType;
  final VoidCallback? callback;
  final String? trailingSvg;
  final double? radius;
  final int? minLines;
  final Color? color;

  const CustomTextfield({
    super.key,
    this.ctrl,
    this.width,
    this.label,
    this.hintText,
    this.svgPrefix,
    this.validator,
    this.obscureText = false,
    this.showBorder = true,
    this.autoValidate = false,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType,
    this.callback,
    this.trailingSvg,
    this.radius,
    this.minLines,
    this.color,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool hideText = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      hideText = widget.obscureText;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label?.isNotEmpty ?? false)
          Text(
            widget.label ?? '',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: const Color(0xFF111111)),

            // const TextStyle(
            //   color: AppColors.textGreyColor,
            // ),
          ),
        const Gap(4),
        Container(
          padding: const EdgeInsets.only(top: 4, bottom: 4),
          alignment: Alignment.center,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            // color: Colors.red,
            borderRadius: BorderRadius.circular(widget.radius ?? 12),
            // border: Border.all(color: AppColors.iconGreyColor, width: .5),
          ),
          width: widget.width,
          child: TextFormField(
            minLines: widget.obscureText ? 1 : widget.minLines,
            maxLines: widget.obscureText ? 1 : widget.minLines,
            autofocus: widget.autofocus,
            readOnly: widget.readOnly,
            onTap: widget.callback,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            autovalidateMode:
                widget.autoValidate ? AutovalidateMode.always : null,
            validator: widget.validator,
            autocorrect: false,
            controller: widget.ctrl,
            obscureText: hideText,
            decoration: InputDecoration(
              suffixIcon: widget.trailingSvg != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/svgs/${widget.trailingSvg}.svg',
                        fit: BoxFit.scaleDown,
                      ),
                    )
                  : widget.obscureText
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              hideText = !hideText;
                            });
                          },
                          child: hideText
                              ? const Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: AppColors.textGreyColor,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: SvgPicture.asset(
                                    'assets/svgs/eye_closed.svg',
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.textGreyColor,
                                      BlendMode.srcIn,
                                    ),
                                    allowDrawingOutsideViewBox: false,
                                    height: 12,
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                        )
                      : null,
              focusedBorder: widget.showBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 12),
                      borderSide: BorderSide(
                        color: AppColors.textGreyColor.withOpacity(.9),
                      ),
                    )
                  : InputBorder.none,
              enabledBorder: widget.showBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 12),
                      borderSide: BorderSide(
                        color: AppColors.textGreyColor.withOpacity(.4),
                      ),
                    )
                  : InputBorder.none,
              disabledBorder: widget.showBorder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 12),
                      borderSide: BorderSide(
                        color: AppColors.textGreyColor.withOpacity(.4),
                      ),
                    )
                  : InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 20, vertical: widget.minLines == null ? 2 : 12),
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: widget.svgPrefix != null
                  ? Padding(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        'assets/svgs/${widget.svgPrefix}.svg',
                      ),
                    )
                  : null,
              filled: true,
              fillColor: widget.color ?? Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide(
                  color: Colors.red.withOpacity(.1),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
