import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_color.dart';

class CustomAuthInput extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final UnderlineInputBorder? enabledBorder;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final Color? fillColor;

  const CustomAuthInput({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.suffixIcon,
    this.prefix,
    this.textInputAction,
    this.suffix,
    this.fillColor, this.enabledBorder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          onTapOutside: (event) {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          validator: validator,
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          textCapitalization: TextCapitalization.words,
          textInputAction: textInputAction,
          cursorColor: AppColor.appBrandColor,
          decoration: InputDecoration(
              fillColor: fillColor,
              suffix: suffix,
              prefixIcon: prefix,
              suffixIcon: suffixIcon,
              labelText: labelText,
              labelStyle: GoogleFonts.cabin(
                color: AppColor.white.withOpacity(0.5),
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
              ),
              hintStyle: GoogleFonts.cabin(
                fontSize: 16.sp,
                color: AppColor.white,
              ),
              hintText: hintText,
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: const Color(
                    0xFFCFD4DC,
                  ),
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: AppColor.appBrandColor),
              ),
              enabledBorder: enabledBorder,
              errorBorder: UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.red),
              )),
          style: TextStyle(
            color: AppColor.white.withOpacity(0.8),
            fontSize: 16.sp, // Adjust the font size
            fontWeight: FontWeight.normal, // Adjust the font weight
          ),
        ),
      ],
    );
  }
}

class CustomTextFieldWithDropdown extends StatefulWidget {
  final String headerText;
  final String hintText;
  final List<String> dropdownItems;
  final ValueChanged<String> onChanged;

  const CustomTextFieldWithDropdown({
    super.key,
    required this.headerText,
    required this.hintText,
    required this.dropdownItems,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldWithDropdownState createState() =>
      _CustomTextFieldWithDropdownState();
}

class _CustomTextFieldWithDropdownState
    extends State<CustomTextFieldWithDropdown> {
  String selectedDropdownValue = "";
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedDropdownValue = widget.dropdownItems.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.headerText,
          style: GoogleFonts.lato(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: const Color(0xFF475466),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          child: TextFormField(
            readOnly: true, // Prevent manual editing
            controller: TextEditingController(
              text: selectedDropdownValue,
            ),
            onTap: () {
              setState(() {
                isDropdownOpen = !isDropdownOpen;
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelStyle: GoogleFonts.lato(
                color: const Color(0xFF475466),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
              hintStyle: const TextStyle(color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColor.appBrandColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: AppColor.appBrandColor)),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    isDropdownOpen = !isDropdownOpen;
                  });
                },
                child: Icon(
                  isDropdownOpen
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                ),
              ),
            ),
          ),
        ),
        if (isDropdownOpen)
          AnimatedContainer(
            margin: EdgeInsets.symmetric(
              vertical: 5.h,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            duration: const Duration(
              milliseconds: 1000,
            ),
            curve: Curves.easeInOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.dropdownItems
                  .map(
                    (item) => InkWell(
                      onTap: () {
                        setState(() {
                          selectedDropdownValue = item;
                          isDropdownOpen = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 5.h,
                          bottom: 10.0.h,
                          left: 10.w,
                          right: 10.w,
                        ),
                        child: Text(
                          item,
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color(0xFF475466)),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
