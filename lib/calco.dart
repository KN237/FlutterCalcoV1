import 'package:flutter/material.dart';
import 'data.dart';
import 'package:provider/provider.dart';
import 'history.dart';

class Calco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 250,
            child: Column(
              children: [
                GestureDetector(
                  onVerticalDragEnd: (d) {
                    print(d);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => History()));
                  },
                  child: SafeArea(
                    child: Row(
                      children: [
                        Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          width: MediaQuery.of(context).size.width,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                  ),
                  child: Operation(
                      operation: Provider.of<Data>(context).operation),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: Result(result: Provider.of<Data>(context).result),
                ),
              ],
            ),
          ),
          Expanded(
            child: Wrap(
              children: [
                BtnCl(
                    val: '%',
                    function: () {
                      Provider.of<Data>(context, listen: false).pourcent();
                    }),
                BtnCl(
                    val: '.',
                    function: () {
                      Provider.of<Data>(context, listen: false).point();
                    }),
                BtnCl(
                    val: 'C',
                    function: () {
                      Provider.of<Data>(context, listen: false)
                          .deleteAllOperations();
                    }),
                BtnCl(
                    val: 'DEL',
                    function: () {
                      Provider.of<Data>(context, listen: false)
                          .deleteLastOperation();
                    }),
                BtnFc(val: '7'),
                BtnFc(val: '8'),
                BtnFc(val: '9'),
                BtnCl(
                    val: '/',
                    function: () {
                      Provider.of<Data>(context, listen: false).div();
                    }),
                BtnFc(val: '4'),
                BtnFc(val: '5'),
                BtnFc(val: '6'),
                BtnCl(
                    val: 'x',
                    function: () {
                      Provider.of<Data>(context, listen: false).mult();
                    }),
                BtnFc(val: '1'),
                BtnFc(val: '2'),
                BtnFc(val: '3'),
                BtnCl(
                    val: '-',
                    function: () {
                      Provider.of<Data>(context, listen: false).sust();
                    }),
                BtnFc(
                  val: '0',
                  size: Size(218, 50),
                ),
                BtnCl(
                    val: '+',
                    function: () {
                      Provider.of<Data>(context, listen: false).add();
                    }),
                BtnCl(
                    val: '+/-',
                    function: () {
                      Provider.of<Data>(context, listen: false).numberSign();
                    }),
                BtnCl(
                    val: 'x2',
                    function: () {
                      Provider.of<Data>(context, listen: false).square();
                    }),
                BtnCl(
                    val: '1/x',
                    function: () {
                      Provider.of<Data>(context, listen: false).reverse();
                    }),
                BtnCl(
                    val: '=',
                    function: () {
                      Provider.of<Data>(context, listen: false).egal();
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Operation extends StatelessWidget {
  Operation({required this.operation});

  String operation;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  operation,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                      color: Color(0xffb5bed3),
                      fontSize: 30,
                      fontWeight: FontWeight.w900),
                ),
              ),
              SizedBox(width: 20),
            ],
          )),
    );
  }
}

class Result extends StatelessWidget {
  Result({required this.result});

  String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 20),
          Flexible(
            child: Text(
              result,
              overflow: TextOverflow.clip,
              style: TextStyle(
                  color: Color(0xFF1f293f),
                  fontSize: 30,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}

class BtnCl extends StatelessWidget {
  BtnCl(
      {required this.val,
      required this.function,
      this.size = const Size(70, 50)});

  String val;
  void Function() function;
  Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
          onPressed: function,
          child: Text(
            val,
            style: TextStyle(
                color: Color(0xFF182649),
                fontSize: 20,
                fontWeight: FontWeight.w900),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color(0xffb0bee1)),
            fixedSize: MaterialStateProperty.all(size),
          )),
    );
  }
}

class BtnFc extends StatelessWidget {
  BtnFc({required this.val, this.size = const Size(70, 50)});

  String val;
  Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: TextButton(
        onPressed: () {
          Provider.of<Data>(context, listen: false).addItemToOperation(val);
        },
        child: Text(
          val,
          style: TextStyle(
              color: Color(0xFFE0ECFF),
              fontSize: 20,
              fontWeight: FontWeight.w900),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xff6C81ae)),
          fixedSize: MaterialStateProperty.all(size),
        ),
      ),
    );
  }
}
