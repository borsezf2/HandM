import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/homeScreen/HomeScreen.dart';
import 'package:minor2/MORE_widgets/login/validator.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  MainModel model;

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of(context);
    super.initState();
    setInitialValue();
  }

  setInitialValue(){
    if(model.MainUser!=null){
      emailController.text = model.MainUser.email.toString();
      passwordController.text = "not required for google/fb";
//      nameController.text = model.MainUser.displayName.toString();
//      phoneController.text = model.MainUser.phoneNumber.toString();
//      addressController.text = "address pre ...edit";
    }else{
      print("Mainuser is null");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("Register"),
        centerTitle: true,
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        )),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/15,
            bottom: MediaQuery.of(context).size.height/10,
            left: 10,
            right: 10
          ),
          height: MediaQuery.of(context).size.height/1.08,
          child: Center(
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              elevation: 10,
              color: Colors.purple[900],
//              color: Colors.transparent,
              child: RegisterFields(context),
            ),
          ),

        ),
      ),
    );
  }





  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  Widget RegisterFields(context){


    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel)
        {
          return Form(
            key: formKey,
//      autovalidate: true,
            child: Container(
//    height: MediaQuery.of(context).size.height/2.5,
//    color: Colors.blue,
              margin: EdgeInsets.only(
                  top: 30, right: 20, left: 20, bottom: 10
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: ValidateEmail,
                    autocorrect: false,
                    controller: emailController,
                    style: TextStyle(color: Colors.white,),
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
                        .height / 30,
                  ),
                  TextFormField(
                    obscureText: true,
                    autocorrect: false,
                    validator: ValidatePassword,
                    controller: passwordController,
                    style: TextStyle(color: Colors.white,),

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
                        .height / 30,
                  ),
                  TextFormField(
                    autocorrect: false,
                    validator: ValidateName,
                    controller: nameController,
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      hintText: "Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2)
                      ),
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.person, color: Colors.white,),

                    ),
                  ),


                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 30,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: phoneController,
                    validator: ValidateContact,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      hintText: "Contact",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2)
                      ),
                      labelText: "Contact",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.phone, color: Colors.white,),

                    ),
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 30,
                  ),
                  TextFormField(
                    autocorrect: false,
                    controller: addressController,
                    style: TextStyle(color: Colors.white,),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      hintText: "Address",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                              color: Colors.lightBlueAccent, width: 2)
                      ),
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white54),
                      prefixIcon: Icon(Icons.home, color: Colors.white,),

                    ),
                  ),


                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 60,
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
                            padding: EdgeInsets.fromLTRB(120, 15, 120, 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Text("Register", style: TextStyle(fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [BoxShadow(color: Colors.black54,
                                    offset: Offset(0.2, 0.5),
                                    blurRadius: 10,
                                    spreadRadius: 10)
                                ]),),
                            onPressed: () async {


                              if (formKey.currentState.validate()){

                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(""
                                    "Wait . registering......."),elevation: 10,));
                                FirebaseUser user = await MainModel.signUpWithEmail(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    add: addressController.text,
                                    phone: phoneController.text,
                                    key: context
                                );
                                if(user!=null)
                                {
                                  print("Signed in as "+user.email.toString());
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                }
                                else{
                                  print("Sign in error google");
                                }
                              }else{
                                Scaffold.of(context).showSnackBar(SnackBar(content: Text(""
                                    "Wrong Entries, please check your inputs"),elevation: 10,));

                              }



                            }),
                      )),

                ],
              ),
            ),
          );
        });
  }











}

