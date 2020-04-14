import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/cart/checkoutPage.dart';
import 'package:minor2/MORE_widgets/homeScreen/HomeScreen.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
//          color: Colors.blue,
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40)
        ),
      ),
      child: CartCode(context),
    );
  }
}


Widget CartCode(context){
  return ScopedModelDescendant<MainModel>(
      builder: (context1, child, MainModel)
  {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Align(
          alignment: Alignment(-1.14, -1.1),
          child: Container(
//              color: Colors.blue,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 7,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3.7,
              child: Center(
                  child: IconButton(
                      icon: Icon(Icons.arrow_drop_down, size: 40,),
                      onPressed: () {
                        Navigator.pop(context);
                      }))),
        ),
        Align(
          alignment: Alignment(0, -0.99),
          child: Container(
//              color: Colors.blue,
            height: MediaQuery
                .of(context)
                .size
                .height / 13,
            width: MediaQuery
                .of(context)
                .size
                .width / 3.7,
            child: Center(
              child: Text(
                "${MainModel.Cart.length.toString()} Items",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(1.05, -0.99),
          child: GestureDetector(
            onTap: () {
              print("Clear tapped");
            },
            child: Container(
//              color: Colors.blue,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 13,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 3.7,
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.clear,
                        color: Colors.red,
                      ),
                      Text(
                        "Clear All",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  )),
            ),
          ),
        ),
        Align(
            alignment: Alignment(0, -0.40),
            child: Container(
//              color: Colors.black12,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 1.5,
//            color: Colors.black12,
              width: MediaQuery
                  .of(context)
                  .size
                  .width / 0.8,
              margin: EdgeInsets.all(1),
              child: CartList(context,MainModel),
            )),
        Align(
          alignment: Alignment(0.6, 0.76),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text("TOTAL : ", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text("₹ ${MainModel.Main_Details.amount.toString()}"
                  , style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25),),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment(0, 1.02),
          child: Container(
//              color: Colors.blue,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 9,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(
                child: RaisedButton(
                    color: Colors.red[900],
                    padding: EdgeInsets.fromLTRB(130, 20, 130, 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    splashColor: Colors.greenAccent,
                    child: Text( MainModel.checkout_active!=0?"Go to Home":
                      "Checkout",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    onPressed: () {
//                      MainModel.cal_total();
                    if(MainModel.checkout_active==0){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutPage()));
                    }
                    else{
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));

                    }
                    }),
              )),
        )
      ],
    );
  });
}

Widget CartList(context,MainModel MainModel) {
//  return ScopedModelDescendant<MainModel>(
//      builder: (context, child, MainModel) {
  total(i){
    double price = double.parse(MainModel.Cart[i].price.toString());
    double quantity = double.parse(MainModel.Cart[i].quantity.toString());
    double value = price * quantity ;
    return value ;
  }
        return Container(
          height: MediaQuery
              .of(context).size.height / 1.35,
          child: ListView.builder(
            itemCount: MainModel.Cart.length,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20
            ),
            itemBuilder: (context, index) {
              ItemDetails data = MainModel.Cart[index];
              return Container(
                margin: EdgeInsets.only(
                  top: 10
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent
                ),
                child: Material(
                  elevation: 5,
                  color: Colors.blue[100],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: Text(data.name.toString()),
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Text((index + 1).toString(),style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    trailing: Container(
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width / 2.8,
//                color: Colors.black38,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${MainModel.Cart[index].price.toString()} X ${MainModel.Cart[index].quantity.toString()}"),
                                Text(
//                              "AED ${(data.price * data.quantity).toStringAsFixed(2)}",
                                  "${total(index).toString()} ₹",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height / 70,
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                  ("deleted tapped");
                                  MainModel.remove_item_from_cart(
                                    email: MainModel.Main_Details.email.toString(),
                                    barcode_in: data.barcode.toString(),
                                    orderID: MainModel.Main_Details.orderID,
                                    qty: data.quantity
                                  );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
//      });
}