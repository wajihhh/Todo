import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labeltext;
  final String? placeholdertext;
  final bool? sufixIcon;
  final TextEditingController? controller;
  final int? radius;
  final TextInputType? textInputType;

  const CustomTextField({
    super.key,
    this.textInputType,
    required this.labeltext,
    this.radius,
    this.controller,
    this.placeholdertext,
    this.sufixIcon = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

bool _isObscure = false;

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
            widget.labeltext,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          cursorColor: Colors.white,
          keyboardType: widget.textInputType,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              decoration: TextDecoration.none,
              decorationThickness: 0),
          controller: widget.controller,
          obscureText: widget.sufixIcon == true ? _isObscure : false,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            hintText: widget.placeholdertext,
            filled: true,
            fillColor: Colors.transparent,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: const BorderSide(
                color: Color(0xff949FBB),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(60.0),
              borderSide: const BorderSide(
                // color: AppColors.textFieldBorder,
                width: 1.0,
              ),
            ),
            // border: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(60.0),
            //   borderSide: const BorderSide(
            //     color: Color(0xffA188FF),
            //     width: 1.0,
            //   ),
            // ),
            suffixIcon: widget.sufixIcon == true
                ? IconButton(
                    onPressed: () {
                      setState(
                        () {
                          _isObscure = !_isObscure;
                        },
                      );
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
