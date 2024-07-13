import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/login_and_register/data/account_database_helper.dart';
import 'package:movies_app/Fetchers/login_and_register/data/account_model.dart';
import 'package:movies_app/Fetchers/login_and_register/presentation/login.dart';
import 'package:movies_app/Fetchers/login_and_register/widget/custom_textformfeild.dart';

class Register extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              labelText: 'Username',
              controller: usernameController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              labelText: 'email',
              controller: emailController,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              labelText: 'Password',
              controller: passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Check if username already exists
                List<User> existingUsers =
                    await DatabaseHelper.instance.getUsers();
                bool usernameExists = existingUsers.any((user) =>
                    user.username == usernameController.text);
                if (usernameExists) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Username already exists'),
                    ),
                  );
                  return;
                }
                // Register new user
                User newUser = User(
                  username: usernameController.text,
                  email: emailController.text,
                  password: passwordController.text,
                );
                await DatabaseHelper.instance.insertUser(newUser);
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('User registered successfully'),
                  ),
                
                );
                usernameController.clear();
                passwordController.clear();
              },
              child: const Text('Register'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account"),
                TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                        ),
                    child: const Text('Login'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
