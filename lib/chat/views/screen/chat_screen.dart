import 'package:chat_app/Auth/view_model/cubit/auth_cubit.dart';
import 'package:chat_app/chat/data/model/message_model.dart';
import 'package:chat_app/chat/view_model/cubit/chat_cubit.dart';
import 'package:chat_app/chat/views/widget/received_message.dart';
import 'package:chat_app/chat/views/widget/sent_message.dart';
import 'package:chat_app/shared/app_them.dart';
import 'package:chat_app/shared/widgets/error_indicator.dart';
import 'package:chat_app/shared/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  static const String routeName = '/chatscreen';
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final chatCubit = ChatCubit();
  final ScrollController _scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatCubit.roomId = ModalRoute.of(context)!.settings.arguments as String;
      chatCubit.getMessageStream();
      chatCubit.currentUser = BlocProvider.of<AuthCubit>(context).currentUser!;
    });
  }

 

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Chat App'),
        forceMaterialTransparency: true,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Material(
              elevation: 12,
              borderRadius: BorderRadius.circular(20),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Container(
                height: MediaQuery.of(context).size.height * .7,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: AppTheme.white,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<ChatCubit, ChatState>(
                        bloc: chatCubit,
                        buildWhen: (previousState, currentState) =>
                            previousState is GetMessageLoading ||
                            currentState is GetMessageLoading,
                        builder: (context, state) {
                          if (state is GetMessageLoading) {
                            return const LoadingIndicator();
                          } else if (state is GetMessageError) {
                            return const ErrorIndicator();
                          } else if (state is GetMessageSuccess) {
                            return StreamBuilder(
                              stream: state.streamMessages,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  messages = snapshot.data!;
                                }
                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => _scrollToBottom());
                                return ListView.separated(
                                  controller: _scrollController,
                                  itemBuilder: (_, index) {
                                    final message = messages[index];
                                    final isMyMessage = chatCubit.isMyMessage(
                                      message.senderId,
                                    );
                                    if (isMyMessage) {
                                      return SentMessage(message: message);
                                    } else {
                                      return ReceivedMessage(message: message);
                                    }
                                  },
                                  itemCount: messages.length,
                                  padding: const EdgeInsets.only(bottom: 60),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 15,
                                  ),
                                );
                              },
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatCubit.contentController,
                            decoration: const InputDecoration(
                              hintText: 'Type a Message',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: AppTheme.grey),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8))),
                              contentPadding: EdgeInsets.only(left: 8),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            chatCubit.sendMessage();
                            _scrollToBottom();
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(80, 45),
                            padding: EdgeInsets.zero,
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('send'),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.send,
                                size: 18,
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
   @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
