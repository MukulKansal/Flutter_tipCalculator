import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  const BillSplitter({Key? key}) : super(key: key);

  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {

  int tipPercentage = 0;
  int personCounter = 1;
  double billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.all(20),
          children: <Widget>[
            Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: BorderRadius.circular(18.5)
            ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Total per Person", style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.normal,
                        fontSize: 25),),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text("\$ ${calculateTotalPerPerson(billAmount, personCounter, tipPercentage)}",style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),),
                    )
                  ],
                ),
              ),
        ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.blueGrey.shade100
                )
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                    decoration: InputDecoration(
                      prefixText: "Bill Amount  ",
                      prefixIcon: Icon(Icons.attach_money)
                    ),
                    onChanged: (String value){
                        try{
                          billAmount = double.parse(value);
                        }catch(exception){
                          billAmount = 0.0;
                        }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Split",style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),),
                      Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                if(personCounter>1){
                                  personCounter-- ;
                                }else {
                                  // nothing
                                }
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.purple.shade200
                              ),
                              child: Center(
                                child: Text(
                                  "-" , style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                                ),
                                ),
                              ),
                            ),
                          ),
                          Text("$personCounter", style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                          InkWell(
                            onTap: (){
                              setState(() {
                                personCounter++;
                              });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  color: Colors.purple.shade200
                            ),
                              child: Center(
                                child: Text(
                                  "+" , style: TextStyle(
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25
                                ),
                                ),
                              ),
                          )
                          ),


                        ],
                      ),
                    ],
                  ),
                  // Tip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Tip" , style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Text("\$ ${calculateTotalTip(billAmount,
                            personCounter, tipPercentage)}",style: TextStyle(
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.bold,
                            fontSize: 25)
                        ),
                      )],
                  ),
                  Column(
                    // For Slider
                    children: [
                      Text("$tipPercentage%", style: TextStyle(
                          color: Colors.blue.shade900,
                          fontWeight: FontWeight.bold,
                          fontSize: 25),),
                      
                      Slider(
                          min: 0,
                          max: 100,
                          divisions: 20,
                          activeColor: Colors.blue.shade700,
                          inactiveColor: Colors.grey,
                          value: tipPercentage.toDouble(),
                          onChanged: (double newValue){
                            setState(() {
                              tipPercentage = newValue.round();
                            });
                          })
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

  calculateTotalPerPerson(double billAmount, int splitBy ,int tipPercentage){

    var totalPerPerson = (calculateTotalTip(billAmount, splitBy, tipPercentage) + billAmount) / splitBy;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip(double billAmount, int splitBy ,int tipPercentage){

    double totalTip = 0.0;
    if(billAmount<0 || billAmount.toString().isEmpty){
      // no go!!!
    }else{
      totalTip = (billAmount * tipPercentage)/100;
    }
      return totalTip;
  }
}
