import 'package:buqit/Pages/AboutPage/AboutPage.dart';
import 'package:buqit/Pages/Appointments/AppointmentPage.dart';
import 'package:buqit/Pages/Authentication/ChangePasswordPage.dart';
import 'package:buqit/Pages/Authentication/EnterPasswordPage.dart';
import 'package:buqit/Pages/Authentication/RecoverPassword.dart';
import 'package:buqit/Pages/Authentication/Register.dart';
import 'package:buqit/Pages/Authentication/RegisterEmailPage.dart';
import 'package:buqit/Pages/HomePage/HomePage.dart';
import 'package:buqit/Pages/Authentication/LoginPage.dart';
import 'package:buqit/Pages/Pages.dart';
import 'package:buqit/Pages/Payment/DiscountPage.dart';
import 'package:buqit/Pages/Payment/EnterPromoCodePage.dart';
import 'package:buqit/Pages/Payment/PaymentPage.dart';
import 'package:buqit/Pages/Profile/ProfilePage.dart';
import 'package:buqit/Pages/Profile/UpdateProfileFields.dart';
import 'package:buqit/Pages/SearchPage/SearchPage.dart';
import 'package:buqit/Pages/Authentication/Splash.dart';
import 'package:buqit/Pages/Setting/SettingPage.dart';
import 'package:buqit/Pages/Support/ContactPage.dart';
import 'package:buqit/Pages/Support/SupportPage.dart';
import 'package:buqit/Pages/WorkPlacePage/WorkPlacePage.dart';
import 'package:buqit/Pages/WorkerPage/AddServicePage/AddServicePage.dart';
import 'package:buqit/Pages/WorkerPage/WorkerPage.dart';
import 'package:buqit/States/AppState/AppProvider.dart';
import 'package:buqit/States/Authentication/AuthProvider.dart';
import 'package:buqit/States/Drawer/DrawerProvider.dart';
import 'package:buqit/States/Payment/PaymentProvider.dart';
import 'package:buqit/States/Appointments/AppointmentProvider.dart';
import 'package:buqit/States/Profile/ProfileProvider.dart';
import 'package:buqit/States/Worker/WorkerProvider.dart';
import 'package:buqit/States/Workplace/WorkPlaceProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:load/load.dart';
import 'package:provider/provider.dart';

import 'Pages/Appointments/AppointmentDetailPage.dart';
import 'Pages/Authentication/VerifyPage.dart';
import 'Pages/Setting/NotificationSettingPage.dart';
import 'Pages/WorkerPage/FavouriteWorkersPage.dart';
import 'Pages/WorkerPage/WorkerWorkPlaceInfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_)=>AuthProvider()),
        ChangeNotifierProvider<WorkPlaceProvider>(create: (_)=>WorkPlaceProvider()),
        ChangeNotifierProvider<WorkerProvider>(create: (_)=>WorkerProvider()),
        ChangeNotifierProvider<PaymentProvider>(create: (_)=>PaymentProvider()),
        ChangeNotifierProvider<DrawerProvider>(create: (_)=>DrawerProvider()),
        ChangeNotifierProvider<AppointmentProvider>(create: (_)=>AppointmentProvider()),
        ChangeNotifierProvider<ProfileProvider>(create: (_)=>ProfileProvider()),
        ChangeNotifierProvider<AppProvider>(create: (_)=>AppProvider()),
      ],
      child: Builder(
        builder: (context) {

          bool dark=context.watch<AppProvider>().dark;
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: [
              FormBuilderLocalizations.delegate
            ],
            theme:dark ? ThemeData.dark() :  ThemeData(
              // primarySwatch: Colors.blue,

            ),

            initialRoute: Pages.splash,
            builder: (c,ch){
              return LoadingProvider(child: ch!, themeData: LoadingThemeData(),loadingWidgetBuilder: (context,bb){
                return CupertinoActivityIndicator(animating: true,radius: 20,);
              },);
            },
            routes: {
              Pages.updateProfile: (context)=>UpdateProfileField(),

              Pages.splash: (context)=>SplashPage(),
              Pages.login: (context)=>LoginPage(),
              Pages.register: (context)=>RegisterPage(),
              Pages.registerEmail: (context)=>RegisterEmailPage(),
              Pages.verify: (context)=>VerifyPage(),
              Pages.password: (context)=>EnterPasswordPage(),
              Pages.recoverPassword: (context)=>RecoveryPassword(),
              Pages.changePassword: (context)=>ChangePasswordPage(),
              // Pages.updatePassword: (context)=>ChangePasswordPage(),


              Pages.home: (context)=>HomePage(),
              Pages.search: (context)=>SearchPage(),
              Pages.workPlace: (context)=>WorkPlaceDisplay(),
              Pages.worker: (context)=>WorkerPage(),
              Pages.workerWorkPlaceInfo: (context)=>WorkerWorkPlaceInfo(),
              Pages.addService: (context)=>AddServicePage(),
              Pages.payment: (context)=>PaymentPage(),
              Pages.enterPromoCode: (context)=>EnterPromoCodePage(),
              Pages.profile: (context)=>ProfilePage(),

              Pages.menu_appointments: (context)=>AppointmentPage(),
              Pages.appointmentDetail: (context)=>AppointmentDetailPage(),

              Pages.menu_favorites: (context)=>FavoriteWorkersPage(),
              Pages.menu_discounts: (context)=>DiscountPage(),
              Pages.menu_settings: (context)=>SettingPage(),
              Pages.menu_about: (context)=>AboutPage(),
              Pages.menu_support: (context)=>SupportPage(),

              Pages.notificationSetting: (context)=>NotificationSettingPage(),
              Pages.contact: (context)=>ContactPage(),

            },
          );
        }
      ),
    );
  }
}

