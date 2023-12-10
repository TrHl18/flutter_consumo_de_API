import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_servicios.dart';
import 'usuario.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => UserProvider(),
        child: MyHomePage(),
      ),
    );
  }
}

class UserProvider extends ChangeNotifier {
  final ApiService _apiService
 = ApiService();
  List<User> _users = [];

  List<User> get users => _users;

  Future<void> fetchUsers() async {
    try {
      _users = await _apiService.getUsers();
      notifyListeners();
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(' Grupos de Trabajo'),
      ),
      body: Center(
        child: userProvider.users.isEmpty
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: userProvider.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(userProvider.users[index].picture),
                    ),
                    title: Text(userProvider.users[index].name),
                    subtitle: Text(userProvider.users[index].email),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          userProvider.fetchUsers();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }
}