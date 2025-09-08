import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final Color textColor;
  const DefaultButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(minimumSize: WidgetStateProperty.all(Size(60, 40)),
        backgroundColor: WidgetStateProperty.all<Color>(color),
        textStyle: WidgetStateProperty.all<TextStyle>(
          TextStyle(color: textColor),
          
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
