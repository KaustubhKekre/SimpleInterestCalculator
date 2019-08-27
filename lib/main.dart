import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.indigo,
      brightness: Brightness.dark,
      accentColor: Colors.indigoAccent,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
      ),
      body: SIForm(),
    ),
    title: "Simple Interest Calculator App",
  ));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupees', 'Dollars', 'Pounds'];
  final _padding = 5.0;
  var _current = 'Rupees';
  var displa = '';
  var _formKey=GlobalKey<FormState>();

  TextEditingController principal = TextEditingController();
  TextEditingController roi = TextEditingController();
  TextEditingController term = TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Form(
      key:_formKey,
      //margin: EdgeInsets.all(_padding * 2.0),
      child: Padding(
          padding: EdgeInsets.all(_padding * 2),
          child: ListView(
            children: <Widget>[
              Center(
                child: getImageAsset(),
              ),
              Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: TextFormField(
                    controller: principal,
                    style: textStyle,
                    validator: (  String value){
                      if (value.isEmpty)
                        {
                          return "Please enter principal amount";
                        }
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15),
                        labelText: 'Principal',
                        labelStyle: textStyle,
                        hintText: 'Enter Principal e.g. 1000',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: TextFormField(
                    controller: roi,
                    validator: (String value){
                      if(value.isEmpty)
                        {
                          return "Please enter rate of interest";
                        }
                    },
                    style: textStyle,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15),
                        labelText: 'Rate of interest',
                        hintText: 'in percent',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  )),
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: _padding, bottom: _padding, right: _padding),
                          child: TextFormField(
                            controller: term,
                            validator: (String value){
                              if(value.isEmpty)
                                {
                                  return "Please enter term";
                                }
                            },

                            style: textStyle,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Term',
                                errorStyle: TextStyle(color: Colors.yellowAccent,fontSize: 15),
                                labelStyle: textStyle,
                                hintText: 'Term in years',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                )),
                          ))),
                  Expanded(
                      child: DropdownButton<String>(
                    items: _currencies.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: textStyle,
                        ),
                      );
                    }).toList(),
                    value: _current,
                    onChanged: (String newValue) {
                      setState(() {
                        _current = newValue;
                      });
                    },
                  ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: _padding, bottom: _padding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          onPressed: () {

                            setState(() {
                              if(_formKey.currentState.validate()) {
                                double prin = double.parse(principal.text);
                                double r = double.parse(roi.text);
                                double t = double.parse(term.text);
                                double value = prin + (prin * r * t) / 100;
                                displa =
                                "After $t years you will get $value $_current";
                              }
                            });
                          },
                          child: Text(
                            'Calculate',
                            style: textStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          onPressed: () {
                            setState(() {
                              displa = '';
                              principal.text = '';
                              term.text = '';
                              roi.text = '';
                            });
                          },
                          child: Text(
                            'Reset',
                            style: textStyle,
                          ),
                        ),
                      )
                    ],
                  )),
              Padding(
                child: Text(
                  displa,
                  style: textStyle,
                ),
                padding: EdgeInsets.all(_padding),
              )
            ],
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImageimg = AssetImage('images/interest.jpg');
    Image image = Image(
      image: assetImageimg,
      width: 125,
      height: 125,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_padding * 10.0),
    );
  }
}
