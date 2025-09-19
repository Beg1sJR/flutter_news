import 'package:flutter/material.dart';

class ShimmerSearchNewsCard extends StatelessWidget {
  const ShimmerSearchNewsCard({super.key, required this.itemCount});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Color baseColor = theme.canvasColor;

    return Column(
      children: List.generate(itemCount, (index) {
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image skeleton (top part)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: baseColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source & Bookmark row
                    Row(
                      children: [
                        Container(
                          width: 52,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: baseColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: baseColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Title
                    Container(
                      height: 22,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: baseColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Description
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: baseColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Author & Date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: baseColor,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 16,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: baseColor,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Container(
                              width: 60,
                              height: 14,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: baseColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
