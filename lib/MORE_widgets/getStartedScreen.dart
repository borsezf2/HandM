import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/login/loginScreen.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:animate_do/animate_do.dart';


class GetStartedScreen extends StatefulWidget {
  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {

  MainModel model;

  @override
  void initState() {
    super.initState();
    model = ScopedModel.of(context);
    model.AutoAuthGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
//        color: Colors.blue,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset("assets/cart.jpg",fit: BoxFit.cover,),
            ImageGradient(context),
            Roulette(
              child: Align(
                alignment: Alignment(0, -0.8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width/1.1,
                  child: ClipOval(
                    child: Container(
                      color: Colors.white60,
                        padding: EdgeInsets.all(10),
                        child: Image.asset("assets/logo1.png")
                    ),
                  ),
                ),
              ),
            ),
            Flash(
              child: Align(
                alignment: Alignment(0, 0.9),
                child: RaisedButton(
                  color: Colors.red[800].withOpacity(0.8),
                  elevation: 10,
                  splashColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height/50,
                      top: MediaQuery.of(context).size.height/50,
                      left: MediaQuery.of(context).size.width/4,
                    right: MediaQuery.of(context).size.width/4
                  ),
                  child: Text("Get Started",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20,
                      shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)])),
                    onPressed: (){
//                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }
                    )
              ),
            )
          ],
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
        colors: [Colors.black,Colors.black87,Colors.black38,Colors.black12,Colors.black12],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      )
    ),
  );
}


//Align(
//alignment: Alignment(0, 0),
//child: ,
//)

class home1 extends StatefulWidget {
  @override
  _home1State createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
