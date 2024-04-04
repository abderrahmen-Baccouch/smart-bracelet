import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/animated_btn.dart';
import 'components/sign_in_dialog.dart';

class OnbodingScreen extends StatefulWidget {
  const OnbodingScreen({super.key});

  @override
  State<OnbodingScreen> createState() => _OnbodingScreenState();
}

class _OnbodingScreenState extends State<OnbodingScreen> {
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
       Positioned(
  top: 0,
  left: 0,
  right: 0,
  child: Container(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Transform.scale(
        scale: 0.8, // Adjust the scale factor as needed
        child: Image.asset(
          "assets/icons/sport.png",
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
),

 Positioned(
  top: 0,
  left: 0,
  right: 0,
  child: Container(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Transform.scale(
        scale: 0.6, // Adjust the scale factor as needed
        child: Image.asset(
          "assets/icons/bracelet.png",
          fit: BoxFit.cover,
        ),
      ),
    ),
  ),
),



          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top :80.0),
                            child: Text(
                              "Health care & ",
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Poppins",
                                height: 1.2,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Don't miss out on the health revolution – step into a smarter, empowered well-being with innovative technologies.",
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;

                        Future.delayed(
                          const Duration(milliseconds: 800),
                          () {
                            setState(() {
                              isShowSignInDialog = true;
                            });
                            showCustomDialog(
                              context,
                              onValue: (_) {
                                setState(() {
                                  isShowSignInDialog = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                   const Padding(
  padding: EdgeInsets.symmetric(vertical: 24),
  child: Text(
    "© 2023 Smart Health. All rights reserved.",
    style: TextStyle(
      color: Colors.grey,
      fontSize: 12,
      
    ),
   
  ),
),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
