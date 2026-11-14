import 'package:flutter/material.dart';

import '../models/member.dart';
import '../utils/fake_api.dart';

/// Single source of truth for the whole app ("lifted state").
///
/// Profile screens call [toggleFollow] / [like]; the Home dashboard reads
/// [totalFollowers] / [totalPosts]. Because both listen to the same
/// notifier through [TeamScope], the dashboard is already up to date
/// the moment the user pops back.
class TeamState extends ChangeNotifier {
  final List<Member> members = [];
  bool isLoading = true;

  int get totalFollowers => members.fold(0, (sum, m) => sum + m.followers);
  int get totalPosts => members.fold(0, (sum, m) => sum + m.posts);

  Member byId(int id) => members.firstWhere((m) => m.id == id);

  /// Simulated API call (2 seconds).
  Future<void> load() async {
    // Only notify when this is a *reload*; the first load starts with
    // isLoading == true, and notifying during initState is not allowed.
    if (!isLoading) {
      isLoading = true;
      notifyListeners();
    }
    final data = await FakeApi.fetchMembers();
    members
      ..clear()
      ..addAll(data);
    isLoading = false;
    notifyListeners();
  }

  void toggleFollow(int id) {
    final m = byId(id);
    if (m.isFollowing) {
      m.followers--;
      m.isFollowing = false;
    } else {
      m.followers++;
      m.isFollowing = true;
    }
    notifyListeners();
  }

  void like(int id) {
    byId(id).likes++;
    notifyListeners();
  }
}

/// InheritedNotifier = built-in way to expose a ChangeNotifier to the tree.
/// Any widget that calls [TeamScope.of] rebuilds when the state changes.
class TeamScope extends InheritedNotifier<TeamState> {
  TeamScope({super.key, required TeamState state, required super.child})
      : super(notifier: state);

  /// Listens to changes (use inside build).
  static TeamState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TeamScope>()!.notifier!;
  }

  /// Reads without listening (use in initState / callbacks).
  static TeamState read(BuildContext context) {
    return context.getInheritedWidgetOfExactType<TeamScope>()!.notifier!;
  }
}
