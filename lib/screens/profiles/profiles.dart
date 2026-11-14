import 'package:flutter/material.dart';

import 'profile_a.dart';
import 'profile_b.dart';
import 'profile_c.dart';
import 'profile_d.dart';

/// Maps a member id to that member's own, uniquely styled profile screen.
Widget profileFor(int memberId) {
  switch (memberId) {
    case 1:
      return ProfileA(memberId: memberId);
    case 2:
      return ProfileB(memberId: memberId);
    case 3:
      return ProfileC(memberId: memberId);
    case 4:
      return ProfileD(memberId: memberId);
    default:
      return ProfileA(memberId: memberId);
  }
}
