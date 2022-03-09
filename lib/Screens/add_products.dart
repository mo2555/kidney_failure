import 'package:fire_base/Providers/auth.dart';
import 'package:fire_base/Screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  int _activeStepIndex = 0;
  String questionOne = 'Q1';
  String questionTwo = 'Q2';
  String result;
  TextEditingController bureaRate = TextEditingController();
  TextEditingController scrtatRate = TextEditingController();

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Step 1'),
          content: Container(
            child: Column(
              children: [
                const Text("Do you have any chronic diseases?"),
                SizedBox(),
                Row(
                  children: [
                    Radio(
                        value: 'Yes',
                        groupValue: questionOne,
                        onChanged: (value) {
                          setState(() {
                            questionOne = value;
                          });
                        }),
                    const Text("Yes"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'No',
                        groupValue: questionOne,
                        onChanged: (value) {
                          setState(() {
                            questionOne = value;
                          });
                        }),
                    const Text("No"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
          state: _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 1,
          title: const Text('Step 2'),
          content: Container(
            child: Column(
              children: [
                const Text("Have you had kidney failure?"),
                SizedBox(),
                Row(
                  children: [
                    Radio(
                        value: 'Yes',
                        groupValue: questionTwo,
                        onChanged: (value) {
                          setState(() {
                            questionTwo = value;
                          });
                        }
                        ),
                    const Text("Yes"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: 'No',
                        groupValue: questionTwo,
                        onChanged: (value) {
                          setState(() {
                            questionTwo = value;
                          });
                        }),
                    const Text("No"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Step(
          state: StepState.complete,
          isActive: _activeStepIndex >= 2,
          title: const Text('Step 3'),
          content: Container(
            child: Column(
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: bureaRate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'B.UREA Rate',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: scrtatRate,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'S.CRTAT Rate',
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Technique for detecting kidney disease',
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black45,
      ),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _activeStepIndex,
        steps: stepList(),
        onStepContinue: () async {
          if (_activeStepIndex < (stepList().length - 1)) {
            setState(() {
              _activeStepIndex += 1;
            });
          } else {
            if((double.parse(bureaRate.text.toString())<45)&&(double.parse(scrtatRate.text.toString())<1.2))
              result = 'Negative';
            else
              result = 'Positive';
            print(result);
            SharedPreferences pre = await SharedPreferences.getInstance();
            pre.setBool('resultScreen', true);
            pre.setString('resultData', result);
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx)=>ResultScreen(
                result:result,
              ),),
            );
            print(result);
          }
        },
        onStepCancel: () {
          if (_activeStepIndex == 0) {
            return;
          }
          setState(() {
            _activeStepIndex -= 1;
          });
        },
        onStepTapped: (int index) {
          setState(() {
            _activeStepIndex = index;
          });
        },
      ),
    );
  }
}
