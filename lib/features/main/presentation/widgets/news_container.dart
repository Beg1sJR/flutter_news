import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news/features/main/data/model/model.dart';

class NewsContainer extends StatelessWidget {
  const NewsContainer({super.key, required this.article});

  final ArticlesModel article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Format published date if available
    String formattedDate = '';
    if (article.publishedAt != null) {
      try {
        final date = DateTime.parse(article.publishedAt!);
        formattedDate = DateFormat('dd MMM, yyyy').format(date);
      } catch (_) {}
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  height: 110,
                  width: 110,
                  child: article.urlToImage != null
                      ? Image.network(
                          article.urlToImage!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: theme.canvasColor,
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: theme.canvasColor,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: theme.canvasColor,
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            article.source?.name ?? 'No Source',
                            style: theme.textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (formattedDate.isNotEmpty) ...[
                          const SizedBox(width: 8),
                          Text(
                            formattedDate,
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: theme.hintColor,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      article.title ?? 'No Title',
                      style: theme.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        if (article.author != null &&
                            article.author!.isNotEmpty)
                          Expanded(
                            child: Text(
                              'By ${article.author}',
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: theme.hintColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
