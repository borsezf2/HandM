import 'package:flutter/material.dart';
import 'package:minor2/scoped_models/MainModel.dart';
import 'package:scoped_model/scoped_model.dart';

class OpenItem extends StatefulWidget {
  @override
  _OpenItemState createState() => _OpenItemState();
}

class _OpenItemState extends State<OpenItem> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ScopedModelDescendant<MainModel>(
          builder: (context1, child, MainModel)
          {
            return
//              MainModel.CurrentItem==null?
//            Text("Scan item to get started", style: TextStyle(color: Colors.white),)
//                :

            Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 10,
              shadowColor: Colors.red[900],
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 1.1,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Align(
                      alignment: Alignment(-0.86, -0.9),
                      child: Text(MainModel.CurrentItem.name.toString(),
//                      child: Text('eg',
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                    ),
                    Align(
                      alignment: Alignment(-0.9, -0.3),
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(10),
                        child: SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 4.5,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width / 3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              MainModel.CurrentItem.pic_url.toString(),
//                              "https://natashaskitchen.com/wp-content/uploads/2019/04/Best-Burger-4.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment(1.8, -0.25),
                        child: DetailsOfItem(context,MainModel)
                    ),
                    Align(
                        alignment: Alignment(-0.9, 0.6),
                        child: ItemCount(context,MainModel)
                    ),
                    Align(
                        alignment: Alignment(0, 1.05),
                        child: AddToCartButton(context,MainModel)
                    ),
                    Align(
                        alignment: Alignment(1.9, 0.73),
                        child: TotalPrice(context,MainModel)
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}



Widget DetailsOfItem(context,MainModel MainModel){
  return Container(
    padding: EdgeInsets.all(2),
//    color: Colors.blue,
    height: MediaQuery.of(context).size.height/4,
    width: MediaQuery.of(context).size.width/2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Price  : ${MainModel.CurrentItem.price.toString()}₹",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), ),
        Text("\nMRP           : ${MainModel.CurrentItem.price.toString()}₹",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.grey), ),
        Text("\nWeight\n${MainModel.CurrentItem.weight.toString()} gm",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54), ),
        Text("\nBarcode\n${MainModel.CurrentItem.barcode.toString()}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black54), ),
      ],
    ),
  );
}


Widget ItemCount(context,MainModel MainModel){
  return Container(
//              color: Colors.blue,
      alignment: Alignment.centerRight,
      height: MediaQuery.of(context).size.height / 14,
      width: MediaQuery.of(context).size.width / 3,
//                padding: EdgeInsets.all(2),
      decoration: ShapeDecoration(
//                    color: Colors.black12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
//                      side: BorderSide(color: Colors.black12,style: BorderStyle.solid,width: 2)
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Material(
            elevation: 5,
            shape: CircleBorder(),
            child: Container(
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 10,
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      MainModel.decrease_item();
                      print("remove tapped");
                    }),
              ),
              decoration: ShapeDecoration(
                  shape: CircleBorder(), color: Colors.blue[800]),
            ),
          ),
          Text(MainModel.CurrentItem.quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          Material(
            elevation: 5,
            shape: CircleBorder(),
            child: Container(
              height: MediaQuery.of(context).size.height / 18,
              width: MediaQuery.of(context).size.width / 10,
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      MainModel.increase_item();
                      print("add tapped");
                    }),
              ),
              decoration: ShapeDecoration(
                  shape: CircleBorder(), color: Colors.green[800]),
            ),
          ),
        ],
      ));
}

Widget AddToCartButton(context,MainModel MainModel){
  return Container(
//              color: Colors.blue,
      height: MediaQuery.of(context).size.height / 11,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: RaisedButton(
            color: Colors.red[900],
            elevation: 8,
            splashColor: Colors.redAccent,
            padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Text("Add to Cart",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white,
                shadows: [BoxShadow(color: Colors.black54,offset: Offset(0.2, 0.5),blurRadius: 10,spreadRadius: 10)]),),
            onPressed: () {
              print(MainModel.Main_Details.orderID.toString());
              MainModel.Add_item_to_cart(MainModel.CurrentItem,MainModel.Main_Details.email,MainModel.Main_Details.orderID);
              Navigator.pop(context);
            }),
      ));
}

Widget TotalPrice(context,MainModel MainModel){

  total(){
    double price = double.parse(MainModel.CurrentItem.price.toString());
    double quantity = double.parse(MainModel.CurrentItem.quantity.toString());
    double value = price * quantity ;
    return value ;
  }


  return Container(
    height: MediaQuery.of(context).size.height / 13,
    width: MediaQuery.of(context).size.width/2,
//    color: Colors.blue,
    child: Text("Total : ${total().toString()} ₹",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
  );
}