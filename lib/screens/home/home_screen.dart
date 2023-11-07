import 'package:flutter/material.dart';
import '../../controller/langs.dart';
import '../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../contact_methods/screens/sms.dart';
import 'widgets/contact_item.dart';
import 'widgets/my_drawer.dart';
import '../whatsapp/screens/whatsapp_screen.dart';
import 'package:whatsapp_marketing/util/helper/media_query.dart';
import 'package:whatsapp_marketing/util/helper/navigation.dart';

import '../../controller/banar_controller.dart';
import '../../util/helper/url_launcher.dart';
import '../imported_messages/imported_messages.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool end = false;
  @override
  void initState() {
    super.initState();
    // setlang();
    Future.delayed(
      Duration.zero,
      () {
        context.read<LangsController>().setlang();
      },
    );

    Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (mounted) {
        if (context.read<BannarController>().banners != null) {
          if (context.read<BannarController>().id + 1 ==
              context.read<BannarController>().banners!.docs.length) {
            end = true;
          } else if (context.read<BannarController>().id == 0) {
            end = false;
          }
          if (context.read<BannarController>().banners!.docs.isNotEmpty) {
            if (end == false) {
              context.read<BannarController>().id++;
            } else {
              context.read<BannarController>().id--;
            }

            context.read<BannarController>().pageController.animateToPage(
                  context.read<BannarController>().id,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.watch<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          width: context.getWidth() * (2 / 3),
          backgroundColor:
              const Color(0xff070707).withAlpha(5).withOpacity(0.5),
          child: const MyDrawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            onTap: () => _key.currentState!.openDrawer(),
            child: Image.asset('assets/menu.png'),
          ),
          title: Text(
            langsController.langs[langsController.lang ?? 'ar']!['homeTitle']!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () =>
                    context.goToNamed(ImportedMessagesScreen.routeName),
                icon: Image.asset('assets/noti.png'))
          ],
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(
            top: 25,
            left: 25,
            right: 25,
          ),
          children: [
            SizedBox(
              height: 170,
              child: FutureBuilder(
                future: context.read<BannarController>().getBannars(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        'فشل تحميل الصور من فضلك اعد تشغيل مرة اخري');
                  }
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              controller: context
                                  .watch<BannarController>()
                                  .pageController,
                              onPageChanged: context
                                  .read<BannarController>()
                                  .onPageChanged,
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      snapshot.data!.docs[index]['imageLink'],
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Text(
                                            'Can\'t load this banner');
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 10,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MyDot(index: index);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(width: 2),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Text('لا توجد اي صور مروفوعه');
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(width: double.infinity),
            ContactItem(
              text: langsController.langs[langsController.lang ?? 'ar']!['whatsapp']!,
              icon: Image.asset('assets/whatsapp.png'),
              onPressed: () => context.goToNamed(WhatsappScreen.routeName),
            ),
            ContactItem(
              text: langsController.langs[langsController.lang ?? 'ar']!['whatsapp_biss']!,
              icon: Image.asset('assets/whatsapp-b.png'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WhatsappScreen(tag: 'B'),)
              ),  
            ),
            ContactItem(
              text:
                  langsController.langs[langsController.lang ?? 'ar']!['sms']!,
              icon: Image.asset('assets/sms.png'),
              onPressed: () => context.goToNamed(SMSScreen.routeName),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              context
                  .watch<LangsController>()
                  .langs[langsController.lang ?? 'ar']!['ad']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 150,
              child: FutureBuilder(
                future:
                    context.read<YoutubeLinksController>().getYouTubeLinks(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text(
                        'فشل تحميل الفيديوهات من فضلك اعد تشغيل مرة اخري');
                  }
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return IconButton(
                            onPressed: () {
                              myLaunchUrl(
                                  '${snapshot.data!.docs[index]['bjh']}');
                            },
                            icon: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                "http://i3.ytimg.com/vi/${snapshot.data!.docs[index]['bjh'].toString().replaceAll('https://www.youtube.com/watch?v=', '')}/hqdefault.jpg",
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Text('Can\'t load this banner');
                                },
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('لا توجد اي صور مروفوعه');
                    }
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyDot extends StatelessWidget {
  const MyDot({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    bool isSelected = index == context.watch<BannarController>().id;
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 300,
      ),
      width: isSelected ? 25 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: isSelected ? Colors.blueAccent : Colors.yellow,
      ),
    );
  }
}
