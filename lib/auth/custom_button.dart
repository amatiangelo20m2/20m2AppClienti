import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/styles.dart';

class CustomButton extends StatelessWidget {
  final AnimationController controller;
  final Animation<double> largura;
  final Animation<double> altura;
  final Animation<double> radius;
  final Animation<double> opacidade;

  final List<Color> gradientColors;
  final String buttonText;
  final VoidCallback onPressed;

  CustomButton({
    Key? key,
    required this.controller,
    required this.gradientColors,
    required this.buttonText,
    required this.onPressed,
  })  : largura = Tween<double>(
    begin: 0,
    end: 500,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5),
    ),
  ),
        altura = Tween<double>(
          begin: 0,
          end: 50,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.7),
          ),
        ),
        radius = Tween<double>(
          begin: 0,
          end: 20,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 1.0),
          ),
        ),
        opacidade = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.6, 0.8),
          ),
        ),
        super(key: key);

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: largura.value,
        height: altura.value,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius.value),
          gradient: LinearGradient(
            colors: gradientColors,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: opacidade,
            child: Text(
              buttonText,
              style: customTitle.copyWith(color: white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: _buildAnimation,
    );
  }
}
