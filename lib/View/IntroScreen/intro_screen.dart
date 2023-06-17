import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ecommerce/Model/GetX/Controller/duplicate_controller.dart';
import 'package:flutter_application_ecommerce/Model/Tools/Color/color.dart';
import 'package:flutter_application_ecommerce/Model/Tools/Constant/const.dart';
import 'package:flutter_application_ecommerce/View/RootScreen/root.dart';
import 'package:flutter_application_ecommerce/ViewModel/Intro/intro.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final duplicateController = Get.find<DuplicateController>();
  late CustomColors colors = duplicateController.colors;
  late List<ContentConfig> contentList = [
    ContentConfig(
        backgroundColor: Colors.white,
        title: "E-commerce ",
        styleDescription: TextStyle(fontFamily:"Pacifico",color: colors.primary),
        description:
               'electronic commerce allows consumers to directly buy\n  goods or services from a seller over the Internet\n using a mobile ..',
          pathImage: manImage),
    ContentConfig(
        backgroundColor: Colors.white,
        title: "E-commerce ",
         styleDescription: TextStyle(fontFamily:"Pacifico",color: colors.primary),
        description:
               'Check out our fast delivery selection for the\n very best in unique or custom, handmade\n pieces from our shops ..',
           pathImage: aboutImage),
    ContentConfig(
        backgroundColor: Colors.white,
        title: "E-commerce ",
         styleDescription: TextStyle(fontFamily:"Pacifico",color: colors.primary),
        description:
           'We are a payment platform with +240\n payment solutions & fraud prevention', pathImage: contentImage)
  ];
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(systemNavigationBarColor: colors.primary));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    IntroFunctions splashFunctions = duplicateController.introFunctions;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IntroSlider(
              renderNextBtn: Container(
                alignment: Alignment.center,
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                    color: colors.whiteColor, borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  CupertinoIcons.right_chevron,
                  color: colors.primary,
                ),
              ),
              renderSkipBtn: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                      color: colors.whiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    color: colors.primary,
                  )),
              renderDoneBtn: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                      color: colors.whiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                  Icons.keyboard_double_arrow_right,
                    color: colors.primary,
                  )),
              listContentConfig: contentList,
              onDonePress: () async {
                await splashFunctions.saveLaunchStatus(status: false);
                Navigator.pop(Get.context!);
                Get.to(const RootScreen(
                  index: 0,
                ));
              },
              onSkipPress: () async {
                await splashFunctions.saveLaunchStatus(status: false);
                Navigator.pop(Get.context!);
                Get.to(const RootScreen(
                  index: 0,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}


