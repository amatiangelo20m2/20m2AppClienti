import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ventimetriappclienti/theme/styles.dart';
import '../../theme/colors.dart';
import 'custom_button.dart';
import 'input_custom.dart';
import 'facebook_login_button.dart';
import 'google_login_button.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animacaoFade;
  Animation<double>? _animacaoSize;
  bool _showConfermaPassword = false;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _animacaoFade = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.easeInOutQuint,
      ),
    );

    _animacaoSize = Tween<double>(
      begin: 0,
      end: 500,
    ).animate(
      CurvedAnimation(
        parent: _controller!,
        curve: Curves.decelerate,
      ),
    );

    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showConfermaPassword = !_showConfermaPassword;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 90,
              height: 90,
              child: SvgPicture.asset('assets/images/logo-bianco.svg'),
            ),
            FadeTransition(
              opacity: _animacaoFade!,
              child: Text(_showConfermaPassword ? "Login" : "Registrati", style: customMiddleParagraph),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 30),
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _animacaoSize!,
                    builder: (context, widget) {
                      return Container(
                        width: _animacaoSize?.value,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const CustomInput(
                              hint: 'Email',
                              obscure: false,
                              icon: Icon(Icons.person),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 0.5,
                                    blurRadius: 0.5,
                                  ),
                                ],
                              ),
                            ),
                            const CustomInput(
                              hint: 'Password',
                              obscure: true,
                              icon: Icon(Icons.lock),
                            ),
                            if (_showConfermaPassword) // Conditionally render "Conferma Password" input field
                              const CustomInput(
                                hint: 'Conferma Password',
                                obscure: true,
                                icon: Icon(Icons.lock),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 10),
                  CustomButton(
                    controller: _controller!,
                    onPressed: () {},
                    buttonText: _showConfermaPassword ?  "Registrati" : "Login",
                    gradientColors: [brown.withOpacity(.9), brown, brown],
                  ),
                  const SizedBox(height: 10),
                  FadeTransition(
                    opacity: _animacaoFade!,
                    child: Text("Password dimenticata?", style: customMiddleParagraph),
                  ),
                  Divider(height: 32, color: white),
                  GoogleSignButton(controller: _controller!),
                  SizedBox(height: 3,),
                  FacebookSignButton(controller: _controller!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}