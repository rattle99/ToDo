import 'package:flutter/material.dart';
import 'package:todo/dbhelper.dart';

class todoui extends StatefulWidget {
  @override
  _todouiState createState() => _todouiState();
}

class _todouiState extends State<todoui> {
  @override

  final dbhelper = Databasehelper.instance;

  final texteditingcontroller = TextEditingController();
  bool validated = true;
  String errorText = "";
  String todoEdited = "";
  var myitems = List();
  List<Widget> children = new List<Widget>();

  void addtodo() async {
    Map<String, dynamic> row = {
      Databasehelper.columnName : todoEdited,
    };
    final id = await dbhelper.insert(row);
    Navigator.pop(context);
    todoEdited = "";
    setState(() {
      validated = true;
      errorText = "";
    });
  }

  Future<bool> query() async {
    myitems = [];
    children = [];
    var allrows = await dbhelper.queryall();
    allrows.forEach((row) {
      myitems.add(row.toString());
      children.add(
        Card(
          elevation: 5.0,
          margin: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(row['todo']),
              onLongPress: (){
                dbhelper.deletedata(row['id']);
                setState(() {
                  
                });
              },
            ),
          )
        )
      );
    });
    return Future.value(true);
  }
  
  void showalertdialog() {
    texteditingcontroller.text = "";
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              ),
            title: Text("Add task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: texteditingcontroller,
                  autofocus: true,
                  onChanged: (_val) {
                    todoEdited = _val;
                  },
                  decoration: InputDecoration(
                    errorText: validated ? null : errorText,
                  ),
                ),
                Row(
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        if(texteditingcontroller.text.isEmpty) {
                          setState(() {
                            errorText = "Can't be empty!";
                            validated = false;
                          });
                        }
                        else if(texteditingcontroller.text.length > 512) {
                          setState(() {
                            errorText = "Too long!";
                            validated = false;
                          });
                        }
                        else {
                          addtodo();
                        }
                      },
                      color: Colors.purple,
                      child: Text("Add"),
                    )
                  ],
                )
              ],
            ),
          );
        });
      }
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.hasData == null) {
          return Center(
            child: Text("No Data"),
          );
        }
        else {
          if (myitems.length == 0) {
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
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              body: Center(
                child: Text("No Tasks"),
              ),
            );
          }
          else {
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
                centerTitle: true,
                backgroundColor: Colors.black,
              ),
              backgroundColor: Colors.black,
              body: SingleChildScrollView(
                child: Column(
                  children: children,
                ),
              ),
            );
          }
        }
      },
      future: query(),
    );
  }
}