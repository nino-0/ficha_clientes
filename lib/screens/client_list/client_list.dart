import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sheets_clients/controllers/firestore_client.dart';
import 'package:sheets_clients/models/client_model.dart';
import 'package:sheets_clients/screens/add_cliente/update_cliente.dart';
import 'package:sheets_clients/services/auth_service.dart';

class ClientList extends StatefulWidget {
  const ClientList({Key? key}) : super(key: key);

  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    _doSingout() {
      try {
        context.read<AuthService>().signOut();
      } on AuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message)));
      }
    }

    final FirestoreClient fireStore = Provider.of<FirestoreClient>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de Clientes"),
          elevation: 4,
          leading: Icon(Icons.menu),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Sair',
              onPressed: () => _doSingout(),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          //não sei como pegar esse o UID do user logado '-'
          stream: fireStore.get_live_data(
              "uid do Usuario"), //firestore.collection("Client").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('HOUVE UM ERRO AO BUSCAR OS DADOS'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  onLongPress: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdateClientLess(cliente: Client.fromJson(data));
                    }));
                  },
                  title: Text(data["nome"]),
                  leading: Icon(Icons.person),
                  trailing: IconButton(
                    onPressed: () {
                      fireStore.delete_client(Client.fromJson(data));
                    },
                    icon: Icon(Icons.close_rounded),
                    color: Colors.red,
                  ),
                );
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("/add_client");
          },
          tooltip: 'Adiciona um novo Cliente',
          child: Icon(Icons.add),
        ));
  }
}







// FutureBuilder<List<Client>>(
//           future: lista, //future_presales,
//           builder: (context, snapshot) {
//             if (snapshot.hasError) {
//               return Text('[Erro] - snapShot não tem dados ${snapshot.error}');
//             } else if (snapshot.hasData) {
//               return ListView.builder(
//                   padding: const EdgeInsets.all(8),
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ListTile(
//                       onLongPress: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return UpdateClientLess(
//                               cliente: snapshot.data![index]);
//                         }));
//                       },
//                       title: Text(snapshot.data![index].nome),
//                       leading: Icon(Icons.person),
//                       trailing: IconButton(
//                         onPressed: () {
//                           controller.delete_client(snapshot.data![index]);
//                         },
//                         icon: Icon(Icons.close_rounded),
//                         color: Colors.red,
//                       ),
//                     );
//                   });
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),