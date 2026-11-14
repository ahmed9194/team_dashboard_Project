import 'package:flutter/material.dart';

import '../../state/team_state.dart';
import '../../utils/format.dart';
import '../../widgets/like_button.dart';
import '../../widgets/member_avatar.dart';

/// Member 4 - "Slivers": CustomScrollView with a collapsing SliverAppBar,
/// stats tiles, a SliverList of posts and an extended FAB for Follow.
class ProfileD extends StatelessWidget {
  const ProfileD({super.key, required this.memberId});

  final int memberId;

  static const Color _teal = Color(0xFF0F766E);

  Widget _tile(IconData icon, String label, int value) {
    return Expanded(
      child: Card(
        elevation: 0,
        color: const Color(0xFFE6F4F1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: [
              Icon(icon, color: _teal, size: 20),
              const SizedBox(height: 6),
              Text(formatCount(value),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _teal)),
              Text(label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final team = TeamScope.of(context);
    final m = team.byId(memberId);

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => team.toggleFollow(m.id),
        backgroundColor: m.isFollowing ? Colors.white : _teal,
        foregroundColor: m.isFollowing ? _teal : Colors.white,
        icon: Icon(m.isFollowing ? Icons.check : Icons.add),
        label: Text(m.isFollowing ? 'Following' : 'Follow'),
      ),
      body: CustomScrollView(
        slivers: [
          // Collapsing app bar
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: _teal,
            foregroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(m.name),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF115E59), Color(0xFF2DD4BF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0, -0.25),
                    child: MemberAvatar(member: m, size: 110),
                  ),
                ],
              ),
            ),
          ),

          // Bio + stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
              child: Column(
                children: [
                  Text('${m.role}  •  ${m.handle}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, color: _teal)),
                  const SizedBox(height: 8),
                  Text(m.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _tile(Icons.article_outlined, 'Posts', m.posts),
                      _tile(Icons.people_outline, 'Followers', m.followers),
                      _tile(Icons.person_add_alt, 'Following', m.following),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LikeButton(
                    likes: m.likes,
                    onLike: () => team.like(m.id),
                    color: Colors.redAccent,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, left: 4),
                      child: Text('Posts',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Posts as a sliver list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE6F4F1),
                  child: Text('${i + 1}',
                      style: const TextStyle(color: _teal)),
                ),
                title: Text(m.postTitles[i]),
                subtitle: const Text('Tap to read more'),
              ),
              childCount: m.postTitles.length,
            ),
          ),
          // Room for the FAB
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
