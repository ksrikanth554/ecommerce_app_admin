import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  static const IMAGES="Images";
  static const PRICE="Price  ";
  static const PRODUCTBRAND="ProductBrand";
  static const PRODUCTCATEGORY="ProductCategory";
  static const PRODUCTNAME="ProductName";
  static const QUANTITY="Quantity";
  static const SIZES="Sizes";
  
  List _images;
  double _price;
  String _productBrand;
  String _productCategory;
  String _productName;
  int _quantity;
  List _sizes;
  
  List get images=>_images;
  double get price=>_price;
  String get productBrand=>_productBrand;
  String get productCategory=>_productCategory;
  String get productName=>_productName;
  int get quantity=>_quantity;
  List get sizes=>_sizes;

  Product.fromSnapshot(DocumentSnapshot snapshot){
    _productName=snapshot.data[PRODUCTNAME];
    _productCategory=snapshot.data[PRODUCTCATEGORY];
    _productBrand=snapshot.data[PRODUCTBRAND];
    _quantity=snapshot.data[QUANTITY];
    _images=snapshot.data[IMAGES];
    _sizes=snapshot.data[SIZES];
    _price=snapshot.data[PRICE];
  }

}