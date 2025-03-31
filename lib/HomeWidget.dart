import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ncell_test/WebViewWidget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _fetchUrl(String? number) async {
    final dio = Dio();
    if (number != null) {
      // final response = await dio.post('http://192.168.1.200:3005/api/test', data: {"phoneNumber": number});
      String url =
          'https://ncell.damicard.com/#/?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZjkwZGVjYzNiYzczZjI0NTdlNjYyOSIsImVtYWlsIjoic25lcGFsLmxvZ2lzcGFya0BnbWFpbC5jb20iLCJyb2xlcyI6W3siX2lkIjoiNjVkZjFlNWFkYzc2OWFiZTE2ZTFkMjIxIiwibmFtZSI6IlNVUEVSX0FETUlOIiwiZGVzY3JpcHRpb24iOiJTVVBFUl9BRE1JTiJ9LHsiX2lkIjoiNjVkZjFlNzBkYzc2OWFiZTE2ZTFkMjI3IiwibmFtZSI6IkNVU1RPTUVSIiwiZGVzY3JpcHRpb24iOiJDVVNUT01FUiJ9XSwibGFzdFVwZGF0ZSI6Ik1vbiBNYXIgMzEgMjAyNSIsImlhdCI6MTc0MzQwMTUyOSwiZXhwIjoxNzU5MTgxNTI5fQ.eaVxEdRnGGmp4ZP3lmZKgrQUiZ3JGEdeLiyJInTVQP0';

      Navigator.push(context, MaterialPageRoute(builder: (context) => WebView(webURL: url)));
    }
  }

  // _showNumberInputDialog(BuildContext context) {
  //   TextEditingController controller = TextEditingController();
  //
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Enter a number'),
  //         content: TextField(
  //           controller: controller,
  //           keyboardType: TextInputType.number,
  //           decoration: InputDecoration(hintText: 'Enter a number', border: OutlineInputBorder()),
  //           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               String input = controller.text.trim();
  //               if (input.isNotEmpty) {
  //                 _fetchUrl(input);
  //               }
  //               // else {
  //               //
  //               //   // Show a warning if no input is provided
  //               //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter a valid number')));
  //               // }
  //             },
  //             child: Text('Submit'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home"), automaticallyImplyLeading: true),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: InkWell(
                onTap: () async {
                  final input = '12132';
                  _fetchUrl(input);
                },
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    width: 100, // Fixed width
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.credit_card_rounded, size: 24, color: Colors.cyanAccent), // Icon
                        SizedBox(width: 6), // Spacing
                        Expanded(
                          child: Text(
                            "Card",
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
