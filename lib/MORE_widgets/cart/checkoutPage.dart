import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/cart/checkoutDone.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:upi_india/upi_india.dart';
import 'package:minor2/globals.dart' as globals;

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {



  var _transaction;

  Future<String> initiateTransaction(String app,orderID) async {
    print("Start payment from "+app);
    UpiIndia upi = new UpiIndia(
      app: app,
      receiverUpiId: globals.Main_UPI,
      receiverName: 'harsh borse',
      transactionRefId: orderID.toString(),
      transactionNote: 'Not actual. Just an example.',
      amount: 1.00,
    );

    String response = await upi.startTransaction().then((response) async {
      print("RESPONSE == "+response);
      if(response!=null||response!=""){
        UpiIndiaResponse _upiResponse;


        if(response == UpiIndiaResponseError.APP_NOT_INSTALLED||response == UpiIndiaResponseError.INVALID_PARAMETERS
          || response==UpiIndiaResponseError.USER_CANCELLED || response == UpiIndiaResponseError.NULL_RESPONSE){
        showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: new Text('Failed!'),
              content: Text(response.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
      else{
        _upiResponse =  UpiIndiaResponse(response);



      if(_upiResponse.status.toString() == "failure"){
        showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: new Text('Failed!'),
              content: Text("try different payment option"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
      else if(_upiResponse.status.toString() == "success"){
        showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: new Text('Paied!'),
              content: Text("thanks for shopping"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CheckoutDone()));
                  },
                ),
              ],
            );
          },
        );

      }
        print("response = "+response.toString());
        print("response2 = "+_upiResponse.status.toString());
      }
      }


      return response ;
    });

    return response;
  }





  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context1, child, MainModel)
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
        ),
        body: Center(
          child: Container(
            child: Wrap(
              runSpacing: 10,
              spacing: 100,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CheckoutDone()));
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Center(child: Text("CASH", style: TextStyle(
                            color: Colors.white, fontSize: 30),))),
                  ),
                  color: Colors.red[800],
                  elevation: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),

                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () {
                      print("gpay");
                      _transaction =
                          initiateTransaction(UpiIndiaApps.GooglePay,MainModel.Main_Details.orderID.toString());

//                    setState(() {});
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Center(child: Text("Google Pay",
                          style: TextStyle(
                              color: Colors.white, fontSize: 30),))),
                  ),
                  color: Colors.green[900],
                  elevation: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),

                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () {
                      _transaction = initiateTransaction(UpiIndiaApps.PhonePe,MainModel.Main_Details.orderID.toString());

                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Center(child: Text("PhonePe", style: TextStyle(
                            color: Colors.white, fontSize: 30),))),
                  ),
                  color: Colors.purple[900],
                  elevation: 10,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40)),

                  child: InkWell(
                    splashColor: Colors.yellow,
                    onTap: () {
                      _transaction = initiateTransaction(UpiIndiaApps.PayTM,MainModel.Main_Details.orderID.toString());
                      setState(() {});
                    },
                    borderRadius: BorderRadius.circular(40),
                    child: Container(
                        height: 80,
                        width: double.infinity,
                        child: Center(child: Text("Paytm", style: TextStyle(
                            color: Colors.white, fontSize: 30),))),
                  ),
                  color: Colors.blue[800],
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
