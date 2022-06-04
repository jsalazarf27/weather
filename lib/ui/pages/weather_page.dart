import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.grey],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Medellín, CO",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const Text(
                "Lat: -75.5636 Long: 6.2518",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              Row(children: [
                Image.network(
                  "http://openweathermap.org/img/wn/10d@2x.png",
                  height: 100,
                ),
                const Text("17°C",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black45,
                    ))
              ]),
              Container(
                width: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.deepOrangeAccent),
                child: const Center(
                    child: Text("Rain",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ))),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Feels like 20°C. light rain",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Humidity: 95%",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Visibily: 10000",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Max temp: 18°C",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Min temp: 17°C",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Pressure: 1024hPa",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(10),
                        child: const Text("Speed wind: 3.6",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
