import 'package:flutter/material.dart';

import '../models/member.dart';
import '../state/team_state.dart';
import '../utils/format.dart';
import '../widgets/member_avatar.dart';
import '../widgets/summary_card.dart';
import 'profiles/profiles.dart';

/// Root screen. A StatefulWidget because it owns the local counter (setState)
/// and kicks off the simulated API call.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    // Start the 2-second simulated fetch.
    TeamScope.read(context).load();
  }

  void _openProfile(Member m) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => profileFor(m.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listening here => the totals refresh as soon as we pop back.
    final team = TeamScope.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F5FB),
      appBar: AppBar(
        title: const Text('Team Hub',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            tooltip: 'Reload',
            icon: const Icon(Icons.refresh),
            onPressed: team.isLoading ? null : () => team.load(),
          ),
        ],
      ),
      body: team.isLoading
          ? const _LoadingView()
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              children: [
                // --- Team stats overview ---
                Row(
                  children: [
                    Expanded(
                      child: SummaryCard(
                        icon: Icons.groups_rounded,
                        label: 'Total Followers',
                        value: formatCount(team.totalFollowers),
                        color: const Color(0xFF6C5CE7),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SummaryCard(
                        icon: Icons.article_rounded,
                        label: 'Total Posts',
                        value: formatCount(team.totalPosts),
                        color: const Color(0xFF00B894),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // --- Counter (setState) ---
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Counter: $_counter',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                        FilledButton.icon(
                          onPressed: () => setState(() => _counter++),
                          icon: const Icon(Icons.add),
                          label: const Text('Increment'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Team Members',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),

                // --- Member cards + navigation buttons ---
                for (var i = 0; i < team.members.length; i++)
                  _MemberCard(
                    member: team.members[i],
                    index: i,
                    onOpen: () => _openProfile(team.members[i]),
                  ),
              ],
            ),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading team data...'),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.member,
    required this.index,
    required this.onOpen,
  });

  final Member member;
  final int index;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            // Tapping the avatar triggers the Hero transition.
            GestureDetector(
              onTap: onOpen,
              child: MemberAvatar(member: member, size: 60),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(member.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(
                    '${formatCount(member.followers)} followers',
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            FilledButton.tonal(
              onPressed: onOpen,
              child: Text('Member ${index + 1} Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
