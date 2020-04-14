import 'package:flutter/material.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class PreviousOrderPage extends StatefulWidget {
  @override
  _PreviousOrderPageState createState() => _PreviousOrderPageState();
}

class _PreviousOrderPageState extends State<PreviousOrderPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel)
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          elevation: 10,

          title: Text("Previous Orders"),
          centerTitle: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )),
        ),
        body: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
//        width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              itemCount: MainModel.previous_orders_list.length,
              padding: EdgeInsets.only(
                  top: 10
              ),
              itemBuilder: (context, index) {
              var data = MainModel.previous_orders_list[index];
                return ListTile(
                  title: Text(data["orderID"].toString()), // + " - OrderIdFromDB"),
                  subtitle: Text(data["timestamp"].toString().length>9?data["timestamp"].toString().substring(0,10):"date"),
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  trailing: Container(
                    width: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(data['amount']),
                        IconButton(
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              color: Colors.blue,
                              size: 40,
                            ),
                            onPressed: () {

                            }),
                      ],
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
