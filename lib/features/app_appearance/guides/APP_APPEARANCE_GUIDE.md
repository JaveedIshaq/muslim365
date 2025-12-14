# App Appearance System Guide

A comprehensive guide to the NurseLife app's unified appearance system, organized in the `lib/features/app_appearance/` feature folder.

## 📁 **File Structure**

```
lib/features/app_appearance/
├── 📄 constants/
│   ├── app_dimensions.dart      # Spacing, sizing, and layout constants
│   ├── app_typography.dart      # Poppins typography system
│   ├── brand_colors.dart        # Dashboard-specific colors
│   └── theme_constants.dart     # Theme selection UI constants
├── 🎨 theme/
│   └── theme.dart              # Material Theme Builder generated theme
├── 🔧 util/
│   └── util.dart               # Text theme utilities
├── 📊 providers/
│   └── theme_provider.dart     # Theme state management
├── 📱 widgets/
│   ├── theme_selection_bottom_sheet.dart
│   └── theme_option_item.dart
├── 💾 models/
│   └── theme_option.dart
├── 🎯 app_appearance.dart      # Export file
└── 📚 Documentation/
    ├── APP_APPEARANCE_GUIDE.md
    ├── COLOR_USAGE_GUIDE.md
    └── THEME_USAGE_GUIDE.md
```

## 🎯 **Usage Overview**

### **Quick Import**
```dart
import 'package:mobile/features/app_appearance/app_appearance.dart';
```

This single import gives you access to:
- All constants (dimensions, typography, colors)
- Material Theme utilities
- Brand color helpers

## 📏 **Dimensions System**

### **Import**
```dart
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';
```

### **Spacing**
```dart
// Vertical and horizontal spacing
SizedBox(height: AppDimensions.spaceSM);    // 8px
SizedBox(width: AppDimensions.spaceMD);     // 16px
SizedBox(height: AppDimensions.spaceLG);     // 24px

// Padding and margins
Padding(
  padding: EdgeInsets.all(AppDimensions.paddingMD), // 16px
  child: child,
)

Container(
  margin: EdgeInsets.symmetric(horizontal: AppDimensions.marginLG), // 24px
  child: child,
)
```

### **Border Radius**
```dart
// Consistent border radius
BorderRadius.circular(AppDimensions.radiusSM),  // 8px
BorderRadius.circular(AppDimensions.radiusMD),  // 12px
BorderRadius.circular(AppDimensions.radiusLG),  // 16px
BorderRadius.circular(AppDimensions.radiusXL),  // 20px

// For circular elements
BorderRadius.circular(AppDimensions.radiusRound), // 9999px
```

### **Component Sizes**
```dart
// Button heights
SizedBox(
  height: AppDimensions.buttonHeightSM, // 36px
  child: ElevatedButton(...),
)

SizedBox(
  height: AppDimensions.buttonHeightMD, // 44px (default)
  child: ElevatedButton(...),
)

// Icon sizes
Icon(
  Icons.star,
  size: AppDimensions.iconSM, // 16px
)

Icon(
  Icons.star,
  size: AppDimensions.iconMD, // 20px
)

Icon(
  Icons.star,
  size: AppDimensions.iconLG, // 24px (default)
)
```

### **Card Dimensions**
```dart
Card(
  // Using predefined card constants
  elevation: AppDimensions.cardElevation, // 2.0
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppDimensions.cardRadius), // 12px
  ),
  child: Padding(
    padding: const EdgeInsets.all(AppDimensions.cardPadding), // 16px
    child: child,
  ),
)
```

## ✍️ **Typography System**

### **Import**
```dart
import 'package:mobile/features/app_appearance/constants/app_typography.dart';
```

### **Headings**
```dart
// Display styles (hero text)
Text(
  'Hi, Diana!',
  style: AppTypography.displayLarge, // 32px, Bold
)

Text(
  'Dashboard Overview',
  style: AppTypography.displayMedium, // 28px, SemiBold
)

// Heading styles
Text(
  'Shift Management',
  style: AppTypography.h1, // 32px, Bold
)

Text(
  'Available Shifts',
  style: AppTypography.h4, // 20px, SemiBold
)

Text(
  'Quick Stats',
  style: AppTypography.h5, // 18px, SemiBold
)
```

### **Body Text**
```dart
// Body text
Text(
  'Manage your nursing shifts efficiently',
  style: AppTypography.bodyLarge, // 16px, Regular
)

Text(
  'Shift details and requirements',
  style: AppTypography.bodyMedium, // 14px, Regular
)

Text(
  'Additional information',
  style: AppTypography.bodySmall, // 12px, Regular
)
```

### **Labels and Buttons**
```dart
// Label text
Text(
  'Status',
  style: AppTypography.labelLarge, // 14px, Medium
)

Text(
  'Shift time',
  style: AppTypography.labelMedium, // 12px, Medium
)

// Button text
ElevatedButton(
  onPressed: () {},
  child: Text(
    'Browse Shifts',
    style: AppTypography.buttonMedium, // 14px, SemiBold
  ),
)
```

### **Dashboard-Specific Styles**
```dart
// Dashboard greeting
Text(
  'Hi, Diana!',
  style: AppTypography.dashboardGreeting, // 28px, Bold
)

// Stats numbers
Text(
  '706.0',
  style: AppTypography.statsNumber, // 24px, Bold
)

// Card titles
Text(
  'Availability',
  style: AppTypography.cardTitle, // 20px, SemiBold
)

// Earnings amounts
Text(
  'R353000.00',
  style: AppTypography.earningsAmount, // 16px, SemiBold
)

// Status badges
Text(
  'OPEN',
  style: AppTypography.statusBadge, // 11px, SemiBold
)
```

### **Text Style Extensions**
```dart
// Apply colors to existing styles
Text(
  'Error message',
  style: AppTypography.bodyMedium.withColor(Colors.red),
)

// Apply weight changes
Text(
  'Bold text',
  style: AppTypography.bodyLarge.withWeight(FontWeight.bold),
)

// Chain modifications
Text(
  'Custom text',
  style: AppTypography.h4
      .withColor(Theme.of(context).colorScheme.primary)
      .withWeight(FontWeight.w600),
)
```

## 🎨 **Color System**

### **Material Theme Colors (95% of usage)**
```dart
// Use Theme.of(context) for standard colors
Container(
  color: Theme.of(context).colorScheme.primary,     // Main accent (blue)
  child: Text(
    'Primary Text',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
    ),
  ),
)

Container(
  color: Theme.of(context).colorScheme.surface,     // Card background
  child: Text(
    'Surface Text',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
)

Container(
  color: Theme.of(context).colorScheme.error,       // Error state
  child: Text(
    'Error Text',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onError,
    ),
  ),
)
```

### **Brand Colors (Dashboard-specific, 5% of usage)**
```dart
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';

// Dashboard status colors
Container(
  color: BrandColors.availabilityAvailable, // Green for available
  child: Text('Available'),
)

Container(
  color: BrandColors.statusOpen, // Green for open shifts
  child: Text('Open'),
)

// Dashboard action buttons
Container(
  decoration: BoxDecoration(
    color: BrandColors.buttonBrowseShifts, // Green for browse shifts
    borderRadius: BorderRadius.circular(16),
  ),
  child: Text('Browse Shifts'),
)

// Gradients
Container(
  decoration: BoxDecoration(
    gradient: BrandColors.primaryGradient, // Blue gradient
    borderRadius: BorderRadius.circular(16),
  ),
  child: Text('Gradient Button'),
)
```

### **Theme-Aware Brand Colors**
```dart
// Brand colors with theme awareness
Container(
  color: BrandColors.getCardBackground(
    context,
    type: CardType.scheduled,
  ),
  child: Text(
    'Scheduled',
    style: TextStyle(
      color: BrandColors.getCardTextColor(
        context,
        type: CardType.scheduled,
      ),
    ),
  ),
)
```

## 🎯 **Complete Widget Examples**

### **Dashboard Card**
```dart
class DashboardStatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color cardColor;

  const DashboardStatCard({
    required this.title,
    required this.value,
    required this.cardColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.cardPadding), // 16px
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLG), // 16px
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.cardTitle.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSM), // 8px
          Text(
            value,
            style: AppTypography.statsNumber.copyWith(
              color: cardColor,
            ),
          ),
        ],
      ),
    );
  }
}
```

### **Status Badge**
```dart
class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({
    required this.label,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSM, // 8px
        vertical: AppDimensions.paddingXS,  // 4px
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL), // 24px
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: AppTypography.statusBadge.copyWith(
          color: color,
        ),
      ),
    );
  }
}
```

### **Action Button**
```dart
class ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const ActionButton({
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56, // dashboardActionButtonSize
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          label,
          style: AppTypography.buttonLabel,
        ),
      ),
    );
  }
}
```

## 🌓 **Dark Mode Support**

### **Automatic Material Theme Colors**
```dart
// These automatically adapt to dark mode
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
Theme.of(context).colorScheme.onSurface
```

### **Theme-Aware Brand Colors**
```dart
// Helper methods handle dark mode automatically
BrandColors.getCardBackground(context, type: CardType.scheduled)
BrandColors.getCardTextColor(context, type: CardType.available)
```

### **Manual Dark Mode Checks**
```dart
Container(
  color: Theme.of(context).brightness == Brightness.dark
      ? Colors.grey.shade800
      : Colors.grey.shade200,
  child: Text('Themed Content'),
)
```

## 📱 **Responsive Design**

### **Breakpoints**
```dart
import 'package:mobile/features/app_appearance/constants/app_dimensions.dart';

if (MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint) {
  // Mobile layout
  return AppTypography.bodyMedium;
} else if (MediaQuery.of(context).size.width < AppDimensions.tabletBreakpoint) {
  // Tablet layout
  return AppTypography.bodyLarge;
} else {
  // Desktop layout
  return AppTypography.bodyLarge;
}
```

## 🔧 **Best Practices**

### **DO ✅**
1. **Use the unified import** for easier access: `import 'package:mobile/features/app_appearance/app_appearance.dart';`
2. **Use Material Theme colors** for 95% of your UI needs
3. **Use Brand Colors** only for dashboard-specific elements
4. **Apply consistent spacing** using `AppDimensions` constants
5. **Use semantic typography** (`h1`, `bodyMedium`, etc.)
6. **Test in both light and dark modes**

### **DON'T ❌**
1. **Don't hardcode values** (use constants instead)
2. **Don't use magic numbers** (use `AppDimensions.spaceMD` instead of `16.0`)
3. **Don't mix fonts** (stick to Poppins throughout)
4. **Don't ignore dark mode** (use theme-aware colors)
5. **Don't create duplicate constants** (use the centralized ones)

## 🚀 **Getting Started**

1. **Import the unified package**:
   ```dart
   import 'package:mobile/features/app_appearance/app_appearance.dart';
   ```

2. **Use Material Theme for colors**:
   ```dart
   Theme.of(context).colorScheme.primary
   ```

3. **Use constants for sizing**:
   ```dart
   AppDimensions.spaceMD, AppTypography.h3, AppDimensions.radiusLG
   ```

4. **Use Brand Colors for dashboard elements**:
   ```dart
   BrandColors.statusOpen, BrandColors.primaryGradient
   ```

This unified system ensures consistency, maintainability, and excellent developer experience across your entire NurseLife app! 🎉