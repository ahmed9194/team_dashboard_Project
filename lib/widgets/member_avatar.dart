import 'package:flutter/material.dart';

import '../models/member.dart';

/// Custom avatar (gradient circle + initials). Wrapped in a [Hero] so tapping
/// it on the Home Hub flies it into the profile screen.
class MemberAvatar extends StatelessWidget {
  const MemberAvatar({
    super.key,
    required this.member,
    this.size = 64,
    this.hero = true,
  });

  final Member member;
  final double size;
  final bool hero;

  @override
  Widget build(BuildContext context) {
    final dark = Color.lerp(member.color, Colors.black, 0.35)!;
    final avatar = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [member.color, dark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Text(
        member.initials,
        style: TextStyle(
          color: Colors.white,
          fontSize: size * 0.36,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
      ),
    );

    if (!hero) return avatar;
    return Hero(
      tag: 'avatar_${member.id}',
      child: Material(type: MaterialType.transparency, child: avatar),
    );
  }
}
