# Color Usage Guide - NurseLife App

This guide explains how to use colors effectively in your Flutter app following the **Material Theme Builder + Brand Extensions** approach.

## 🎨 **Color System Architecture**

```
Material Theme Builder (Primary)      +     Brand Extensions (Secondary)
├── Theme.of(context).colorScheme           ├── BrandColors (dashboard-specific)
├── Primary, Secondary, Surface             ├── Status colors
├── Automatic light/dark mode support       ├── Dashboard UI colors
└── Material Design 3 semantic naming      └── Brand gradients
```

## 📋 **When to Use Each Color System**

### **✅ Use Material Theme Colors (95% of cases)**
```dart
Theme.of(context).colorScheme.primary      // Main accent color (blue)
Theme.of(context).colorScheme.secondary    // Secondary accent (green)
Theme.of(context).colorScheme.surface      // Card/surface backgrounds
Theme.of(context).colorScheme.onSurface    // Text on surfaces
Theme.of(context).colorScheme.background   // App background
Theme.of(context).colorScheme.error        // Error states
```

**Use for:**
- Standard UI components (buttons, cards, inputs)
- Text and icons
- Navigation elements
- Forms and dialogs
- Any standard Material Design component

### **✅ Use Brand Colors (5% of cases)**
```dart
import 'package:mobile/features/app_appearance/constants/brand_colors.dart';

BrandColors.availabilityAvailable        // Dashboard availability green
BrandColors.buttonBrowseShifts          // Dashboard button colors
BrandColors.primaryGradient             // Brand gradients
BrandColors.statusOpen                  // Shift status colors
```

**Use for:**
- Dashboard-specific UI elements
- Custom components not in Material Design
- Brand-specific status colors
- Custom gradients
- Healthcare-specific color meanings

## 🎯 **Practical Examples**

### **Dashboard Card - Using Both Systems**
```dart
class DashboardCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      // Material Theme for structure
      color: Theme.of(context).colorScheme.surface,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Material Theme for text
            Text(
              'Availability',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    // Brand Colors for dashboard-specific styling
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: BrandColors.getCardBackground(context, type: CardType.scheduled),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '706.0h',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                            color: BrandColors.getCardTextColor(context, type: CardType.scheduled),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Scheduled',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

### **Status Badge - Brand Colors**
```dart
class StatusBadge extends StatelessWidget {
  final ShiftStatus status;

  const StatusBadge({required this.status, super.key});

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;

    switch (status) {
      case ShiftStatus.open:
        color = BrandColors.statusOpen;
        label = 'OPEN';
        break;
      case ShiftStatus.completed:
        color = BrandColors.statusCompleted;
        label = 'COMPLETED';
        break;
      case ShiftStatus.pending:
        color = BrandColors.statusPending;
        label = 'PENDING';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
```

### **Action Button - Material Theme**
```dart
// Use Material Theme for standard buttons
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
  ),
  child: Text('Standard Button'),
)

// Use Brand Colors for dashboard-specific buttons
Container(
  decoration: BoxDecoration(
    gradient: BrandColors.primaryGradient,
    borderRadius: BorderRadius.circular(16),
  ),
  child: TextButton(
    onPressed: () {},
    child: Text(
      'Dashboard Action',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
  ),
)
```

## 🌓 **Dark Mode Support**

### **Material Theme Colors**
✅ **Automatic** - No additional code needed
```dart
// These automatically adapt to dark mode
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface
Theme.of(context).colorScheme.onSurface
```

### **Brand Colors**
🔧 **Manual handling required for optimal experience**
```dart
// Helper method in BrandColors handles this
Color getCardBackground(BuildContext context, {required CardType type}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  switch (type) {
    case CardType.scheduled:
      return isDark ? cardBgScheduledDark : cardBgScheduledLight;
    // ...
  }
}
```

## 🎨 **Color Decision Tree**

```
Need a color?
    │
    ├─ Is it a standard UI element? (button, card, text, input)
    │   └─ YES → Use Theme.of(context).colorScheme
    │
    ├─ Is it dashboard-specific? (availability, shift status, healthcare UI)
    │   └─ YES → Use BrandColors
    │
    ├─ Do you need a gradient?
    │   └─ YES → Use BrandColors.primaryGradient or create Material gradient
    │
    └─ Is it healthcare/medical specific?
        └─ YES → Consider BrandColors for semantic clarity
```

## 📱 **Accessibility Best Practices**

### **Contrast Ratios**
- **Material Theme**: ✅ Handled automatically
- **Brand Colors**: ⚠️ Test manually
```dart
// Good: High contrast
Text(
  'High Contrast Text',
  style: TextStyle(
    color: Theme.of(context).colorScheme.onSurface,
  ),
)

// Test brand colors for accessibility
Color textColor = isLightBackground(BrandColors.statusOpen)
    ? Colors.black
    : Colors.white;
```

### **Color Blindness Considerations**
```dart
// Don't rely on color alone
Row(
  children: [
    Container(color: BrandColors.statusOpen, width: 12, height: 12),
    const SizedBox(width: 8),
    Text('Open Shift'),
    Icon(Icons.circle, color: BrandColors.statusOpen, size: 12),
  ],
)
```

## 🔧 **Best Practices**

### **DO ✅**
1. **Use Material Theme** for 95% of your colors
2. **Use Brand Colors** only for dashboard-specific elements
3. **Test in both light and dark modes**
4. **Check contrast ratios** for accessibility
5. **Use semantic naming** (success, warning, error)
6. **Create reusable color helpers** in BrandColors

### **DON'T ❌**
1. **Don't hardcode colors** in widgets
2. **Don't create duplicate color definitions**
3. **Don't ignore dark mode adaptation**
4. **Don't rely on color alone** for meaning
5. **Don't use Material Theme for brand-specific elements**

## 🚀 **Migration Guide**

### **Old Way (Removed)**
```dart
// ❌ REMOVED
AppColors.primaryBlue
AppColors.buttonDisabled
AppColors.white
```

### **New Way**
```dart
// ✅ Material Theme
Theme.of(context).colorScheme.primary
Theme.of(context).colorScheme.surface.withValues(alpha: 0.12)
Theme.of(context).colorScheme.onPrimary

// ✅ Brand Colors (only when needed)
BrandColors.buttonBrowseShifts
BrandColors.statusOpen
BrandColors.primaryGradient
```

## 📚 **Quick Reference**

| Component | Use | Example |
|-----------|-----|---------|
| **Text** | Material Theme | `Theme.of(context).colorScheme.onSurface` |
| **Buttons** | Material Theme | `Theme.of(context).colorScheme.primary` |
| **Cards** | Material Theme | `Theme.of(context).colorScheme.surface` |
| **Dashboard** | Brand Colors | `BrandColors.availabilityAvailable` |
| **Status** | Brand Colors | `BrandColors.statusOpen` |
| **Gradients** | Brand Colors | `BrandColors.primaryGradient` |
| **Error States** | Material Theme | `Theme.of(context).colorScheme.error` |

This hybrid approach gives you the best of both worlds: **Material Design consistency** + **Brand-specific customization**! 🎉