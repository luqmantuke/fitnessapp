import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGridView extends StatelessWidget {
  const ShimmerGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: const Color.fromARGB(255, 160, 156, 156),
        highlightColor: Colors.grey.shade100,
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 16 / 10,
            crossAxisCount:
                ResponsiveValue(context, defaultValue: 2, valueWhen: [
                      const Condition.largerThan(name: TABLET, value: 4),
                      const Condition.largerThan(name: MOBILE, value: 3),
                      const Condition.smallerThan(name: TABLET, value: 2),
                    ]).value ??
                    2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {},
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 15),
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 160, 156, 156),
                      borderRadius: BorderRadius.circular(5))),
            );
          },
        ));
  }
}
