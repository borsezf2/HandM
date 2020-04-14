import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:minor2/MORE_widgets/cart/cartWidgets.dart';
import 'package:minor2/MORE_widgets/homeScreen/drawer.dart';
import 'package:minor2/MORE_widgets/homeScreen/offerGrid.dart';
import 'package:minor2/MORE_widgets/scanScreens/scanButton.dart';
import 'package:minor2/MORE_widgets/scanScreens/scanScreen.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:minor2/globals.dart' as globals;
import 'package:animate_do/animate_do.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  MainModel model;

  @override
  void initState() {
    get_main_url().then((_){
      print("New url is fetched");
      constructor();
    });
    super.initState();
    model = ScopedModel.of(context);
//    print("Main user is = "+model.MainUser.email.toString());
//    model.Check_is_user(model.MainUser.email.toString(), context);
//    model.Start_Order(model.MainUser.email.toString());
//    model.Get_offers();
  }

  void constructor(){
    print("Main user is = "+model.MainUser.email.toString());
    model.Check_is_user(model.MainUser.email.toString(), context);
    model.Start_Order(model.MainUser.email.toString());
    model.Get_offers();
  }

  get_main_url()async{
    List a = await Firestore.instance.collection("API").getDocuments().then((val) => val.documents);
    print("MAIN URL = "+a[0]["main_url"].toString());
    print("MAIN UPI= "+a[0]["upi"].toString());

//    var b = a[0];
    globals.Main_API_URL = a[0]["main_url"].toString() ;
    globals.Main_UPI = a[0]["upi"].toString() ;
  }



  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Widget build(BuildContext context) {

//    if (model.MainUser.email ==null || model.MainUser.email.toString()=="" || model.MainUser.email.toString()=="null"){
//      constructor();
//      print("MainUser.email = null");
//    }
//    else if (model.Main_Details.email ==null || model.Main_Details.email.toString()=="" || model.Main_Details.email.toString()=="null"){
//      constructor();
//      print("MainDetails.email = null");
//
//    }
//    else if (model.Main_Details.orderID==null){
//      constructor();
//      print("orderID = null");
//
//    }


    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(context),
      backgroundColor: Colors.transparent,
      drawerScrimColor: Colors.transparent,
      body: SafeArea(
        child: Container(
//        color: Colors.blue,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image.asset("assets/home-bg.jpg",fit: BoxFit.cover,),
              ImageGradient(context),
              Align(
                alignment: Alignment(0, 0.6),
                child: OfferGrid(),
              ),
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                delay: Duration(milliseconds: 1500),
                animate: true,
                child: Align(
                  alignment: Alignment(0, -0.95),
                  child: MyAppBar(context,scaffoldKey),
                ),
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                delay: Duration(milliseconds: 1500),
                animate: true,
                child: Align(
                  alignment: Alignment(0, 1),
                  child: StartScanButton(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

Widget MyAppBar(context,scaffoldKey){

  return ScopedModelDescendant<MainModel>(
builder: (context1, child, MainModel)
  {
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.white54,
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),

//        border: Border.all(width: 0.5,color: Colors.black),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height / 18,
            width: MediaQuery
                .of(context)
                .size
                .width / 1.1,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.red[900],
                      Colors.red[800],
                      Colors.red[600],
                      Colors.red[800]
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                )
//              color: Colors.red,
//              image: DecorationImage(image: AssetImage("assets/appbar-bg.jpg"),fit: BoxFit.cover)
            ),
            child: Container(
              decoration: BoxDecoration(
//              color: Colors.black.withOpacity(0.7)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      icon: Icon(EvaIcons.menu, size: 35, color: Colors.white,),
                      onPressed: () {
                        scaffoldKey.currentState.openDrawer();
                      }),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 6,
                  ),
                  Text(MainModel.Main_Details.name.toString(), style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white,
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .height / 40,
                      shadows: [BoxShadow(color: Colors.black,
                          offset: Offset(0.2, 0.5),
                          blurRadius: 10,
                          spreadRadius: 10)
                      ]),),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 7.5,
                  ),
                  CircleAvatar(
                    child: IconButton(
                        icon: Icon(EvaIcons.shoppingCart, color: Colors.white,
                          size: 25,),
                        onPressed: () {
                          MainModel.OpenCart(context);
                        }),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  });
}

