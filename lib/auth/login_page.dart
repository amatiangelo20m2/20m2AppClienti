import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/home.dart';
import '../theme/colors.dart';
import 'login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(0, 0),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: FloatingActionButton(
          backgroundColor: brown,
          onPressed: () {
            Navigator.pushNamed(context, Home.routeName);
          },
          child: Icon(Icons.menu, color: white),
        ),
      ),
      backgroundColor: white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/panino_home.jpg',
            fit: BoxFit.cover,
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context,
                Widget? child) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/sfondo_20m2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FractionalTranslation(
                  translation: _animation.value,
                  child: child,
                ),
              );
            },
            child: const Login(),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
