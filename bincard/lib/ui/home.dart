// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:bincard/model/movie.dart';
import 'package:bincard/model/question.dart';

import 'package:flutter/material.dart';

import 'movie_ui.dart';

class MovieList extends StatelessWidget {
  final List<Movie> moviesList = Movie.getMovies();

  MovieList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade700,
        title: Text("Movies List"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blueGrey.shade300,
      body: ListView.builder(
        itemCount: moviesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Stack(children: <Widget>[
            Positioned(child: moviesCard(moviesList[index], context)),
            Positioned(
                left: 10.0,
                top: 10.0,
                child: movieImage(moviesList[index].images[0])),
          ]);

          // return Card(
          //   elevation: 4.5,
          //   color: Colors.white,
          //   child: ListTile(
          //     leading: CircleAvatar(
          //       child: Container(
          //         decoration: BoxDecoration(
          //           color: Colors.blue,
          //           borderRadius: BorderRadius.circular(13.7),
          //           image: DecorationImage(
          //               image: NetworkImage(moviesList[index].images[0]),
          //               fit: BoxFit.cover),
          //         ),
          //         // child: Text("H"),
          //       ),
          //     ),
          //     title: Text(moviesList[index].title),
          //     subtitle: Text(mList[index]["Language"]),
          //     trailing: Text("....."),
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) => MoviesListViewDetail(
          //                     moviesName: moviesList[index].title,
          //                     movie: moviesList[index],
          //                   )));
          //     },
          //     // onTap: () =>
          //     // debugPrint("Movies Name : ${movies.elementAt(index)}"),
          //   ),
          // );
        },
      ),
    );
  }

  Widget moviesCard(Movie movie, BuildContext context) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.only(left: 60.0),
          width: MediaQuery.of(context).size.width,
          height: 120,
          child: Card(
            color: Colors.black45,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 54.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          movie.title,
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Text("Rating : ${movie.imdbRating} /10 ",
                          style: TextStyle(fontSize: 15.0, color: Colors.grey)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Release : ${movie.released}",
                          style: mainTextStyle()),
                      Text(movie.runtime, style: mainTextStyle()),
                      Text(movie.rated, style: mainTextStyle()),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MoviesListViewDetail(
                        moviesName: movie.title,
                        movie: movie,
                      )),
            ));
  }

  TextStyle mainTextStyle() {
    return TextStyle(fontSize: 13.0, color: Colors.grey);
  }

  Widget movieImage(String imgUrl) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
      ),
    );
  }
}

//New Route

class MoviesListViewDetail extends StatelessWidget {
  final String moviesName;
  final Movie movie;

  const MoviesListViewDetail(
      {Key? key, required this.moviesName, required this.movie})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent.shade700,
        // ignore: unnecessary_this
        title: Text("Movies ${this.moviesName}"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          MovieDetailThumbnail(thumbnail: movie.images[1]),
          MovieDetailHeaderWithPoster(movie: movie),
          HorizontalLine(),
          MovieDetailCast(
            movie: movie,
          ),
          HorizontalLine(),
          MovieDetailExtraPoster(
            poster: movie.images,
          )
        ],
      ),
      // body: Center(
      //   child: Container(
      //     // ignore: missing_required_param
      //     child: RaisedButton(
      //       child: Text("Go Back"),
      //       onPressed: () => Navigator.pop(context),
      //     ),
      //   ),
      // ),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentQIndex = 0;
  List questionBank = [
    // "The US declaration of indenpandanc was adopted in 1993",
    // "The US declaration of indenpandanc was adopted in 222"
    Question.name(
        "The US declaration of indenpandanc was adopted in 1993", true),
    Question.name(
        "The US declaration of indenpandanc was adopted in 333", false),
    Question.name("The US declaration of indenpandanc was adopted in 33", true),
    Question.name(
        "The US declaration of indenpandanc was adopted in 22", false),
    Question.name(
        "The US declaration of indenpandanc was adopted in 5555", false)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("True Citizen"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "images/flag.png",
                width: 250,
                height: 180,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.0),
                    border: Border.all(
                        color: Colors.blueGrey.shade400,
                        style: BorderStyle.solid)),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(questionBank[currentQIndex].questionText),
                )),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () => _checkAnswer(true), child: Text("TRUE")),
                ElevatedButton(
                    onPressed: () => _checkAnswer(false), child: Text("FALSE")),
                OutlinedButton(
                    onPressed: () => _nextQuestion(),
                    child: Icon(Icons.arrow_forward))
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  _checkAnswer(bool userChoice) {
    if (userChoice == questionBank[currentQIndex].isCorrect) {
      debugPrint("Answer is Ture");
      var snapbar = SnackBar(
        content: Text("Answer is true!"),
        backgroundColor: Colors.lightBlue,
      );
      ScaffoldMessenger.of(context).showSnackBar(snapbar);
    } else {
      debugPrint("Answer is False");
      var snapbar = SnackBar(
        content: Text("Answer is False!"),
        backgroundColor: Colors.black,
      );
      ScaffoldMessenger.of(context).showSnackBar(snapbar);
    }
  }

  _nextQuestion() {
    setState(() {
      // debugPrint(questionBank.length.toString());
      if (currentQIndex == questionBank.length - 1) {
        debugPrint("Finished");
      } else {
        currentQIndex++;
      }
    });
  }
}

class BinCard extends StatelessWidget {
  const BinCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BinCard'),
      ),
      // body

      body: Container(
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [_getCard(), _getAvatar()],
        ),
      ),
    );
  }

  Container _getCard() {
    return Container(
      width: 350,
      height: 200,
      margin: EdgeInsets.all(40.0),
      decoration: BoxDecoration(
          color: Colors.pinkAccent, borderRadius: BorderRadius.circular(4.5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Mr Phyo"),
          const Text("mgpyaephyowin.1571993mm@gmail.com"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Icon(Icons.person_outline), Text("google.com")],
          )
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          border: Border.all(color: Colors.redAccent, width: 1.4),
          image: DecorationImage(
            image: NetworkImage("https://picsum.photos/id/237/300/300"),
            fit: BoxFit.cover,
          ),
        ));
  }
}

class BillSpliter extends StatefulWidget {
  const BillSpliter({Key? key}) : super(key: key);

  @override
  _BillSpliterState createState() => _BillSpliterState();
}

class _BillSpliterState extends State<BillSpliter> {
  int _tipPer = 0;
  double _billAmount = 0.0;
  int _personCount = 1;
  // Color _purple = HexColor("#6908d6");
  final Color _purple = Color(0xff6908d6);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20.5),
          children: [
            Container(
              width: 150.0,
              height: 200.0,
              decoration: BoxDecoration(
                  color:
                      _purple.withOpacity(0.3), //Colors.purpleAccent.shade100,
                  borderRadius: BorderRadius.circular(12.6)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total Per Person"),
                    Text(
                        "\$ ${caculateTotalPerson(_billAmount, _personCount, _tipPer)}"),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: Colors.blueGrey.shade500,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(12.0)),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                        prefixText: "Bill Amount",
                        prefixIcon: Icon(Icons.attach_money)),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (e) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Split",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCount > 1) {
                                  _personCount--;
                                } else {
                                  //do nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                    color: _purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCount",
                            style: TextStyle(
                              color: _purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _personCount++;
                              });
                            },
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: _purple.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(7.0),
                              ),
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: _purple,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tips",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                          "\$ ${caculateTotalTip(_billAmount, _personCount, _tipPer)}")
                    ],
                  ),
                  Column(
                    children: [
                      Text("$_tipPer%",
                          style: TextStyle(
                            color: _purple,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Slider(
                          min: 0,
                          max: 100,
                          activeColor: Colors.redAccent.shade400,
                          divisions: 20,
                          inactiveColor: Colors.blueAccent.shade200,
                          value: _tipPer.toDouble(),
                          onChanged: (double valu) {
                            setState(() {
                              _tipPer = valu.round();
                            });
                          }),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  caculateTotalPerson(double totalTip, int splitBy, int tipPer) {
    var totalPerPerson = caculateTotalTip(_billAmount, _personCount, _tipPer) +
        _billAmount / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  caculateTotalTip(double billAmount, int splitBy, int tipPer) {
    double totalTip = 0.0;
    if (billAmount < 0 || billAmount.toString().isEmpty) {
      // no go

    } else {
      // go
      totalTip = (billAmount * tipPer) / 100;
    }

    return totalTip;
  }
}
