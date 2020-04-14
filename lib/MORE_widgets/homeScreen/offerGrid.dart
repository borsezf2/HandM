import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/cart/openItem.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';

class OfferGrid extends StatefulWidget {
  @override
  _OfferGridState createState() => _OfferGridState();
}

class _OfferGridState extends State<OfferGrid> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context1, child, MainModel)
    {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 1.1,
        width: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.only(top: 8),
//      color: Colors.blue,
        child: MainModel.OffersList.length==0?
            Center(child: CircularProgressIndicator())
            :GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 2 / 2.25),
          padding: EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 80),
          itemCount: MainModel.OffersList.length,

          itemBuilder: (context, index) {
            ItemDetails data = MainModel.OffersList[index];
            return OfferTile(context, data,MainModel);
          },
        ),
      );
    });
  }




  Widget OfferTile(context,ItemDetails data,MainModel){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        borderOnForeground: true,
        borderRadius: BorderRadius.circular(12),
        shadowColor: Colors.white30,
        elevation: 8,
        child: InkWell(
          onTap: (){
            setState(() {
              MainModel.CurrentItem = data ;
              MainModel.CurrentItem.quantity = 1.0 ;
              MainModel.CurrentItem.weight = data.weight ;

            });

            showGeneralDialog(
                barrierColor: Colors.black54,
                transitionBuilder: (context, a1, a2, widget) {
                  return Transform.scale(
                    scale: a1.value,
                    child: Opacity(
                      opacity: a1.value,
                      child: OpenItem(),
                    ),
                  );
                },
                transitionDuration: Duration(milliseconds: 300),
                barrierDismissible: true,
                barrierLabel: '',
                context: context,
                pageBuilder: (context, animation1, animation2) {}
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1,color: Colors.white),
                borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.transparent,
//          border: Border.all(color: Colors.white,width: 1)
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[

                    Container(child: Image.network(data.pic_url,fit: BoxFit.cover,)),
                    OfferGradient(context),
                    Align(
                      alignment: Alignment(-0.8, 0.65),
                      child: Text(data.name.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/50,
                          shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]),),
                    ),
                    Align(
                      alignment: Alignment(0.8, 0.65),
                      child: Text(data.price.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height/50,
                          shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]),),
                    ),
                    Align(
                      alignment: Alignment(0.8, 0.9),
                      child: Text(data.price.toString(),style: TextStyle(color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.height/70,
                          shadows: [BoxShadow(color: Colors.black,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]),),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }




}


Widget OfferGradient(context){
  return Container(
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black,Colors.black38,Colors.black12,Colors.black12],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        )
    ),
  );
}
