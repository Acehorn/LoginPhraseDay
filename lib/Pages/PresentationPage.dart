import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frase_day/Screens/auth_screens.dart';
import 'package:frase_day/Services/auth_service.dart';
import 'package:provider/provider.dart';

class PresentationPage extends StatelessWidget {
  const PresentationPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    final double height = MediaQuery.of(context).size.height;
    List<String> imgList = [
      "assets/joe-straker-QOlUd56l9ZE-unsplash.jpg",
      "assets/ozzie-kirkby-Ig8uqUCGADc-unsplash.jpg",
    ];

    return Scaffold(
      body: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Text('');

          if (snapshot.data == "") {
            return Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,

                    autoPlayCurve: Curves.easeInExpo,

                    autoPlayAnimationDuration: Duration(seconds: 4),
                    height: height,

                    viewportFraction: 0.999,

                    // autoPlay: false,
                  ),
                  items: imgList
                      .map((item) => Container(
                            child: Center(
                                child: Image.asset(
                              item,
                              fit: BoxFit.cover,
                              height: height,
                            )),
                          ))
                      .toList(),
                ),
                Center(
                  child: Container(
                    child: Text(
                      "FONDEADORA",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 300,
                        color: Colors.white,
                        child: FlatButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, 'register');
                          },
                          child: Text(
                            "Registrate",
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "¿Ya tienes cuenta?  ",
                                style: TextStyle(color: Colors.white),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "login");
                                  },
                                  child: Text(
                                    "Inicia sesión",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                  )),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            );
          } else {
            Future.microtask(() {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => HomePage(),
                      transitionDuration: Duration(seconds: 0)));
            });

            return Container();
          }
        },
      ),
    );
  }
}
