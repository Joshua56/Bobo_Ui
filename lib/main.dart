import 'package:bobo_ui/modules/club_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bobo App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xFF707070),
      ),
      home: ChangeNotifierProvider<ClubModule>(
        builder: (context)=> ClubModule(),
        child: Consumer<ClubModule>(
          builder: (context, clubModule, _){
            clubModule.fetchClubs;
            return GoogleMapPage();
          },
        ),
      ),
      routes: <String, WidgetBuilder> {
        '/club': (BuildContext context) => ClubsPage(),
        '/event': (BuildContext context) => EventsPage(),
        '/crew': (BuildContext context) => CrewPage(),
        '/taxi': (BuildContext context) => TaxiPage(),
        '/payment': (BuildContext context) => PaymentPage(),
        '/reservation': (BuildContext context) => ReservationPage(),
        '/settings': (BuildContext context) => SettingsPage(),
      },

    );
  }
}

class ClubsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("ClubsPage"),),
    );
  }
}
class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("events"),),
    );
  }
}
class CrewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("crew"),),
    );
  }
}
class TaxiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("taxi"),),
    );
  }
}
class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("payment"),),
    );
  }
}
class ReservationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("reservation"),),
    );
  }
}
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(child: Text("settings"),),
    );
  }
}
