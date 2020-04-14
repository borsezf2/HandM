import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/login/validator.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {



  MainModel model;

  @override
  void initState() {
    // TODO: implement initState
    model = ScopedModel.of(context);
    super.initState();
    setInitialValue();
  }

  setInitialValue(){

    email = model.MainUser.email.toString();
    nameController.text = model.MainUser.displayName.toString();
    phoneController.text = model.Main_Details.phone.toString();
    addressController.text =  model.Main_Details.address.toString();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[900],
          elevation: 10,
          title: Text("Profile Details"),
          centerTitle: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)
            )),
        ),
        body: SingleChildScrollView(
          child: Container(
//            alignment: Alignment(0, 0),
            padding: EdgeInsets.only(
              top: 20
            ),
            height: MediaQuery.of(context).size.height/1.1125,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height/7,
                  width: MediaQuery.of(context).size.width,
                  child: Material(
                    shape: CircleBorder(),
                    elevation: 10,
                    child: CircleAvatar(
                      child: Text(model.MainUser.email[0].toUpperCase(),
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                      backgroundColor: Colors.red[800],
                      radius: MediaQuery.of(context).size.height/10,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Material(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  color: Colors.transparent,
                  child: Container(
                    height: MediaQuery.of(context).size.height/1.8,
                    width: MediaQuery.of(context).size.width/1.1,
                    padding: EdgeInsets.all(5),

                    decoration: BoxDecoration(
                    color: Colors.purple[900],
                    borderRadius: BorderRadius.circular(20)
                    ),
                    child:  DetailsCard(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }









  TextEditingController emailController = new TextEditingController();
  var email = "";
  TextEditingController passwordController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


  Widget DetailsCard(context){
    return ScopedModelDescendant<MainModel>(
        builder: (context, child, MainModel)
        {
          return Container(
//    height: MediaQuery.of(context).size.height/2.5,
//    color: Colors.blue,
            margin: EdgeInsets.only(
                top: 30, right: 20, left: 20, bottom: 10
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: <Widget>[
                Text("Email : " + email.toString(), style: TextStyle(
                    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),),


                SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 20,
                ),
                TextFormField(
                  autocorrect: false,
                  style: TextStyle(color: Colors.white,),
                  validator: ValidateName,
                  controller: nameController,
//                  initialValue: nameController.text.toString(),
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
                    prefixIcon: Icon(Icons.perm_identity, color: Colors.white,),

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
                  validator: ValidateContact,
                  keyboardType: TextInputType.number,
//                  initialValue: phoneController.text.toString(),
                  controller: phoneController,
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
                  style: TextStyle(color: Colors.white,),
//                  initialValue: addressController.text.toString(),
                  controller: addressController,
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
                      .height / 25,
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
                          padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text("Update", style: TextStyle(fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [BoxShadow(color: Colors.black54,
                                  offset: Offset(0.2, 0.5),
                                  blurRadius: 10,
                                  spreadRadius: 10)
                              ]),),
                          onPressed: () {

                            Scaffold.of(context).showSnackBar(SnackBar(content: Text(""
                                "Wait . Updating......."),elevation: 10,));
                            MainModel.update_user_info(
                              email: email.toString(),
                              name: nameController.text,
                              add: addressController.text,
                              phone: phoneController.text,
                            );
                          }),
                    )),

              ],
            ),
          );
        });
  }
}




