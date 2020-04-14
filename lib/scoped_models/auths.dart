import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:minor2/MORE_widgets/homeScreen/HomeScreen.dart';
import 'package:minor2/MORE_widgets/login/registerFields.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:minor2/globals.dart' as globals;
import 'dart:convert';
mixin Auths on Model {

  FirebaseUser MainUser ;
//  MainDetails Main_Details = new MainDetails();

  //******************************************************************************************************
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  AutoAuthGoogle(context)async{
    final FirebaseUser user = await _auth.currentUser() ;
    FirebaseUser Finaluser = null;

    if(user!=null){
      print("Auto auth yes");
      MainUser = user ;
//      Main_Details.email = MainUser.email ;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      return user;
    }
    else {
      print("Auto auth No");
//      return null;
    }
    notifyListeners();
  }

  Future<FirebaseUser> signInWithGoogle(context) async {

    final FirebaseUser user = await _auth.currentUser() ;
    FirebaseUser Finaluser = null;

    if(user!=null){
      print("Auto auth");
      MainUser = user ;
//      Main_Details.email = MainUser.email ;
      return user;
    }
    else{
      print("static auth");

      try {
        final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final AuthResult authResult = await _auth.signInWithCredential(credential);
        final FirebaseUser user = authResult.user;
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);
        final FirebaseUser currentUser = await _auth.currentUser();
        assert(user.uid == currentUser.uid);
        MainUser = user ;
//        Main_Details.email = MainUser.email ;

        return user;
      } catch (error) {
        showDialog(
          context: context,
          builder: (BuildContext bc) {
            return AlertDialog(
              title: new Text('SignIn Error!'),
              content: Text(
                  'There seems to be some error with Authentication,'),

              actions: <Widget>[
                // usually buttons at the bottom of the dialog
                new FlatButton(
                  child: new Text("Ok"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            );
          },
        );
        print(error);
      }

    }


    return Finaluser;
  }

  void signOutGoogle() async {
    try{
      await googleSignIn.signOut();
    }catch(e){
      print("error in logout google");
    }

//    try{
//      await googleSignIn.signOut();
//    }catch(e){
//      print("error in logout google");
//    }

    try{
      await fbLogin.logOut();
    }catch(e){
      print("error in logout fb");
    }

    await _auth.signOut() ;
    MainUser = null ;
//    Main_Details.email = null;
    print("User Sign Out");
  }

//************************************************************************************************************


  Future<FirebaseUser> firebaseAuthWithFacebook({@required FacebookAccessToken token,context}) async {
    print("fb 2");
    AuthCredential credential =
    FacebookAuthProvider.getCredential(accessToken: token.token);
    print("fb 3");
    FirebaseUser firebaseUser =null;
    try{
       firebaseUser = (await _auth.signInWithCredential(credential)).user;
      print("fb 4 = "+firebaseUser.email);
    }catch(e){
      print("eamil already used "+e.toString());
      showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: new Text('Failed!'),
            content: Text(
                'Looks like this email is already used , try another login method , which was used first time to login.'),
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
      return null;
    }


    return firebaseUser;
  }
  FacebookLogin fbLogin = new FacebookLogin();

  Future<FirebaseUser> signInWithFacebook(context) async {
//    FacebookLoginResult facebookLoginResult =  await fbLogin.loginWithPublishPermissions(['email','public_profile']);
//    try {
    FacebookLoginResult facebookLoginResult =
    await fbLogin.logInWithReadPermissions(['email', 'public_profile']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        return null ;
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        return null;
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        /// calling the auth mehtod and getting the logged user
        print("fb 1");
        var firebaseUser = await firebaseAuthWithFacebook(
            token: facebookLoginResult.accessToken,context: context);
        print("fb end = "+firebaseUser.email.toString());
        MainUser = firebaseUser ;
//        Main_Details.email = MainUser.email ;

        return firebaseUser;
    }
//    } catch (e) {
//      print(" error in logInWithReadPermissions");
//    }
  }

  //*************************************************************************************************************************


  Future<FirebaseUser> signUpWithEmail({String email, String password,key,name,phone,add}) async {
    // marked async
    FirebaseUser user;
    try {
      user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
    } catch (e) {

      print(e.toString());
      showDialog(
        context: key,
        builder: (BuildContext bc) {
          if(MainUser!=null){
            register_user_in_DB(email,name,phone,add);
            return AlertDialog(
              title: new Text('Registered'),
              content: Text(
                  "Scan and shop\nhave fun!!"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
//                    Navigator.pop(key);

                    Navigator.of(key).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen()),
                            (Route<dynamic> route) => false);
                  },
                ),
              ],
            );
          }
          else{
            return AlertDialog(
              title: new Text('ERROR'),
              content: Text(
                  e.code.toString()),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.pop(key);
                  },
                ),
              ],
            );
          }


        },
      );
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
        MainUser = user;
        email = user.email;
//        Main_Details.email = MainUser.email ;

        print("Signed up = " + user.email);
        await register_user_in_DB(user.email,name,phone,add);
        notifyListeners();
        return user;
      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        print("error.....");
        notifyListeners();

        return null;
      }
    }
  }

  register_user_in_DB(email,name,phone,address)async{
    var url = globals.Main_API_URL + "/register_user_in_DB" ;

    var data = {
      "name":name.toString(),
      "email":email.toString(),
      "phone":phone.toString(),
      "address":address.toString()
    };
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = response.body.toString();
    print("Response check is user = "+response_data.toString());
  }


  Future signInWithEmail({String email, String password, GlobalKey<ScaffoldState> key}) async {
    // marked async
    FirebaseUser user;

    try {
      user = (await _auth.signInWithEmailAndPassword(
          email: email, password: password)).user;
    } catch (e) {
      print("E code = " + e.code.toString());
//      print("E mssg = " + e.message.toString());

      print(e.toString());
      showDialog(
        context: key.currentContext,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: new Text('ERROR'),
            content: Text(
                e.code.toString()),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.pop(key.currentContext);
                },
              ),
            ],
          );
        },
      );
      return e.code.toString();
    } finally {
      if (user != null) {
        // sign in successful!
        // ex: bring the user to the home page
        print("Signed up = "+user.email.toString());
//        String type = authorizeAdmin();
          MainUser = user ;
//        Main_Details.email = MainUser.email ;

        notifyListeners();

          return user;

      } else {
        // sign in unsuccessful
        // ex: prompt the user to try again
        print("error");
        notifyListeners();
      return null;
      }
    }
  }

  //*********************************************************************************************************
  //login register checks




  update_user_info({email,name,phone,add})async{
    var url = globals.Main_API_URL + "/update_user_info" ;

    var data = {
      "name":name.toString(),
      "email":email.toString(),
      "phone":phone.toString(),
      "address":add.toString()
    };
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = response.body.toString();
    print("Response update user info = "+response_data.toString());
  }




}

