// import 'dart:async';
//
// import 'package:twilio_programmable_video/twilio_programmable_video.dart';
//
// class TwilioService {
//
//   Room _room = Room(123);
//   final Completer<Room> _completer = Completer<Room>();
//   String accessToken = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzJmMjQwMmYzZTM4NDEzOTNkNWE3Y2U3MGYwNDlmMzg1LTE2NjEwMzQxMDIiLCJpc3MiOiJTSzJmMjQwMmYzZTM4NDEzOTNkNWE3Y2U3MGYwNDlmMzg1Iiwic3ViIjoiQUMyNjAxOWExOWE0N2Q3NmJkODFiNTkyMzJiMzlmNjQ4MCIsImV4cCI6MTY2MTAzNzcwMiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiZHJheXRlc3QiLCJ2aWRlbyI6eyJyb29tIjoicm9vbXRlc3QifX19.H8tPfG3pntl_zjIouUXOwTMNHGBi3VpVglB5W3bQqPA';
//   TwilioService(String act ){
//     accessToken = act.isNotEmpty ?
//         "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzJmMjQwMmYzZTM4NDEzOTNkNWE3Y2U3MGYwNDlmMzg1LTE2NjEwMzQxMDIiLCJpc3MiOiJTSzJmMjQwMmYzZTM4NDEzOTNkNWE3Y2U3MGYwNDlmMzg1Iiwic3ViIjoiQUMyNjAxOWExOWE0N2Q3NmJkODFiNTkyMzJiMzlmNjQ4MCIsImV4cCI6MTY2MTAzNzcwMiwiZ3JhbnRzIjp7ImlkZW50aXR5IjoiZHJheXRlc3QiLCJ2aWRlbyI6eyJyb29tIjoicm9vbXRlc3QifX19.H8tPfG3pntl_zjIouUXOwTMNHGBi3VpVglB5W3bQqPA" :
//         act;
//
//
//   }
//
//   void _onConnected(Room room) {
//     print('Connected to ${room.name}');
//     _completer.complete(_room);
//   }
//
//   void _onConnectFailure(RoomConnectFailureEvent event) {
//     print('Failed to connect to room ${event.room.name} with exception: ${event.exception}');
//     _completer.completeError(event.exception.toString());
//   }
//
//   Future<Room> connectToRoom(String roomName) async {
//     // Retrieve the camera source of your choosing
//     var cameraSources = await CameraSource.getSources();
//     var cameraCapturer = CameraCapturer(
//       cameraSources.firstWhere((source) => source.isFrontFacing),
//     );
//
//     var connectOptions = ConnectOptions(
//       accessToken,
//       roomName: "roomtest",                   // Optional name for the room
//       // region: region,                       // Optional region.
//       preferredAudioCodecs: [OpusCodec()],  // Optional list of preferred AudioCodecs
//       preferredVideoCodecs: [H264Codec()],  // Optional list of preferred VideoCodecs.
//       audioTracks: [LocalAudioTrack(true,"mp3")], // Optional list of audio tracks.
//       dataTracks: [
//         LocalDataTrack(
//           DataTrackOptions(
//               ordered: true,                      // Optional, Ordered transmission of messages. Default is `true`.
//               // maxPacketLifeTime: maxPacketLifeTime,  // Optional, Maximum retransmit time in milliseconds. Default is [DataTrackOptions.defaultMaxPacketLifeTime]
//               // maxRetransmits: maxRetransmits,        // Optional, Maximum number of retransmitted messages. Default is [DataTrackOptions.defaultMaxRetransmits]
//               name: "Mind Interest"                            // Optional
//           ),                                // Optional
//         ),
//       ],                                    // Optional list of data tracks
//       videoTracks: [LocalVideoTrack(true, cameraCapturer)], // Optional list of video tracks.
//     );
//     _room = await TwilioProgrammableVideo.connect(connectOptions);
//     _room.onConnected.listen(_onConnected);
//     _room.onConnectFailure.listen(_onConnectFailure);
//     return _completer.future;
//   }
//
// }