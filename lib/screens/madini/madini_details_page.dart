import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/models/madini/madini_models.dart';
import 'package:ommyfitness/providers/shared_preferences/shared_preferences_provider.dart';
import 'package:ommyfitness/utils/colours.dart';
import 'package:ommyfitness/utils/routes.dart';

class MadiniDetailsPage extends ConsumerStatefulWidget {
  final MadiniModelData madiniModelData;
  const MadiniDetailsPage({super.key, required this.madiniModelData});

  @override
  ConsumerState<MadiniDetailsPage> createState() => _MadiniDetailsPageState();
}

class _MadiniDetailsPageState extends ConsumerState<MadiniDetailsPage> {
  @override
  void initState() {
    ref.read(sharedPreferenceInstanceProvider);
    ref.read(isLoggedInProvider);
    ref.read(userNameProvider);
    ref.read(tokenProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = ref.watch(isLoggedInProvider);

    /// sanitize or query document here
    Widget html = Html(
      data: widget.madiniModelData.content,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: isLoggedIn.maybeWhen(
        orElse: () => const SizedBox(),
        data: (data) => data == false
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      goRouter.goNamed('signIn');
                    },
                    child: Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 18,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: redColor),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          "Login To Continue",
                          style: TextStyle(
                            color: blackColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : SingleChildScrollView(child: html),
      ),
    );
  }
}
