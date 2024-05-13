class Item {
  static const String collectionName = 'itemCollection';

  String? id;
  String? productName;
  DateTime? expiryDate;
  double? quantity;
  double? wholesalePrice;
  double? customerPrice;
  String? weightUnit;

  Item({this.expiryDate,this.quantity,this.wholesalePrice,this.customerPrice,this.productName,this.weightUnit,this.id});

  Item.fromFireStore(Map<String,dynamic>?data){
    id = data?['id'];
    productName = data?['productName'];
    expiryDate = DateTime.fromMillisecondsSinceEpoch(data?['expiryDate']);
    quantity = data?['quantity'];
    wholesalePrice = data?['wholesalePrice'];
    customerPrice = data?['customerPrice'];
    weightUnit = data?['weightUnit'];
  }
  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'productName' : productName,
      'expiryDate' : expiryDate!.millisecondsSinceEpoch,
      'quantity' : quantity,
      'wholesalePrice' : wholesalePrice,
      'customerPrice' : customerPrice,
      'weightUnit': weightUnit
    };
  }
}