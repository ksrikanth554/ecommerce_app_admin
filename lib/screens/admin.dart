import 'package:ecommerce_app_admin/db/brand.dart';
import 'package:ecommerce_app_admin/db/category.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

enum Page{
  dashboard,
  manage
}

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  MaterialColor active=Colors.red;
  MaterialColor notActive=Colors.grey;
  Page _selectedPage=Page.dashboard;
  final _categoryFormkey=GlobalKey<FormState>();
  final _brandFormkey=GlobalKey<FormState>();
  TextEditingController categoryController=TextEditingController();
  TextEditingController brandController=TextEditingController();
  CategoryServices _categoryServices=CategoryServices();
  BrandServices _brandServices=BrandServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          children: <Widget>[
            Expanded(
              child: FlatButton.icon(
                icon: Icon(Icons.dashboard,
                      color:_selectedPage==Page.dashboard?active:notActive,),
                label: Text('DashBoard'),
                 
                onPressed: (){
                    setState(() {
                      _selectedPage=Page.dashboard;
                    });
                },
              ),
            ),
            Expanded(
              child: FlatButton.icon(
                icon: Icon(Icons.sort,
                          color: _selectedPage==Page.manage?active:notActive,),
                label: Text('Manage'),
                
                onPressed: (){
                  setState(() {
                    _selectedPage=Page.manage;
                  });
                },
              ),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: _loadScreen(),
    );
  }
  Widget _loadScreen(){
   switch (_selectedPage) {
     case Page.dashboard:
          return Column(
            children: <Widget>[
              ListTile(
                title: Text("Revenue",textAlign:TextAlign.center,style:TextStyle(color:Colors.grey,fontSize: 20.0)),
                subtitle: FlatButton(
                child: Text('₹ 12000',textAlign:TextAlign.center,style:TextStyle(color:Colors.green,fontSize: 20.0),),
                onPressed:(){},
                )
                
              ),
              Expanded(
                child: GridView(
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.people_outline), 
                            label: Text('Users'),
                            onPressed: (){}, 
                          ),subtitle: Text('7',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.category), 
                            label: Text('Categories'),
                            onPressed: (){}, 
                          ),subtitle: Text('23',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.track_changes), 
                            label: Text('Products'),
                            onPressed: (){}, 
                          ),subtitle: Text('120',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.tag_faces), 
                            label: Text('Sold'),
                            onPressed: (){}, 
                          ),subtitle: Text('13',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.shopping_cart), 
                            label: Text('Orders'),
                            onPressed: (){}, 
                          ),subtitle: Text('5',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          title: FlatButton.icon(
                            icon: Icon(Icons.close), 
                            label: Text('Return'),
                            onPressed: (){}, 
                          ),subtitle: Text('0',textAlign: TextAlign.center,style:TextStyle(color:active,fontSize:60 ),),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
     break;
     case Page.manage:
          return ListView(
            children: <Widget>[
              ListTile(
                leading:Icon(Icons.add),
                title: Text('Add Product'),
                onTap:(){},
              ),
              Divider(),
              ListTile(
                leading:Icon(Icons.change_history),
                title: Text('Product List'),
                onTap:(){},
              ),
              Divider(),
              ListTile(
                leading:Icon(Icons.add_circle),
                title: Text('Add Category'),
                onTap:(){
                  _addCategoryAlert();
                },
              ),
              Divider(),
              ListTile(
                leading:Icon(Icons.category),
                title: Text('Category List'),
                onTap:(){},
              ),
              Divider(),
              ListTile(
                leading:Icon(Icons.add_circle_outline),
                title: Text('Add Brand'),
                onTap:(){
                  _addBrandAlert();
                },
              ),
              Divider(),
              ListTile(
                leading:Icon(Icons.library_books),
                title: Text('Brand List'),
                onTap:(){},
              ),
              Divider(),
            ],
          );
     break;
     default:
     return Container();
   }
  }
 void _addCategoryAlert(){
      var alert=AlertDialog(
        title: Text('Add Category'),
        content:Form(
          key: _categoryFormkey,
          child:TextFormField(
            controller:categoryController,
            validator: (val){
              if (val.isEmpty) {
                return "category shoud not empty";
              }
              else
              return null;
            },
          ),
          
        ),
        actions: <Widget>[
          FlatButton( 
            child: Text('Add'),
            onPressed: (){
              FormState _formState=_categoryFormkey.currentState;

              if (_formState.validate()) {
                _categoryServices.createProduct(categoryController.text);
              Navigator.of(context).pop();
              Toast.show("Category added Succesfully", context,duration: Toast.LENGTH_LONG);
              categoryController.clear();
              }
                
            },
          ),
          FlatButton( 
            child: Text('Close'),
            onPressed: (){
              Navigator.of(context).pop();
              
            },
          ),
        ],
      );
    showDialog(context: context,builder:(ctx)=>alert);
  }
 void _addBrandAlert(){
      var alert=AlertDialog(
        title: Text('Add Brand'),
        content:Form(
          key: _brandFormkey,
          child:TextFormField(
            controller:brandController,
             validator: (val){
              if (val.isEmpty) {
                return "brand shoud not empty";
              }
              else
              return null;
            },
          ),
        ),
        actions: <Widget>[
          FlatButton( 
            child: Text('Add'),
            onPressed: (){
              FormState _formState=_brandFormkey.currentState;
              if(_formState.validate()){
                _brandServices.createBrand(brandController.text);
              Navigator.of(context).pop();
              Toast.show("Brand added succesfully ", context,duration: Toast.LENGTH_LONG);
                brandController.clear();
              }
            },
          ),
          FlatButton( 
            child: Text('Close'),
            onPressed: (){
              Navigator.of(context).pop();
              
            },
          ),
        ],
      );
    showDialog(context: context,builder:(ctx)=>alert);
  }
}