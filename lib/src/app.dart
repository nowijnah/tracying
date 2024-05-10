import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:samplelogin/src/pages/home.dart';
import 'package:samplelogin/src/pages/provider/CounterModel.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CounterModel(),
      child: FutureBuilder(
      future: Firebase.initializeApp(), 
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Center(
            child: Text("Firebase load failed"),
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return Home();
        }
        return CircularProgressIndicator();
      },
    ));
  }
}