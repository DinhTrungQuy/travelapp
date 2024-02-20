import 'package:flutter/material.dart';
import 'package:travelapp/component/back-button.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:travelapp/component/custom-text-field.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // final cpfFormatter = MaskTextInputFormatter(
  //   mask: '###.###.###-##',
  //   filter: {
  //     '#': RegExp(
  //       r'[0-9]',
  //     ),
  //   },
  // );
  // final celularFormatter = MaskTextInputFormatter(
  //   mask: '## ## # ####-####',
  //   filter: {
  //     '#': RegExp(
  //       r'[0-9]',
  //     ),
  //   },
  // );
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red[400],
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Column(children: [
                const Expanded(
                  child: Center(
                    child: const Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                        ),
                        children: [
                          TextSpan(
                            text: 'Travel ',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: 'App',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                //Formulario
                Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(45))),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          const CustomTextField(
                            icon: Icons.person,
                            label: 'Name',
                          ),
                          CustomTextField(
                            icon: Icons.file_copy_rounded,
                            label: 'Individual Taxpayer Registration',
                            // inputFormatters: [cpfFormatter],
                          ),
                          CustomTextField(
                            icon: Icons.phone,
                            label: 'Cell phone',
                            // inputFormatters: [celularFormatter],
                          ),
                          const CustomTextField(
                            icon: Icons.mail,
                            label: 'Email',
                          ),
                          const CustomTextField(
                            icon: Icons.lock,
                            label: 'Password',
                            isSecret: true,
                          ),
                          SizedBox(
                              height: 50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[400],
                                  ),
                                  onPressed: () {
                                    //TODO: create account
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Create account',
                                    style: TextStyle(
                                      fontFamily: 'OpenSans',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )))
                        ])),
              ]),
              Positioned(
                left: 16,
                top: 16,
                child: SafeArea(child: BackArrowButton(
                  onTap: () {
                    Navigator.pop(context);
                  },
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
