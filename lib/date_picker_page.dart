import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {

  TextEditingController _dataController = TextEditingController();
  DateTime _dataSelecionada = DateTime.now();

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? dataEscolhida = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (dataEscolhida != null) {
      setState(() {
        _dataSelecionada = dataEscolhida;
        _dataController.text = DateFormat('dd/MM/yyyy').format(_dataSelecionada);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: TextField(
            controller: _dataController,
            decoration: InputDecoration(
              labelText: 'Selecione a Data',
              hintText: 'DD/MM/AAAA',
            ),
            readOnly: true, // Faz com que o campo seja somente leitura
            onTap: () => _selecionarData(context), // Abre o DatePicker
          ),
        )
      ),
    );
  }
}
