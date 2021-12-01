import 'package:api/api/controllars/student_api_controller.dart';
import 'package:api/api/controllars/users_api-controller.dart';
import 'package:api/models/users.dart';
import 'package:api/prefs/student_preferance_controller.dart';
import 'package:api/utils/helpers.dart';
import 'package:flutter/material.dart';
class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen>with Helpers {
  List<User>_users =<User>[];
 late Future<List<User>> _future;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future =UsersAPIControllers().getUser();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: ()async=>await logout(),
          icon:Icon(Icons.logout),),
          IconButton(onPressed: ()=>Navigator.pushNamed(context, '/image_screen'), icon: Icon(Icons.image),),

        ],
      ),
      body:FutureBuilder<List<User>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );

          }else if(snapshot.hasData&&snapshot.data!.isNotEmpty){
             _users =snapshot.data ?? [];
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.person),
                  title: Text("${_users[index].firstName} ${_users[index].lastName}"),
                  subtitle: Text(_users[index].email),
                  trailing: Icon(Icons.arrow_forward_ios),


                );

            },);

          }else{
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
  Future<void>logout()async{
   bool status  =await StudentPreferenceController().loggedOut();
   if(status){
     Navigator.pushNamed(context,'/login_screen');
   }else{
      showSnackBar(context: context, message: 'logout failed');
   }
  }
}
