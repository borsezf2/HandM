
class ItemDetails {
  String name;
  var price;
  String pic_url;
  double quantity;
  String barcode;
  String weight;

  ItemDetails({this.name, this.price, this.quantity,this.barcode,this.weight});

  Map<String, dynamic> toJson() => {
    "barcode": barcode,
    "name": name,
    "price": price,
    "weight": weight,
    "pic_url":pic_url,
    "quantity": quantity,
  };

  ItemDetails.fromJson(Map<String, dynamic> json) {
    print("JSON = "+json.toString());
    name = json['name'];
    price = json['price'];
    weight = json['weight'];
    pic_url = json['pic_url'];
    quantity = json['quantity'];
    barcode = json['barcode'];
    price = json['price'];
  }
}

class MainDetails {
  var name;
  var phone;
  var address;
  var email;

  var amount;
  var orderID;
  var checkout;

}