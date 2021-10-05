import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sheets_clients/models/client_model.dart';

class FirestoreClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void insert_client(String collection, Client cliente) async {
    try {
      await firestore
          .collection("Client")
          .doc(cliente.uuid)
          .set(cliente.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  void update_client(String ref, Client client) async {
    try {
      await firestore
          .collection("Client")
          .doc(client.uuid)
          .update(client.toJson());
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

// List<Presales> presales = list["data"]
//         .map<Presales>((model) => Presales.fromJson(model))
//         .toList();
  Future<List<Client>> all_clients(String ref) async {
    try {
      var all = await firestore.collection("Client").get();
      List<Client> listaCli = [];
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

  get_live_data(String ref) {
    try {
      return firestore.collection("Client").snapshots();
    } catch (e) {}
  }
}
