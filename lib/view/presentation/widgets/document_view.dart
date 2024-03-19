import 'package:flutter/material.dart';
import 'package:webviewx/webviewx.dart';

class document_view extends StatefulWidget {
  document_view({super.key,required this.document_url});
  String document_url;

  @override
  State<document_view> createState() => _document_viewState();
}

class _document_viewState extends State<document_view> {
  late WebViewXController webviewController;
   
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.document_url);
    webviewController=WebViewXController(initialContent: 
    '''
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Embed Microsoft Word and Excel Documents in HTML Web Page by CodeAT21</title>

</head>
<body>
<div class="container">
	<div class="embeded">
		<div class="cols">
			<h2> Embed MS word file </h2>
			<iframe src=https://firebasestorage.googleapis.com/v0/b/hhstudios-4ce70.appspot.com/o/document%2F2523784e-28d3-41ae-ba4b-93a71be0d96a.pdf?alt=media&token=0cddd8c6-54fb-4bd9-821f-e8ac0d104db' width='100%' height='650px' frameborder='0'></iframe>
		</div>
		
	</div>
</div>
</body>
</html>
'''
    , initialSourceType: SourceType.HTML, ignoreAllGestures: true);
    webviewController.loadContent(widget.document_url, SourceType.URL);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewX(
        initialContent:'''
<!DOCTYPE html>
<html lang="en-US">
<head>
<title>Embed Microsoft Word and Excel Documents in HTML Web Page by CodeAT21</title>

</head>
<body>
<div class="container">
	<div class="embeded">
		<div class="cols">
			<h2> Embed MS word file </h2>
			<iframe src='https://firebasestorage.googleapis.com/v0/b/hhstudios-4ce70.appspot.com/o/document%2F2523784e-28d3-41ae-ba4b-93a71be0d96a.pdf?alt=media&token=0cddd8c6-54fb-4bd9-821f-e8ac0d104db' width='100%' height='100%' frameborder='0'></iframe>
		</div>
		
	</div>
</div>
</body>
</html>
''',
        initialSourceType: SourceType.HTML,
        onWebViewCreated: (controller) => webviewController = controller,
      ),
    );
  }
}