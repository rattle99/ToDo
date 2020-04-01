import 'package:flutter/material.dart';

class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
  @override

  void showalertdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        title: Text("Add task"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: (){},
                  color: Colors.purple,
                  child: Text("Add"),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  Widget mycard(String task) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: ListTile(
          title: Text(task),
          onLongPress: (){
            print("To be deleted");
          },
        ),
      )
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: showalertdialog,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
      appBar: AppBar(
        title: Text("Tasks"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            mycard("task")
          ]
        )
      ),
    );
  }
}