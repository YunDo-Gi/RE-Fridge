import 'package:flutter/material.dart';
import 'package:re_fridge/colors.dart';
import 'package:re_fridge/controllers/pantry_controller.dart';

class BlinkingCircle extends StatefulWidget {
  @override
  _BlinkingCircleState createState() => _BlinkingCircleState();
}

class _BlinkingCircleState extends State<BlinkingCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  final pantryController = PantryController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _colorAnimation = ColorTween(
            begin: pantryController.color,
            end: pantryController.color.withOpacity(0))
        .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
