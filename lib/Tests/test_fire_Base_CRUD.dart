import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:sheets_clients/controllers/firestore_client.dart';
import 'package:sheets_clients/models/client_model.dart';
import 'package:sheets_clients/services/auth_service.dart';
import 'package:uuid/uuid.dart';

var firestore = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AuthService auth = AuthService();

  FirestoreClient controller = FirestoreClient();

// final authService = Provider.of<AuthService>(context);
  Client cliente = new Client(
      uuid: Uuid().v1(),
      nome: "joaca silva rodrigues ",
      telefone: "777777777777",
      rua: "rua dos campos",
      numeroCasa: 04);

  var wait = await get_live_data("helloThere");
  print(wait);
  // controller.insert_client("Client", cliente);
  // insert_client("chaveDoUSER123", cliente);
  // update_client("XYDSPm00NPa1NG069CTo", cliente);
  // delete_client(cliente);
  // get_all_clients("Client");
}

void insert_client(String collection, Client cliente) {
  try {
    firestore.collection("Client").doc(cliente.uuid).set(cliente.toJson());
  } catch (e) {
    print(e.toString());
  }
}

void update_client(String ref, Client client) {
  try {
    firestore.collection("Client").doc(client.uuid).update(client.toJson());
  } catch (e) {
    print(e.toString());
  }
}

void delete_client(Client cliente) {
  try {
    firestore.collection('Client').doc(cliente.uuid).delete();
  } catch (e) {
    print(e.toString());
  }
}

Future<List<Client>> all_clients(String ref) async {
  try {
    var all = await firestore.collection("Client").get();
    List<Client> listaCli = [];
    // List<Client> listaCli =
    //     all.docs.map<Client>((e) => Client.fromJson(e)).toList();
    for (var doc in all.docs) {
      print(doc["nome"]);
      listaCli.add(Client(
          uuid: doc["uuid"],
          nome: doc["nome"],
          telefone: doc["telefone"],
          rua: doc["rua"],
          numeroCasa: doc["numero_casa"]));
    }

    return listaCli;
  } catch (e) {
    print(e.toString());
    return [];
  }
}

void get_all_clients(String ref) async {
  try {
    var all = await firestore.collection("Client").get();
    for (var doc in all.docs) {
      print(doc["nome"]);
    }
  } catch (e) {
    print(e.toString());
  }
}

Future<List<Client>> get_live_data(String ref) async {
  try {
    List<Client> listaCli = [];
    var result = await firestore.collection("Client").get();
    ;
    firestore.collection("Client").snapshots().listen((r) {
      result = r;
      for (var doc in r.docs) {
        print(doc["nome"]);
        listaCli.add(Client(
            uuid: doc["uuid"],
            nome: doc["nome"],
            telefone: doc["telefone"],
            rua: doc["rua"],
            numeroCasa: doc["numero_casa"]));
      }
    });

    return listaCli;
  } catch (e) {
    print(e.toString());
    return [];
  }
}
