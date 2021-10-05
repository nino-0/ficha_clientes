import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:sheets_clients/screens/login/components/rounded_button.dart';
import 'package:sheets_clients/screens/login/components/rounded_imput.dart';
import 'package:sheets_clients/screens/login/components/rounded_input_password.dart';
import 'package:sheets_clients/screens/login/components/top_bar.dart';

import 'package:sheets_clients/services/auth_service.dart';
import 'package:sheets_clients/services/authenticationService.dart';

import '../../../constants.dart';

String _password = "";
String _email = "";
final _formkey = GlobalKey<FormState>();

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _doLogin() async {
      if (_formkey.currentState!.validate()) {
        try {
          await context.read<AuthService>().Login(_email, _password);
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      }
    }

    Size size = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      body: Obx(
        () => authService.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TopBar(
                      size: size,
                      hintBar: "Login",
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    RoundedInputText(
                        hintText: "E-mail",
                        onChanged: (value) {
                          _email = value;
                        }),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundedPasswordInput(
                      hintText: "Senha",
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundedButton(
                        text: "Entrar",
                        press: () =>
                            _doLogin(), //AuthController.login(_email, _password),
                        color: kButtonColor,
                        textColor: branco),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                      child: Text("Registar-se"),
                    )
                  ],
                ),
              )),
      ),
    );
  }
}
