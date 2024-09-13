import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lista_contatos/custom_list_view.dart';
import 'package:lista_contatos/date_picker_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'card_contato.dart';
import 'contato.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Contato> contatosAll = Contato.fromJson(Contato.json);
  List<Contato> contatos = Contato.fromJson(Contato.json);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) async{
            setState((){
              loading = true;
            });
            await Future.delayed(Duration(milliseconds: 20));
            setState(() {
              contatos = contatosAll.where((c) => c.nome.toLowerCase().contains(value.toLowerCase())).toList();
              loading = false;
            });
          },
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DatePickerPage())),
            icon: Icon(Icons.date_range)
          ),
        ]
      ),
      body: loading ? Center(child: CircularProgressIndicator()): contatos.isNotEmpty ? CustomListView(
        itemExtent: MediaQuery.of(context).size.height * 0.33,
        visualizedItems: 8,
        initialIndex: contatos.length - 2,
        padding: EdgeInsets.all(10),
        onTapFrontItem: (value) => print(value),
        children: List.generate(contatos.length, (index){
          final Contato contato = contatos[index];
          final Color borderColor = Colors.accents[index % Colors.accents.length];
          return CardContato(contato: contato, borderColor: borderColor);
        }),
      ): Center(child: Text('Nenhum contato encontrado'),)
    );
  }

}
