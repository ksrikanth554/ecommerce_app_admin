
import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app_admin/db/brand.dart';
import 'package:ecommerce_app_admin/db/category.dart';
import 'package:ecommerce_app_admin/db/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  Color white=Colors.white;
  Color black=Colors.black;
  Color grey=Colors.grey;
  final _formKey=GlobalKey<FormState>();
  TextEditingController productNameController=TextEditingController();
  TextEditingController quantityController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  List<DocumentSnapshot> categories=[];
  List<DocumentSnapshot> brands=[];
  List<DropdownMenuItem<String>> categoryDropDown=[];
  List<DropdownMenuItem<String>> brandDropDown=[];
  String _currentCategory;
  String _currentBrand;
  CategoryServices _categoryServices=CategoryServices();
  BrandServices _brandServices=BrandServices();
  ProductServices _productServices=ProductServices();
  List<String> selectedSizes=[];
  File image1,image2,image3;
  bool isLoading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
    getBrands();
  }
  getProducts()async{
      List<DocumentSnapshot> data=await _categoryServices.getCategory();
      setState(() {
        
      categories=data;
      categoryDropDown=getCategoryDropDown();
     // _currentCategory=categoryDropDown[0].value;
      });
  }
  getBrands()async{
    List<DocumentSnapshot> data=await _brandServices.getBrands();
    setState(() {
      brands=data;
      brandDropDown=getBrandDropDown();
    //  _currentBrand=brandDropDown[0].value;
    });
  }
 List<DropdownMenuItem<String>> getCategoryDropDown(){
    List<DropdownMenuItem<String>> dropDownList=[];
    for (var item in categories) {
      dropDownList.add(DropdownMenuItem(child: Text(item['CategoryName']),value: item['CategoryName'],));
    }
    return dropDownList;
  }
  List<DropdownMenuItem<String>> getBrandDropDown(){
    List<DropdownMenuItem<String>> dropDownList=[];
    for (var item in brands) {
      dropDownList.add(DropdownMenuItem(
                      child: Text(item['BrandName']),
                      value: item['BrandName'],
                      ));
    }
    return dropDownList;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon:Icon(Icons.close,color:black,),
        onPressed:()=> Navigator.of(context).pop(),),
        title: Text('Add Procuct',style:TextStyle(color:black),),
        backgroundColor: white,
        elevation: 1,
      ),
      body: Form(
        key:_formKey ,
         child: Stack(
                children:<Widget>[

            ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: InkWell(
                             child: Container(
                             height: MediaQuery.of(context).size.height*0.15,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: grey
                              )
                            ),
                      child: image1==null?Padding(
                              padding: EdgeInsets.only(
                                top:MediaQuery.of(context).size.height*0.03,
                                left: MediaQuery.of(context).size.width*0.02,
                                right: MediaQuery.of(context).size.width*0.02,
                                bottom: MediaQuery.of(context).size.height*0.03
                              ),
                              child: Icon(Icons.add,color: grey,),
                      ):Image.file(image1,fit: BoxFit.fill,),
                    
                           ),
                      onTap: (){
                        _selectImage(ImagePicker.pickImage(source:ImageSource.gallery),1);
                       
                      }
                         ),
                       ),
                  ),
                  Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                           height: MediaQuery.of(context).size.height*0.15,
                           child: InkWell(
                        child: Container(
                     // borderSide: BorderSide(color:grey,width: 2.0),
                     decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: grey
                              )
                            ),
                      child: image2==null?Padding(
                              padding: EdgeInsets.only(
                                top:MediaQuery.of(context).size.height*0.03,
                                left: MediaQuery.of(context).size.width*0.02,
                                right: MediaQuery.of(context).size.width*0.02,
                                bottom: MediaQuery.of(context).size.height*0.03
                              ),
                              child: Icon(Icons.add,color: grey,),
                      ):Image.file(image2,fit: BoxFit.fill,),
                    ),
                      onTap: (){
                        _selectImage(ImagePicker.pickImage(source:ImageSource.gallery),2);
                      }
                           ),
                         ),
                       ),
                  ),
                  Expanded(
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: InkWell(
                              child: Container(
                             height: MediaQuery.of(context).size.height*0.15,
                             decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                color: grey
                                )
                              ),
                    
                      child:image3==null? Padding(
                              padding: EdgeInsets.only(
                                top:MediaQuery.of(context).size.height*0.03,
                                left: MediaQuery.of(context).size.width*0.02,
                                right: MediaQuery.of(context).size.width*0.02,
                                bottom: MediaQuery.of(context).size.height*0.03
                              ),
                              child: Icon(Icons.add,color: grey,),
                      ):Image.file(image3,fit: BoxFit.fill,),
                    ),
                      onTap: (){
                        _selectImage(ImagePicker.pickImage(source:ImageSource.gallery),3);
                      }
                        
                         ),
                       ),
                  ),
                ],
              ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Enter Product Name',
                        labelText: 'Product Name'
                      ),
                      controller: productNameController,
                      validator: (val){
                          if (val.isEmpty) {
                            return 'Please Enter Product Name';
                          }
                          return null;
                      },
                    ),
                  ),
                Row(
                  children: <Widget>[
                    SizedBox(width: 5,),
                    Text('Category',style:TextStyle(color:Colors.red),),
                    SizedBox(width:5),
                    DropdownButton(
                      items: getCategoryDropDown(),
                      hint: Text('Select Category'),
                      value: _currentCategory,
                      onChanged:(selectedValue){
                        setState(() {
                          _currentCategory=selectedValue;
                        });
                      }
                    ),
                     SizedBox(width: 5,),
                    Text('Brand',style:TextStyle(color:Colors.red),),
                    SizedBox(width:5),
                DropdownButton(
                  focusColor: Colors.red,
                  hint: Text('Select Brand'),
                  items: getBrandDropDown(),
                  value: _currentBrand,
                 // elevation: 20,
                  onChanged:(selectedValue){
                    setState(() {
                      _currentBrand=selectedValue;
                    });
                  }
                ),
                  ],
                ),
              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Quantity',
                        labelText: 'Quantity'
                      ),
                      controller: quantityController,
                      validator: (val){
                          if (val.isEmpty) {
                            return 'Please Enter Quantity';
                          }
                          return null;
                      },
                    ),

                  ),
              Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Price',
                        labelText: 'Price'
                      ),
                      controller: priceController,
                      validator: (val){
                          if (val.isEmpty) {
                            return 'Please Enter Price';
                          }
                          return null;
                      },
                    ),

                  ),
              Text('Available Sizes',textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.bold),),
              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('XS'), onChanged:(value)=>changeSelectedSize(value,'XS')),
                  Text('XS'),
                  Checkbox(value: selectedSizes.contains('S'), onChanged:(value)=>changeSelectedSize(value,'S')),
                  Text('S'),
                  Checkbox(value: selectedSizes.contains('M'), onChanged:(value)=>changeSelectedSize(value,'M')),
                  Text('M'),
                  Checkbox(value: selectedSizes.contains('L'), onChanged:(value)=>changeSelectedSize(value,'L')),
                  Text('L'),
                  Checkbox(value: selectedSizes.contains('XL'), onChanged:(value)=>changeSelectedSize(value,'XL')),
                  Text('XL'),
                  Checkbox(value: selectedSizes.contains('XXL'), onChanged:(value)=>changeSelectedSize(value,'XXL')),
                  Text('XXL'),
                ],
              ),
              Row(
                children: <Widget>[
                  Checkbox(value: selectedSizes.contains('14'), onChanged:(value)=>changeSelectedSize(value,'14')),
                  Text('14'),
                  Checkbox(value: selectedSizes.contains('16'), onChanged:(value)=>changeSelectedSize(value,'16')),
                  Text('16'),
                  Checkbox(value: selectedSizes.contains('18'), onChanged:(value)=>changeSelectedSize(value,'18')),
                  Text('18'),
                  Checkbox(value: selectedSizes.contains('20'), onChanged:(value)=>changeSelectedSize(value,'20')),
                  Text('20'),
                  Checkbox(value: selectedSizes.contains('22'), onChanged:(value)=>changeSelectedSize(value,'22')),
                  Text('22'),
                  Checkbox(value: selectedSizes.contains('24'), onChanged:(value)=>changeSelectedSize(value,'24')),
                  Text('24'),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  color: Colors.red,
                  child:Text('Add Product',style:TextStyle(color:white),),
                  onPressed: (){
                    validateAndUploadImageWithProduct();
                  }
                ),
              )
            ],
        ),
        Visibility(
          visible: isLoading==true,
          child: Center(
            
            child: CircularProgressIndicator(),
          )
        )
     ]
      ),
      ),
      
    );
  }
  changeSelectedSize(bool value,String size){
    setState(() {
      if (value) {
        selectedSizes.add(size);
      }
      else{
        selectedSizes.remove(size);
      }
    });
  }

  void _selectImage(Future<File> pickImage,int imageNumber)async{
    File tempImage=await pickImage;
    switch (imageNumber) {
      case 1:setState(() {
              image1=tempImage;
             });
      break;
      case 2:setState((){
              image2=tempImage;
             });
      break;
      case 3:setState((){
              image3=tempImage;
             });
        
      break;
      
    }

  }

  void validateAndUploadImageWithProduct() async{
    FormState _formState=_formKey.currentState;
    if (_formState.validate()) {
      setState(() {
        isLoading=true;
      });
      if (image1!=null && image2!=null && image3!=null) {
        if (_currentCategory!=null && _currentBrand!=null) {
          if (selectedSizes.isNotEmpty) {
            String imageUrl1;
            String imageUrl2;
            String imageUrl3;
            final FirebaseStorage storage=FirebaseStorage.instance;
            final String picture1="1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
            StorageUploadTask task1=storage.ref().child(picture1).putFile(image1);
            final String picture2="2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
            StorageUploadTask task2=storage.ref().child(picture2).putFile(image2);
            final String picture3="3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
            StorageUploadTask task3=storage.ref().child(picture3).putFile(image3);
            
            StorageTaskSnapshot snapshot1=await task1.onComplete.then((snapshot1)=>snapshot1);
            StorageTaskSnapshot snapshot2=await task2.onComplete.then((snapshot2)=>snapshot2);
            task3.onComplete.then((snapshot3)async{
              imageUrl1=await snapshot1.ref.getDownloadURL();
              imageUrl2=await snapshot2.ref.getDownloadURL();
              imageUrl3=await snapshot3.ref.getDownloadURL();
              List<String> images=[imageUrl1,imageUrl2,imageUrl3];
              _productServices.uploadProduct(
                images: images,
                price: double.parse(priceController.text),
                productBrand: _currentBrand,
                productCategory: _currentCategory,
                productName: productNameController.text,
                quantity: int.parse(quantityController.text),
                sizes: selectedSizes
              );
              _formState.reset();
              setState(() {
                isLoading=false;
              });
              Navigator.of(context).pop();
              Toast.show('Product Added Successfully', context,duration:Toast.LENGTH_LONG);
            });


         }
        else{
          setState(() {
            isLoading=false;
          });
          Toast.show('Select atleast one size', context,duration: Toast.LENGTH_LONG);
         }
      }
      else{
          setState(() {
            isLoading=false;

          });
          Toast.show('Select brand and category', context,duration: Toast.LENGTH_LONG);
      }

    }
      else{
        setState(() {
          isLoading=false;
        });
        Toast.show("Images shoud not be empty", context,duration:Toast.LENGTH_LONG);
      }
      
    }
  }
}