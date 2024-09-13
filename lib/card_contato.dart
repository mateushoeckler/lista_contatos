import 'package:flutter/material.dart';

import 'contato.dart';

class CardContato extends StatelessWidget {

  final Contato contato;
  final Color borderColor;

  const CardContato({required this.contato, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          heightFactor: 0.9,
          alignment: Alignment.centerLeft,
          child: Container(
            height: 30,
            width: 70,
            decoration: BoxDecoration(
              color: borderColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10))
            ),
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 40),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              text: contato.nome,
                              children: [
                                TextSpan(

                                )
                              ]
                            )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
        )
      ],
    );
  }
}
