import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheets_clients/screens/login/components/rounded_button.dart';
import 'package:sheets_clients/screens/login/components/rounded_imput.dart';
import 'package:sheets_clients/screens/login/components/rounded_input_password.dart';
import 'package:sheets_clients/screens/login/components/top_bar.dart';
import 'package:sheets_clients/services/auth_service.dart';

import '../../../constants.dart';

String email = "";
String pass = "";
String confirPass = "";
String _screenName = "Registrar";

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    _doRegister() async {
      if (pass == confirPass) {
        try {
          await context.read<AuthService>().register(email, pass);
          Navigator.of(context).pushReplacementNamed("/");
        } on AuthException catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(e.message)));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('As senha não batem')));
      }
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () => authService.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(children: <Widget>[
                  TopBar(
                    size: size,
                    hintBar: _screenName,
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RoundedInputText(
                      hintText: "E-mail",
                      onChanged: (value) {
                        email = value;
                      }),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RoundedPasswordInput(
                    hintText: "Senha",
                    onChanged: (value) {
                      pass = value;
                      print(pass);
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RoundedPasswordInput(
                    hintText: "Confirmar senhar",
                    onChanged: (value) {
                      confirPass = value;
                      print(confirPass);
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  RoundedButton(
                      text: _screenName,
                      press: () {
                        _doRegister();
                      },
                      color: kButtonColor,
                      textColor: branco)
                ]),
              ),
      ),
    );
  }
}
