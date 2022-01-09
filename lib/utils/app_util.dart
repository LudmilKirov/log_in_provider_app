import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:log_in_provider/res/images/images.dart';
import 'package:log_in_provider/res/strings/str_keys.dart';

class AppUtil {
  static Widget buildMainImage(String image) {
    return image.isEmpty
        ? _offlineImage()
        : CachedNetworkImage(
            imageUrl: image,
            height: _imageHeight,
            width: _imageWidth,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(child: Text(StrKey.loadingImageLabel.tr)),
            errorWidget: (context, url, error) => _offlineImage(),
          );
  }

  static Image _offlineImage() {
    return Image.asset(
      Img.imgNotAvailable,
      height: _imageHeight,
      width: _imageWidth,
      fit: BoxFit.fill,
    );
  }
}

const double _imageHeight = 80;
const double _imageWidth = 80;
