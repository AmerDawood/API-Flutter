import 'package:api/api/controllars/category_api_controller.dart';
import 'package:api/models/category.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Category>_categories =<Category>[];
  late Future<List<Category>> _future;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future =CategoryAPIController().getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category',),
        centerTitle: true,
      ),
       body:FutureBuilder<List<Category>>(
         future: _future,
           builder:(context, snapshot) {
             if(snapshot.connectionState==ConnectionState.waiting){
               return Center(
                 child: CircularProgressIndicator(),
               );

             }else if(snapshot.hasData&&snapshot.data!.isNotEmpty){
               _categories = snapshot.data ??[];

               return ListView.builder(
                 itemCount: _categories.length,
                 itemBuilder: (context, index) {
                 return ListTile(
                   leading: Icon(Icons.category),
                   title: Text(_categories[index].title),
                   subtitle: Text(_categories[index].id.toString()),

                 );
               },
               );

             }else {
               return Column(
                 children: [
                   Icon(Icons.warning,size: 80,),
                   SizedBox(height: 20,),
                   Text('No Data',
                     style: TextStyle(
                       fontSize: 30,
                       color: Colors.grey,

                     ),
                   ),
                 ],
               );
             }

           },

       ),
    );
  }
}
