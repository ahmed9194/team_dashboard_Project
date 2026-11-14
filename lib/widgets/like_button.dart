import 'package:flutter/material.dart';

/// Custom "Like" button: DOUBLE TAP to like, with an [AnimatedScale] pop.
class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.likes,
    required this.onLike,
    this.color = Colors.pink,
    this.textColor,
    this.icon = Icons.favorite,
  });

  final int likes;
  final VoidCallback onLike;
  final Color color;
  final Color? textColor;
  final IconData icon;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  double _scale = 1.0;

  void _handleDoubleTap() {
    widget.onLike();
    setState(() => _scale = 1.5);
    Future.delayed(const Duration(milliseconds: 180), () {
      if (mounted) setState(() => _scale = 1.0);
    });
  }

  void _handleSingleTap() {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Double tap to like'),
          duration: Duration(seconds: 1),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.textColor ?? Colors.black87;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: _handleDoubleTap,
      onTap: _handleSingleTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedScale(
              scale: _scale,
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOutBack,
              child: Icon(widget.icon, color: widget.color, size: 44),
            ),
            const SizedBox(height: 4),
            Text(
              '${widget.likes} likes',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'double tap to like',
              style: TextStyle(color: textColor.withAlpha(140), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
