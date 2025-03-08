// import 'package:flutter/material.dart';
// import 'package:netflix_app/screens/testtttt/api/service.dart';
// import 'package:netflix_app/screens/testtttt/widgets/nbutton.dart';
// import 'package:netflix_app/screens/testtttt/widgets/text_field.dart';
// import 'register_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _tmdbService = TMDBService();
//   bool _isLoading = false;

//   Future<void> _login() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);
//     try {
//       await _tmdbService.login(
//         _usernameController.text,
//         _passwordController.text,
//       );
//       if (mounted) {
//         Navigator.pushReplacementNamed(context, '/home');
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(e.toString())),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() => _isLoading = false);
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.black, Colors.red],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24),
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/netflix.png',
//                       width: 200,
//                     ),
//                     const SizedBox(height: 48),
//                     NetflixTextField(
//                       controller: _usernameController,
//                       label: 'Username',
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your username';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     NetflixTextField(
//                       controller: _passwordController,
//                       label: 'Password',
//                       obscureText: true,
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your password';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     NetflixButton(
//                       onPressed: _isLoading ? null : _login,
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text('Sign In'),
//                     ),
//                     const SizedBox(height: 16),
//                     TextButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const RegisterScreen(),
//                           ),
//                         );
//                       },
//                       child: const Text(
//                         'New to Netflix? Sign up now',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }