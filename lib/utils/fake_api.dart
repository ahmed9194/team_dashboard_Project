import 'package:flutter/material.dart';

import '../models/member.dart';

/// Simulates a network call. No numbers are hardcoded in the UI:
/// everything the dashboard shows comes from this 2-second Future.
///
/// TODO (team): replace the names / handles / bios below with your real info.
class FakeApi {
  static Future<List<Member>> fetchMembers() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Member(
        id: 1,
        name: 'Ahmed Hesham',
        handle: 'AH',
        role: 'UI Designer',
        bio: 'Pixels, gradients and way too much coffee.',
        color: const Color(0xFF3B82F6),
        posts: 12,
        followers: 5200,
        following: 310,
        postTitles: [
          'Designing my first Flutter screen',
          'Gradients that actually look good',
          'Why spacing matters more than color',
        ],
      ),
      Member(
        id: 2,
        name: 'Salma Hassanien',
        handle: 'SH',
        role: 'Backend Dev',
        bio: 'Turning caffeine into APIs since day one.',
        color: const Color(0xFF00BFA6),
        posts: 8,
        followers: 3100,
        following: 145,
        postTitles: [
          'REST vs GraphQL: my take',
          'Futures and async/await explained',
          'Debugging at 3 AM',
          'My terminal setup',
        ],
      ),
      Member(
        id: 3,
        name: 'Jana Hossam',
        handle: 'JH',
        role: 'Data Nerd',
        bio: 'If it has a CSV, I will plot it.',
        color: const Color(0xFFE17055),
        posts: 21,
        followers: 7800,
        following: 502,
        postTitles: [
          'Cleaning messy data in 5 steps',
          'My favourite Python one-liners',
          'Charts vs tables',
        ],
      ),
      Member(
        id: 4,
        name: 'Student D',
        handle: '@student_d',
        role: 'Mobile Dev',
        bio: 'Widgets all the way down.',
        color: const Color(0xFF8E44AD),
        posts: 15,
        followers: 4400,
        following: 230,
        postTitles: [
          'StatefulWidget lifecycle cheat sheet',
          'Slivers made simple',
          'Hero animations in 10 lines',
          'Provider vs InheritedWidget',
        ],
      ),
    ];
  }
}
