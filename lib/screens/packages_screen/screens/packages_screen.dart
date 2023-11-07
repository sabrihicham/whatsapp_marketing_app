import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:provider/provider.dart';
import '../package_item.dart';
import '../../../util/helper/navigation.dart';

import '../../../controller/packages_controller.dart';

class PackagesScreen extends StatelessWidget {
  static String routeName = 'packages_screen';

  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LangsController langsController = context.read<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(langsController
              .langs[langsController.lang ?? 'ar']!['add_plan']!),
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  langsController
                      .langs[langsController.lang ?? 'ar']!['currunt_plans']!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                height: 350,
                child: FutureBuilder(
                    future: context.read<PackagesController>().getPackages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text(
                            "لقد حدث خطأ غير متوقع الرجاء المحاولة مرة أخري",
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PackageItem(
                              index: index,
                              type: snapshot.data!.docs[index]['packageName'],
                              details: snapshot.data!.docs[index]['details'],
                              price: snapshot.data!.docs[index]['price'],
                            );
                          },
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
