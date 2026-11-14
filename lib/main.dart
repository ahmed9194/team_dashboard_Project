import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'state/team_state.dart';

void main() => runApp(const TeamHubApp());

class TeamHubApp extends StatefulWidget {
  const TeamHubApp({super.key});

  @override
  State<TeamHubApp> createState() => _TeamHubAppState();
}

class _TeamHubAppState extends State<TeamHubApp> {
  // The shared state lives ABOVE MaterialApp so every route (Home + all
  // profile screens) can read it. This is the "lifted state".
  final TeamState _teamState = TeamState();

  @override
  void dispose() {
    _teamState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TeamScope(
      state: _teamState,
      child: MaterialApp(
        title: 'Team Hub',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: const Color(0xFF6C5CE7),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
