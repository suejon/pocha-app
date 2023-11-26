import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          SupaEmailAuth(
            redirectTo: kIsWeb ? null : 'pocha://',
            onSignInComplete: (response) {
              Navigator.of(context).pushNamed('/home');
              // do something, for example: navigate('home');
            },
            onSignUpComplete: (response) {
              Navigator.of(context).pushNamed('/home');
              // do something, for example: navigate("wait_for_email");
            },
            metadataFields: [
              MetaDataField(
                prefixIcon: const Icon(Icons.person),
                label: 'Username',
                key: 'username',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter something';
                  }
                  return null;
                },
              ),
            ],
          ),
          const Divider(),
          SupaSocialsAuth(
            colored: true,
            socialProviders: const [SocialProviders.google] ,
            onSuccess: (session) {
              Navigator.of(context).pushReplacementNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}
