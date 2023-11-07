import 'package:flutter/material.dart';
import '../../../controller/langs.dart';
import '../../../util/helper/dirction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../util/helper/media_query.dart';
import '../../../util/helper/navigation.dart';
import '../../../controller/policy_terms.dart';

class PolicyScreen extends StatelessWidget {
  static const String routeName = 'policy';

  const PolicyScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PolicyAndTermsController policyAndTermsController =
        context.read<PolicyAndTermsController>();
    LangsController langsController = context.watch<LangsController>();

    return Directionality(
      textDirection: getDirction(langsController.lang),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.goBack(),
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: SizedBox(
            child: Text(
              langsController.langs[langsController.lang ?? 'ar']!['policy']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: FutureBuilder(
          future: policyAndTermsController.getPolicy(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  vertical: context.getHeight() / 40,
                  horizontal: context.getWidth() / 30,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    snapshot.data!.data()!['link'],
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            } else {
              return const Text('حدث خطأ');
            }
          },
        ),
      ),
    );
  }
}
