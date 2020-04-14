import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/scanScreens/scanScreen.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';


Widget StartScanButton(context){
  return ScopedModelDescendant<MainModel>(
      builder: (context1, child, MainModel)
  {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height / 10,
      decoration: BoxDecoration(
          color: Colors.red[900].withOpacity(0.8),
          borderRadius: BorderRadius.only(
              topRight: Radius.elliptical(80, 60),
              topLeft: Radius.elliptical(80, 60)
          )
      ),

      child: Center(
        child: SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height / 13,
          width: MediaQuery
              .of(context)
              .size
              .width / 1.2,
          child: RaisedButton(
              child: Text("Start Scanning", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),),
              color: Colors.black,
              elevation: 10,
              splashColor: Colors.yellowAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.elliptical(80, 60),
                      topLeft: Radius.elliptical(80, 60),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)
                  )
              ),
              onPressed: () {
                MainModel.Start_Order(MainModel.Main_Details.email);
                MainModel.CurrentItem = null;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanScreen()));
              }),
        ),

      ),
    );
  });
}