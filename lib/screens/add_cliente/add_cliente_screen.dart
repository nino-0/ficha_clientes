import 'package:flutter/material.dart';
import 'package:sheets_clients/constants.dart';
import 'package:sheets_clients/controllers/firestore_client.dart';
import 'package:sheets_clients/models/client_model.dart';
import 'package:sheets_clients/screens/add_cliente/components/rounded_input_generic.dart';
import 'package:sheets_clients/screens/login/components/rounded_button.dart';
import 'package:uuid/uuid.dart';

String nome = "";
String telefone = "";
String rua = "";
int numeroCasa = 0;

class AddClient extends StatefulWidget {
  const AddClient({Key? key}) : super(key: key);

  @override
  _AddClientState createState() => _AddClientState();
}

class _AddClientState extends State<AddClient> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController numCasaController = TextEditingController();
  FirestoreClient controller = FirestoreClient();

  void add(Client cliente) async {
    try {
      controller.insert_client("idUser", cliente);
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Cliente adicionado com sucesso")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Falha ao Adicionar o Cliente")));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Cliente"),
        elevation: 4,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RoundedInputTextGeneric(
                  controller: nomeController,
                  hintText: "Nome",
                  icon: Icons.person,
                  onChanged: (value) {
                    nome = value;
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedInputTextGeneric(
                  controller: telefoneController,
                  icon: Icons.phone,
                  hintText: "Telefone",
                  onChanged: (value) {
                    telefone = value;
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedInputTextGeneric(
                  controller: ruaController,
                  icon: Icons.streetview,
                  hintText: "Rua",
                  onChanged: (value) {
                    rua = value;
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedInputTextGeneric(
                  controller: numCasaController,
                  icon: Icons.confirmation_number,
                  hintText: "Numero",
                  onChanged: (value) {
                    numeroCasa = int.parse(value);
                  }),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedButton(
                  text: "Adicionar",
                  press: () {
                    add(Client(
                        uuid: Uuid().v1(),
                        nome: nome,
                        telefone: telefone,
                        rua: rua,
                        numeroCasa: numeroCasa));
                  }, //AuthController.login(_email, _password),
                  color: kButtonColor,
                  textColor: branco),
            ],
          ),
        ),
      ),
    );
  }
}
