import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/page/quiz_page.dart';

class CategoryScreen extends StatefulWidget {
  final List<ExamModel> exams;
  const CategoryScreen({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late FetchAllQuizProvider _quizProvider;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _quizProvider = Provider.of<FetchAllQuizProvider>(context, listen: false);

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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery.height * 0.05,
            ),
            // Container(
            //   height: mediaQuery.height * 0.35,
            //   width: double.infinity,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       colorFilter: ColorFilter.linearToSrgbGamma(),
            //       image: AssetImage('assets/images/aone.jpg'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
                  if (provider.apiResponseStatus ==
                      ApiResponseStatus.isLoading) {
                    return const Center(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else if (provider.apiResponseStatus ==
                      ApiResponseStatus.hasData) {
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
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
                                          category:
                                              provider.exams[index].category,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Data is still loading. Please wait...'),
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
                  } else if (provider.apiResponseStatus ==
                      ApiResponseStatus.hasError) {
                    return Center(
                      child: Text(provider.errorMessage!),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
