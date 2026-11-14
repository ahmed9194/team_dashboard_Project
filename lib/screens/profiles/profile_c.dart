import 'package:flutter/material.dart';

import '../../state/team_state.dart';
import '../../utils/format.dart';
import '../../widgets/like_button.dart';
import '../../widgets/member_avatar.dart';

/// Member 3 - "Editorial": warm paper background, left-aligned serif
/// typography, divider-separated stats and a numbered list of posts.
class ProfileC extends StatelessWidget {
  const ProfileC({super.key, required this.memberId});

  final int memberId;

  static const Color _paper = Color(0xFFFBF5EA);
  static const Color _ink = Color(0xFF2B2118);
  static const Color _accent = Color(0xFFC8553D);

  Widget _stat(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            formatCount(value),
            style: const TextStyle(
              fontFamily: 'serif',
              fontSize: 26,
              color: _ink,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(label,
              style: const TextStyle(color: Colors.black54, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = TeamScope.of(context);
    final m = team.byId(memberId);

    return Scaffold(
      backgroundColor: _paper,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(foregroundColor: _accent),
                child: const Text('< Back'),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                MemberAvatar(member: m, size: 76),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    m.role.toUpperCase(),
                    style: const TextStyle(
                      color: _accent,
                      letterSpacing: 2.5,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              m.name,
              style: const TextStyle(
                fontFamily: 'serif',
                fontSize: 40,
                height: 1.05,
                color: _ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              m.bio,
              style: const TextStyle(
                fontFamily: 'serif',
                fontStyle: FontStyle.italic,
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(color: _ink, thickness: 1.2),

            // Stats separated by thin vertical rules
            IntrinsicHeight(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 0),
                    child: _stat('Posts', m.posts),
                  ),
                  const VerticalDivider(color: Colors.black26, width: 1),
                  _stat('Followers', m.followers),
                  const VerticalDivider(color: Colors.black26, width: 1),
                  _stat('Following', m.following),
                ],
              ),
            ),
            const Divider(color: _ink, thickness: 1.2),
            const SizedBox(height: 16),

            // Follow as an underlined text action + like on the right
            Row(
              children: [
                GestureDetector(
                  onTap: () => team.toggleFollow(m.id),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 2),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: _accent, width: 2),
                      ),
                    ),
                    child: Text(
                      m.isFollowing ? 'Following ✓' : 'Follow +',
                      style: const TextStyle(
                        color: _accent,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                LikeButton(
                  likes: m.likes,
                  onLike: () => team.like(m.id),
                  color: _accent,
                  textColor: _ink,
                  icon: Icons.favorite_border,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'NOTES & POSTS',
              style: TextStyle(letterSpacing: 2.5, fontSize: 12, color: _ink),
            ),
            const SizedBox(height: 4),

            for (var i = 0; i < m.postTitles.length; i++) ...[
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Text(
                  (i + 1).toString().padLeft(2, '0'),
                  style: const TextStyle(
                    fontFamily: 'serif',
                    fontSize: 22,
                    color: _accent,
                  ),
                ),
                title: Text(
                  m.postTitles[i],
                  style: const TextStyle(fontFamily: 'serif', fontSize: 17),
                ),
                trailing: const Icon(Icons.north_east, size: 16),
              ),
              const Divider(height: 1, color: Colors.black12),
            ],
          ],
        ),
      ),
    );
  }
}
