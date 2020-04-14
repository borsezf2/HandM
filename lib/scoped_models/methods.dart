import 'package:flutter/material.dart';
import 'package:minor2/MORE_widgets/cart/cartWidgets.dart';
import 'package:minor2/MORE_widgets/login/registerFields.dart';
import 'package:minor2/scoped_models/extraClasses.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:minor2/globals.dart' as globals;
import 'package:http/http.dart' as http;
import 'package:minor2/scoped_models/extraClasses.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


mixin Methods on Model {

  MainDetails Main_Details = new MainDetails();
  List<ItemDetails> Cart = [];
  List<ItemDetails> OffersList = [];
  List<ItemDetails> suggestionsList = [];
  ItemDetails CurrentItem = null;
  ItemDetails CurrentItemSuggestion = new ItemDetails();
  var checkout_active = 0 ;
  var previous_orders_list = [] ;

  void checkout_change(val)
  {
    checkout_active = val;
    notifyListeners();
  }


  OpenCart(context){

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
              height: MediaQuery.of(context).size.height/1.135,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)
                  )
              ),
              child: CartWidget(),
              padding: EdgeInsets.only(
                  top: 0,
                  right: 0,
                  left: 0
              ),
            );
          });
      notifyListeners();
      cal_total() ;
    }

  Check_is_user(email,context)async{
    var url = globals.Main_API_URL + "/is_user_in_DB" ;
    var data = {
      "email":email.toString()
    };
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());

    print("Response check is user = "+response_data.toString());
    if(response_data['message']=="false"){
      notifyListeners();
      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterPage()));
    }
    else{
      var temp = response_data['user'];
      Set_MainDetails(temp);
      notifyListeners();
      return true;
    }
    notifyListeners();
  }


  Set_MainDetails(data_in){
    print("data before = "+data_in.toString());

    var data = jsonDecode(data_in);
    print("data after = "+data.toString());
    Main_Details.name = data['name'];
    Main_Details.email = data['email'];
    Main_Details.address = data['address'];
    Main_Details.phone = data['phone'];
    Main_Details.amount = data['amount'];
    Main_Details.checkout = data['checkout'];
    Main_Details.orderID = data['orderID'];

    print("end set main details");
    notifyListeners();
  }


  Start_Order(email) async {
    if(Main_Details.orderID==null){
      var url = globals.Main_API_URL + "/start_order" ;
      var data = {
        "email":email.toString()
      };
      http.Response response = await http.post(url,body: jsonEncode(data));
      var response_data = jsonDecode(response.body.toString());
      print("Response Start = "+response_data.toString());

      Main_Details.amount = response_data['amount'];
      Main_Details.orderID = response_data['orderID'];
      Main_Details.checkout = response_data['checkout'];


      Start_Cart(response_data['items']);
    }
    else{
      print("cart already loaded");
    }

    notifyListeners();
  }

  Start_Cart(items){
    print("Cart items = "+items.toString());

    Cart = List<ItemDetails>.from(
        items.map((p) => ItemDetails.fromJson(p)));
    print("Cart = "+Cart.length.toString());
    notifyListeners();
  }



  Search_Item(barcode,context)async{
    var url = globals.Main_API_URL + "/search_item" ;
    var data = {
      "barcode":barcode.toString()
    };
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());
    print("Response search item = "+response_data.toString());
    

    if(response_data["message"].toString()=="Item Not in DB"){
      showDialog(
        context: context,
        builder: (BuildContext bc) {
          return AlertDialog(
            title: new Text('Not Found'),
            content: Text(
                'this item is not present in the stores inventory, please contact some authority'),
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
    }
    else{
      CurrentItem = new ItemDetails();

      var item = jsonDecode(response_data["message"]);
      if(response_data["suggestions"]=="no"){
        suggestionsList = [] ;

      }else{
        var suggestions = jsonDecode(response_data["suggestions"]);
        print("Response Suggestions = "+suggestions.toString());
        List<ItemDetails> tempList = List<ItemDetails>.from(suggestions.map((data)=>ItemDetails.fromJson(data)).toList());
        suggestionsList = tempList ;

      }
      print("Response search item = "+item.toString());
      CurrentItem.name = item['name'];
      CurrentItem.barcode = item['barcode'];
      CurrentItem.weight = item['weight'];
      CurrentItem.price = item['price'];
      CurrentItem.quantity = 1;
      CurrentItem.pic_url = item['pic_url'];
    }

    notifyListeners();
  }

  increase_item(){
    if(CurrentItem.quantity<99){
      CurrentItem.quantity += 1;

    }
    notifyListeners();
  }

  decrease_item(){
    if(CurrentItem.quantity>1){
      CurrentItem.quantity -= 1;
    }
    notifyListeners();
  }

  Add_item_to_cart(ItemDetails item,email,orderID) async {
    var temp = Cart.indexWhere((p) => p.barcode == item.barcode);
    if (temp != -1) {
      print("already present");
      Cart[temp].quantity += item.quantity;
    } else {
      print("not present");
      Cart.add(item);
    }
    var len = Cart.length - 1 ;
    print("cart length = "+Cart.length.toString());
    print("cart [0] = "+Cart[len].name.toString());
    print("cart [0] = "+Cart[len].quantity.toString());
    var url = globals.Main_API_URL + "/add_item_to_cart" ;

    var cartjson = Cart.map((e) => e.toJson()).toList();

    print("cart json = "+cartjson.toString());


    var data = {
      "email": email.toString(),
      "orderID": orderID.toString(),
      "items": cartjson
//      "items": jsonEncode(Cart.map((e) => e.toJson()).toList())
    };
    print("data sent to server= "+data.toString());
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());
    print("Response add to cart item = "+response_data.toString());

//    CurrentItem = null ;
    notifyListeners();
  }

  Get_offers()async{
    CurrentItem = new ItemDetails();
    var url = globals.Main_API_URL + "/getOffer" ;

    http.Response response = await http.get(url);
    var response_data = jsonDecode(response.body.toString());
    print("Response search item = "+response_data.toString());

    var items = jsonDecode(response_data["message"]);
    print("Response offers main page = "+items.toString());

    List<ItemDetails> tempList = List<ItemDetails>.from(items.map((data)=>ItemDetails.fromJson(data)).toList());
    print("Response offers list = "+tempList.length.toString());
    OffersList = tempList ;
    notifyListeners();
  }

  remove_item_from_cart({String barcode_in, double qty, email,orderID}) async {
    Cart.removeWhere((p) => p.barcode == barcode_in && p.quantity == qty);
    var url = globals.Main_API_URL + "/add_item_to_cart" ;

    var cartjson = Cart.map((e) => e.toJson()).toList();

    print("cart json = "+cartjson.toString());


    var data = {
      "email": email.toString(),
      "orderID": orderID.toString(),
      "items": cartjson
//      "items": jsonEncode(Cart.map((e) => e.toJson()).toList())
    };
    print("data sent to server = "+data.toString());
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());
    print("Response remove item = "+response_data.toString());
    notifyListeners();

  }

  cal_total(){

    double sum = 0;

    for(int i = 0;i<Cart.length;i++){
      sum += Cart[i].quantity * double.parse(Cart[i].price) ;
    }
    print("sum = "+sum.toString());
    Main_Details.amount = sum ;
    notifyListeners();

    return sum ;
  }

  checkout_true({paid,email,orderID,sum})async{
    var url = globals.Main_API_URL + "/checkout_true" ;
    var data = {
      "paid":paid.toString(),
      "email":email.toString(),
      "orderID":orderID.toString(),
      "amount":sum.toString()
    };
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());
    print("Response search item = "+response_data.toString());
    notifyListeners();

  }

  train_model()async{
    var url = globals.Main_API_URL + "/train_data" ;
    var data = {};
    http.Response response = await http.post(url,body: jsonEncode(data));
    var response_data = jsonDecode(response.body.toString());
    print("Response search item = "+response_data.toString());
    notifyListeners();

  }


  send_invoice(data)async{
    String url = globals.Main_API_URL+"/send_invoice" ;
    var jsone = jsonEncode(data);
    print("SENT IS = "+jsone.toString());
    try{
    http.Response response = await http.post(url ,body: jsonEncode(data));
    print("Invoice response status code= "+response.statusCode.toString());
    print("Invoice response = "+response.body.toString());
    }catch(e){
    print("error in send invoice");
    }
    notifyListeners();

    print("invoice sent");
  }


  previous_orders(data)async{
    String url = globals.Main_API_URL+"/previous_order" ;
    var json = jsonEncode(data);
    print("SENT IS = "+json.toString());
//    try{
    http.Response response = await http.post(url ,body: jsonEncode(data));
    print("previous response status code= "+response.statusCode.toString());
    print("previous response = "+response.body.toString());
    var orders_data = jsonDecode(response.body);
    orders_data = jsonDecode(orders_data[0]["message"]) ;
    print("previous response JSON = "+orders_data[0].toString());
    previous_orders_list = orders_data ;
    notifyListeners();
//    print("previous response JSON = "+orders_data[0]["amount"].toString());

//    }catch(e){
//    print("error in previous order");
//    }

  }


  get_main_url()async{
    List a = await Firestore.instance.collection("API").getDocuments().then((val) => val.documents);
    print("a[0] = "+a[0]["main_url"].toString());
//    var b = a[0];
    globals.Main_API_URL = a[0]["main_url"].toString() ;
    notifyListeners();
  }

}
