import 'package:fire_base/Providers/auth.dart';
import 'package:fire_base/Screens/add_products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreen extends StatefulWidget {
  final String result;

  ResultScreen({this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List lifeStyleImprovementSteps = [
    'Reducing alcohol consumption to a minimum.',
    'Eat as little protein and salt as possible.',
    'Taking appropriate medications in case of some diseases, such as diabetes and blood pressure.',
    'Stop smoking.',
    'Maintain a healthy weight.',
    'Avoid taking some medications that increase kidney toxicity.',
  ];

  List pharmacologicalTreatmentsSteps = [
    'Angiotensin converting enzyme inhibitors and angiotensin II receptor blockers (ARB).',
    'Treatments to lower cholesterol.',
    'Treatments to raise the level of hemoglobin and treat anemia.',
    'Treatments to strengthen the bones.',
    'Treatments to get rid of edema.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Result"),
        elevation: 0,
        backgroundColor: Colors.black45,
        centerTitle: true,
      ),
      body: widget.result.compareTo('Negative') == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "Congratulation your result is Negative",
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                        child: Text("Retest"),
                        onPressed: () async {
                          SharedPreferences pre =
                              await SharedPreferences.getInstance();
                          pre.setBool('resultScreen', false);
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (ctx) => AddProduct()),
                          );
                          print(widget.result);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8.0),
                        color: Colors.black45,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        "We are sorry, but your result is Positive",
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        '''Please follow this tips to get good health :''',
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: lifeStyleImprovementSteps.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              color: Color.fromRGBO(255, 238, 219, 1),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  "${index + 1} - ${lifeStyleImprovementSteps[index]}",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Text(
                        '''And take this pharmacological treatments :''',
                        softWrap: true,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: pharmacologicalTreatmentsSteps.length,
                          itemBuilder: (ctx, index) {
                            return Card(
                              color: Color.fromRGBO(255, 238, 219, 1),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                child: Text(
                                  "${index + 1} - ${pharmacologicalTreatmentsSteps[index]}",
                                  style: TextStyle(color: Colors.black),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          child: Text("Retest"),
                          onPressed: () async {
                            SharedPreferences pre =
                                await SharedPreferences.getInstance();
                            pre.setBool('resultScreen', false);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (ctx) => AddProduct()),
                            );
                            print(widget.result);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 8.0),
                          color: Colors.black45,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}
