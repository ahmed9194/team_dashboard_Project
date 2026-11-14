import 'package:flutter/material.dart';

import '../../state/team_state.dart';
import '../../utils/format.dart';
import '../../widgets/like_button.dart';
import '../../widgets/member_avatar.dart';

/// Member 1 - "Aurora": gradient header, floating avatar, white stats card.
class ProfileA extends StatelessWidget {
  const ProfileA({super.key, required this.memberId});

  final int memberId;

  Widget _stat(String label, int value) {
    return Expanded(
      child: Column(
        children: [
          Text(
            formatCount(value),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4C1D95),
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = TeamScope.of(context);
    final m = team.byId(memberId);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- Gradient header + floating avatar ----------
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  height: 230,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(36)),
                  ),
                  child: SafeArea(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new,
                            size: 16, color: Colors.white),
                        label: const Text('< Back',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -55,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 14),
                      ],
                    ),
                    child: MemberAvatar(member: m, size: 100),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 64),

            // ---------- Name + bio ----------
            Text(m.name,
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            Text('${m.role}  •  ${m.handle}',
                style: const TextStyle(color: Colors.black54)),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 10, 32, 0),
              child: Text(m.bio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black87)),
            ),
            const SizedBox(height: 20),

            // ---------- Stats card ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  child: Row(
                    children: [
                      _stat('Posts', m.posts),
                      _stat('Followers', m.followers),
                      _stat('Following', m.following),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ---------- Follow ----------
            SizedBox(
              width: 220,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () => team.toggleFollow(m.id),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      m.isFollowing ? Colors.white : const Color(0xFF6D28D9),
                  foregroundColor:
                      m.isFollowing ? const Color(0xFF6D28D9) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Color(0xFF6D28D9)),
                  ),
                ),
                icon: Icon(m.isFollowing ? Icons.check : Icons.person_add_alt_1),
                label: Text(m.isFollowing ? 'Following' : 'Follow'),
              ),
            ),
            const SizedBox(height: 12),
            LikeButton(
              likes: m.likes,
              onLike: () => team.like(m.id),
              color: const Color(0xFFEC4899),
            ),
            const SizedBox(height: 8),

            // ---------- Posts ----------
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Recent posts',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  for (final title in m.postTitles)
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: const Icon(Icons.auto_awesome,
                            color: Color(0xFF8B5CF6)),
                        title: Text(title),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
