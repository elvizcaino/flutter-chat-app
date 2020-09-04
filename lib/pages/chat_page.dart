import "dart:io";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chat/widgets/message_bubble.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  TextEditingController _textInputChatController;
  FocusNode _textInputChatFocusNode;
  bool _isWriting = false;

  List<MessageBubble> _bubbleMessages = [];

  @override
  void initState() { 
    super.initState();

    for (MessageBubble bubble in _bubbleMessages) {
      bubble.animationController.dispose();
    }
    
    _textInputChatController = TextEditingController();
    _textInputChatFocusNode = FocusNode();
  }

  @override
  void dispose() { 
    _textInputChatController.dispose();
    _textInputChatFocusNode.dispose();

    //TODO: off del socket
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("E", style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 15,
            ),
            SizedBox(height: 3),
            Text("Elvis", style: TextStyle(color: Colors.black87, fontSize: 12),)
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: _bubbleMessages.length,
                reverse: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (_, index) => _bubbleMessages[index]
              ),
            ),
            Divider(height: 1),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
   );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textInputChatController,
                focusNode: _textInputChatFocusNode,
                onSubmitted: _handleSubmit,
                onChanged: (value) {
                  setState(() {
                    if(value.trim().length > 0 ) {
                      _isWriting = true;
                    } else {
                      _isWriting = false;
                    }
                  });
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Escribe un mensaje"
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                ? CupertinoButton(
                  child: Text("Enviar"),
                  onPressed: _isWriting ? () => _handleSubmit(_textInputChatController.text.trim()) : null,
                )
                : Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blueAccent[400]),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.send),
                      onPressed: _isWriting ? () => _handleSubmit(_textInputChatController.text.trim()) : null,
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if(text.trim().length == 0) return;

    _textInputChatController.clear();
    _textInputChatFocusNode.requestFocus();
    
    final newMsg = MessageBubble(
      uid: "123", 
      text: text,
      animationController: AnimationController(
        vsync: this, 
        duration: 
        Duration(milliseconds: 200)
      ),
    );
    _bubbleMessages.insert(0, newMsg);
    newMsg.animationController.forward();

    setState(() {
      _isWriting = false;
    });
  }

}