import 'package:flutter/material.dart';

import '../utils/question.dart';
import '../utils/quiz.dart';

import '../UI/answer_button.dart';
import '../UI/question_text.dart';
import '../UI/correct_wrong_overlay.dart';

import './score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Si means Yes", true),
    new Question("Vez means Time", true),
    new Question("Ano means day", false),
    new Question("Cosa means Thing", true),
    new Question("Hombre means Women", false),
    new Question("Vida means Grow", false),
    new Question("Ser means To Be", true),
    new Question("Ir means To Go", true),
    new Question("Tener means To Want", false),
    new Question("Querer means To have", false),
    new Question("Entender means To Understand", true),
    new Question("Hablar means To Speak", true),
    new Question("Aqua means Juice", false),
    new Question("comida means funny", false),
    new Question("Lugar means Place", true),
    new Question("Escuela means School", true),
    new Question("casa means hospital", false),
    new Question("Trabajo means house", false),
    new Question("Palabra means Word", true),
    new Question("deporte means Sport", true),
    new Question("Vivir means To Die", false),
    new Question("Amar means To Walk", false),
    new Question("Preguntar means To Ask", true),
    new Question("Pensar means To Think", true),
    new Question("Malo means No", false),
    new Question("Bueno means Jacket", false),
  ]);
  String quesitonText;
  int quesitonNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    quesitonText = currentQuestion.question;
    quesitonNumber = quiz.quesitonNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(children: <Widget>[
          new AnswerButton(
              true,
              () => {
                    handleAnswer(true),
                  }),
          new QuesitonText(quesitonText, quesitonNumber),
          new AnswerButton(
              false,
              () => {
                    handleAnswer(false),
                  }),
        ]),
        overlayShouldBeVisible == true
            ? new CorrectWrongOverlay(isCorrect, () {
                if (quiz.length == quesitonNumber) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  quesitonText = currentQuestion.question;
                  quesitonNumber = quiz.quesitonNumber;
                });
              })
            : new Container(),
      ],
    );
  }
}
