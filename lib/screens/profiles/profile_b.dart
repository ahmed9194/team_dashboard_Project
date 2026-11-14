import 'package:flutter/material.dart';

import '../../state/team_state.dart';
import '../../utils/format.dart';
import '../../widgets/like_button.dart';
import '../../widgets/member_avatar.dart';

/// Member 2 - "Neon": dark cyber theme, glowing avatar, outlined chips,
/// 2-column grid of posts.
class ProfileB extends StatelessWidget {
  const ProfileB({super.key, required this.memberId});

  final int memberId;

  static const Color _neon = Color(0xFF00F5D4);
  static const Color _bg = Color(0xFF0B0D17);

  Widget _chip(String label, int value) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFF141829),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: _neon.withAlpha(120)),
        ),
        child: Column(
          children: [
            Text(
              formatCount(value),
              style: const TextStyle(
                color: _neon,
                fontSize: 18,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = TeamScope.of(context);
    final m = team.byId(memberId);

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: _neon, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('// ${m.handle}',
            style: const TextStyle(
                fontFamily: 'monospace', color: Colors.white70, fontSize: 14)),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          // Glowing avatar
          Center(
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: _neon.withAlpha(110),
                      blurRadius: 36,
                      spreadRadius: 4),
                ],
              ),
              child: MemberAvatar(member: m, size: 112),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              m.name.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                letterSpacing: 3,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _neon.withAlpha(30),
              ),
              child: Text(m.role,
                  style: const TextStyle(color: _neon, fontSize: 12)),
            ),
          ),
          const SizedBox(height: 14),
          Text(m.bio,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white60)),
          const SizedBox(height: 24),

          // Stats chips
          Row(
            children: [
              _chip('Posts', m.posts),
              _chip('Followers', m.followers),
              _chip('Following', m.following),
            ],
          ),
          const SizedBox(height: 24),

          // Follow (outlined neon)
          OutlinedButton(
            onPressed: () => team.toggleFollow(m.id),
            style: OutlinedButton.styleFrom(
              foregroundColor: m.isFollowing ? _bg : _neon,
              backgroundColor: m.isFollowing ? _neon : Colors.transparent,
              side: const BorderSide(color: _neon, width: 1.5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
            child: Text(
              m.isFollowing ? 'FOLLOWING ✓' : 'FOLLOW',
              style: const TextStyle(
                  letterSpacing: 3, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: LikeButton(
              likes: m.likes,
              onLike: () => team.like(m.id),
              color: const Color(0xFFFF2E93),
              textColor: Colors.white,
              icon: Icons.bolt,
            ),
          ),
          const SizedBox(height: 12),
          const Text('> LATEST_POSTS',
              style: TextStyle(
                  color: _neon, fontFamily: 'monospace', letterSpacing: 1)),
          const SizedBox(height: 12),

          // Grid of posts
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.25,
            children: [
              for (var i = 0; i < m.postTitles.length; i++)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF141829),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('#${(i + 1).toString().padLeft(2, '0')}',
                          style: const TextStyle(
                              color: _neon, fontFamily: 'monospace')),
                      const Spacer(),
                      Text(m.postTitles[i],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
