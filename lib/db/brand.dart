

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class BrandServices{
    String ref="Brands";
    Firestore _fireStore=Firestore.instance;
    void createBrand(String name){
        var id=Uuid();
        String brandId=id.v1(); 
       _fireStore.collection(ref).document(brandId).setData({"BrandName":name});
    }
 Future<List<DocumentSnapshot>> getBrands(){
      return _fireStore.collection(ref).getDocuments().then((snap){
          return snap.documents;
      });

  }
}