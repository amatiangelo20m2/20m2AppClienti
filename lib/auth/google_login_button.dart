import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import '../../theme/colors.dart';
import '../state_managment/state_managment.dart';
import '../theme/styles.dart';

class GoogleSignButton extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> _signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      // Create a new credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

      // Return the user
      return userCredential.user;
    } catch (error) {
      // Handle sign-in errors
      print("Error signing in with Google: $error");
      return null;
    }
  }

  AnimationController controller;
  Animation<double> largura;
  Animation<double> altura;
  Animation<double> radius;
  Animation<double> opacidade;

  GoogleSignButton({super.key,
    required this.controller})
      : largura = Tween<double>(
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
        );

  Widget _buildAnimation(BuildContext context, Widget? widget) {
    return Consumer<StateManagmentProvider>(
      builder: (BuildContext context, StateManagmentProvider stateManagmentProvider, Widget? child) {
        return InkWell(
          onTap: () async {
            showDialog(
              context: context,
              barrierDismissible: false, // Prevent dialog from closing when tapped outside
              builder: (BuildContext context) {
                return Center(
                  child: SpinKitFadingFour(
                    color: brown,
                    size: 50.0,
                  ),
                );
              },
            );
            // await stateManagmentProvider.loginUserAndRetrieveDataFake('amati.angelo90@gmail.com');
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CollectData()));
            // }else{
            //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RootApp()));
            // }




            User? user = await _signInWithGoogle();

            if (user != null) {

              print("User signed in: ${user.displayName}");
              print("User signed in: ${user.email}");
              print("User signed in with number: ${user.phoneNumber}");

              String? token = await FirebaseMessaging.instance.getToken();
              // Sign in to Firebase with the Google credential

              print('Store credentials: ' + token!);

              // await stateManagmentProvider.loginUserAndRetrieveData(user, token);
              // if(stateManagmentProvider.ventiMetriQuadriData.branches.isEmpty){
              //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CollectData()));
              // }else{
              //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RootApp()));
              // }


            } else {
              print("Sign-in failed.");
            }
          },
          child: Container(
            width: largura.value,
            height: altura.value,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius.value),
              gradient: LinearGradient(
                colors: [
                  white,
                  white
                ],
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: opacidade,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/google.svg', height: 18),
                    Text(
                      "  Accedi con Google",
                      style: customParagraphBackground,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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