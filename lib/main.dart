import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/getStartedScreen.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:minor2/globals.dart' as globals;

main(){
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  get_main_url()async{
    List a = await Firestore.instance.collection("API").getDocuments().then((val) => val.documents);
    print("MAIN URL = "+a[0]["main_url"].toString());
    print("MAIN UPI= "+a[0]["upi"].toString());

//    var b = a[0];
    globals.Main_API_URL = a[0]["main_url"].toString() ;
    globals.Main_UPI = a[0]["upi"].toString() ;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_main_url() ;
  }


  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: MainModel(),
      child: MaterialApp(
        title: "Minor 2",
        home: GetStartedScreen(),
      ),
    );
  }
}
