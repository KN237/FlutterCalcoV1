import 'package:flutter/material.dart';
import 'calco.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(join(await getDatabasesPath(), 'calco.db'),
      version: 1, onCreate: (db, version) {
    return db.execute(
        'create table operations (id integer primary key autoincrement,operation text,result text,date date)');
  });
  runApp(myApp(db: await database));
}

class myApp extends StatelessWidget {
  myApp({this.db});
  Database? db;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Data(db: db),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xffe4edff),
        ),
        home: Calco(),
      ),
    );
  }
}
