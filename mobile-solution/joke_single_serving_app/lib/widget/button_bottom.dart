import 'package:flutter/material.dart';

class ButtonBottom extends StatelessWidget {
  final void Function()? onPressed;
  final String? titleButton;
  final Color? colorButton;

  const ButtonBottom({
    super.key,
    this.onPressed,
    this.titleButton,
    this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(colorButton)),
        onPressed: onPressed,
        child: Text(
          titleButton ?? "",
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
