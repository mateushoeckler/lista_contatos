import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {

  DateTime _dataSelecionada = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: (){
              showCupertinoModalPopup(
                context: context,
                builder: (context){
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Sair'),
                        ),
                        Expanded(
                          child: CupertinoDatePicker(
                            initialDateTime: _dataSelecionada,
                            mode: CupertinoDatePickerMode.date,
                            maximumDate: DateTime.now(),
                            onDateTimeChanged: (date){
                              setState(() {
                                _dataSelecionada = date;
                              });
                            }
                          )
                        )
                      ],
                    ),
                  );
                }
              );
            },
            child: Text(_dataSelecionada.toString())
          )
        )
      ),
    );
  }
}
