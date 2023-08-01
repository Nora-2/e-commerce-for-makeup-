import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_ecommerce/Model/GetX/Controller/duplicate_controller.dart';
import 'package:flutter_application_ecommerce/Model/GetX/Controller/home_controller.dart';
import 'package:flutter_application_ecommerce/Model/GetX/Controller/profile_controller.dart';
import 'package:flutter_application_ecommerce/Model/Tools/Color/color.dart';
import 'package:flutter_application_ecommerce/Model/Tools/Constant/const.dart';
import 'package:flutter_application_ecommerce/Model/Tools/Font/font.dart';
import 'package:flutter_application_ecommerce/Model/Tools/JsonParse/product_parse.dart';
import 'package:flutter_application_ecommerce/Model/Widget/widget.dart';
import 'package:flutter_application_ecommerce/View/HomeScreen/SerachScreen/serach_screen.dart';
import 'package:flutter_application_ecommerce/View/HomeScreen/ShopScreen/shop_screen.dart';
import 'package:flutter_application_ecommerce/chat_gpt/chatgpt.dart';
// import 'package:flutter_application_ecommerce/screens/chat_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeBloc? homeBloc;

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final duplicateController = Get.find<DuplicateController>();
  final homeController = Get.find<HomeController>();
  final getContext = Get.context!;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: duplicateController.colors.whiteColor));
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(homeRepository: homeController.homeRepository);
        bloc.add(HomeStart());
        homeBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final CustomColors colors = duplicateController.colors;
          final CustomTextStyle textStyle = duplicateController.textStyle;
          final ScrollPhysics physics =
              duplicateController.uiDuplicate.defaultScroll;
          if (state is HomeLoading) {
            return const CustomLoading();
          } else if (state is HomeSuccess) {
            final List<ProductEntity> productList = state.productList;
            final profileFunctions =
                Get.find<ProfileController>().profileFunctions;
            return Scaffold(
              backgroundColor: colors.blackColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: colors.blackColor,
                centerTitle: true,
                title: Text(
                  "Store",
                  style: TextStyle(
                    fontSize: 35.0,
                    color: colors.whiteColor,
                    fontFamily: 'Pacifico',
                  ),
                ),
                actions: [
                  CupertinoButton(
                    child: Icon(
                      Icons.search,
                      color: colors.whiteColor,
                    ),
                    onPressed: () {
                      Get.to(const SearchScreen());
                    },
                  ),
                  CupertinoButton(
                    child: Icon(
                      Icons.chat,
                      color: colors.whiteColor,
                    ),
                    onPressed: () {
                      Get.to(const ChatBotWidget(title: 'ChatBot'));
                    },
                  )
                ],
              ),
              body: duplicateContainer(
                colors: colors,
                child: ListView.builder(
                  physics: physics,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 1:
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Find the perfect watch for your wrist",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: Colors.black,
                                  fontFamily: 'Pacifico',
                                ),
                              )
                            ],
                          ),
                        );

                      case 2:
                        return BannerListView(
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Top deals",
                                  productList: productList));
                            },
                            produtList: productList,
                            colors: colors,
                            textStyle: textStyle);
                      case 3:
                        return ProductListView(
                            colors: colors,
                            profileFunctions: profileFunctions,
                            reverse: false,
                            physics: physics,
                            textStyle: textStyle,
                            productList: productList,
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Latest", productList: productList));
                            },
                            title: "Latest");
                      case 4:
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [Text('New Featuers',style: TextStyle(
                                            color: colors.primary,
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Pacifico',
                                          ),)],
                          ),
                        );
                      case 5:
                        return gridViewScreensContainer(
                          colors: colors,
                          child: ProductGrideView(
                              productList: productList,
                              uiDuplicate: duplicateController.uiDuplicate,
                              colors: colors,
                              textStyle: textStyle),
                        );
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            );
          } else if (state is HomeError) {
            return AppException(
              callback: () {
                homeBloc!.add(HomeStart());
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
