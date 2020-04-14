import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/scanScreens/offers.dart';
import 'package:minor2/MORE_widgets/scanScreens/scannedItem.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {



  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  Future ScanBarcode()async{
    String cameraScanResult = await scanner.scan();
    print("scanner result = "+cameraScanResult.toString());
    return cameraScanResult;
}


  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
builder: (context1, child, MainModel)
    {
      return Scaffold(
        body: SafeArea(
          child: Container(
//        color: Colors.blue,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset("assets/home-bg.jpg", fit: BoxFit.cover,),
                ImageGradient(context),
                Align(
                  alignment: Alignment(0, -0.9),
                  child: Text("Scanned Item", style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      shadows: [BoxShadow(color: Colors.black,
                          offset: Offset(0.2, 0.5),
                          blurRadius: 10,
                          spreadRadius: 10)
                      ]
                  ),),
                ),
                Align(
                  alignment: Alignment(0, -0.4),
                  child: ScannedItem(),
                ),
                Align(
                  alignment: Alignment(-0.8, 0.42),
                  child: Text(MainModel.CurrentItem==null?"":
                  "People also bougth",style: TextStyle(color: Colors.white),),
                ),
                Align(
                  alignment: Alignment(0, 0.7),
                  child: MainModel.suggestionsList.length==0?null:OffersWidget(),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: StartScanButton(context),
                ),
                Align(
                  alignment: Alignment(-0.99, -0.91),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white,),
                    color: Colors.white54,
                    splashColor: Colors.yellowAccent,
                    onPressed: () {
                      print("back");
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment(0.9, -0.91),
                  child: CircleAvatar(
                    child: IconButton(
                        icon: Icon(EvaIcons.shoppingCart, color: Colors.white,
                          size: 25,),
                        onPressed: () {
                          MainModel.OpenCart(context);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }



  Widget StartScanButton(context){
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel)
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
                child: Text("Scan", style: TextStyle(color: Colors.white,
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
                  ScanBarcode().then((code){
                    MainModel.Search_Item(code,context);

                  });

                }),
          ),

        ),
      );
    });
  }


}


Widget ImageGradient(context){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black54,Colors.black87,Colors.black87,Colors.black87,Colors.black87,Colors.black87,Colors.black54],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )
    ),
  );
}


