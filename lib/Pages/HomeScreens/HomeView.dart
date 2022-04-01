import 'package:flutter/material.dart';
import 'package:frase_day/Models/QuoteDay.dart';
import 'package:frase_day/Services/quote_request.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  "assets/priscilla-du-preez-tAnrp8P51tY-unsplash.jpg",
                  fit: BoxFit.cover,
                  height: 320,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.topLeft,
                child: Text(
                  "La frase del dia es:",
                  style: TextStyle(fontSize: 23),
                ),
              ),
              FutureBuilder(
                builder: (context, projectSnap) {
                  if (projectSnap.hasData == true) {
                    QuoteDay project = projectSnap.data;

                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(44),
                        alignment: Alignment.topLeft,
                        child: Text(
                          project.contents.quotes[0].quote,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(44),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "The only person you are destined to become is the person you decide to be.",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                future: quoteOfTheDay(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
