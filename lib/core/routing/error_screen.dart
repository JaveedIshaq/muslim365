import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/app_appearance/constants/app_dimensions.dart';

/// Error screen displayed when a route is not found or an error occurs
class ErrorScreen extends ConsumerWidget {
  const ErrorScreen({super.key, required this.routerInfo});

  final GoRouterState routerInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: colorScheme.errorContainer,
        foregroundColor: colorScheme.onErrorContainer,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Error icon and message
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: AppDimensions.spaceMD),
                    Text(
                      'Oops! Page Not Found',
                      style: textTheme.headlineSmall?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDimensions.spaceSM),
                    Text(
                      'The page you\'re looking for doesn\'t exist or has been moved.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppDimensions.spaceXL),

              // Detailed Route Information
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDimensions.paddingMD),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMD),
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Route Details:',
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.spaceSM),
                      _buildRouteDetail(
                        context,
                        'Full Path',
                        routerInfo.fullPath ?? 'Unknown',
                        Icons.route,
                        colorScheme,
                        textTheme,
                      ),
                      _buildRouteDetail(
                        context,
                        'Route Name',
                        routerInfo.name ?? 'Unnamed',
                        Icons.label,
                        colorScheme,
                        textTheme,
                      ),
                      _buildRouteDetail(
                        context,
                        'Location',
                        routerInfo.uri.toString(),
                        Icons.location_on,
                        colorScheme,
                        textTheme,
                      ),
                      if (routerInfo.pathParameters.isNotEmpty) ...[
                        const SizedBox(height: AppDimensions.spaceSM),
                        Text(
                          'Path Parameters:',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        ...routerInfo.pathParameters.entries.map(
                          (entry) => _buildRouteDetail(
                            context,
                            entry.key,
                            entry.value,
                            Icons.subdirectory_arrow_right,
                            colorScheme,
                            textTheme,
                          ),
                        ),
                      ],
                      if (routerInfo.uri.queryParameters.isNotEmpty) ...[
                        const SizedBox(height: AppDimensions.spaceSM),
                        Text(
                          'Query Parameters:',
                          style: textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface,
                          ),
                        ),
                        ...routerInfo.uri.queryParameters.entries.map(
                          (entry) => _buildRouteDetail(
                            context,
                            entry.key,
                            entry.value,
                            Icons.help_outline,
                            colorScheme,
                            textTheme,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: AppDimensions.spaceLG),

              // Action Buttons
              Column(
                children: [
                  // Go Back Button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeightLG,
                    child: FilledButton.icon(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Go Back'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.spaceMD),

                  // Home Button
                  SizedBox(
                    width: double.infinity,
                    height: AppDimensions.buttonHeightLG,
                    child: OutlinedButton.icon(
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.home),
                      label: const Text('Go Home'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        side: BorderSide(color: colorScheme.primary),
                      ),
                    ),
                  ),

                  // Auth-based button
                  const SizedBox(height: AppDimensions.spaceMD),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteDetail(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: AppDimensions.spaceXS),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  value.isNotEmpty ? value : 'Empty',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
