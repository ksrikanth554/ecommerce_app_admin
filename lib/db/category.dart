import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices{
 void createProduct(String name){
   var id=Uuid();
   String categoryId=id.v1(); 
    Firestore _fireStore=Firestore.instance;
    _fireStore.collection("Categories").document(categoryId).setData({"CategoryName":name});
  }
}