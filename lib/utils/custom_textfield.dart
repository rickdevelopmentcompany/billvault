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
  final TextInputType? keyboardType;
  final VoidCallback? callback;
  final String? trailingSvg;
  final double? radius;

  const CustomTextfield({
    super.key,
    this.ctrl,
    this.width,
    this.label,
    this.hintText,
    this.svgPrefix,
    this.validator,
    this.obscureText = false,
    this.autoValidate = false,
    this.readOnly = false,
    this.autofocus = false,
    this.enabled = true,
    this.keyboardType,
    this.callback,
    this.trailingSvg,
    this.radius,
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
            style: const TextStyle(
              color: AppColors.textGreyColor,
            ),
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
                        'assets/svg/${widget.trailingSvg}.svg',
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
                                    'assets/svg/eye_closed.svg',
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 12),
                borderSide: BorderSide(
                  color: AppColors.textGreyColor.withOpacity(.9),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 12),
                borderSide: BorderSide(
                  color: AppColors.textGreyColor.withOpacity(.4),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.radius ?? 12),
                borderSide: BorderSide(
                  color: AppColors.textGreyColor.withOpacity(.4),
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: widget.hintText,
              hintStyle: const TextStyle(fontSize: 12),
              prefix: widget.svgPrefix != null
                  ? SvgPicture.asset(
                      widget.svgPrefix!,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textGreyColor,
                        BlendMode.srcIn,
                      ),
                    )
                  : null,
              filled: true,
              fillColor: Colors.white,
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
