import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';
import 'package:sheets_clients/controllers/firestore_client.dart';
import 'package:sheets_clients/screens/add_cliente/add_cliente_screen.dart';
import 'package:sheets_clients/screens/client_list/client_list.dart';
import 'package:sheets_clients/screens/login/login_screen.dart';

import 'package:sheets_clients/screens/register/register_screen.dart';
import 'package:sheets_clients/services/auth_service.dart';
import 'package:sheets_clients/services/authenticationService.dart';
import 'package:sheets_clients/widgets/authentication_wrapper.dart';
import 'package:sheets_clients/widgets/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<FirestoreClient>(
          create: (_) => FirestoreClient(),
        ),
      ],
      child: MaterialApp(
        title: 'Ficha app',
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('você tem um erro ${snapshot.error.toString()}');
              return Text("algo deu errado!");
            } else if (snapshot.hasData) {
              return Manager();
              // MyHomePage(title: 'Flutter Demo Home Page');
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class Manager extends StatelessWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (_) => Wrapper(),
        '/register': (_) => RegisterScreen(),
        '/login': (_) => Login(),
        '/client_list': (_) => ClientList(),
        '/add_client': (_) => AddClient(),
      },
    );
  }
}
