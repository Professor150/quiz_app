class Quiz {
  final int responseCode;
  final List<Question> questions;

  Quiz({required this.responseCode, required this.questions});

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      responseCode: json['response_code'],
      questions: List<Question>.from(json['results'].map((result) => Question.fromJson(result))),
    );
  }
}

class Question {
  final String category;
  final String type;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question({
    required this.category,
    required this.type,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      category: json['category'],
      type: json['type'],
      difficulty: json['difficulty'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      incorrectAnswers: List<String>.from(json['incorrect_answers']),
    );
  }
}
