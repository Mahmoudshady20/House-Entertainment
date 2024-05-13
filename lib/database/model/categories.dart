class Categories {
  static const String collectionName = 'category';
  String? name;
  String? id;

  Categories({this.name,this.id});
  Categories.fromFireStore(Map<String,dynamic>? data):this(
    name: data?['name'],
    id: data?['id'],
  );
  Map<String,dynamic> toFireStore(){
    return {
      'name':name,
      'id':id,
    };
  }
}