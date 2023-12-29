import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';

Widget imageWidget(String imageUrl) {
  return FastCachedImage(
      url: imageUrl,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(seconds: 1),
      errorBuilder: (context, exception, stacktrace) {
        return Text(stacktrace.toString());
      });
}

FastCachedImageProvider fastCachedNetwrokImageProvider(String imageUrl) {
  return FastCachedImageProvider(imageUrl);
}
