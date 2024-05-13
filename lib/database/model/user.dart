class MyUser {
  static const String collectionName = 'user';

  String? id;
  String? name;
  String? email;

  MyUser({this.id,this.email,this.name});
  MyUser.fromFireStore(Map<String,dynamic>?data){
    id = data?['id'];
    name = data?['name'];
    email = data?['email'];
  }
  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'name' : name,
      'email' : email
    };
}
}