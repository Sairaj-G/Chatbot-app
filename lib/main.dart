import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const chatbot());
}

class chatbot extends StatefulWidget {
  const chatbot({Key? key}) : super(key: key);
  @override
  State<chatbot> createState() => _chatbotState();
}
TextEditingController msg = new TextEditingController();
ScrollController _scrollController = ScrollController();
class _chatbotState extends State<chatbot> {
  var Qoutes = [];
  var BotQoutes = [];
  var t;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Chatbot",
          style: TextStyle(color: Colors.grey[200], fontWeight: FontWeight.bold),
        ),
      ),


      body :
      Column(
        children: [
          
          Expanded(
            flex : 9,
            child: Container(
              color: Colors.grey[300],
              height : 600.0,
              child: Scrollbar(
                isAlwaysShown: false,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: Qoutes.length,
                  itemBuilder: (context, index)  {
                    return
                      Container(

                      margin: const EdgeInsets.all(5.0),
                      padding: const EdgeInsets.all(3.0),
                        height: 200.0 +t,
                        width: 50.0,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.grey[300]),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              flex : 1,
                              child: Container(
                              margin: const EdgeInsets.all(20.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.blueAccent),
                                color: Colors.white,
                              ),

                                height: 120.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end ,
                                  children: [
                                       Text(
                                        " ME",
                                        style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.blue),
                                      ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Expanded(child: Text(Qoutes[index])),
                                          ],
                                        ),
                                ]
                              ),
                        ),
                            ),

                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Container(
                              height : 120.0,
                              margin: const EdgeInsets.all(20.0),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                border: Border.all(color: Colors.blueAccent),
                                color: Colors.green[200],
                              ),

                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start ,
                                          children: [
                                          Expanded(
                                            child: Text(
                                              "BOT",
                                                  style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color: Colors.blue),
                                              ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              children: [
                                              Expanded(child: Text(
                                                  BotQoutes[index],
                                              )
                                              ),
                                            ],
                                            ),
                                          ),
                                          ],
                                            ),
                                            ),
                          ),
                      ],
                    ),

                    );

                  }
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Expanded(
                flex : 5,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0,0.0,3.0),
                  child: TextField (
                    controller: msg,
                    decoration: InputDecoration(
                      hintText: "Enter Your Message",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed:() async {
                    var Reply = await getChatbotReply(msg.text);
                    if ((msg.text) == "")
                    {
                      return;
                    }
                    else {
                      setState(() {
                        Qoutes.add(msg.text);
                        BotQoutes.add(Reply);
                        msg.clear();
                        if (Reply.length > 80)
                          {
                            t = 100.0;
                          }
                        else
                          {
                            t = 70.0;
                          }

                        _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn);
                      });
                    }
                  },
                  icon: Icon(Icons.send),
                  color: Colors.green[400],
                ),
              ),
            ],
    ),
          ),
        ],
      ),
      ),
      ),
    );
  }
}

Future <String> getChatbotReply(String userReply) async {
  var response = await http.get(Uri.parse("http://api.brainshop.ai/get?bid=167106&key=iABJFJf8sP50MTTg&uid=Sai_G&msg=${userReply}"));
  var data = await jsonDecode(response.body);
  return (await data["cnt"]);
}


