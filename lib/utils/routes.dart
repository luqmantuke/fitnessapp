// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/screens/account/account_page.dart';
import 'package:ommyfitness/screens/authentication/login_page.dart';
import 'package:ommyfitness/screens/authentication/signup_page.dart';
import 'package:ommyfitness/screens/authentication/signup_verify_page.dart';
import 'package:ommyfitness/screens/ebooks/ebooks_page.dart';
import 'package:ommyfitness/screens/homescreen/homescreen.dart';
import 'package:ommyfitness/screens/madini/madini_details_page.dart';
import 'package:ommyfitness/screens/madini/madini_page.dart';
import 'package:ommyfitness/screens/privacy/privacy_policy_page.dart';
import 'package:ommyfitness/screens/search/search_page.dart';
import 'package:ommyfitness/screens/videos/videos_details.dart';
import 'package:ommyfitness/screens/videos/videos_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/home',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'signIn',
      path: '/signIn',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'signUp',
      path: '/signUp',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreenPage(),
    ),
    GoRoute(
      name: 'madini',
      path: '/madini',
      builder: (context, state) => const MadiniPage(),
    ),
    GoRoute(
      name: 'videos',
      path: '/videos',
      builder: (context, state) => const VideosPage(),
    ),
    GoRoute(
      name: 'ebooks',
      path: '/ebooks',
      builder: (context, state) => const EbooksPage(),
    ),
    GoRoute(
      name: 'account',
      path: '/account',
      builder: (context, state) => const AccountPage(),
    ),
    GoRoute(
      name: 'searchPage',
      path: '/searchPage',
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
        name: 'madiniDetailsPage',
        path: '/madiniDetailsPage',
        builder: (context, state) {
          MadiniModelData madiniModelData = state.extra as MadiniModelData;
          return MadiniDetailsPage(
            madiniModelData: madiniModelData,
          );
        }),
    GoRoute(
        name: 'videosDetailsPage',
        path: '/videosDetailsPage',
        builder: (context, state) {
          VideosModelData videosModelData = state.extra as VideosModelData;
          return VideosDetails(
            videosModelData: videosModelData,
          );
        }),
    GoRoute(
      name: 'privacyAndPolicy',
      path: '/privacyAndPolicy',
      builder: (context, state) => const PrivacyScreenPage(),
    ),
    GoRoute(
      name: 'signUpVerify',
      path: '/signUpVerify/:number',
      builder: (context, state) => SignUpVerifyPage(
        phoneNumber: state.params['number'].toString(),
      ),
    ),
  ],
);
