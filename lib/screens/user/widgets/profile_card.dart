// import 'package:flutter/material.dart';
// import 'package:netflix_app/screens/user/model/user_profile.dart';

// class ProfileCard extends StatelessWidget {
//   final UserProfile profile;
//   final VoidCallback onRemove;

//   const ProfileCard({
//     super.key,
//     required this.profile,
//     required this.onRemove,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           children: [
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey, width: 2),
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: Image.network(
//                   profile.imageUrl,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Positioned(
//               top: 0,
//               right: 0,
//               child: IconButton(
//                 icon: const Icon(
//                   Icons.remove_circle,
//                   color: Colors.red,
//                 ),
//                 onPressed: onRemove,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 8),
//         Text(
//           profile.name,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//         ),
//       ],
//     );
//   }
// }