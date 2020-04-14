import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/scanScreens/openItemsuggestion.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';

class OffersWidget extends StatefulWidget {
  @override
  _OffersWidgetState createState() => _OffersWidgetState();
}

class _OffersWidgetState extends State<OffersWidget> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (context1, child, MainModel)
    {
      return Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
          ),
          height: MediaQuery
              .of(context)
              .size
              .height / 7,
          width: MediaQuery
              .of(context)
              .size
              .width / 1.1,
          child: ListView.builder(
            itemCount: MainModel.suggestionsList.length,
            scrollDirection: Axis.horizontal,

            padding: EdgeInsets.all(2),
            itemBuilder: (context, index) {
              ItemDetails data = MainModel.suggestionsList[index];

              return OfferTile(context,data,MainModel);
            },
          ),
        ),
      );
    });
  }
}

Widget OfferTile(context,ItemDetails data,MainModel){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.transparent,
      elevation: 10,
      child: InkWell(
        onTap: (){
          MainModel.CurrentItemSuggestion = data ;
          MainModel.CurrentItemSuggestion.quantity = 1.0 ;
          showGeneralDialog(
              barrierColor: Colors.black54,
              transitionBuilder: (context, a1, a2, widget) {
                return Transform.scale(
                  scale: a1.value,
                  child: Opacity(
                    opacity: a1.value,
                    child: OpenItemSuggestion(),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 300),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {});
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20)
          ),
          height: MediaQuery.of(context).size.height / 9,
          width: MediaQuery.of(context).size.width / 2.53,
          child: Row(
            children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(15),
                   child: Container(
                     width: MediaQuery.of(context).size.width /6,
                     height: MediaQuery.of(context).size.height / 8,
                      color: Colors.blue,
                     child: Image.network(data.pic_url.toString(),fit: BoxFit.cover,),
                   ),
                 ),
               ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width /5.8,
                      padding: EdgeInsets.only(top: 10),
//                    color: Colors.blue,
                      child: Text(data.name.toString(),style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Text("${data.price.toString()} ₹",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}