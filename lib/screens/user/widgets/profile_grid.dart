// import 'package:flutter/material.dart';
// import 'package:netflix_app/screens/user/model/user_profile.dart';
// import 'profile_card.dart';

// class ProfileGrid extends StatelessWidget {
//   final List<UserProfile> profiles;
//   final Function(int) onRemoveProfile;

//   const ProfileGrid({
//     super.key,
//     required this.profiles,
//     required this.onRemoveProfile,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        
//         return GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: crossAxisCount,
//             childAspectRatio: 0.8,
//             crossAxisSpacing: 16,a/a
//             mainAxisSpacing: 16,
//           ),
//           itemCount: profiles.length,
//           itemBuilder: (context, index) {
//             return ProfileCard(
//               profile: profiles[index],
//               onRemove: () => onRemoveProfile(index),
//             );
//           },
//         );
//       },
//     );
//   }

//   int _getCrossAxisCount(double width) {
//     if (width < 600) return 2;
//     if (width < 900) return 3;
//     if (width < 1200) return 4;
//     return 5;
//   }
// }