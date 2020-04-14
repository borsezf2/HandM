import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/homeScreen/HomeScreen.dart';
import 'package:minor2/MORE_widgets/login/registerFields.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

Widget EmailSignIn(context,key){
  return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel)
  {

    TextEditingController emailController = new TextEditingController();
    TextEditingController passwordController = new TextEditingController();

    return Container(
//    height: MediaQuery.of(context).size.height/2.5,
//    color: Colors.blue,
      margin: EdgeInsets.only(
          top: 20, right: 20, left: 20, bottom: 10
      ),
      child: Column(
        children: <Widget>[
          TextFormField(
            autocorrect: false,
            style: TextStyle(color: Colors.white,),
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: "Email",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.lightBlueAccent, width: 2)
              ),
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white54),
              prefixIcon: Icon(Icons.alternate_email, color: Colors.white,),

            ),
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 20,
          ),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            style: TextStyle(color: Colors.white,),
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white)
              ),
              hintText: "Password",
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(20)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                      color: Colors.lightBlueAccent, width: 2)
              ),
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.white),
              hintStyle: TextStyle(color: Colors.white54),
              prefixIcon: Icon(Icons.security, color: Colors.white,),

            ),
          ),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 20,
          ),
          Container(
//              color: Colors.blue,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 11,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(
                child: RaisedButton(
                    color: Colors.red[900],
                    elevation: 8,
                    splashColor: Colors.yellowAccent,
                    padding: EdgeInsets.fromLTRB(130, 15, 130, 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text("Sign in", style: TextStyle(fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [BoxShadow(color: Colors.black54,
                            offset: Offset(0.2, 0.5),
                            blurRadius: 10,
                            spreadRadius: 10)
                        ]),),
                    onPressed: () async {
                      FirebaseUser user = await MainModel.signInWithEmail(
                        email: emailController.text,
                        password: passwordController.text,
                        key: key
                      );
                      if(user!=null)
                      {
                        print("Signed in as "+user.email.toString());
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      }
                      else{
                        print("Sign in error google");
                      }
                    }),
              )),
          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 50,
          ),
          InkWell(
            child: Text("Register",
              style: TextStyle(color: Colors.white70, fontSize: 17,),),
            onTap: () {
//            ShowBottomSheetRegister(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
          )
        ],
      ),
    );
  });
}


