
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class ProductServices{
  String ref="products";
  Firestore _firestore=Firestore.instance;
  void uploadProduct({String productName,String productCategory,String productBrand,List images,double price,int quantity,List sizes}){
    var id=Uuid();
    String productId=id.v1();
    _firestore.collection(ref).document(productId).setData({
      "ProductName":productName,
      "ProductCategory":productCategory,
      "ProductBrand":productBrand,
      "Images":images,
      "Price":price,
      "Quantity":quantity,
      "Sizes":sizes
    });

  }
}