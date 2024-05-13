import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:houseenterainment/database/model/categories.dart';
import 'package:houseenterainment/database/model/item.dart';
import 'package:houseenterainment/database/model/user.dart';

class MyDataBase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addUser(MyUser myUser) {
    return getUserCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUser(String uid) async {
    var snapShots = await getUserCollection().doc(uid).get();
    return snapShots.data();
  }

  static CollectionReference<Categories> getCategoryCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Categories.collectionName)
        .withConverter<Categories>(
          fromFirestore: (snapshot, options) =>
              Categories.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addCategory(String uid, Categories categories) {
    DocumentReference<Categories> collection = getCategoryCollection(uid).doc();
    categories.id = collection.id;
    return collection.set(categories);
  }

  static Stream<QuerySnapshot<Categories>> getCategories(String uid) {
    CollectionReference<Categories> collection = getCategoryCollection(uid);
    return collection.snapshots();
  }

  static Future<void> deleteCategory(String uid, Categories categories) {
    CollectionReference<Categories> collection = getCategoryCollection(uid);
    return collection.doc(categories.id).delete();
  }

  static Future<void> editCategory(String uid, Categories categories) {
    CollectionReference<Categories> collection = getCategoryCollection(uid);
    return collection.doc(categories.id ?? '').update(categories.toFireStore());
  }
  static Future<void> editItem(String uid, String cid, Item item) {
    CollectionReference<Item> collection = getItemCollection(uid, cid);
    return collection.doc(item.id ?? '').update(item.toFireStore());
  }
  static CollectionReference<Item> getItemCollection(String uid, String cid) {
    return getCategoryCollection(uid)
        .doc(cid)
        .collection(Item.collectionName)
        .withConverter<Item>(
          fromFirestore: (snapshot, options) =>
              Item.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  static Future<void> addItem(String uid, String cid, Item item) {
    DocumentReference<Item> collection = getItemCollection(uid, cid).doc();
    item.id = collection.id;
    return collection.set(item);
  }

  static Stream<QuerySnapshot<Item>> getItems(String uid, String cid) {
    return getItemCollection(uid, cid).snapshots();
  }

  static Future<void> deleteItem(String uid, String cid, Item item) {
    CollectionReference<Item> collection = getItemCollection(uid, cid);
    return collection.doc(item.id).delete();
  }

}
