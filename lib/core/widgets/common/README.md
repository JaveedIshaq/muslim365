# Common Widgets

This folder contains reusable UI components that can be used throughout the application.

## LoadingDialog

A modern, animated overlay loading dialog with customizable messages.

### Quick Usage

```dart
// Show loading dialog
LoadingDialog.show(context, "Creating your account...");

// Hide loading dialog
LoadingDialog.hide(context);

// Using extension methods
context.showLoading("Processing payment...");
context.hideLoading();

// Using predefined messages
LoadingDialog.show(context, LoadingMessages.generatingVideo);
```

### Features

- ✅ Overlay dialog with blur backdrop
- ✅ Customizable loading message
- ✅ Modern circular progress indicator
- ✅ Smooth entry/exit animations
- ✅ Responsive design (mobile & tablet)
- ✅ Theme integration
- ✅ Extension methods for easier usage
- ✅ Predefined common messages

### Best Practices

Always ensure to hide the loading dialog in both success and error cases:

```dart
try {
  LoadingDialog.show(context, "Saving changes...");
  await performOperation();
  LoadingDialog.hide(context);
} catch (e) {
  LoadingDialog.hide(context);
  // Handle error
}
```
