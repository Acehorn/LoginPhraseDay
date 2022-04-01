import 'package:flutter/material.dart';
import 'package:frase_day/Widgets/alert.dart';

class FondeadoraView extends StatelessWidget {
  const FondeadoraView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.topLeft,
              child: Text(
                "FONDEADORA",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: size.height * 0.70,
              child: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  buttonMenu(context, "Ahorros"),
                  buttonMenu(context, "Inversiones"),
                  buttonMenu(context, "Cheques"),
                  buttonMenu(context, "Pagos"),
                  buttonMenu(context, "Tarjeta"),
                  buttonMenu(context, "Divisas"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonMenu(context, String text) {
    return GestureDetector(
      onTap: () {
        dialogOpen(context, "proximamente");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(8),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 23),
        )),
      ),
    );
  }
}
