// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travelapp/component/ProfileComponent.dart';
import 'package:travelapp/component/TextFieldComponent.dart';
import 'package:travelapp/model/User.dart';

class EditProfilePage extends StatefulWidget {
  final User user;
  const EditProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 32),
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: widget.user.imageUrl,
            isEdit: true,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          TextFieldComponent(
            label: 'Full Name',
            text: widget.user.fullname,
            maxLines: 1,
            onChanged: (name) {},
          ),
          const SizedBox(height: 24),
          TextFieldComponent(
            label: 'Email',
            text: widget.user.email,
            maxLines: 1,
            onChanged: (email) {},
          ),
          const SizedBox(height: 24),
          TextFieldComponent(
            label: 'Phone',
            text: widget.user.phone,
            maxLines: 1,
            onChanged: (about) {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
