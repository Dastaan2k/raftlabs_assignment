import 'package:flutter/material.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).disabledColor),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Loading'),
            SizedBox(width: 20),
            SizedBox(height: 10, width: 10, child: CircularProgressIndicator(color: Colors.grey,))
          ],
        )
    );
  }
}
