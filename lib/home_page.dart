import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

import 'about_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _commandController = TextEditingController();
  String _output = '';
  List<String> _executablePaths = [];

  @override
  void initState() {
    super.initState();
    _scanForExecutables();
  }

  @override
  void dispose() {
    _commandController.dispose();
    super.dispose();
  }

  Future<void> _scanForExecutables() async {
    List<FileSystemEntity> files = [];
    String homeDir = Directory.current.path;
    await for (FileSystemEntity entity
        in Directory(homeDir).list(recursive: true)) {
      if (entity is File && path.extension(entity.path) == '.exe') {
        files.add(entity);
      }
    }
    List<String> paths = files.map((file) => file.path).toList();
    setState(() {
      _executablePaths = paths;
    });
  }

  Future<void> _runExecutable() async {
    String command = _commandController.text;
    if (command.isEmpty) {
      setState(() {
        _output = 'Please enter an executable command.';
      });
      return;
    }

    ProcessResult result = await Process.run('wine', [command]);
    setState(() {
      _output = result.stdout.toString();
      if (result.stderr != null && result.stderr.toString().isNotEmpty) {
        _output += '\n\nError:\n${result.stderr.toString()}';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Los Executable Runner'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Los Executable Runner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
            ListTile(
              title: Text('About'),
              leading: Icon(Icons.info),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _commandController,
              decoration: const InputDecoration(
                labelText: 'Enter the executable command',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _runExecutable,
              child: const Text('Run Executable'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_output),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
