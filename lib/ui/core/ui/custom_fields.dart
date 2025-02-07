import 'package:flutter/material.dart';

Widget customField({
  required String text,
  required String label,
  IconData? icon,
  bool? isPassword,
  TextEditingController? controller,
  bool? addClearButton,
  TextInputType? keyboardType,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 40, right: 40),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          controller: controller,
          obscureText: isPassword ?? false,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(
              color: Colors.white,
              // fontSize: 20,
            ),
            prefixIcon: Icon(
              // size: 30,
              icon,
              color: Colors.white,
            ),
            suffixIcon: addClearButton == true
                ? IconButton(
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      controller!.clear();
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            // contentPadding: const EdgeInsets.symmetric(vertical: 20.0),
          ),
        ),
      ],
    ),
  );
}
