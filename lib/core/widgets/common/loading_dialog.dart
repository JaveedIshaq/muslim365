import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/app_typography.dart';


/// A reusable overlay loading dialog widget
///
/// Provides a modern, animated loading dialog that can be displayed over any screen
/// with a customizable message and professional design.
///
/// Features:
/// - Overlay dialog with blur backdrop
/// - Customizable loading message
/// - Modern circular progress indicator
/// - Smooth entry/exit animations
/// - Responsive design for mobile and tablet
/// - Consistent theming with app design system
/// - Simple static methods for show/hide
///
/// Usage:
/// ```dart
/// // Show loading dialog
/// LoadingDialog.show(context, "Creating your account...");
///
/// // Hide loading dialog
/// LoadingDialog.hide(context);
/// ```
class LoadingDialog {
  static OverlayEntry? _overlayEntry;
  static bool _isShowing = false;

  /// Show the loading dialog with an optional custom message
  ///
  /// [context] - BuildContext to show the dialog
  /// [message] - Custom loading message (defaults to "Loading...")
  static void show(BuildContext context, [String? message]) {
    if (_isShowing) return;

    _isShowing = true;
    _overlayEntry = OverlayEntry(
      builder: (context) => _LoadingDialogWidget(
        message: message ?? "Loading...",
        onDismiss: () => hide(context),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  /// Hide the currently displayed loading dialog
  ///
  /// [context] - BuildContext to hide the dialog
  static void hide(BuildContext context) {
    if (!_isShowing || _overlayEntry == null) return;

    _overlayEntry?.remove();
    _overlayEntry = null;
    _isShowing = false;
  }

  /// Check if the loading dialog is currently showing
  static bool get isShowing => _isShowing;
}

/// Internal widget that renders the loading dialog UI
class _LoadingDialogWidget extends StatefulWidget {
  final String message;
  final VoidCallback? onDismiss;

  const _LoadingDialogWidget({required this.message, this.onDismiss});

  @override
  State<_LoadingDialogWidget> createState() => _LoadingDialogWidgetState();
}

class _LoadingDialogWidgetState extends State<_LoadingDialogWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isTablet = screenSize.width >= AppDimensions.tabletBreakpoint;

    // Responsive dimensions
    final containerWidth = isTablet ? 320.0 : 280.0;
    final containerHeight = isTablet ? 180.0 : 160.0;
    final contentPadding = isTablet ? 32.0 : 24.0;

    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black.withValues(alpha: 0.5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
          child: Center(
            child:
                Container(
                      width: containerWidth,
                      height: containerHeight,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(24.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(contentPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated Loading Indicator
                            SizedBox(
                              width: 48,
                              height: 48,
                              child: AnimatedBuilder(
                                animation: _rotationController,
                                builder: (context, child) {
                                  return Transform.rotate(
                                    angle:
                                        _rotationController.value * 2 * 3.14159,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 4.0,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        theme.colorScheme.primary,
                                      ),
                                      backgroundColor: theme.colorScheme.primary
                                          .withValues(alpha: 0.2),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Loading Message
                            Text(
                              widget.message,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTypography.h6.copyWith(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
                    .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.0, 1.0),
                      duration: 300.ms,
                      curve: Curves.easeOutCubic,
                    ),
          ),
        ),
      ),
    );
  }
}

/// Extension methods for easier access to loading dialog
extension LoadingDialogExtension on BuildContext {
  /// Show loading dialog with optional custom message
  void showLoading([String? message]) {
    LoadingDialog.show(this, message);
  }

  /// Hide the currently displayed loading dialog
  void hideLoading() {
    LoadingDialog.hide(this);
  }

  /// Check if loading dialog is currently showing
  bool get isLoadingShowing => LoadingDialog.isShowing;
}

/// Utility class for predefined loading messages
class LoadingMessages {
  static const String creatingAccount = "Creating your account...";
  static const String generatingVideo = "Generating video...";
  static const String savingChanges = "Saving changes...";
  static const String processingPayment = "Processing payment...";
  static const String uploadingFile = "Uploading file...";
  static const String downloadingFile = "Downloading file...";
  static const String signingIn = "Signing in...";
  static const String signingOut = "Signing out...";
  static const String updatingProfile = "Updating profile...";
  static const String sendingEmail = "Sending email...";
  static const String verifyingCode = "Verifying code...";
  static const String resettingPassword = "Resetting password...";
  static const String deletingAccount = "Deleting account...";
  static const String loading = "Loading...";
}
