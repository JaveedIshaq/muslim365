import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile/features/aap_language/providers/language_provider.dart';
import 'package:mobile/features/aap_language/widgets/language_selection_bottom_sheet.dart';
import 'package:mobile/l10n/app_localizations.dart';
import 'constants/app_dimensions.dart';
import 'constants/app_typography.dart';
import 'extensions/widget_animation_extensions.dart';
import 'providers/theme_provider.dart';
import 'widgets/theme_selection_bottom_sheet.dart';

class AppAppearanceScreen extends ConsumerWidget {
  const AppAppearanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeModeProvider);
    final l10n = AppLocalizations.of(context)!;
    final currentLanguageModel = ref.watch(currentLanguageModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appAppearance, style: theme.textTheme.headlineSmall),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimensions.screenPaddingHorizontal),
        child: ListView(
          children: [
            // Theme selection option
            _buildSettingsOption(
              context: context,
              title: 'Theme',
              subtitle: _getThemeDisplayName(themeMode),
              icon: _getThemeIcon(themeMode),
              onTap: () => ThemeSelectionBottomSheet.show(context),
            ),
            const SizedBox(height: AppDimensions.spaceMD),

            // App language option
            _buildSettingsOption(
              context: context,
              title: 'App Language',
              subtitle: currentLanguageModel?.languageTitle ?? 'English',
              icon: Icons.language,
              onTap: () => LanguageSelectionBottomSheet.show(context),
            ),
          ].animateSettingsOptions(),
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
        child: Container(
          padding: const EdgeInsets.all(AppDimensions.paddingMD),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLG),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingSM),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSM),
                ),
                child: Icon(
                  icon,
                  color: colorScheme.primary,
                  size: AppDimensions.iconLG,
                ),
              ),

              const SizedBox(width: AppDimensions.spaceMD),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.bodyLarge.copyWith(
                        color: colorScheme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spaceXS),
                    Text(
                      subtitle,
                      style: AppTypography.bodyMedium.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
                size: AppDimensions.iconLG,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeDisplayName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  IconData _getThemeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      case ThemeMode.system:
        return Icons.settings_system_daydream;
    }
  }
}
