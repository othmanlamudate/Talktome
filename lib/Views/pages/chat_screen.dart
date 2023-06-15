import 'package:flutter/material.dart';

import 'package:talktome/services/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/chat_widget.dart';
import '../widgets/my_drawer.dart';
import '../../constants/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool _isTyping = true;
  var list = [];
  late TextEditingController textEditingController;
  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  //Chat AI
  Future ChatAI(String prompt) async {
    var apiKey =
        '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'; // Replace with your OpenAI API key
    var url = 'https://api.openai.com/v1/completions';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    var body = {
      "model": "text-davinci-003",
      "prompt": "Say this is a test",
      "max_tokens": 7,
      "temperature": 0,
      "top_p": 1,
      "n": 1,
      "stream": false,
      "logprobs": null,
      "stop": "\n"
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var choices = data['choices'];
        if (choices.isNotEmpty) {
          print(choices[0]['text']);
        }
      }

      print(Exception('Failed to get OpenAI response. '));
      print(response.statusCode);
      print(jsonDecode(response.body));
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF021638)
            : Colors.white,
        drawer: const MyDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Builder(
              builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: const Icon(Icons.menu),
                    color: const Color(0xFFCC1DB9),
                    iconSize: 30,
                  )),
          actions: [
            IconButton(
                onPressed: () async {
                  await Services.showModalSheet(context: context);
                },
                icon: Icon(
                  Icons.more_vert_rounded,
                  color: myColor,
                ))
          ],
        ),
        // appBar: AppBar(
        //   backgroundColor: myColor3,
        //   elevation: 2,
        //   leading: Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Image.asset("images/chat.png"),
        //   ),
        //   title: const Text(
        //     "ChatApp",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await Services.showModalSheet(context: context);
        //       },
        //       icon: const Icon(
        //         Icons.more_vert_rounded,
        //         color: Colors.white,
        //       ))
        // ],
        // ),
        body: SafeArea(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        msg: chatMessages[index]["msg"].toString(),
                        chatIndex: int.parse(
                            chatMessages[index]["chatIndex"].toString()),
                      );
                    }),
              ),
              if (_isTyping) ...[
                SpinKitThreeBounce(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : myColor,
                  // color: Colors.white,
                  size: 18,
                ),
                const SizedBox(
                  height: 35,
                ),
                Material(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? myColor3
                      : myColor,
                  // color: myColor3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            controller: textEditingController,
                            onSubmitted: (value) {
                              //TODO SEND MESSAGE
                            },
                            decoration: const InputDecoration.collapsed(
                                hintText: "How can I help you",
                                hintStyle: TextStyle(color: Colors.grey)),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              if (textEditingController.text.isNotEmpty) {
                                print("hi");
                                var response =
                                    ChatAI(textEditingController.text.trim());
                                print(response);
                              }
                            },
                            icon: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                )
              ]
            ],
          ),
        ));
  }
}
