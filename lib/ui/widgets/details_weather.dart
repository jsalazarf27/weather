import 'package:flutter/material.dart';

class DetailsWeather extends StatelessWidget {
  const DetailsWeather({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: const [
          DetailRow(leftText: "Humidity: 95%", rightText: "Visibily: 10000"),
          DetailRow(leftText: "Max temp: 18°C", rightText: "Min temp: 17°C"),
          DetailRow(
              leftText: "Pressure: 1024hPa", rightText: "Speed wind: 3.6"),
        ],
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final String? leftText;
  final String? rightText;
  const DetailRow({Key? key, this.leftText, this.rightText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (leftText != null) TextDetail(text: leftText!),
        if (rightText != null) TextDetail(text: rightText!),
      ],
    );
  }
}

class TextDetail extends StatelessWidget {
  final String text;
  const TextDetail({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ));
  }
}
