import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:minor2/MORE_widgets/homeScreen/HomeScreen.dart';
import 'package:minor2/MORE_widgets/login/emailFields.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:animate_do/animate_do.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScreenBody(),
      key: scaffoldKey,
    );
  }
}
GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

class LoginScreenBody extends StatefulWidget {
  @override
  _LoginScreenBodyState createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {



  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
    builder: (context, child, MainModel) {
    return  SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset("assets/login-bg.jpg",fit: BoxFit.cover,),
            ImageGradient(context),
            SlideInRight(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 100,
              child: Align(
                  alignment: Alignment(0.9, 0.5),

                  child: SizedBox(
                    width:  MediaQuery.of(context).size.width/7,
                    height:  MediaQuery.of(context).size.height/7,
                    child: RaisedButton(
                        color: Colors.white,
                        splashColor: Colors.blue[900],
                        shape: CircleBorder(),
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height/21,
                            top: MediaQuery.of(context).size.height/21,
//                        left: MediaQuery.of(context).size.width/6,
//                        right: MediaQuery.of(context).size.width/6
                        ),
                        child: Image.asset("assets/google-icon.png"),

                      onPressed: () async {
//                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        FirebaseUser user = await MainModel.signInWithGoogle(context);
                        if(user!=null)
                          {
                            print("Signed in as "+user.email.toString());
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                          }
                          else{
                            print("Sign in error google");
                        }
                      }
                    ,),
                  ),
              ),
            ),
            SlideInLeft(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 500,
              child: Align(
                alignment: Alignment(0.35, 0.44),
                child: Text("Sign in with Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),

            SlideInRight(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 100,
              child: Align(
                alignment: Alignment(0.9, 0.75),

                child: SizedBox(
                  width:  MediaQuery.of(context).size.width/7,
                  height:  MediaQuery.of(context).size.height/7,
                  child: RaisedButton(
                    color: Colors.blue[900],
                    splashColor: Colors.blue,
                    shape: CircleBorder(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height/90,
                      top: MediaQuery.of(context).size.height/90,
//                        left: MediaQuery.of(context).size.width/6,
//                        right: MediaQuery.of(context).size.width/6
                    ),
                    child: Icon(EvaIcons.facebook,color: Colors.white,size: 40,),

                    onPressed: ()async{

                      FirebaseUser user = await MainModel.signInWithFacebook(context);
                      if(user!=null)
                      {
                        print("Signed in as "+user.email.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }
                      else{
                        print("Sign in error google");
                      }

                    }
                    ,),
                ),
              ),
            ),
            SlideInLeft(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 500,
              child: Align(
                alignment: Alignment(0.35, 0.66),
                child: Text("Sign in with Facebook",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            SlideInRight(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 100,
              child: Align(
                alignment: Alignment(0.9, 0.99),

                child: SizedBox(
                  width:  MediaQuery.of(context).size.width/7,
                  height:  MediaQuery.of(context).size.height/7,
                  child: RaisedButton(
                    color: Colors.red[900],
                    splashColor: Colors.yellowAccent,
                    shape: CircleBorder(),
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height/90,
                      top: MediaQuery.of(context).size.height/90,
//                        left: MediaQuery.of(context).size.width/6,
//                        right: MediaQuery.of(context).size.width/6
                    ),
                    child: Icon(EvaIcons.email,color: Colors.white,size: 40,),

                    onPressed: (){
                      ShowBottomSheetEmail();
                    }
                    ,),
                ),
              ),
            ),
            SlideInLeft(
              animate: true,
              duration: Duration(milliseconds: 700),
              delay: Duration(milliseconds: 200),
              from: 500,
              child: Align(
                alignment: Alignment(0.35, 0.86),
                child: Text("Sign in with Email",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              ),
            ),
            Align(
              alignment: Alignment(0, -0.9),
              child: SlidingText(context),
            )
          ],
        ),
      ),
    );
    });
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
  ShowBottomSheetEmail(){
    showModalBottomSheet(context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
          )
        ),
        backgroundColor: Colors.transparent,
        builder: (context){
      return Container(
        height: MediaQuery.of(context).size.height/1.4,
        decoration: BoxDecoration(
          color: Colors.deepPurple[900].withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50)
          )
        ),
        child: EmailSignIn(context,scaffoldKey),
          padding: EdgeInsets.all(5),
      );
        });
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

Widget SlidingText(context)
{
  var items = ["Best Products","Lowest price","Fast checkout","No waiting","Self Billig","Easy shopping"];
  return Container(
    height: MediaQuery.of(context).size.height/2,
    color: Colors.transparent,
    child: CarouselSlider(
      height: MediaQuery.of(context).size.height/10,
      scrollDirection: Axis.horizontal,
        pauseAutoPlayOnTouch: Duration(seconds: 2),
        autoPlay: true,
        enableInfiniteScroll: true,
      autoPlayInterval: Duration(seconds: 2),
      autoPlayAnimationDuration: Duration(milliseconds: 800),
      autoPlayCurve: Curves.ease,
      items: items.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: MediaQuery.of(context).size.height/4,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
//                      color: Colors.blue.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Center(child: Text('$i',
                    style: TextStyle(fontSize: 35.0,color: Colors.white,fontWeight: FontWeight.bold,
                        shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]
                  ),))
              );
            },
          );
        }).toList(),
    ),
  );
}