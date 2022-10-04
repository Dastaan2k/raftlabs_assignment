import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String title;
  final VoidCallback? callback;

  const AppButton({Key? key, required this.title, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary),
        child: Text(title, style: const TextStyle(color: Colors.black))
    );
  }
}
