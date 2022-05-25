import 'package:flutter/material.dart';

class RoundedKeyActionButton extends StatelessWidget {
  const RoundedKeyActionButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.color,
  }) : super(key: key);

  final void Function()? onPressed;
  final Color? color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: color,
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
