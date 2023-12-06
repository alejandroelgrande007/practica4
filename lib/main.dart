import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuarios desde API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<dynamic> usuarios = []; // Lista para almacenar los usuarios

  @override
  void initState() {
    super.initState();
    obtenerUsuarios(); // Llamada a la función al inicio
  }

  Future<void> obtenerUsuarios() async {
    final url = Uri.parse('https://api-jobs-production.up.railway.app/api/users');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        usuarios = json.decode(response.body) as List<dynamic>;
      });
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
      ),
      body: usuarios.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(usuarios[index]['nombre']),
                  subtitle: Text(usuarios[index]['email']),
                );
              },
            ),
    );
  }
}
