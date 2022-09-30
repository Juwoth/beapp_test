import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class Searchbar extends StatelessWidget {
  final String hintText;
  const Searchbar({
    Key? key,
    required this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: FocusNode(canRequestFocus: false),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.alphaWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
            color: AppColors.mainBlue,
          ),
        ),
        suffixIcon: const InkWell(
          child: Icon(Icons.search),
        ),
        contentPadding: const EdgeInsets.fromLTRB(25, 6, 0, 6),
        hintText: hintText,
      ),
    );
  }
}