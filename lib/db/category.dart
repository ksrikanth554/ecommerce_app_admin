import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CategoryServices{
Firestore _fireStore=Firestore.instance;
String ref="Categories";
 void createCategory(String name){
   var id=Uuid();
   String categoryId=id.v1(); 
    _fireStore.collection(ref).document(categoryId).setData({"CategoryName":name});
  }
  Future<List<DocumentSnapshot>> getCategory(){
    return _fireStore.collection(ref).getDocuments().then((snap){
      return snap.documents;
    });
  }
}