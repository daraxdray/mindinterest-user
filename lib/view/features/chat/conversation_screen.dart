import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:mindintrest_user/app/theme/text_styles.dart';
import 'package:mindintrest_user/app/theme/theme.dart';
import 'package:mindintrest_user/core/data_models/chat_model.dart';
import 'package:mindintrest_user/core/data_models/consultant_model.dart';
import 'package:mindintrest_user/core/data_models/user_model.dart';
import 'package:mindintrest_user/core/services/database/local_storage.dart';
import 'package:mindintrest_user/core/services/firebase/chat.dart';
import 'package:mindintrest_user/core/state/providers.dart';
import 'package:mindintrest_user/view/features/chat/chat_bubble.dart';
import 'package:mindintrest_user/view/global_widgets/header_subheader.dart';
import 'package:mindintrest_user/view/global_widgets/loaders/button_loader.dart';
import 'package:mindintrest_user/view/global_widgets/nav_header.dart';
import 'package:mindintrest_user/view/global_widgets/network_images.dart';
import 'package:mindintrest_user/view/global_widgets/tmi_textinput.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

import '../../../app/route/app_pages.dart';

class ConversationScreen extends StatefulHookConsumerWidget {
  const ConversationScreen({
    Key? key,
    required this.cid,
    required this.bookingId,
    required this.meetLink
  }) : super(key: key);
  final int cid;
  final String bookingId;
  final String? meetLink;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  late TmiUser? user;
  late Consultant? consultant;
  bool _isLoading = true;
  TextEditingController _controller = TextEditingController();

  void fetchData() async {
    final res = await TmiLocalStorage().getData(TmiLocalStorage.kUserDataKey);
    user = TmiUser.fromJson(json.decode(res!));
    consultant = await ref.read(chatVM).getConsultant(widget.cid);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  // void joinAudio() async {
  //   final now = DateTime.now();
  //   final date = DateTime(now.year, now.month);
  //
  //   var options = JitsiMeetingOptions(
  //       roomNameOrUrl: date.toIso8601String(),
  //       isAudioOnly: true,
  //       subject: 'Therapy Session',
  //       userDisplayName: user!.name!,
  //       featureFlags: {
  //         FeatureFlag.isAddPeopleEnabled: false,
  //         FeatureFlag.isCalendarEnabled: false,
  //         FeatureFlag.isChatEnabled: false,
  //         FeatureFlag.isInviteEnabled: false,
  //       });
  //   await JitsiMeetWrapper.joinMeeting(options: options);
  // }

  // void joinTwilioAudio(String token){
  //   Navigator.of(context).push(
  //       MaterialPageRoute(builder:(context)=> ConferencePage( roomModel: RoomModel(
  //         identity: "${user!.id}",
  //         token: token,
  //         name: "TMI-${consultant!.id}${user!.id}",
  //         isAudio:true
  //       ),))
  //   );
  // }
  // void joinVideo() async {
  //   final now = DateTime.now();
  //   final date = DateTime(now.year, now.month);
  //   var options = JitsiMeetingOptions(
  //       roomNameOrUrl: date.toIso8601String(),
  //       isAudioOnly: false,
  //       subject: 'Therapy Session',
  //       userDisplayName: user!.name!,
  //       featureFlags: {
  //         FeatureFlag.isAddPeopleEnabled: false,
  //         FeatureFlag.isCalendarEnabled: false,
  //         FeatureFlag.isChatEnabled: false,
  //         FeatureFlag.isInviteEnabled: false,
  //       });
  //   await JitsiMeetWrapper.joinMeeting(options: options);
  // }
  // void joinTwilioVideo(String token) async {
  //    Navigator.of(context).push(
  //     MaterialPageRoute(builder:(context)=> ConferencePage( roomModel: RoomModel(
  //       identity: "${user!.id}",
  //       token: token,
  //       name: "TMI-${consultant!.id}${user!.id}",
  //     ),))
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // var scheduleVM = ref.watch(scheduleListingVM);
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: kWhite,
        ),
      ),
      body: _isLoading
          ? Center(
              child: TMIButtonLoader(
                size: 18,
                color: kPrimaryColor,
              ),
            )
          : user == null || consultant == null
              ? Center(
                  child: Text('Could not load converstion'),
                )
              : Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      color: kWhite,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const NavHeader(
                            showCloseButton: false,
                            iconColor: kPrimaryColor,
                          ),
                          const Gap(24),
                          Row(
                            children: [
                              UserAvatar(
                                height: 44,
                                width: 44,
                                ringColor: kSecondaryColor,
                                url: consultant!.profileImg!,
                              ),
                              const Gap(12),
                              Expanded(
                                child: HeaderSubheaderRow(
                                  title: 'Dr. ${consultant!.name}',
                                  titleMaxLines: 1,
                                  subtitleMaxLines: 2,
                                  titleStyle: AppStyles.getTextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: kTitleActiveColor,
                                  ),
                                  subtitle: consultant!.specialty!,
                                  subtitleStyle: AppStyles.getTextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                    color: kLabelColor,
                                  ),
                                ),
                              ),
                              widget.meetLink == "null"?
                              SizedBox() :
                              ElevatedButton(
                                  onPressed: ()=>  GoRouter.of(context).go(RoutePaths.call+"?url=${widget.meetLink}&cid=${widget.cid}&bid=${widget.bookingId}",),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children:  [
                                      Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 15, ),
                                      SizedBox(
                                          width:10
                                      ),
                                      Icon(Icons.video_call,
                                        color: Colors.white,
                                        size: 19,),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0), // Adjust the radius as needed
                                      ))),

                              // Row(
                              //   children: [
                              //
                              //     InkWell(
                              //       onTap: ()=>   GoRouter.of(context).go(RoutePaths.call+"?url=${widget.meetLink}&cid=${widget.cid}&bid=${widget.bookingId}",),
                              //       child: SizedBox(
                              //         height: 20,
                              //         width: 20,
                              //         child: Image.asset('assets/images/call.png'),
                              //       ),
                              //     ),
                              //     const Gap(24),
                              //     InkWell(
                              //       onTap:() => GoRouter.of(context).go(RoutePaths.call2+"?url=${widget.meetLink}"),
                              //       child: SizedBox(
                              //         height: 28,
                              //         width: 28,
                              //         child: Image.asset('assets/images/video.png'),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // FutureBuilder(
                              //   future: scheduleVM.getAccessToken(consultant!.id),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<String?> snapshot) {
                              //     if (snapshot.hasError ||
                              //         snapshot.connectionState == ConnectionState.done &&
                              //             snapshot.data == null) {
                              //
                              //       return SizedBox(
                              //         height: 100,
                              //         child: Center(
                              //           child: Text('Not Available'),
                              //         ),
                              //       );
                              //     }
                              //     if (snapshot.hasData) {
                              //       if (snapshot.data!.isEmpty) {
                              //         return SizedBox(
                              //             child: IconButton(onPressed: ()=> setState(() {
                              //
                              //             }), icon: Icon(Icons.refresh))
                              //         );
                              //       } else {
                              //         return Row(
                              //           children: [
                              //             InkWell(
                              //               onTap: ()=>   GoRouter.of(context).go(RoutePaths.call+"?${widget.meetLink}"),
                              //               child: SizedBox(
                              //                 height: 20,
                              //                 width: 20,
                              //                 child: Image.asset('assets/images/call.png'),
                              //               ),
                              //             ),
                              //             const Gap(24),
                              //             InkWell(
                              //               onTap:() => GoRouter.of(context).go(RoutePaths.call+"?${widget.meetLink}"),
                              //               child: SizedBox(
                              //                 height: 28,
                              //                 width: 28,
                              //                 child: Image.asset('assets/images/video.png'),
                              //               ),
                              //             ),
                              //           ],
                              //         );
                              //       }
                              //     } else {
                              //       return SizedBox(
                              //         height: 100,
                              //         child: Center(
                              //           child: TMIButtonLoader(
                              //             color: kPrimaryColor,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       );
                              //     }
                              //   },
                              // ),

                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 48),
                            child: PaginateFirestore(
                              physics: ClampingScrollPhysics(),
                              reverse: true,
                              allowImplicitScrolling: true,
                              // footer: Gap(100),
                              padding: EdgeInsets.only(
                                  bottom: 100, left: 24, right: 24),
                              // scrollController: _scrollController,
                              isLive: true,
                              itemBuilder: (BuildContext context,
                                  List<DocumentSnapshot<Object?>>
                                      documentSnapshots,
                                  int index) {
                                final data = documentSnapshots[index].data()
                                    as Map<String, dynamic>?;
                                final message = ChatModel.fromJson(data!);
                                return ChatBubble(
                                  message,
                                  isMine: message.senderID == user!.id,
                                  // isMine: false,
                                );
                              },
                              query: FirebaseFirestore.instance
                                  .collection('conversation_messages')
                                  .doc(widget.bookingId)
                                  .collection('all_messages')
                                  .orderBy("timestamp", descending: true),
                              itemBuilderType: PaginateBuilderType.listView,
                              itemsPerPage: 10,
                              onEmpty: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 24),
                                child: Center(
                                  child: Text('No chat history'),
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
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: TMIButtonLoader(
                                      size: 18,
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                                padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(24),
                                        // width: size.width,
                                        decoration: BoxDecoration(
                                            color: kWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey.shade200,
                                                  blurRadius: 2,
                                                  spreadRadius: 1)
                                            ]),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 2, 1, 2),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: TMITextField(
                                                  maxLines: 4,
                                                  minLines: 1,
                                                  controller: _controller,
                                                  autoFocus: true,
                                                  hintText: 'Write message',
                                                ),
                                              ),
                                              Gap(24),
                                              GestureDetector(
                                                onTap: send,
                                                child: Container(
                                                  child: SizedBox(
                                                    height: 20,
                                                    width: 20,
                                                    child: Image.asset(
                                                        "assets/images/send.png"),
                                                  ),
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: kPrimaryColor),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
    );
  }

  void send() async {
    if (_controller.text.trim().isEmpty) {
      return;
    }
    ChatService chatService = ChatService();
    await chatService
        .sendMessage(consultant!.id!, user!.id!, widget.bookingId,
            ChatModel(senderID: user!.id!, text: _controller.text))
        .then((value) {
      _controller.clear();
    });
  }
}
