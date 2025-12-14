import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
import 'package:mobile/features/app_appearance/constants/app_typography.dart';

/// Custom Numeric Keypad Widget
///
/// A reusable numeric keypad component with a 3x4 grid layout featuring:
/// - Numbers 1-9 arranged in standard phone keypad layout
/// - Special keys: *, 0, and backspace
/// - Customizable button styling and callbacks
/// - Haptic feedback on button presses
/// - Responsive design following the app's design system
///
/// Design specifications:
/// - Button size: 72px x 72px
/// - Transparent background with subtle tap feedback
/// - 24px font size for numbers
/// - Purple accent color for active states
/// - 16px spacing between buttons
class NumericKeypad extends StatelessWidget {
  /// Callback when a number (0-9) is pressed
  final ValueChanged<String>? onNumberPressed;

  /// Callback when backspace is pressed
  final VoidCallback? onBackspacePressed;

  /// Callback when * key is pressed
  final VoidCallback? onAsteriskPressed;

  /// Custom button size (defaults to 72x72 from design specs)
  final double buttonSize;

  /// Spacing between buttons
  final double spacing;

  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;

  /// Custom text style for numbers
  final TextStyle? numberTextStyle;

  const NumericKeypad({
    super.key,
    this.onNumberPressed,
    this.onBackspacePressed,
    this.onAsteriskPressed,
    this.buttonSize = 72.0,
    this.spacing = 16.0,
    this.enableHapticFeedback = true,
  }) : numberTextStyle = null;

  const NumericKeypad.withTextStyle({
    super.key,
    this.onNumberPressed,
    this.onBackspacePressed,
    this.onAsteriskPressed,
    this.buttonSize = 72.0,
    this.spacing = 16.0,
    this.enableHapticFeedback = true,
    this.numberTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(spacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: 1, 2, 3
          _buildKeypadRow([
            _buildNumberButton(context, '1'),
            _buildNumberButton(context, '2'),
            _buildNumberButton(context, '3'),
          ]),
          SizedBox(height: spacing),

          // Row 2: 4, 5, 6
          _buildKeypadRow([
            _buildNumberButton(context, '4'),
            _buildNumberButton(context, '5'),
            _buildNumberButton(context, '6'),
          ]),
          SizedBox(height: spacing),

          // Row 3: 7, 8, 9
          _buildKeypadRow([
            _buildNumberButton(context, '7'),
            _buildNumberButton(context, '8'),
            _buildNumberButton(context, '9'),
          ]),
          SizedBox(height: spacing),

          // Row 4: *, 0, backspace
          _buildKeypadRow([
            _buildSpecialButton(context, '*', onPressed: onAsteriskPressed),
            _buildNumberButton(context, '0'),
            _buildBackspaceButton(context),
          ]),
        ],
      ),
    );
  }

  Widget _buildKeypadRow(List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((button) => Expanded(child: button)).toList(),
    );
  }

  Widget _buildNumberButton(BuildContext context, String number) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing / 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (enableHapticFeedback) {
              HapticFeedback.lightImpact();
            }
            onNumberPressed?.call(number);
          },
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonSize / 2),
            ),
            child: Center(
              child: Text(
                number,
                style:
                    numberTextStyle ??
                    AppTypography.h2.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialButton(
    BuildContext context,
    String symbol, {
    VoidCallback? onPressed,
  }) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing / 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (enableHapticFeedback) {
              HapticFeedback.lightImpact();
            }
            onPressed?.call();
          },
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonSize / 2),
            ),
            child: Center(
              child: Text(
                symbol,
                style:
                    numberTextStyle ??
                    AppTypography.h2.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.onSurface,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: spacing / 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (enableHapticFeedback) {
              HapticFeedback.mediumImpact();
            }
            onBackspacePressed?.call();
          },
          borderRadius: BorderRadius.circular(buttonSize / 2),
          child: Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(buttonSize / 2),
            ),
            child: Center(
              child: Icon(
                Icons.backspace_outlined,
                size: AppDimensions.iconLG,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
