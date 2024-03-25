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
        title: const Text('Nofication'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Nofication Page'),
      ),
    );
  }
}
