import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/common/responsiveWidgets/responsive_text_widget.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/models/subscription/user_subscription_model.dart';
import 'package:ommyfitness/providers/apiservices/banners/fetch_banner_images_provider.dart';
import 'package:ommyfitness/providers/apiservices/madini/madini_providers.dart';
import 'package:ommyfitness/providers/apiservices/videos/videos_provider.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/providers/subscription/user_subscription_provider.dart';
import 'package:ommyfitness/screens/subscription/paywall.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int currentBannerIndex = 0;

  final ScrollController gridController = ScrollController();
  final PageController bannerController = PageController();

  @override
  void initState() {
    ref.read(fetchBannerImagesProvider);
    ref.read(fetchMadiniProvider);
    ref.read(fetchVideosProvider);
    ref.read(sharedPreferenceInstanceProvider);
    ref.read(isLoggedInProvider);
    ref.read(userNameProvider);
    ref.read(tokenProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);
    final userSubscription = ref.watch(userSubscriptionProvider);

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 14,
            ),
            child: isLoggedIn.maybeWhen(
              orElse: () => const SizedBox(),
              data: (loggedIn) => loggedIn == false
                  ? homepageContent(context, UserSubscriptionModel(), loggedIn)
                  : userSubscription.maybeWhen(
                      error: (error, stackTrace) => Text(
                            error.toString(),
                            style: const TextStyle(
                              color: blackColor,
                            ),
                          ),
                      orElse: () => const SizedBox(),
                      data: (userSubscribed) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            subscriptionStatus(userSubscribed, context),
                            SizedBox(
                              height: SizeConfig.screenHeight(context) * 0.02,
                            ),
                            homepageContent(context, userSubscribed, loggedIn),
                          ],
                        );
                      }),
            )),
      ),
    ));
  }

  Align subscriptionStatus(
      UserSubscriptionModel userSubscribed, BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          userSubscribed.data!.isActive! ? null : payWallSheet(context);
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: redColor.withOpacity(0.8),
          ),
          child: MyResponsiveTextWidget(
            text: "Umebakiza siku: ${userSubscribed.data?.remainingDays}",
            desktopFontSizeValue: 14,
            tabletFontSizeValue: 14,
            mobileFontSizeValue: 14,
            textColor: blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Column homepageContent(
      BuildContext context, UserSubscriptionModel userSubscribed, isLoggedIn) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        carouselBanner(context, bannerController),
        SizedBox(height: SizeConfig.screenHeight(context) * 0.02),
        categoryInfo("Popular Madini", "madini"),
        Consumer(
          builder: (context, ref, child) {
            final madini = ref.watch(fetchMadiniProvider);
            return madini.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () => const SizedBox(),
              data: (data) => categoryDetails(
                  context,
                  data,
                  'madiniDetailsPage',
                  isLoggedIn == false ? false : userSubscribed.data!.isActive!,
                  isLoggedIn),
            );
          },
        ),
        SizedBox(height: SizeConfig.screenHeight(context) * 0.02),
        categoryInfo("Popular Videos", "videos"),
        Consumer(
          builder: (context, ref, child) {
            final videos = ref.watch(fetchVideosProvider);
            return videos.maybeWhen(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              orElse: () => const SizedBox(),
              data: (data) => categoryDetails(
                  context,
                  data,
                  'videosDetailsPage',
                  isLoggedIn == false ? false : userSubscribed.data!.isActive!,
                  isLoggedIn),
            );
          },
        ),
      ],
    );
  }

  Widget categoryDetails(BuildContext context, List data, String location,
      bool subscribed, bool isLoggedIn) {
    return SizedBox(
      height: SizeConfig.screenHeight(context) * 0.3,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: data.length > 8 ? 8 : data.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (isLoggedIn == false) {
                goRouter.pushNamed(
                  location,
                  extra: data[index],
                );
              } else {
                subscribed
                    ? goRouter.pushNamed(
                        location,
                        extra: data[index],
                      )
                    : payWallSheet(context);
              }
            },
            child: SizedBox(
              width: SizeConfig.screenWidth(context) * 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    height: SizeConfig.screenHeight(context) * 0.2,
                    width: SizeConfig.screenWidth(context) * 0.4,
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
                  ),
                  Expanded(
                    child: MyResponsiveTextWidget(
                      text: data[index].title.toString(),
                      desktopFontSizeValue: 13,
                      tabletFontSizeValue: 13,
                      mobileFontSizeValue: 13,
                      textColor: blueColor04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget carouselBanner(BuildContext context, controller) {
    return Consumer(
      builder: (context, ref, child) {
        final bannerImages = ref.watch(fetchBannerImagesProvider);
        return bannerImages.maybeWhen(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          orElse: () => const SizedBox(),
          data: (data) => Column(
            children: [
              CarouselSlider(
                items: data
                    .map((images) => Container(
                          height: SizeConfig.screenHeight(context) * 0.25,
                          width: SizeConfig.screenWidth(context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image:
                                    NetworkImage(images.imageField.toString()),
                                fit: BoxFit.cover),
                          ),
                        ))
                    .toList(),
                options: CarouselOptions(
                  height: SizeConfig.screenHeight(context) * 0.255,

                  // aspectRatio: 2.0,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  enlargeFactor: 0.3,

                  onPageChanged: (index, reason) {
                    setState(() {
                      currentBannerIndex = index;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 08.0),
                child: Center(
                  child: CarouselIndicator(
                    count: data.length,
                    index: currentBannerIndex,
                    activeColor: blackColor,
                    color: blueColor04,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Row categoryInfo(
    String title,
    String location,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: blackColor,
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        InkWell(
          onTap: () {
            goRouter.pushNamed(location);
          },
          child: const Text(
            "View all",
            style: TextStyle(
              color: bluewinter,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        )
      ],
    );
  }
}
