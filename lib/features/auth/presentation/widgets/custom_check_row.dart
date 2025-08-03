import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCheckRow extends StatelessWidget {
  const CustomCheckRow({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
  });
  final bool value;
  final void Function(bool?) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            checkColor: Colors.indigo,
            side: BorderSide(color: Colors.white),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
