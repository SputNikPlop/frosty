import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:frosty/models/channel.dart';
import 'package:frosty/providers/chat_provider.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  final Channel channelInfo;

  const Chat({Key? key, required this.channelInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    final viewModel = context.read<ChatProvider>();
    return SafeArea(
      child: FutureBuilder(
        future: viewModel.getEmotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
              stream: viewModel.channel.stream,
              builder: (context, snapshot) {
                for (final message in snapshot.data.toString().split('\r\n')) {
                  viewModel.parseIrcMessage(message);
                }
                return Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ListView.builder(
                      itemCount: viewModel.messages.length,
                      controller: viewModel.scrollController,
                      padding: const EdgeInsets.all(5.0),
                      itemBuilder: (context, index) {
                        return viewModel.messages[index];
                      },
                    ),
                    Consumer<ChatProvider>(
                      builder: (context, viewModel, child) {
                        return Visibility(
                          visible: !viewModel.autoScroll,
                          child: ElevatedButton(
                            onPressed: () {
                              viewModel.autoScroll = true;
                              viewModel.scrollController.jumpTo(viewModel.scrollController.position.maxScrollExtent);
                              SchedulerBinding.instance?.addPostFrameCallback((_) {
                                viewModel.scrollController.jumpTo(viewModel.scrollController.position.maxScrollExtent);
                              });
                            },
                            child: const Text('Resume Scroll'),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
