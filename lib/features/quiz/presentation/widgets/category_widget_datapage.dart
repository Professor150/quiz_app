import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';

import '../page/quiz_page.dart';

class CategoryDataPage extends StatelessWidget {
  const CategoryDataPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FetchAllQuizProvider>(
      builder: (context, provider, _) {
        if (provider.apiResponseStatus == ApiResponseStatus.isLoading) {
          return const Center(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (provider.apiResponseStatus == ApiResponseStatus.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: provider.exams.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(-1, 2),
                      spreadRadius: 1,
                      blurRadius: 2,
                    )
                  ],
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          provider.exams[index].category,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      onTap: () async {
                        if (provider.apiResponseStatus ==
                            ApiResponseStatus.hasData) {
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuizScreen(
                                exams: provider.exams,
                                category: provider.exams[index].category,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Data is still loading. Please wait...'),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        } else if (provider.apiResponseStatus == ApiResponseStatus.hasError) {
          return Center(
            // child: AlertDialog(
            //   title: const Text('No Internet Connections'),
            //   content: const Text('Connect Internet'),
            //   scrollable: true,
            //   alignment: Alignment.center,
            //   actions: [
            //     const SizedBox(
            //       height: 10,
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, Routes().category);
            //       },
            //       child: const Text('Restart'),
            //     ),
            //     const CircularProgressIndicator(),
            //   ],
            // ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text('No Internet Connection'),
                InkWell(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, Routes().splashScreen),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(15), // 15
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple.shade200,
                            Colors.blue,
                          ],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: const Text(
                        "Restart",
                        style: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
