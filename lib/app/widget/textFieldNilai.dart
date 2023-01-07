import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/textStyle.dart';

class TextFormNilai extends StatelessWidget {
  final String hint;
  final bool readOnly;
  final TextEditingController? controller;
  const TextFormNilai({
    super.key,
    required this.hint,
    required this.controller,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: Get.height * 0.05,
          width: 50,
          decoration: BoxDecoration(
            color: AppColors.grayshade,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  autofocus: true,
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  maxLength: 2,
                  readOnly: readOnly,
                  controller: controller,
                  style: KTextStyle.textFieldHintStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    focusColor: Colors.grey.shade50,
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
