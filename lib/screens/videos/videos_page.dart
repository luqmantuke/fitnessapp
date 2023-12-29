import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ommyfitness/common/option_view.dart';
import 'package:ommyfitness/common/responsiveWidgets/responsive_text_widget.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/common/textfield_widget.dart';
import 'package:ommyfitness/models/subscription/user_subscription_model.dart';
import 'package:ommyfitness/models/videos/videos_model.dart';
import 'package:ommyfitness/providers/apiservices/videos/videos_provider.dart';
import 'package:ommyfitness/providers/apiservices/videos/videos_search_provider.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/providers/subscription/user_subscription_provider.dart';
import 'package:ommyfitness/screens/subscription/paywall.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class VideosPage extends ConsumerStatefulWidget {
  const VideosPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VideosPageState();
}

class _VideosPageState extends ConsumerState<VideosPage> {
  final TextEditingController videoSearchController = TextEditingController();
  @override
  void initState() {
    ref.read(sharedPreferenceInstanceProvider);
    ref.read(isLoggedInProvider);
    ref.read(userNameProvider);
    ref.read(tokenProvider);
    ref.read(fetchVideosProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final videos = ref.watch(fetchVideosProvider);
    final userSubscription = ref.watch(userSubscriptionProvider);
    final isLoggedIn = ref.watch(isLoggedInProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos",
            style: TextStyle(
              color: blackColor,
              fontWeight: FontWeight.w600,
            )),
        backgroundColor: whiteBackgroundColor,
        elevation: 0.0,
      ),
      body: isLoggedIn.maybeWhen(
          orElse: () => const SizedBox(),
          data: (loggedIn) => loggedIn == true
              ? userSubscription.maybeWhen(
                  orElse: () => const SizedBox(),
                  data: (subscribed) =>
                      videoContent(context, videos, subscribed, loggedIn))
              : videoContent(
                  context, videos, UserSubscriptionModel(), loggedIn)),
    );
  }

  SafeArea videoContent(
      BuildContext context,
      AsyncValue<List<VideosModelData>> videos,
      UserSubscriptionModel subscribed,
      bool loggedIn) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: TextFieldWidget(
                  borderColor: greenColor.withOpacity(0.7),
                  hintSize: 14,
                  contentPadding: 25,
                  fillColor: Colors.white,
                  color: Colors.black.withOpacity(0.7),
                  texttFieldController: videoSearchController,
                  hintText: 'Search...',
                  suffixIcon: const Icon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                  onChanged: (value) {
                    setState(() {
                      videoSearchController;
                    });
                    ref.read(searchVideosProvider(videoSearchController.text));
                  }),
            ),
            SizedBox(
              height: SizeConfig.screenHeight(context) * 0.03,
            ),
            videoSearchController.text == ''
                ? videos.maybeWhen(
                    orElse: () => const SizedBox(),
                    data: (data) => fetchVideosData(
                        data,
                        loggedIn == false ? false : subscribed.data!.isActive!,
                        loggedIn),
                  )
                : Consumer(
                    builder: (context, ref, child) {
                      final videoSearch = ref.watch(
                          searchVideosProvider(videoSearchController.text));
                      return videoSearch.maybeWhen(
                        error: (error, stackTrace) => Text('Error: $error'),
                        orElse: () => const SizedBox(),
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        data: (data) => data.statusCode == 404
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyResponsiveTextWidget(
                                      text:
                                          "Sorry we couldn't find the video that your looking for. You can request through whatsapp and we can look that for you.",
                                      desktopFontSizeValue: 16,
                                      tabletFontSizeValue: 15,
                                      mobileFontSizeValue: 14,
                                      textColor: blackColor),
                                  SizedBox(
                                      height: SizeConfig.screenHeight(context) *
                                          0.05),
                                  InkWell(
                                    onTap: () {
                                      var url = 'https://wa.me/+255676372280';

                                      void launchURL() async {
                                        if (!await launchUrl(Uri.parse(url),
                                            mode: LaunchMode
                                                .externalApplication)) {
                                          throw 'Could not launch $url';
                                        }
                                      }

                                      launchURL();
                                    },
                                    child: ResponsiveValue(context,
                                        defaultValue: Center(
                                          child: SizedBox(
                                            width: SizeConfig.screenWidth(
                                                    context) *
                                                0.4,
                                            child: OptionView(
                                              redColor,
                                              'Request On Whatsapp',
                                              padding: 10,
                                            ),
                                          ),
                                        ),
                                        valueWhen: [
                                          Condition.smallerThan(
                                            name: DESKTOP,
                                            value: Center(
                                              child: SizedBox(
                                                width: SizeConfig.screenWidth(
                                                        context) *
                                                    0.4,
                                                child: OptionView(
                                                  redColor,
                                                  'Request On Whatsapp',
                                                  padding: 10,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Condition.largerThan(
                                              name: TABLET,
                                              value: Center(
                                                child: SizedBox(
                                                  width: SizeConfig.screenWidth(
                                                          context) *
                                                      0.3,
                                                  child: OptionView(
                                                    redColor,
                                                    'Request On Whatsapp',
                                                    padding: 10,
                                                  ),
                                                ),
                                              ))
                                        ]).value!,
                                  ),
                                ],
                              )
                            : fetchVideosData(
                                data.data as List<VideosModelData>,
                                loggedIn == false
                                    ? false
                                    : subscribed.data!.isActive!,
                                loggedIn),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Expanded fetchVideosData(
      List<VideosModelData> data, subscribed, bool loggedIn) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (loggedIn == false) {
                goRouter.pushNamed(
                  'videosDetailsPage',
                  extra: data[index],
                );
              } else {
                subscribed
                    ? goRouter.pushNamed(
                        'videosDetailsPage',
                        extra: data[index],
                      )
                    : payWallSheet(context);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: SizeConfig.screenHeight(context) * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(
                          8,
                        ),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            data[index].images.toString(),
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: const Center(
                        child: CircleAvatar(
                      backgroundColor: purpleBackgroundColor,
                      child: Icon(
                        FontAwesomeIcons.circlePlay,
                        color: yellowshore,
                      ),
                    )),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight(context) * 0.01,
                  ),
                  MyResponsiveTextWidget(
                    text: data[index].title.toString(),
                    desktopFontSizeValue: 16,
                    tabletFontSizeValue: 15,
                    mobileFontSizeValue: 16,
                    textColor: blackColor.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
