import 'package:flutter/material.dart';
import 'package:movies_app/Fetchers/login_and_register/data/account_database_helper.dart';
import 'package:movies_app/Fetchers/login_and_register/data/account_model.dart';
import 'package:movies_app/Fetchers/login_and_register/presentation/register.dart';
import 'package:movies_app/Fetchers/login_and_register/widget/custom_textformfeild.dart';
import 'package:movies_app/core/widget/bottomNavigationBar.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextFormField(
              labelText: 'Email',
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
                List<User> users = await DatabaseHelper.instance.getUsers();
                // Check if user exists
                for (var user in users) {
                  if (user.email == emailController.text &&
                      user.password == passwordController.text) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => App()),
                        );
                    return;
                  }
                }
                // Show error message if user not found
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Invalid username or password')),
                );
              },
              child: const Text('Login'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account"),
                TextButton(
                    onPressed: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => Register(),
                          ),
                        ),
                    child: const Text('register'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
