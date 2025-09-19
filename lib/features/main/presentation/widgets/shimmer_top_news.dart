import 'package:flutter/material.dart';

class ShimmerTopNews extends StatelessWidget {
  const ShimmerTopNews({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.canvasColor,
            ),
          );
        },
      ),
    );
  }
}
