import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/chat_item_model.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/features/chat/chat_item.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ChatScreen extends HookConsumerWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: kBgColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(8),
            const HeaderSubheaderRow(
              title: 'Chat',
            ),
            const Gap(24),
            Expanded(
              child: PaginateFirestore(
                physics: ClampingScrollPhysics(),
                // reverse: true,
                allowImplicitScrolling: true,
                // footer: Gap(100),
                padding: EdgeInsets.only(
                  bottom: 24,
                ),
                // scrollController: _scrollController,
                isLive: true,
                itemBuilder: (BuildContext context,
                    List<DocumentSnapshot<Object?>> documentSnapshots,
                    int index) {
                  final data =
                      documentSnapshots[index].data() as Map<String, dynamic>?;
                  final item = ChatItemModel.fromJson(
                      data!, documentSnapshots[index].id);
                  return ChatItem(
                    chatItem: item,
                    index: index,
                  );
                },
                query: FirebaseFirestore.instance
                    .collection('conversations')
                    .where('uid', isEqualTo: ref.read(userProvider).id)
                    .orderBy("timestamp", descending: true),
                itemBuilderType: PaginateBuilderType.listView,
                itemsPerPage: 10,
                onEmpty: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 24),
                  child: Center(
                    child: Text('No chats'),
                  ),
                ),
                initialLoader: Center(
                  child: TMIButtonLoader(
                    size: 18,
                    color: kPrimaryColor,
                  ),
                ),
                bottomLoader: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TMIButtonLoader(
                        size: 18,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
