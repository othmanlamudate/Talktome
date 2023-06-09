import 'package:flutter/material.dart';



import '../widgets/constants.dart';
import '../widgets/my_drawer.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class textToGcode extends StatefulWidget {
  const textToGcode({super.key});

  @override
  State<textToGcode> createState() => _textToGcodeState();
}

class _textToGcodeState extends State<textToGcode> {
  var textController=TextEditingController();
  
  var gcode="";

  Future getText(String txt) async {

  var url =
      Uri.https('lamudateothman.pythonanywhere.com', '/code/$txt', {'q': '{http}'});

  // Await the http get response, then decode the json-formatted response.
  showDialog(
        context: context,
        builder: (_) => const Center(
          child: CircularProgressIndicator(
            backgroundColor: Color(0xFFCC1DB9),
            color: Colors.black,
          ),
        ),
      );
    setState(() {
      gcode="";
    });
  var response = await http.get(url);
  
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    
    for (var element in jsonResponse) {
      setState(() {
      gcode+=element+"\n";
    });
    }
    Navigator.pop(context);
    print('Gcode : $jsonResponse.');
  } else {
    print('Request failed with status: ${response.statusCode}.');
    Navigator.pop(context);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF021638)
            : Colors.white,
        drawer: const MyDrawer(),
        appBar: AppBar(
          title: const Center(child: Text("Talk To Me")),
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
              color: myColor,
              iconSize: 30,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Center(child: Text("Welcome to Gcode Converter",style: TextStyle(fontSize: 40),),),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width/2,
                      child: Column(
                        children: [
                          
                              
                          SizedBox(
                            width: MediaQuery.of(context).size.width/3,
                            child: TextField(
                              controller: textController,
                              decoration: const InputDecoration(
                                label:  Center(child: Text("Text a Converte")),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(vertical: 90.0)
                              ),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                    SizedBox(
                      height:200,
                      width: MediaQuery.of(context).size.width/2.5,
                      child: Expanded(
                        
                        flex: 1,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Text(
                            gcode,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                 const SizedBox(height: 20,),
                 Center(
                  child:  SizedBox(
                        width: MediaQuery.of(context).size.width/3,
                        child: ElevatedButton(onPressed: (){
                          getText(textController.text);
                        }, child: const Text("converte")),
                      ),
                ),
               
              ],
            ),
          ),
        )
           );
  }
}