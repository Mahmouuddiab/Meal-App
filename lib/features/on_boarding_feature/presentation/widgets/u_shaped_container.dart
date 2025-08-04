import 'package:flutter/material.dart';

import '../../../../core/Utils/app_colors.dart';

class UShapedContainer extends StatelessWidget{
  const UShapedContainer({super.key});

  @override
  Widget build(BuildContext context){
    return ClipPath(
    clipper: _UShapeClipper(),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 4,
            color: AppColors.black
          )
        ]
      ),

      height: MediaQuery.of(context).size.height * 0.66,
      width: double.infinity,
      )
    );
  }
}


class _UShapeClipper extends CustomClipper<Path>{


  @override
  Path getClip(Size size) {

      final path = Path();
      
      // 1. Start at top-left corner (point A)
      path.moveTo(0, 0);
      
      // 2. Draw straight line down left side (point B)
      path.lineTo(0, size.height * 0.7);

      // 3. First quadratic curve - left half of U (B → C)
      path.quadraticBezierTo(
        size.width * 0.5,  // Control point (P1) - pulls curve downward
        size.height ,        // This is the "depth" of the U
        size.width ,   // End point (C) - middle bottom
        size.height * 0.7   // Same height as start point
      );

      path.lineTo(size.width, 0);

      
      // 6. Close the path (automatically connects E → A)
      path.close();
      
      return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;

}
