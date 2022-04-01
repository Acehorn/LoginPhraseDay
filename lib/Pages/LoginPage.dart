import 'package:flutter/material.dart';
import 'package:frase_day/Providers/login_provider.dart';
import 'package:frase_day/Services/auth_service.dart';
import 'package:frase_day/Widgets/TextFieldLogin.dart';
import 'package:frase_day/Widgets/alert.dart';
import 'package:local_auth/local_auth.dart';
/* import 'package:local_auth/local_auth.dart'; */
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, 'presentation');
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Inicia sesión",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ChangeNotifierProvider(
                  create: (_) => LoginFormProvider(), child: _LogForm())
            ],
          ),
        ),
      ),
    );
  }
}

class _LogForm extends StatefulWidget {
  @override
  __LogFormState createState() => __LogFormState();
}

class __LogFormState extends State<_LogForm> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  bool canCheckBiometrics = false;

  var _authorizedOrNot;

  @override
  void initState() {
    checkingForBioMetrics();
    super.initState();
  }

  Future checkingForBioMetrics() async {
    canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    print(canCheckBiometrics);
    setState(() {});
  }

  Future<void> _authenticateMe() async {
    // 8. this method opens a dialog for fingerprint authentication.
    //    we do not need to create a dialog nut it popsup from device natively.
    bool authenticated = false;
    try {
      authenticated = await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "", // message for dialog
        useErrorDialogs: true, // show error in dialog
        stickyAuth: true, // native process
        sensitiveTransaction: true,
      );
    } catch (e) {
      print(e);
    }
    if (!mounted) return;

    _authorizedOrNot = authenticated ? "Authorized" : "Not Authorized";
    if (_authorizedOrNot == "Authorized") {
      Navigator.pushReplacementNamed(context, 'home');
    }
    print(_authorizedOrNot);
  }

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: TextFieldLogin(
                obscureField: false,
                hintText: "Correo electrónico",
                onChanged: (value) => loginForm.email = value,
                icon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                keyboardType: TextInputType.emailAddress,
                regex:
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                errorMessage:
                    "Favor de verificar el correo electrónico ingresado",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: TextFieldLogin(
                obscureField: true,
                hintText: "Contraseña",
                icon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                onChanged: (value) => loginForm.password = value,
                keyboardType: TextInputType.text,
                regex: r"^[a-z|0-9|A-Z]{8}",
                errorMessage: "La contraseña debe tener al menos 8 caracteres",
              ),
            ),
            canCheckBiometrics
                ? GestureDetector(
                    onTap: _authenticateMe,
                    child: Icon(
                      Icons.fingerprint,
                      size: 40,
                    ))
                : Container(),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 300,
                color: Colors.black,
                child: FlatButton(
                  color: Colors.black,
                  onPressed: loginForm.isLoading
                      ? null
                      : () async {
                          setState(() {});
                          showLoader(context);
                          FocusScope.of(context).unfocus();

                          final authService =
                              Provider.of<AuthService>(context, listen: false);

                          if (!loginForm.isValidForm()) return;

                          loginForm.isLoading = true;

                          await Future.delayed(Duration(seconds: 2));

                          final errorMessage = await authService.login(
                              loginForm.email, loginForm.password);
                          hideLoader(context);
                          if (errorMessage == null) {
                            Navigator.pushReplacementNamed(context, 'home');
                          } else {
                            print(errorMessage);

                            dialogOpen(context, errorMessage);
                          }
                          loginForm.isLoading = false;
                        },
                  child: Text(
                    "Inicia sesión",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
