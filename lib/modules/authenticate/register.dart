import 'package:flutter/material.dart';
import 'package:flutter_chat_app/modules/view/loading_view.dart';
import 'package:flutter_chat_app/services/auth.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.toggleView}) : super(key: key);
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController emailAgainCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingView()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Register'),
              actions: [
                TextButton(
                  child: const Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Chat App',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
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
                            validator: (val) => val != emailCtrl.text
                                ? 'Please enter the same e-mail address'
                                : null,
                            controller: emailAgainCtrl,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              labelText: 'E-mail Again',
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
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            child: const Text('Register'),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.registerWithEmailAndPassword(
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
