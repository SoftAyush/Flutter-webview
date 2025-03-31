import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class WebView extends StatefulWidget {
  const WebView({super.key, required this.webURL});

  final String webURL;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the WebView and request permissions
    _initializeWebView();
  }

  Future<void> _initializeWebView() async {
    // Ensure WebView is initialized properly

    _controller = WebViewController(
      onPermissionRequest: (WebViewPermissionRequest request) {
        // ✅ Grant permissions only if needed
        if (request.types.contains(WebViewPermissionResourceType.camera) || request.types.contains(WebViewPermissionResourceType.microphone)) {
          request.grant(); // Auto-approve camera & microphone
          debugPrint("✅ Permission Granted: ${request.types}");
        } else {
          request.deny(); // Deny other permissions
          debugPrint("❌ Permission Denied: ${request.types}");
        }
      },
    );
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          debugPrint('WebView is loading (progress : $progress%)');
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          debugPrint('Page finished loading: $url');
        },
        onWebResourceError: (WebResourceError error) {
          debugPrint('''Page resource error:
          code: ${error.errorCode}
          description: ${error.description}
          errorType: ${error.errorType}
          isForMainFrame: ${error.isForMainFrame}''');
        },
      ),
    );

    // // Request camera permissions before loading the URL
    // await _checkPermissions();

    // Load the URL after permission is granted
    _controller.loadRequest(Uri.parse(widget.webURL));

    // If it's an Android WebView, enable debugging and camera
    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);

      // Enable camera and microphone
      (_controller.platform as AndroidWebViewController).setAllowFileAccess(true);
      (_controller.platform as AndroidWebViewController).setAllowContentAccess(true);
      (_controller.platform as AndroidWebViewController).setOnShowFileSelector((params) async {
        if (params.isCaptureEnabled) {
          final file = await _pickCameraFile();
          return file != null ? [file] : [];
        } else {
          final file = await _pickFile();
          return file != null ? [file] : [];
        }
      });
    }
  }

  Future<String?> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any, // Allow all file types
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      return result.files.first.path;
    }

    return null;
  }

  Future<String?> _pickCameraFile() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      return pickedFile.path; // Return the file path of the captured image
    }

    return null;
  }

  // Future<void> _checkPermissions() async {
  //   PermissionStatus status = await Permission.camera.request();
  //   if (status.isGranted) {
  //     print("Camera Permission Granted");
  //     // Load the URL only after permission is granted
  //     _controller.loadRequest(Uri.parse(widget.webURL));
  //   } else {
  //     print("Camera Permission Denied");
  //     // Handle the case where permission is denied
  //     // Show an alert or redirect the user to settings
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: WebViewWidget(controller: _controller, layoutDirection: TextDirection.ltr)));
  }
}
