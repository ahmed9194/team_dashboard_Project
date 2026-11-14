import 'package:flutter/material.dart';

/// A team member. Fields that change at runtime (followers, likes, ...)
/// are only mutated through [TeamState], never directly from a screen.
class Member {
  Member({
    required this.id,
    required this.name,
    required this.handle,
    required this.role,
    required this.bio,
    required this.color,
    required this.posts,
    required this.followers,
    required this.following,
    required this.postTitles,
    this.likes = 0,
    this.isFollowing = false,
  });

  final int id;
  final String name;
  final String handle;
  final String role;
  final String bio;
  final Color color;
  final List<String> postTitles;

  int posts;
  int followers;
  int following;
  int likes;
  bool isFollowing;

  String get initials {
    final parts = name.trim().split(' ');
    return parts.take(2).map((p) => p[0]).join().toUpperCase();
  }
}
