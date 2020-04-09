import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices{
 void createBrand(String name){
   var id=Uuid();
   String brandId=id.v1(); 
    Firestore _fireStore=Firestore.instance;
    _fireStore.collection("Brands").document(brandId).setData({"BrandName":name});
  }
}