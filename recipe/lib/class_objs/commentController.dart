

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Comment_Controller extends GetxController {
  RxMap commentsMap = {}.obs;
  
  void addComment(String imageUrlOrId, String comment) {
    if (commentsMap.containsKey(imageUrlOrId)) {
      commentsMap[imageUrlOrId]!.add(comment);
    } else {
      commentsMap[imageUrlOrId] = [comment];
    }
  }
}

