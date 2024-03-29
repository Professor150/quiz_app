import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/core/utils/constants/images.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/category_widget_datapage.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/category_widget_didchange_dependency.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quizapp_bg_gradinant.dart';

class CategoryScreen extends StatefulWidget {
  final List<ExamModel> exams;
  const CategoryScreen({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final dataFetcher = QuizDataFetcher(context);
    dataFetcher.fetchQuizData();
    _quizProvider = Provider.of<FetchAllQuizProvider>(context);
    if (_quizProvider.exams.isEmpty) {
      await _fetchQuizData();
    }
  }

  Future<void> _fetchQuizData() async {
    try {
      await _quizProvider.getQuiz();
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('Topic'),
        centerTitle: true,
        leading: const Text(''),
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: mediaQuery.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.linearToSrgbGamma(),
                      image: AssetImage('assets/images/aone.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   top: 175,
                //   left: 10,
                //   right: 10,
                //   bottom: 0,
                //   child: GestureDetector(
                //     onTap: () {
                //       print('data is coming');
                //       Navigator.pushReplacementNamed(
                //           context, Routes().quizScreen);
                //     },
                //     child: Container(
                //       decoration: const BoxDecoration(
                //         borderRadius: BorderRadius.only(
                //             topLeft: Radius.circular(10),
                //             topRight: Radius.circular(10)),
                //         color: Colors.white70,
                //       ),
                //       child: Row(
                //         children: [
                //           Padding(
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 10, vertical: 5),
                //             child: Column(
                //               children: [
                //                 const Text(
                //                   'Recent Added',
                //                   style: TextStyle(letterSpacing: 1.3),
                //                 ),
                //                 SizedBox(
                //                   height: mediaQuery.height * 0.02,
                //                   width: mediaQuery.width * 0.02,
                //                 ),
                //                 ClipRRect(
                //                   borderRadius: BorderRadius.circular(10),
                //                   child: Image.asset(
                //                     scienceImages,
                //                     fit: BoxFit.cover,
                //                     width: mediaQuery.width * 0.22,
                //                     height: mediaQuery.height * 0.08,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           SizedBox(
                //             width: mediaQuery.width * 0.03,
                //           ),
                //           Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               const Text(
                //                 'Science',
                //                 style: TextStyle(
                //                     fontSize: 20, fontWeight: FontWeight.w400),
                //               ),
                //               SizedBox(
                //                 height: mediaQuery.height * 0.015,
                //               ),
                //               Text(
                //                 'Added ${_quizProvider.exams.length} New Questions',
                //                 style: TextStyle(
                //                     fontSize: 16, fontWeight: FontWeight.w400),
                //               ),
                //             ],
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            const Text(
              'Topic',
              style: TextStyle(fontSize: 22, letterSpacing: 1.3),
            ),
            Text(
              _quizProvider.exams.length.toString(),
              style: TextStyle(fontSize: 22),
            ),
            Container(
              child: Consumer<FetchAllQuizProvider>(
                  builder: (context, provider, _) {
                switch (provider.apiResponseStatus) {
                  case ApiResponseStatus.isLoading:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ApiResponseStatus.hasData:
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: provider.exams.length,
                      itemBuilder: (context, index) {
                        final category =
                            'Category ${provider.exams[index].category}';
                        return Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(-1, 2),
                                spreadRadius: 2,
                                blurRadius: 6,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    child: Text(
                                      provider.exams[index].category,
                                      style: const TextStyle(fontSize: 18),
                                    )),
                                onTap: () async {
                                  await Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => QuizScreen(
                                            exams: provider.exams,
                                            category:
                                                provider.exams[index].category),
                                      ));
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );

                  case ApiResponseStatus.hasError:
                    return Center(
                      child: Text(provider.errorMessage!),
                    );
                  default:
                    return Container();
                }
              }),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: QuizBackGroundColor(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CategoryDataPage(),
            ],
          ),
        ),
      )
    );
  }
}
