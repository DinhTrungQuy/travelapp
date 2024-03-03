import 'package:flutter/material.dart';

class NoficationPage extends StatefulWidget {
  const NoficationPage({super.key});

  @override
  State<NoficationPage> createState() => _NoficationPageState();
}

class _NoficationPageState extends State<NoficationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nofication'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Nofication Page'),
      ),
    );
  }
}
