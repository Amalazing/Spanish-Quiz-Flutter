import 'package:quiz/utils/question.dart';

class Quiz{
  List<Question> _questions;
  int _currentQuesitonIndex = -1;
  int _score = 0;

  Quiz(this._questions){
    _questions.shuffle();
  }

  List<Question> get questions => _questions;
  int get score => _score;
  int get length => _questions.length;
  int get quesitonNumber => _currentQuesitonIndex + 1;

  Question get nextQuestion{
    _currentQuesitonIndex++;
    if (_currentQuesitonIndex >= length){
      return null;
    }else{
      return _questions[_currentQuesitonIndex];
    }
  }

  void answer(bool isCorrect){
    if (isCorrect){
      _score++;
    }
  }
}