import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';

class CheckoutDone extends StatefulWidget {
  @override
  _CheckoutDoneState createState() => _CheckoutDoneState();
}

class _CheckoutDoneState extends State<CheckoutDone> {

  MainModel model ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model = ScopedModel.of(context) ;
    model.checkout_change(1);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    model.checkout_change(0);
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel)
    {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[900],
          title: Text("Pay"),
          centerTitle: true,
          elevation: 10,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)
          )),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.check_circle),
                onPressed: (){
                    MainModel.checkout_true(
                      orderID: MainModel.Main_Details.orderID,
                      email: MainModel.Main_Details.email,
                      paid: "true",
                      sum: MainModel.cal_total().toString()
                    );
                }),
            IconButton(icon: Icon(Icons.receipt),
                onPressed: (){

                  var items = jsonEncode(MainModel.Cart.map((e) => e.toJson()).toList());
                  print("items json = "+items.toString());
                  var sendData = {
                    "items": items,
                    "order_id": MainModel.Main_Details.orderID,
                    "total": MainModel.Main_Details.amount,
                    "customer_address":MainModel.Main_Details.address,
                    "customer_email": MainModel.Main_Details.email,
                    "date":"27/2/19"
                  } ;
                  MainModel.send_invoice(sendData);
                })
          ],
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20,),
                Text("Thanks For Shopping with us", style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
//                  shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 5,spreadRadius: 5)]
                ),),
                SizedBox(height: 20,),
                Container(
                    height: 200,
                    child: Image.network(
                        "https://jet-marking.com/wp-content/uploads/2017/04/pasted-image-0-1.png")
                ),
                SizedBox(height: 20,),
                Text(MainModel.Cart.length.toString(), style: TextStyle(fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),),
                Text("Item(s) in Cart", style: TextStyle(fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),),
                SizedBox(height: 50,),


                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () {
                      MainModel.OpenCart(context);
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                        height: 50,
                        width: double.infinity,
                        child: Center(child: Text("Show Cart", style: TextStyle(
                            color: Colors.white, fontSize: 30),))),
                  ),
                  color: Colors.red[800],
                  elevation: 10,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
