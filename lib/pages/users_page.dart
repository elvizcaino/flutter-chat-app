import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat/services/chat_service.dart';
import 'package:chat/services/users_service.dart';
import 'package:chat/services/socket_service.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/models/user_model.dart';


class UsersPage extends StatefulWidget {

  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usersService = UsersService();

  List<UserModel> users = [];

  @override
  void initState() { 
    this._loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthService>(context).user;
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(user.fullName, style: TextStyle(color: Colors.black54)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87,),
          onPressed: () {
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, "login");
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online)
              ? Icon(Icons.check_circle, color: Colors.blue[400])
              : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _loadUsers,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _usersListView(),
      )
   );
  }

  ListView _usersListView() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, index) => _userListTile(users[index]), 
      separatorBuilder: (_, index) => Divider(), 
      itemCount: users.length
    );
  }

  ListTile _userListTile(UserModel user) {
    return ListTile(
        title: Text(user.fullName),
        subtitle: Text(user.email),
        leading: CircleAvatar(
          child: Text(user.fullName.substring(0, 1)),
          backgroundColor: Colors.blue[100],
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: user.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: () {
          final chatService = Provider.of<ChatService>(context, listen: false);

          chatService.userTo = user;

          Navigator.pushNamed(context, "chat");
        },
      );
  }

  void _loadUsers() async {
    this.users = await usersService.getUsers();

    setState(() {});

    _refreshController.refreshCompleted();
  }

}