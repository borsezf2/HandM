import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Text("H"),
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
                  height: MediaQuery.of(context).size.height/1.5,
                  width: MediaQuery.of(context).size.width/1.1,
                  padding: EdgeInsets.all(5),

                  decoration: BoxDecoration(
                      color: Colors.purple[900],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child:  FeedbackCard(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Widget FeedbackCard(context){
  return Container(
//    height: MediaQuery.of(context).size.height/2.5,
//    color: Colors.blue,
    margin: EdgeInsets.only(
        top: 30,right: 20,left: 20,bottom: 10
    ),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: <Widget>[
        Text("Email : Harshzf2@gmail.com",style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),



        SizedBox(
          height: MediaQuery.of(context).size.height/20,
        ),
        TextFormField(
          autocorrect: false,
          style: TextStyle(color: Colors.white,),
          keyboardType: TextInputType.multiline,
          maxLines: 14,
//          expands: true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)
            ),
            hintText: "Feedback",
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(20)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.lightBlueAccent,width: 2)
            ),
            labelText: "Feedback",
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white54),
            prefixIcon: Icon(Icons.perm_identity,color: Colors.white,),

          ),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height/25,
        ),
        Container(
//              color: Colors.blue,
            height: MediaQuery.of(context).size.height / 11,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: RaisedButton(
                  color: Colors.red[900],
                  elevation: 8,
                  splashColor: Colors.yellowAccent,
                  padding: EdgeInsets.fromLTRB(110, 15, 110, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text("Update",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,
                      shadows: [BoxShadow(color: Colors.black54,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]),),
                  onPressed: () {

                  }),
            )),

      ],
    ),
  );
}