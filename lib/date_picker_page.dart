import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lista_contatos/api_cliente.dart';
import 'package:lista_contatos/mes.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {

  late DateTime _dataSelecionada;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    asyncFunction();
  }

  Future<void> asyncFunction() async{
    ///Estou passando 1 como id do cliente
    _dataSelecionada = await ApiCliente().getDateTime(1);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: loading ? CircularProgressIndicator() : ElevatedButton(
            onPressed: (){
              showCupertinoModalPopup(
                context: context,
                builder: (context){
                  Mes _mes = Mes.values.firstWhere((m) => m.numero == _dataSelecionada.month);
                  List<Widget> _dias = List.generate(_mes.dias, (index){
                    return Center(child: Text('${index + 1}'));
                  });
                  print(_mes.nome);
                  print(_dias.length);
                  return StatefulBuilder(
                    builder: (context, modalSetState) {
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
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 250,
                                    child: CupertinoPicker(
                                      itemExtent: 50,
                                      scrollController: FixedExtentScrollController(
                                        initialItem: _dataSelecionada.day - 1
                                      ),
                                      onSelectedItemChanged: (index){
                                        setState(() {
                                          _dataSelecionada = DateTime(
                                            _dataSelecionada.year,
                                            _dataSelecionada.month,
                                            index + 1
                                          );
                                        });
                                        modalSetState((){
                                          _mes = Mes.values.firstWhere((m) => m.numero == _dataSelecionada.month);
                                          _dias = List.generate(_mes.dias, (index){
                                            return Center(child: Text('${index + 1}'));
                                          });
                                        });
                                      },
                                      children: _dias
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: 250,
                                    child: CupertinoPicker(
                                      itemExtent: 50,
                                      scrollController: FixedExtentScrollController(
                                        initialItem: _mes.numero - 1
                                      ),
                                      onSelectedItemChanged: (index){
                                        Mes mesSelecionado = Mes.values.firstWhere((m) => m.numero == index + 1);
                                        int diasExtras = _dataSelecionada.day - mesSelecionado.dias;
                                        setState(() {
                                          _dataSelecionada = DateTime(
                                            _dataSelecionada.year,
                                            index + 1,
                                            diasExtras > 0 ? _dataSelecionada.day - diasExtras : _dataSelecionada.day
                                          );
                                        });
                                        modalSetState((){
                                          _mes = Mes.values.firstWhere((m) => m.numero == _dataSelecionada.month);
                                          _dias = List.generate(_mes.dias, (index){
                                            return Center(child: Text('${index + 1}'));
                                          });
                                        });
                                      },
                                      children: Mes.values.map((m){
                                        return Center(child: Text(m.nome));
                                      }).toList()
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }
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
