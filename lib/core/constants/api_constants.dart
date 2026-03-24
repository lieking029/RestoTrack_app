class ApiConstants {
  static const String baseUrl = 'http://98.81.163.124:9008/api/v1';

  static const String login = '/login';
  static const String logout = '/logout';
  static const String me = '/me';
  static const String profile = '/profile';
  
  static const String order = '/server/order';
  static const String myOrders = '/server/order/my';

  static const String menus = '/server/menus';
  static const String categories = '/categories';
  
  static const String kitchenOrders = '/kitchen/orders';
  static const String cashierOrders = '/cashier/orders';

  static const String payments = '/cashier/payments';
  static const String onlinePayment = '/cashier/payments/online';
  static const String transactions = '/transactions';
  
  static const String inventory = '/inventory';

  static const String salesReport = '/reports/sales';
}
