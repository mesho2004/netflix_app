// import 'package:flutter/material.dart';
// import 'package:netflix_app/screens/testtttt/api/service.dart';
// import 'package:netflix_app/screens/testtttt/widgets/nbutton.dart';
// import 'package:netflix_app/screens/testtttt/widgets/text_field.dart';

// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _tmdbService = TMDBService();
//   bool _isLoading = false;

//   Future<void> _register() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _isLoading = true);
//     try {
//       // Note: TMDB doesn't have a direct register API
//       // Redirect users to TMDB website for registration
//       const url = 'https://www.themoviedb.org/signup';
//       // You can use url_launcher package to open the URL
//       // For now, show a dialog
//       if (mounted) {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Registration'),
//             content: const Text(
//               'Please visit themoviedb.org to create an account, then come back to login.',
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
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
//     _emailController.dispose();
//     _usernameController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       extendBodyBehindAppBar: true,
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
//                       controller: _emailController,
//                       label: 'Email',
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter your email';
//                         }
//                         if (!value!.contains('@')) {
//                           return 'Please enter a valid email';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     NetflixTextField(
//                       controller: _usernameController,
//                       label: 'Username',
//                       validator: (value) {
//                         if (value?.isEmpty ?? true) {
//                           return 'Please enter a username';
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
//                           return 'Please enter a password';
//                         }
//                         if (value!.length < 6) {
//                           return 'Password must be at least 6 characters';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 24),
//                     NetflixButton(
//                       onPressed: _isLoading ? null : _register,
//                       child: _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text('Sign Up'),
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