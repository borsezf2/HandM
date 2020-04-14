import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:minor2/MORE_widgets/login/loginScreen.dart';
import 'package:minor2/appBarPages/feedbackScreen.dart';
import 'package:minor2/appBarPages/previousOrder.dart';
import 'package:minor2/appBarPages/profilePage.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';


Widget MyDrawer(context){
  return ScopedModelDescendant<MainModel>(
      builder: (context1, child, MainModel)
      {
        return SafeArea(
          child: Drawer(
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    color: Colors.purple[900],
                    padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .size
                          .height / 40,
                      top: MediaQuery
                          .of(context)
                          .size
                          .height / 25,
                    ),
                    child: SizedBox(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 5,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 10,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width/5,
                            child: CircleAvatar(
                              backgroundImage: MainModel.MainUser.photoUrl!=null?NetworkImage(MainModel.MainUser.photoUrl):null,
//                        child: Text(MainModel.MainUser.displayName[0]),
                              child: MainModel.MainUser.photoUrl!=null?null:Text(MainModel.MainUser.email[0].toUpperCase(),
                                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                              backgroundColor: Colors.black54,
                              radius: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 10,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 22,
                          ),
                          Text(MainModel.MainUser.email,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 25),)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 80,
                  ),
                  MaterialButton(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.person,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Profile", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProfilePage()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 70,
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.shoppingBag,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Previous Orders", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
                      var data = {
                        "email": MainModel.Main_Details.email.toString()
                      };
                      MainModel.previous_orders(data);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PreviousOrderPage()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 70,
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.bookOpen,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Feedback", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => FeedbackScreen()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 70,
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.logOut,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Log Out", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
                      MainModel.signOutGoogle();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginScreen()),
                              (Route<dynamic> route) => false);
                      },
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 70,
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.refresh,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Train ML", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
                      MainModel.train_model();
                      showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(),
                            title: new Text('Data reTrained'),
                            content: Text(
                                'you have retrained your suggestion Machine learning module'),
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
                    },
                  ),

                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 70,
                  ),
                  MaterialButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(EvaIcons.refresh,),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("get main url", style: TextStyle(fontSize: 20),),
                        ),
                      ],
                    ),
                    color: Colors.white,

                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    splashColor: Colors.redAccent,
                    minWidth: double.infinity,
                    onPressed: () {
//                      MainModel.get_main_url();

                    },
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
