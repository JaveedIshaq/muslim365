import 'package:flutter/material.dart';

/// ✅ **OnboardingGradientDecoration** - Reusable gradient accent widget
///
/// This widget creates beautiful gradient accents similar to modern onboarding screens,
/// with gradients positioned in the corners as shown in the reference design.
///
/// **Features:**
/// - Material 3 themed gradients using primary and secondary color variants
/// - Responsive design that adapts to different screen sizes
/// - Smooth, organic gradient shapes with proper opacity
/// - Clean, maintainable code following SOLID principles
/// - Performance optimized with const constructors where possible
class OnboardingGradientDecoration extends StatelessWidget {
  /// Creates a gradient decoration with corner accents
  const OnboardingGradientDecoration({super.key, this.child});

  /// The child widget to display over the gradient decoration
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildTopLeftAccent(context),
        _buildBottomRightAccent(context),

        if (child != null) child!,
      ],
    );
  }

  Widget _buildTopLeftAccent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      top: -screenSize.width * 0.4,
      left: -screenSize.width * 0.3,
      child: _buildGradientBlob(
        colors: [
          colorScheme.primary.withValues(alpha: 0.7),
          colorScheme.primary.withValues(alpha: 0.6),
          colorScheme.primary.withValues(alpha: 0.7),
          colorScheme.primary.withValues(alpha: 0.6),
        ],
        size: screenSize.width * 1.0,
      ),
    );
  }

  /// Builds the bottom-right gradient accent using secondary color variants
  Widget _buildBottomRightAccent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    return Positioned(
      bottom: -screenSize.width * 0.35,
      right: -screenSize.width * 0.25,
      child: _buildGradientBlob(
        colors: [
          colorScheme.secondary.withValues(alpha: 0.35),
          colorScheme.primary.withValues(alpha: 0.25),
          colorScheme.secondaryContainer.withValues(alpha: 0.2),
          Colors.transparent,
        ],
        size: screenSize.width * 0.9,
      ),
    );
  }

  /// Builds an organic, spread-out gradient blob instead of a perfect circle
  Widget _buildGradientBlob({
    required List<Color> colors,
    required double size,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size * 0.7,
        ), // Creates blob-like shape
        gradient: RadialGradient(
          center: const Alignment(0.0, 0.3), // Off-center for organic look
          radius: 0.6, // Increased radius for more spread
          colors: colors,
          stops: const [0.1, 0.1, 0.1, 1.0],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: 0.3),
            blurRadius: size * 0.7,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
    );
  }
}

/// ✅ **GradientAccentBubble** - Individual gradient bubble component
///
/// A smaller, reusable gradient bubble for creating accent points
/// throughout the onboarding experience. This demonstrates the Single
/// Responsibility Principle by focusing on one specific UI element.
class GradientAccentBubble extends StatelessWidget {
  /// Creates a small gradient bubble accent
  const GradientAccentBubble({
    super.key,
    required this.color,
    this.size = 40.0,
    this.opacity = 0.3,
    this.alignment,
  });

  /// The base color for the gradient bubble
  final Color color;

  /// Size of the bubble
  final double size;

  /// Opacity of the bubble
  final double opacity;

  /// Optional alignment for positioning
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withValues(alpha: opacity),
            color.withValues(alpha: opacity * 0.5),
            color.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 0.7, 1.0],
        ),
      ),
    );
  }
}
