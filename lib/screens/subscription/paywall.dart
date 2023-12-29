import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:im_stepper/stepper.dart';
import 'package:ommyfitness/common/message_dialog.dart';
import 'package:ommyfitness/common/option_view.dart';
import 'package:ommyfitness/common/phone_number_filter.dart';
import 'package:ommyfitness/common/price_formatter.dart';
import 'package:ommyfitness/common/sizeConfig.dart';
import 'package:ommyfitness/common/textfield_widget.dart';
import 'package:ommyfitness/models/subscription/plans_model.dart';
import 'package:ommyfitness/providers/subscription/plans_provider.dart';
import 'package:ommyfitness/providers/subscription/user_subscription_provider.dart';
import 'package:ommyfitness/utils/colours.dart';

payWallSheet(BuildContext context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      final TextEditingController phoneNumberController =
          TextEditingController();
      bool isLoading = false;
      int activeStep = 0; // Initial step set to 5.
      PlansModelData selectedPlanIndex = PlansModelData();
      debugPrint("name ${selectedPlanIndex.name}");
      return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Material(
            child: Scaffold(
              appBar: AppBar(
                leading: InkWell(
                  onTap: () {
                    activeStep == 2 || activeStep == 3 ? null : context.pop();
                  },
                  child: const Icon(
                    FontAwesomeIcons.x,
                    size: 14,
                  ),
                ),
                elevation: 0,
                backgroundColor: whiteBackgroundColor,
              ),
              body: SafeArea(
                child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter stepSetState) {
                  return Consumer(builder: (context, ref, child) {
                    ref.read(fetchPlansProvider);
                    return Column(
                      children: [
                        IconStepper(
                          enableNextPreviousButtons: false,
                          activeStepColor: blueColor,
                          stepRadius: 10,
                          enableStepTapping: false,
                          icons: [
                            Icon(
                              FontAwesomeIcons.cubes,
                              color: activeStep == 0 ? greyColor02 : blackColor,
                            ),
                            Icon(FontAwesomeIcons.ccAmazonPay,
                                color:
                                    activeStep == 1 ? greyColor02 : blackColor),
                            Icon(
                              FontAwesomeIcons.spinner,
                              color: activeStep == 2 ? greyColor02 : blackColor,
                            ),
                            Icon(
                              FontAwesomeIcons.circleCheck,
                              color: activeStep == 3 ? greyColor02 : blackColor,
                            ),
                          ],

                          // activeStep property set to activeStep variable defined above.
                          activeStep: activeStep,

                          // This ensures step-tapping updates the activeStep.
                          // onStepReached: (index) {
                          //   stepSetState(() {
                          //     activeStep = index;
                          //   });
                          // },
                        ),
                        activeStep == 0
                            ? Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            SizeConfig.screenHeight(context) *
                                                0.02,
                                      ),
                                      Text(
                                        "Lipia ili uweze kuijunga na programme itakayokusaidia kuondokana na changamoto yako na kuweza kuimarisha na kurudisha uanaume wako.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                          color: blackColor.withOpacity(0.6),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            SizeConfig.screenHeight(context) *
                                                0.02,
                                      ),
                                      Expanded(
                                        child: Consumer(
                                            builder: (context, ref, child) {
                                          final plans =
                                              ref.watch(fetchPlansProvider);

                                          return plans.maybeWhen(
                                            orElse: () => const SizedBox(),
                                            loading: () => const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                            data: (data) => ListView.builder(
                                                itemCount: data.length,
                                                itemBuilder: (context, index) =>
                                                    InkWell(
                                                      onTap: () {
                                                        debugPrint(
                                                            "SelectedPlan: ${selectedPlanIndex.name}");
                                                        stepSetState(() {
                                                          selectedPlanIndex =
                                                              data[index];
                                                        });
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10,
                                                                vertical: 25),
                                                        margin: const EdgeInsets
                                                            .only(top: 15),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                            color: selectedPlanIndex ==
                                                                    data[index]
                                                                ? greenColor
                                                                : Colors
                                                                    .transparent,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              selectedPlanIndex ==
                                                                      data[
                                                                          index]
                                                                  ? FontAwesomeIcons
                                                                      .circleDot
                                                                  : FontAwesomeIcons
                                                                      .circle,
                                                              color: selectedPlanIndex ==
                                                                      data[
                                                                          index]
                                                                  ? greenColor
                                                                  : blackColor
                                                                      .withOpacity(
                                                                          0.5),
                                                            ),
                                                            SizedBox(
                                                              width: SizeConfig
                                                                      .screenWidth(
                                                                          context) *
                                                                  0.04,
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  data[index]
                                                                      .name
                                                                      .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    color: blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  formattedPrice(
                                                                      double.parse(data[
                                                                              index]
                                                                          .price
                                                                          .toString())),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: blackColor
                                                                        .withOpacity(
                                                                            0.6),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                          );
                                        }),
                                      ),
                                      selectedPlanIndex.name == null
                                          ? const Center()
                                          : Center(
                                              child: InkWell(
                                                onTap: () {
                                                  stepSetState(() {
                                                    activeStep = 1;
                                                  });
                                                },
                                                child: SizedBox(
                                                  width: SizeConfig.screenWidth(
                                                          context) *
                                                      0.75,
                                                  child: OptionView(
                                                    greenColor,
                                                    "Endelea",
                                                    padding: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height:
                                            SizeConfig.screenHeight(context) *
                                                0.04,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : activeStep == 1
                                ? Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: ListView(
                                        children: [
                                          SizedBox(
                                            height: SizeConfig.screenHeight(
                                                    context) *
                                                0.02,
                                          ),
                                          Text(
                                            "MAELEKEZO:",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color:
                                                  blackColor.withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            "Igiza namba yako ya simu kisha wasilisha. Malipo haya yamewezeshwa na SWAHILIES. Utaletewa PUSH kwenye namba ya simu uliyowasilisha kuthibitisha malipo yako kwenda SWAHILIES kwa ajili ya kifurushi ulichochagua.",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                              color:
                                                  blackColor.withOpacity(0.6),
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.screenHeight(
                                                    context) *
                                                0.02,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 25),
                                            margin:
                                                const EdgeInsets.only(top: 15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                    FontAwesomeIcons.circleDot,
                                                    color: greenColor),
                                                SizedBox(
                                                  width: SizeConfig.screenWidth(
                                                          context) *
                                                      0.04,
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                      selectedPlanIndex.name
                                                          .toString(),
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: blackColor
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                    Text(
                                                      formattedPrice(
                                                          double.parse(
                                                              selectedPlanIndex
                                                                  .price
                                                                  .toString())),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: blackColor
                                                            .withOpacity(0.6),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.screenHeight(
                                                    context) *
                                                0.03,
                                          ),
                                          TextFieldWidget(
                                              borderColor:
                                                  greenColor.withOpacity(0.7),
                                              hintSize: 14,
                                              contentPadding: 25,
                                              fillColor: Colors.white,
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              texttFieldController:
                                                  phoneNumberController,
                                              hintText:
                                                  "Namba ya simu mfano 07xxxxx"),
                                          SizedBox(
                                            height: SizeConfig.screenHeight(
                                                    context) *
                                                0.05,
                                          ),
                                          Center(
                                            child: InkWell(
                                              onTap: isLoading == true
                                                  ? () {}
                                                  : () async {
                                                      stepSetState(() {
                                                        isLoading = true;
                                                      });
                                                      if (phoneNumberController
                                                              .text ==
                                                          '') {
                                                        messageDialog(
                                                            context,
                                                            'Phone Number',
                                                            'Tafadhali inigiza namba yako ya simu.');
                                                      } else {
                                                        final formattedNumber =
                                                            phoneNumberFilter(
                                                                phoneNumberController
                                                                    .text);
                                                        if (formattedNumber ==
                                                            'invalid format') {
                                                          messageDialog(
                                                              context,
                                                              'Phone Number',
                                                              'Invalid phone number. Phone number should start with 255... or 0..');
                                                        } else {
                                                          String formatPrice(
                                                              String
                                                                  priceString) {
                                                            double price =
                                                                double.parse(
                                                                    priceString); // Parse string as double
                                                            int priceAsInt = price
                                                                .toInt(); // Convert to integer
                                                            String
                                                                formattedPrice =
                                                                priceAsInt
                                                                    .toString(); // Convert to string
                                                            return formattedPrice;
                                                          }

                                                          ref
                                                              .read(createSubscriptionProvider(CreateSubscription(
                                                                      amount: formatPrice(selectedPlanIndex
                                                                          .price
                                                                          .toString()),
                                                                      phoneNumber:
                                                                          formattedNumber))
                                                                  .future)
                                                              .then((value) {
                                                            if (value
                                                                    .statusCode ==
                                                                200) {
                                                              ref.read(
                                                                  userSubscriptionStreamProvider);
                                                              messageDialog(
                                                                      context,
                                                                      value
                                                                          .status
                                                                          .toString(),
                                                                      value
                                                                          .message
                                                                          .toString())
                                                                  .then((value) =>
                                                                      stepSetState(
                                                                          () {
                                                                        activeStep =
                                                                            2;
                                                                      }));
                                                            } else {
                                                              messageDialog(
                                                                  context,
                                                                  value.status
                                                                      .toString(),
                                                                  value.message
                                                                      .toString());
                                                              stepSetState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            }
                                                          });
                                                        }
                                                      }
                                                    },
                                              child: isLoading == true
                                                  ? const CircularProgressIndicator()
                                                  : SizedBox(
                                                      width: SizeConfig
                                                              .screenWidth(
                                                                  context) *
                                                          0.75,
                                                      child: OptionView(
                                                        greenColor,
                                                        "Endelea",
                                                        padding: 15,
                                                      ),
                                                    ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: SizeConfig.screenHeight(
                                                    context) *
                                                0.04,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : activeStep == 2
                                    ? Consumer(
                                        builder: (context, ref, child) {
                                          final userSubscriptionStream =
                                              ref.watch(
                                                  userSubscriptionStreamProvider);
                                          debugPrint(
                                              "watch is $userSubscriptionStreamProvider");
                                          return userSubscriptionStream.when(
                                            data: (subscription) {
                                              if (subscription.statusCode ==
                                                  200) {
                                                debugPrint(
                                                    "data is ${subscription.data!.isActive.toString()}");
                                                if (subscription
                                                        .data!.isActive ==
                                                    false) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else {
                                                  ref
                                                      .refresh(
                                                          userSubscriptionProvider
                                                              .future)
                                                      .then((value) {
                                                    messageDialog(
                                                            context,
                                                            "Success",
                                                            "Umefanikiwa kulipia kifurushi cha ${value.data?.plan?.name.toString()}")
                                                        .then((value) =>
                                                            context.pop());
                                                  });
                                                }
                                              }

                                              debugPrint(
                                                  "Data is ${subscription.statusCode}");
                                              // Render UI based on the subscription data
                                              return Text(
                                                  subscription.status
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: blackColor));
                                            },
                                            loading: () {
                                              // Render a loading indicator
                                              return const CircularProgressIndicator();
                                            },
                                            error: (error, stackTrace) {
                                              // Render an error message
                                              return Text('Error: $error');
                                            },
                                          );
                                        },
                                      )
                                    : activeStep == 3
                                        ? const Center(
                                            child: Text("success"),
                                          )
                                        : Center(
                                            child: Text(
                                              activeStep.toString(),
                                              style: const TextStyle(
                                                  color: blackColor),
                                            ),
                                          ),
                      ],
                    );
                  });
                }),
              ),
            ),
          ));
    },
  );
}
