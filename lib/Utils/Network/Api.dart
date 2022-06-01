import 'package:buqit/States/Appointments/data.dart';

class Api {
  static const String BASE_URL = "https://buqit.com/api/v1";


  static const String SIGNIN = "/customers/signin";
  static const String SIGNUP = "/customers/signup";
  static const String CONTACT = "/feedback";
  static const String SET_NOTIFICATION = "/settings";
  static const String UPDATE_PROFILE = "/users";
  static const String RESET_PASSWORD = "/settings/password/recovery";

  static RECOVER_PASSWORD (String? email){return "/users/$email/recovery/password/verification";}
  static VERIFY_PASSWORD_RECOVERY_CODE (String? email,String code){return "/users/$email/recovery/password/verification/$code";}
  static RESEND_PASSWORD_RECOVERY_CODE (String? email){return "/users/$email/recovery/password/nvc";}
  static CHANGE_PASSWORD (String? email){return "/settings/password";}

  static RESEND_CODE (String? userId){return "/users/$userId/nvc";}
  static GET_PROFILE (String userId){return "/customers/$userId";}
  static VERIFY_EMAIL (String email,String code){return "/users/$email/verification/$code";}
  static CHECK_EMAIL (String email){return "/users/$email/availability";}
  static CHANGE_SETTING (){return "/v1/settings";}


  static UPCOMING_CANCEL (String appointmentId){return "/appointments/upcoming/${appointmentId}/cancellation";}
  static REQUEST_CANCEL (String appointmentId){return "/appointments/requests/${appointmentId}/cancellation";}
  static ONGOING_CANCEL (String appointmentId){return "/appointments/ongoing/${appointmentId}/cancellation";}
  static HISTORY_CANCEL (String appointmentId){return "/appointments/history/${appointmentId}/cancellation";}



  static SEARCH_HISTORY (id){return "/users/${id}/history/search";}

  static const REQUEST_SERVICE="/appointments/requests";
  static GET_DRAWER_CONTENT (String userId){return "/customers/$userId/configurations/ui/menu";}
  static GET_APPOINTMENTS (String userId,String type){return "/users/$userId/appointments/$type";}


  static String  GET_NEARBY_PROVIDERS="/providers/nearby";
  static GET_PROVIDERS (String workPlaceId){return "/workplaces/${workPlaceId}/providers";}
  static GET_PROVIDERS_SERVICE (String workerId){return "/providers/${workerId}/services";}
  static LIKE_PROVIDER (String workerId,String userId){return "/customers/${userId}/favorites/providers/${workerId}";}
  static GET_AVAILABLE_TIMES (String workerId){return "/providers/${workerId}/availabilities";}
  static CHECK_PROVIDER_FAVOURITE (String workerId,String userId){return "/customers/$userId/favorites/providers/${workerId}/status";}
  static GET_FAVOURITE_PROVIDERS (String customerId){return "/customers/$customerId/favorites/providers";}


  static GET_SERVICES (String searchText){return "/services/search/${searchText}";}
  static GET_WORKPLACES (String searchText){return "/workplaces/search/${searchText}";}

  static GET_PAYMENTS_METHOD (String userId){return "/customers/${userId}/payment-methods";}
  static ACTIVE_PAYMENT (String paymentId){return "/payment-methods/${paymentId}";}



}
