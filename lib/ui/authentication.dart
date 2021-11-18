import 'package:flutter/material.dart';

class Authentication extends StatelessWidget{
  const Authentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ListView(

          padding: const EdgeInsets.all(32.0),
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                ),
                filled: true
              ),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                  filled: true
              ),
            ),
            const Padding(padding: EdgeInsets.all(16.0)),
            FloatingActionButton.extended(
              onPressed: () {},
              label: const Text("Log In"),
            )
          ],
        ),
      ),
    );
  }

}