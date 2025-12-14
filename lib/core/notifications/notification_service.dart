// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mobile/core/extensions/log_extension.dart';
// import 'package:mobile/features/profile/domain/repositories/profile_repository.dart';
// import 'package:mobile/features/profile/infrastructure/dtos/update_profile_request_dto.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  ("notifications title:${message.notification?.title}").log();
  ("notifications body:${message.notification?.body}").log();
  ('count:${message.notification?.android?.count}').log();
  ('data:${message.data.toString()}').log();
  await Firebase.initializeApp();
}

enum NotificationType { none, spot, chat, match }

class NotificationServices {
  final FirebaseMessaging _messaging;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  // final ProfileRepository _profileRepository;

  static final NotificationServices instance = NotificationServices._();

  NotificationServices._()
    : _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin(),
      _messaging = FirebaseMessaging.instance;
  // _profileRepository = getIt<ProfileRepository>();

  bool _canReceiveNotification = false;
  bool _isChatPageActive = false;

  void Function(NotificationType type, String payloadId)? onNotificationTap;

  StreamSubscription<RemoteMessage>? _onMessageSubscription;
  StreamSubscription<RemoteMessage>? _onMessageOpenedSubscription;

  static final List<NotificationActionPayload> _processedNotificationPayloads =
      [];

  Future<void> initialize({
    void Function(NotificationType type, String payloadId)? onNotificationTap,
  }) async {
    this.onNotificationTap = onNotificationTap;

    final hasPermission = await requestNotificationPermission();
    if (hasPermission) {
      if (Platform.isIOS) {
        final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        ('apnsToken: $apnsToken').log();

        _canReceiveNotification = apnsToken != null;
        if (_canReceiveNotification) {
          await FirebaseMessaging.instance
              .setForegroundNotificationPresentationOptions(
                alert: true,
                badge: true,
                sound: true,
              );
        }
      } else {
        _canReceiveNotification = true;
        await FirebaseMessaging.instance
            .setForegroundNotificationPresentationOptions(
              alert: true,
              badge: true,
              sound: true,
            );
      }

      if (_canReceiveNotification) {
        FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler,
        );

        await _initLocalNotifications();

        _onMessageSubscription?.cancel();
        _onMessageSubscription = FirebaseMessaging.onMessage.listen((message) {
          ("📨 Firebase message received").log();
          ("notifications title:${message.notification?.title}").log();
          ("notifications body:${message.notification?.body}").log();
          ('count:${message.notification?.android?.count}').log();
          ('data:${message.data.toString()}').log();
          ('message.notification object: ${message.notification}').log();

          // Show notification regardless of chat status for foreground messages
          if (Platform.isAndroid) {
            _showNotification(message);
          } else if (Platform.isIOS &&
              (!_isChatPageActive ||
                  (_isChatPageActive &&
                      message.data['type'] != 'MESSAGE_RECEIVED'))) {
            _showNotification(message);
          }
        });

        // getDeviceToken().then((fcmToken) {
        //   if (fcmToken != null) {
        //     _profileRepository.updateProfileData(
        //       updateProfileRequestDto:
        //           UpdateProfileRequestDto(fcmToken: fcmToken),
        //     );
        //   }
        // });

        // _messaging.onTokenRefresh.listen((fcmToken) {
        //   _profileRepository.updateProfileData(
        //     updateProfileRequestDto:
        //         UpdateProfileRequestDto(fcmToken: fcmToken),
        //   );
        // });

        _setupInteractMessage();
      }
    }
  }

  Future<bool> requestNotificationPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        provisional: false,
        sound: true,
      );

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      ('Error requesting notification permission: $e').log();
      return false;
    }
  }

  void setChatActive() {
    _isChatPageActive = true;
  }

  void setChatInactive() {
    _isChatPageActive = false;
  }

  Future<String?> getDeviceToken() async {
    final fcmToken = await _messaging.getToken();
    ("fcmToken: $fcmToken").log();
    return fcmToken;
  }

  Future<void> _setupInteractMessage() async {
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage?.notification != null && initialMessage?.data != null) {
      ('NOTI::initialMessage ${initialMessage?.data}').log();
      handleMessageAction(
        NotificationActionPayload.fromJson(initialMessage!.data).copyWith(
          title: initialMessage.notification?.title,
          body: initialMessage.notification?.body,
        ),
      );
    }

    _onMessageOpenedSubscription?.cancel();
    _onMessageOpenedSubscription = FirebaseMessaging.onMessageOpenedApp.listen((
      message,
    ) {
      ('NOTI::onMessageOpenedApp $message').log();

      handleMessageAction(
        NotificationActionPayload.fromJson(message.data).copyWith(
          title: message.notification?.title,
          body: message.notification?.body,
        ),
      );
    });
  }

  static void handleMessageAction(NotificationActionPayload payload) {
    if (!_processedNotificationPayloads.contains(payload)) {
      ('NOTI::Message Action payload: $payload').log();
      _processedNotificationPayloads.add(payload);

      if (payload.type == 'MESSAGE_RECEIVED' && payload.isSpot!) {
        instance.onNotificationTap?.call(NotificationType.spot, payload.id!);
      } else if (payload.type == 'MESSAGE_RECEIVED') {
        instance.onNotificationTap?.call(NotificationType.chat, payload.id!);
      }
    }
  }

  int _notificationCounter = 0;

  Future<void> _initLocalNotifications() async {
    ('🔧 Initializing local notifications...').log();
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
    ('✅ Notification channel created').log();

    const initializationSetting = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/launcher_icon'),
      iOS: DarwinInitializationSettings(),
    );

    final initialized = await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        ('📱 Notification tapped with payload: ${response.payload}').log();
        if (response.payload != null) {
          final payload = NotificationActionPayload.fromJson(
            jsonDecode(response.payload!),
          );
          handleMessageAction(payload);
        }
      },
    );
    ('🔧 Local notifications initialized: $initialized').log();

    // Test notification immediately after initialization (for debugging)
    if (initialized == true) {
      await _showTestNotification();
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    ('🔔 _showNotification called with title: ${message.notification?.title}')
        .log();

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
      enableVibration: true,
    );

    // Try with launcher_icon first, fallback to ic_launcher if that fails
    AndroidNotificationDetails
    androidNotificationDetails = AndroidNotificationDetails(
      channel.id,
      channel.name,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      ticker: 'ticker',
      sound: channel.sound,
      icon: '@mipmap/launcher_icon', // Use mipmap reference instead of drawable
      channelShowBadge: true,
      enableLights: true,
      visibility: NotificationVisibility.public,
    );

    const darwinNotificationDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    try {
      // Show notification if we have at least a title or body
      final title = message.notification?.title ?? 'NurseLife';
      final body = message.notification?.body ?? 'You have a new notification';

      if (title.isNotEmpty || body.isNotEmpty) {
        ('🔔 About to show notification - Title: "$title", Body: "$body"')
            .log();
        await _flutterLocalNotificationsPlugin.show(
          _notificationCounter++,
          title,
          body,
          notificationDetails,
          payload: jsonEncode({
            'title': message.notification?.title ?? title,
            'body': message.notification?.body ?? body,
            ...message.data,
          }),
        );
        ('✅ Notification displayed successfully').log();
      } else {
        ('❌ No content to show in notification').log();
      }
    } catch (e) {
      ('Error showing notification: $e').log();

      // If it fails with invalid_icon error, try with default Android icon
      if (e.toString().contains('invalid_icon') ||
          e.toString().contains('launcher_icon')) {
        try {
          ('Retrying notification with default icon').log();

          // Create notification details without custom icon (uses default)
          androidNotificationDetails = AndroidNotificationDetails(
            channel.id,
            channel.name,
            importance: Importance.max,
            priority: Priority.max,
            playSound: true,
            ticker: 'ticker',
            sound: channel.sound,
            // No icon specified - will use default
            channelShowBadge: true,
            enableLights: true,
            visibility: NotificationVisibility.public,
          );

          notificationDetails = NotificationDetails(
            android: androidNotificationDetails,
            iOS: darwinNotificationDetails,
          );

          final fallbackTitle = message.notification?.title ?? 'NurseLife';
          final fallbackBody =
              message.notification?.body ?? 'You have a new notification';

          ('🔄 Retrying notification with fallback - Title: "$fallbackTitle", Body: "$fallbackBody"')
              .log();
          await _flutterLocalNotificationsPlugin.show(
            _notificationCounter++,
            fallbackTitle,
            fallbackBody,
            notificationDetails,
            payload: jsonEncode({
              'title': message.notification?.title ?? fallbackTitle,
              'body': message.notification?.body ?? fallbackBody,
              ...message.data,
            }),
          );
          ('✅ Fallback notification displayed successfully').log();
        } catch (fallbackError) {
          ('Failed to show notification even with fallback: $fallbackError')
              .log();
        }
      }
    }
  }

  // Test notification method for debugging
  Future<void> _showTestNotification() async {
    try {
      ('🧪 Showing test notification').log();

      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        showBadge: true,
        playSound: true,
        enableVibration: true,
      );

      final androidNotificationDetails = AndroidNotificationDetails(
        channel.id,
        channel.name,
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        ticker: 'test',
        sound: channel.sound,
        icon: '@mipmap/launcher_icon',
        channelShowBadge: true,
        enableLights: true,
        visibility: NotificationVisibility.public,
      );

      const darwinNotificationDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      final notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: darwinNotificationDetails,
      );

      // await _flutterLocalNotificationsPlugin.show(
      //   999, // Fixed ID for test
      //   'Test Notification',
      //   'Local notifications are working!',
      //   notificationDetails,
      // );

      ('✅ Test notification sent').log();
    } catch (e) {
      ('❌ Test notification failed: $e').log();
    }
  }
}

class NotificationActionPayload extends Equatable {
  final String? type;
  final String? id;
  final bool? isSpot;
  final String? title;
  final String? body;

  const NotificationActionPayload({
    this.type,
    this.id,
    this.isSpot,
    this.title,
    this.body,
  });

  @override
  List<Object?> get props => [type, id, isSpot, title, body];

  factory NotificationActionPayload.fromJson(Map<String, dynamic> map) {
    return NotificationActionPayload(
      type: map['type'],
      id: map['id'],
      isSpot: map['isSpot'] == 'true',
      title: map['title'],
      body: map['body'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'id': id,
      'isSpot': isSpot.toString(),
      'title': title,
      'body': body,
    };
  }

  NotificationActionPayload copyWith({
    String? type,
    String? id,
    bool? isSpot,
    String? title,
    String? body,
  }) {
    return NotificationActionPayload(
      type: type ?? this.type,
      id: id ?? this.id,
      isSpot: isSpot ?? this.isSpot,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}
