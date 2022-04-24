import 'package:flutter/material.dart';
import 'db.dart';
import 'package:provider/provider.dart';
import 'data.dart';
import 'package:flutter/src/widgets/async.dart';

class History extends StatefulWidget {
  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historique"),
        backgroundColor: Color(0xff6C81ae),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                    child: TextButton(
                        onPressed: () {
                          DB().deleteAll(
                              Provider.of<Data>(context, listen: false).db);
                          print('ok');
                          setState(() {});
                        },
                        child: Text(
                          "Effacer",
                          style: TextStyle(color: Colors.black54),
                        )))
              ];
            },
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      body: FutureBuilder(
        future: DB().Operations(Provider.of<Data>(context, listen: false).db),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xff6C81ae),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (!snapshot.hasData) {
              return Center(
                child: Text('Pas de donnée enregistrée'),
              );
            } else {
              var tab = snapshot.data as List;
              return ListView.builder(
                itemCount: tab.length,
                itemBuilder: (context, i) {
                  return Container(
                    height: 100,
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xff6c81ae), width: 1),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text(tab[i].date,
                                style: TextStyle(
                                    color: Color(0xFF1f293f),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900)),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              tab[i].operation,
                              style: TextStyle(
                                  color: Color(0xffb5bed3),
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900),
                            ),
                            Flexible(
                              child: Text(
                                tab[i].result,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Color(0xffb5bed3),
                                    fontSize: 30,
                                    fontWeight: FontWeight.w900),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          } else {
            return Center(
              child: Text(
                  'Une érreur s\'est produite, veuillez redémarrer l\'application '),
            );
          }
        },
      ),
    );
  }
}
