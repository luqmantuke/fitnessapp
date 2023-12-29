import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ommyfitness/utils/colours.dart';

class EbooksPage extends ConsumerStatefulWidget {
  const EbooksPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EbooksPageState();
}

class _EbooksPageState extends ConsumerState<EbooksPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Ebooks",
          style: TextStyle(
            color: whiteBackgroundColor,
          ),
        ),
      ),
    );
  }
}
