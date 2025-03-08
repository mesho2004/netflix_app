// import 'package:flutter/material.dart';
// import 'package:netflix_app/screens/user/model/user_profile.dart';
// import 'package:netflix_app/screens/user/widgets/add_profile_button.dart';
// import 'package:netflix_app/screens/user/widgets/profile_grid.dart';

// class UserScreen extends StatefulWidget {
//   const UserScreen({super.key});

//   @override
//   State<UserScreen> createState() => _ProfileSelectionScreenState();
// }

// class _ProfileSelectionScreenState extends State<UserScreen> {
//   final List<UserProfile> profiles = [
//     UserProfile(
//       name: 'User 1',
//       imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Netflix-avatar.png',
//     ),
//     UserProfile(
//       name: 'User 2',
//       imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Netflix-avatar.png',
//     ),
//   ];

//   void _addProfile() {
//     if (profiles.length >= 5) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Maximum number of profiles reached'),
//         ),
//       );
//       return;
//     }

//     setState(() {
//       profiles.add(
//         UserProfile(
//           name: 'User ${profiles.length + 1}',
//           imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Netflix-avatar.png',
//         ),
//       );
//     });
//   }

//   void _removeProfile(int index) {
//     setState(() {
//       profiles.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text(
//           'Who\'s watching?',
//           style: TextStyle(fontSize: 24),
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Expanded(
//                 child: ProfileGrid(
//                   profiles: profiles,
//                   onRemoveProfile: _removeProfile,
//                 ),
//               ),
//               AddProfileButton(onAdd: _addProfile),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }