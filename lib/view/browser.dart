


import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';
import '../app/route/app_pages.dart';

class BrowserScreen extends StatefulWidget {
   BrowserScreen({Key? key, required this.url, required this.cid, required this.bookingId}) : super(key: key);
final String url;
final String cid;
   final String bookingId;

  @override
  _BrowserScreenState createState() =>
      _BrowserScreenState();
}

class _BrowserScreenState extends State<BrowserScreen> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewOptions settings = InAppWebViewOptions(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: false,
    allowFileAccessFromFileURLs: true,
    // frame: "camera; microphone",
    // iframeAllowFullscreen: true
  );

  PullToRefreshController? pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  String? image;
  double progress = 0;
  final urlController = TextEditingController();
  int accumulated = 0;
  bool willpop = false;


  @override
  void initState() {
    super.initState();
      // Either the permission was already granted before or the user just granted it.
    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
            // id: 1,
              title: "Special",
              action: () async {
                await webViewController?.clearFocus();
              })
        ],
        // settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          // print("onCreateContextMenu");
          // print(hitTestResult.extra);
          // print(await webViewController?.getSelectedText());
        },
        onHideContextMenu: () {
          // print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = contextMenuItemClicked.androidId;
          // print("onContextMenuActionItemClicked: " +
          //     id.toString() +
          //     " " +
          //     contextMenuItemClicked.title);
        });

    pullToRefreshController = kIsWeb || ![TargetPlatform.iOS, TargetPlatform.android].contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
      onRefresh: () async {
        if (defaultTargetPlatform == TargetPlatform.android) {
          webViewController?.reload();
        } else if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.macOS) {
          webViewController?.loadUrl(
              urlRequest:
              URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

  }

  Future<void> checkPermission()async{
    if (await Permission.camera.request().isGranted && await Permission.microphone.request().isGranted) {
      print("PERMITTED");
    }else{

    }
  }
  @override
  void dispose() {
    super.dispose();
    webViewController = null;
    pullToRefreshController = null;

  }

  Future <bool> exitRequest() async{
    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Do you want to close the window?',style: TextStyle(color: Colors.black),),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () {



                GoRouter.of(context).pushReplacement(RoutePaths.dashboardIndex);


              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
    return shouldPop ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        // drawer: myDrawer(context: context),
        body: SafeArea(
            child: Column(children: <Widget>[
              // TextField(
              //   decoration: InputDecoration(prefixIcon: Icon(Icons.search)),
              //   controller: urlController,
              //   keyboardType: TextInputType.text,
              //   onSubmitted: (value) {
              //     var url = Uri.parse(value);
              //     if (url.scheme.isEmpty) {
              //       url = Uri.parse((!kIsWeb
              //           ? "https://www.google.com/search?q="
              //           : "https://www.bing.com/search?q=") +
              //           value);
              //     }
              //     webViewController?.loadUrl(urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.url)),
                      // initialUrlRequest:
                      // URLRequest(url: Uri.parse(Uri.base.toString().replaceFirst("/#/", "/") + 'page.html')),
                      // initialFile: "assets/index.html",
                      initialUserScripts: UnmodifiableListView<UserScript>([]),
                      initialOptions: InAppWebViewGroupOptions(crossPlatform: settings),
                      // contextMenu: contextMenu,
                      // pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) async {
                        webViewController = controller;
                        webViewController?.addJavaScriptHandler(handlerName: 'handleResult', callback: (callback){
                          //check if message is game event
                          _getUserMedia();
                        });
                        // print(await controller.getUrl());
                      },
                      onLoadStart: (controller, url) async {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                        await checkPermission();
                      },
                      androidOnPermissionRequest: ( InAppWebViewController controller,
                          String origin,
                          List<String> resources) async {
                        return PermissionRequestResponse(resources: resources, action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading:
                          (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![
                          "http",
                          "https",
                          "file",
                          "chrome",
                          "data",
                          "javascript",
                          "about"
                        ].contains(uri.scheme)) {
                          if (await canLaunchUrl(uri)) {
                            // Launch the App
                            await launchUrl(
                              uri,
                            );
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController?.endRefreshing();
                        await controller.evaluateJavascript(source: """
                           
                            window.addEventListener("message", (event) => {       
                             
                             window.flutter_inappwebview
                            .callHandler('handleResult',event.data);
                             
                            }, false);
                          """);

                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      // onReceivedError: (controller, request, error) {
                      //   pullToRefreshController?.endRefreshing();
                      // },
                      onProgressChanged: (controller, progress) {
                        // if (progress == 100) {
                        //   pullToRefreshController?.endRefreshing();
                        // }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, isReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        debugPrint(consoleMessage.toString());
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                      Align(
                      alignment: Alignment(-1,-0.8),
                      child: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: ()=>exitRequest(),
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),),
                  ],
                ),
              ),
            ]))),
        onWillPop: () async {


    return willpop;
        });
  }

  Future<void> _getUserMedia() async {
    final javascriptCode = '''
      async function getUserMediaAsync() {
        try {
const stream = await window.navigator.getUserMedia(audio: true, video: true);
          // Handle the media stream, e.g., send to Flutter or use it in JavaScript
alert("STREAM DONE, stream");
alert(stream);

        } catch (error) {
          // Handle error
          console.error(error);
        }
      }
      getUserMediaAsync();
    ''';

    // Execute the JavaScript code within the WebView
    await webViewController?.evaluateJavascript(source: javascriptCode);
  }


}


