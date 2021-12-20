part of app_metrica_plugin;

/// Appmetrica SDK singleton.
class AppmetricaSdk {
  String? globalApiKey;

  static final MethodChannel _channel =
      const MethodChannel('app_metrica_plugin');

  /// Initializes the library in an application with given parameters.
  ///
  /// The [apiKey] is API key of the application. The API key is a unique application identifier that is issued
  /// in the AppMetrica web interface during app registration. Make sure you have entered it correctly.
  /// The [sessionTimeout] sets the session timeout in seconds. The default value is 10 (minimum allowed value).
  /// The [locationTracking] enables/disables sending location of the device. By default, sending is enabled.
  /// The [statisticsSending] enables/disables sending statistics to the AppMetrica server. By default, sending is enabled.
  /// The [crashReporting] indicating that sending app crashes is enabled. By default, sending is enabled.
  /// Android only. The [maxReportsInDatabaseCount] is maximum number of events that can be stored in the database on the phone before being sent to AppMetrica. If there are more events, old records will begin to be deleted. The default value is 1000 (allowed values from 100 to 10000).
  Future<void> activate(
      {required String apiKey,
      int sessionTimeout = 10,
      bool locationTracking = true,
      bool statisticsSending = true,
      bool crashReporting = true,
      bool revenueAutoTrackingEnabled = true,
      int maxReportsInDatabaseCount = 1000}) async {
    /// Set the API Key after activation.
    globalApiKey = apiKey;

    await _channel.invokeMethod<void>('activate', <String, dynamic>{
      'apiKey': apiKey,
      'sessionTimeout': sessionTimeout,
      'locationTracking': locationTracking,
      'statisticsSending': statisticsSending,
      'crashReporting': crashReporting,
      'maxReportsInDatabaseCount': maxReportsInDatabaseCount,
      'revenueAutoTrackingEnabled': revenueAutoTrackingEnabled,
    });
  }

  Future<void> reportRevenue({
    required int productQuantity,
    required var productPrice,
  }) async {
    await _channel.invokeMethod<void>(
      'reportRevenue',
      <String, dynamic>{
        'productQuantity': productQuantity,
        'productPrice': productPrice,
      },
    );
  }

  ///Sends the begining of checkout event with [orderID] and List of lists of products as a set of [products]
  ///important that the internal lists should contain the attributes in the following form:
  ///0 - [itemID], 1 - [itemName], 2 - [actualPrice], 3 - [originalPrice], 4 - [itemQuantity] points 2 and 3 ar always shoud be DOUBLE
  Future<void> reportBeginCheckoutEvent({
    required String orderID,
    required List products,
  }) async {
    await _channel.invokeMethod<void>(
      'beginCheckoutEvent',
      <String, dynamic>{
        'orderID': orderID,
        'products': products,
      },
    );
  }

  ///Sends the purchase event with [orderID] and List of lists of products as a set of [products]
  ///important that the internal lists should contain the attributes in the following form:
  ///0 - [itemID], 1 - [itemName], 2 - [actualPrice], 3 - [originalPrice], 4 - [itemQuantity] points 2 and 3 ar always shoud be DOUBLE
  Future<void> reportPurchaseEvent({
    required String orderID,
    required List products,
  }) async {
    await _channel.invokeMethod<void>(
      'purchaseEvent',
      <String, dynamic>{
        'orderID': orderID,
        'products': products,
      },
    );
  }

  ///Sends an event for adding an item from the shopping cart to the AppMetrica server.
  Future<void> reportAddCartItemEvent({
    required double actualPrice,
    required double productOriginalPrice,
    required String productName,
    required String productID,
  }) async {
    await _channel.invokeMethod<void>('addCartItemEvent', <String, dynamic>{
      'actualPrice': actualPrice,
      'productOriginalPrice': productOriginalPrice,
      'productName': productName,
      'productID': productID,
    });
  }

  ///Sends an event for deleting an item from the shopping cart to the AppMetrica server.
  Future<void> reportRemoveCartItemEvent({
    required double actualPrice,
    required double productOriginalPrice,
    required String productName,
    required String productID,
  }) async {
    await _channel.invokeMethod<void>('removeCartItemEvent', <String, dynamic>{
      'actualPrice': actualPrice,
      'productOriginalPrice': productOriginalPrice,
      'productName': productName,
      'productID': productID,
    });
  }

  ///Sends an event recording the viewing of a specific product card to the AppMetrica server.
  Future<void> reportShowProductCardEvent({
    required double actualPrice,
    required double productOriginalPrice,
    required String screenWhereFromOpen,
    required String productName,
    required String productID,
  }) async {
    await _channel.invokeMethod<void>(
      'showProductCardEvent',
      <String, dynamic>{
        'actualPrice': actualPrice,
        'productOriginalPrice': productOriginalPrice,
        'screenWhereFromOpen': screenWhereFromOpen,
        'productName': productName,
        'productID': productID,
      },
    );
  }

  ///Sends an event recording the viewing of a specific screen of the app to the AppMetrica server.
  Future<void> reportShowScreenEvent(
      {required String screenWhereFromOpen}) async {
    await _channel.invokeMethod<void>(
      'showScreenEvent',
      <String, dynamic>{
        'screenWhereFromOpen': screenWhereFromOpen,
      },
    );
  }

  ///Sends an event recording the viewing of a specific product detailed description to the AppMetrica server.
  Future<void> reportShowProductDetailsEvent({
    required double actualPrice,
    required double productOriginalPrice,
    required String productName,
    required String productID,
  }) async {
    await _channel.invokeMethod<void>(
      'ShowProductDetailsEvent',
      <String, dynamic>{
        'actualPrice': actualPrice,
        'productOriginalPrice': productOriginalPrice,
        'productName': productName,
        'productID': productID,
      },
    );
  }

  /// Sends an event with [name] and message as a set of [attributes] to the AppMetrica server.
  Future<void> reportEvent(
      {required String name, Map<String, dynamic>? attributes}) async {
    await _channel.invokeMethod<void>('reportEvent', <String, dynamic>{
      'name': name,
      'attributes': attributes,
    });
  }

  /// Sends custom string user profile attribute with the given [key] and [value] to the AppMetrica server.
  Future<void> reportUserProfileCustomString(
      {required String key, String? value}) async {
    await _channel
        .invokeMethod<void>('reportUserProfileCustomString', <String, dynamic>{
      'key': key,
      'value': value,
    });
  }

  /// Sends custom number user profile attribute with the given [key] and [value] to the AppMetrica server.
  Future<void> reportUserProfileCustomNumber(
      {required String key, double? value}) async {
    await _channel
        .invokeMethod<void>('reportUserProfileCustomNumber', <String, dynamic>{
      'key': key,
      'value': value,
    });
  }

  /// Sends custom boolean user profile attribute with the given [key] and [value] to the AppMetrica server.
  Future<void> reportUserProfileCustomBoolean(
      {required String key, bool? value}) async {
    await _channel
        .invokeMethod<void>('reportUserProfileCustomBoolean', <String, dynamic>{
      'key': key,
      'value': value,
    });
  }

  /// Sends custom counter user profile attribute with the given [key] and [value] to the AppMetrica server.
  Future<void> reportUserProfileCustomCounter(
      {required String key, required double delta}) async {
    await _channel
        .invokeMethod<void>('reportUserProfileCustomCounter', <String, dynamic>{
      'key': key,
      'delta': delta,
    });
  }

  /// Sends predefined [userName] profile attribute to the AppMetrica server.
  Future<void> reportUserProfileUserName({String? userName}) async {
    await _channel
        .invokeMethod<void>('reportUserProfileUserName', <String, dynamic>{
      'userName': userName,
    });
  }

  /// Sends predefined [notificationsEnabled] profile attribute to the AppMetrica server.
  Future<void> reportUserProfileNotificationsEnabled(
      {bool? notificationsEnabled}) async {
    await _channel.invokeMethod<void>(
        'reportUserProfileNotificationsEnabled', <String, dynamic>{
      'notificationsEnabled': notificationsEnabled,
    });
  }

  /// Disable and enable sending statistics to the AppMetrica server.
  Future<void> setStatisticsSending({required bool statisticsSending}) async {
    await _channel.invokeMethod<void>('setStatisticsSending', <String, dynamic>{
      'statisticsSending': statisticsSending,
    });
  }

  /// Returns the current version of the AppMetrica library.
  Future<String?> getLibraryVersion() async {
    return await _channel.invokeMethod<String>('getLibraryVersion');
  }

  /// Sets the ID of the user profile.
  /// Required for predefined profile attributes like Name or Notifications enabled.
  Future<void> setUserProfileID({required String userProfileID}) async {
    await _channel.invokeMethod<void>('setUserProfileID', <String, dynamic>{
      'userProfileID': userProfileID,
    });
  }

  /// Sends stored events from the buffer.
  /// AppMetrica SDK does not send an event immediately after it occurred.
  /// The library stores event data in the buffer. The sendEventsBuffer() method
  /// sends data from the buffer and flushes it. Use the method to force sending
  /// stored events after passing important checkpoints of user scenarios.
  Future<void> sendEventsBuffer() async {
    await _channel.invokeMethod<String>('sendEventsBuffer');
    return;
  }

// Sets referral URL for this installation. This might be required to track
// some specific traffic sources like Facebook.
// Referral URL reporting is no longer available
// but many agencies use this report
  Future<void> reportReferralUrl({required String referral}) async {
    await _channel.invokeMethod<String>('reportReferralUrl', <String, dynamic>{
      'referral': referral,
    });
    return;
  }
}
