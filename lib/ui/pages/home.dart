import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iremember/blocs/app_state_provider.dart';

import 'add.dart';

//TODO List out items from Firestore with image using the state management solution you have integrated
class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        leading: Icon(Icons.home),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
        Navigator.pushNamed(context, AddPage.route);
      }),
      body: StreamBuilder(
        stream: appState.articleBloc.articles,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data.documents.map((doc){
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide()
                  )
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      child: Image.network(doc.data['imageURL']),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(doc?.data['name'] ?? ''),
                          Text(doc?.data['description'] ?? '')
                        ],
                      ),
                    )
                  ],
                ),
              );
            }).toList(),
          );
        },
      )
    );
  }

}
