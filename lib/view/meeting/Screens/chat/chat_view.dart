import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import '../../theme/AppColors.dart';
import 'chat_widget.dart';

// ChatScreen
class ChatView extends StatefulWidget {
  final Room meeting;
  const ChatView({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  // MessageTextController
  final msgTextController = TextEditingController();

  // PubSubMessages
  PubSubMessages? messages;

  @override
  void initState() {
    super.initState();

    // Subscribing 'CHAT' Topic
    widget.meeting.pubSub
        .subscribe("CHAT", messageHandler)
        .then((value) => setState((() => messages = value)));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primaryColor,
      appBar: AppBar(
        flexibleSpace: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
               Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Chat",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,
                  color: Appcolors.fontcolor
                    
                    ),
                  ),
                ),
              ),
              IconButton(
                icon:  Icon(Icons.close,
                  color: Appcolors.fontcolor
                
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor:Appcolors.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: messages == null
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        reverse: true,
                        child: Column(
                          children: messages!.messages
                              .map(
                                (e) => ChatWidget(
                                  message: e,
                                  isLocalParticipant: e.senderId ==
                                      widget.meeting.localParticipant.id,
                                ),
                              )
                              .toList(),
                        ),
                      ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.fromLTRB(16, 4, 4, 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color:Appcolors.black900),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style:  TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        color: Appcolors.fontcolor

                        ),
                        controller: msgTextController,
                        onChanged: (value) => setState(() {
                          msgTextController.text;
                        }),
                        decoration:  InputDecoration(
                            hintText: "Write your message",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                  color: Appcolors.fontcolor
                              
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: msgTextController.text.trim().isEmpty
                          ? null
                          : () => widget.meeting.pubSub
                              .publish(
                                "CHAT",
                                msgTextController.text,
                                const PubSubPublishOptions(persist: true),
                              )
                              .then((value) => msgTextController.clear()),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          width: 45,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: msgTextController.text.trim().isEmpty
                                  ? null
                                  : Appcolors.black800,
                              borderRadius: BorderRadius.circular(8)),
                          child:  Icon(Icons.send,
                  color: Appcolors.fontcolor
                          
                          )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void messageHandler(PubSubMessage message) {
    setState(() => messages!.messages.add(message));
  }

  @override
  void dispose() {
    widget.meeting.pubSub.unsubscribe("CHAT", messageHandler);
    super.dispose();
  }
}
