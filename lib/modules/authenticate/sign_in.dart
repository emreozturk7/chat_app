import 'package:flutter/material.dart';
import 'package:flutter_chat_app/utils/loading_screen.dart';
import 'package:flutter_chat_app/services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
              title: const Text('Sign In'),
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Image.asset("assets/images/chat.png"),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter Email' : null,
                            controller: emailCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              labelText: 'E-mail',
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          TextFormField(
                            validator: (val) => val!.length < 6
                                ? 'Enter password 6+ Chars Long'
                                : null,
                            controller: passwordCtrl,
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              labelText: 'Password',
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),
                            ),
                            child: const Text('Sign In'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInEmailAndPassword(
                                        emailCtrl.text, passwordCtrl.text);
                                if (result == null) {
                                  setState(() {
                                    error = 'Please supply a valid email';
                                    loading = false;
                                  });
                                }
                              }
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 3.50,
                              top: MediaQuery.of(context).size.height / 50,
                            ),
                            child: const Text(
                              'Chat App v1.0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
