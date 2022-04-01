import 'package:flutter/material.dart';
import 'package:frase_day/Services/auth_service.dart';
import 'package:frase_day/Widgets/alert.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(24),
              alignment: Alignment.topLeft,
              child: Text(
                "Perfil",
                style: TextStyle(fontSize: 23),
              ),
            ),
            optionList(
                Icon(
                  Icons.account_circle,
                  color: Colors.black,
                ),
                "Perfil", () {
              dialogOpen(context, "proximamente");
            }),
            optionList(
                Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                "Configuración", () {
              dialogOpen(context, "proximamente");
            }),
            optionList(
                Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                "Cerrar sesión", () {
              authService.logout();
              Navigator.pushReplacementNamed(context, "presentation");
            }),
          ],
        ),
      ),
    );
  }

  Widget optionList(Icon icon, String text, onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          ListTile(
            leading: icon,
            title: Text(text),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ),
          Divider(
            color: Colors.black,
            height: 2,
          ),
        ],
      ),
    );
  }
}
