import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback press;

  const AnimatedButton({Key? key, required this.press}) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.forward();
        Future.delayed(
          const Duration(milliseconds: 800),
          () {
            widget.press();
          },
        );
      },
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Opacity(
                opacity: 1 - _animationController.value,
                child: Image.asset(
                  "assets/RiveAssets/button.png", // Replace with your button image
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              top: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_right),
                  const SizedBox(width: 8),
                  Text(
                    "Start the adventure",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
