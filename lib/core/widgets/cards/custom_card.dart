import 'package:flutter/material.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final bool isSelected;
  final Gradient? gradient;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
    this.borderRadius,
    this.border,
    this.boxShadow,
    this.onTap,
    this.isSelected = false,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardBorderRadius =
        borderRadius ?? BorderRadius.circular(AppDimensions.cardRadius);

    Widget cardContent = Container(
      padding: padding ?? const EdgeInsets.all(AppDimensions.cardPadding),
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? theme.cardColor) : null,
        gradient: gradient,
        borderRadius: cardBorderRadius,
        border:
            border ??
            (isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  )
                : null),
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: Theme.of(
                  context,
                ).colorScheme.shadow.withValues(alpha: 0.1),
                offset: const Offset(0, AppDimensions.shadowOffsetY),
                blurRadius: AppDimensions.shadowBlurRadius,
                spreadRadius: AppDimensions.shadowSpreadRadius,
              ),
            ],
      ),
      child: child,
    );

    if (onTap != null) {
      cardContent = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: cardBorderRadius,
          child: cardContent,
        ),
      );
    }

    return Container(
      margin: margin ?? const EdgeInsets.all(AppDimensions.marginSM),
      child: cardContent,
    );
  }
}

class VideoCard extends StatelessWidget {
  final String? thumbnailUrl;
  final String title;
  final String? subtitle;
  final Duration? duration;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;
  final bool isLoading;
  final String aspectRatio; // "16:9" or "9:16"

  const VideoCard({
    super.key,
    this.thumbnailUrl,
    required this.title,
    this.subtitle,
    this.duration,
    this.onTap,
    this.onMorePressed,
    this.isLoading = false,
    this.aspectRatio = "16:9",
  });

  double get _aspectRatio {
    switch (aspectRatio) {
      case "9:16":
        return AppDimensions.videoPlayerAspectRatio9x16;
      case "16:9":
      default:
        return AppDimensions.videoPlayerAspectRatio16x9;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppDimensions.paddingMD),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Thumbnail
          Container(
            width: double.infinity,
            height: 200 / _aspectRatio,
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
              border: Border.all(color: theme.dividerColor, width: 1),
            ),
            child: Stack(
              children: [
                if (thumbnailUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                    child: Image.network(
                      thumbnailUrl!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildPlaceholder(theme);
                      },
                    ),
                  )
                else
                  _buildPlaceholder(theme),

                // Play button overlay
                if (!isLoading)
                  Center(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.surface.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.shadow.withValues(alpha: 0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: Theme.of(context).colorScheme.primary,
                        size: AppDimensions.iconLG,
                      ),
                    ),
                  ),

                // Loading indicator
                if (isLoading)
                  Container(
                    color: Theme.of(
                      context,
                    ).colorScheme.shadow.withValues(alpha: 0.3),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),

                // Duration badge
                if (duration != null)
                  Positioned(
                    bottom: AppDimensions.spaceSM,
                    right: AppDimensions.spaceSM,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSM,
                        vertical: AppDimensions.paddingXS,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.shadow.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusXS,
                        ),
                      ),
                      child: Text(
                        _formatDuration(duration!),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spaceMD),

          // Video Info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        subtitle!,
                        style: theme.textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              if (onMorePressed != null) ...[
                const SizedBox(width: AppDimensions.spaceSM),
                IconButton(
                  onPressed: onMorePressed,
                  icon: const Icon(Icons.more_vert),
                  color: theme.colorScheme.onSurface,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surface,
      child: Center(
        child: Icon(
          Icons.video_library_outlined,
          size: AppDimensions.iconXXL,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
