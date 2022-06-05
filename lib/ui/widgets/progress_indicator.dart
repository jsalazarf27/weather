import 'package:flutter/material.dart';

class CricleProgressIndicator extends StatelessWidget {
  const CricleProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(.7),
      child: const Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.deepOrangeAccent,
        ),
      ),
    );
  }
}
