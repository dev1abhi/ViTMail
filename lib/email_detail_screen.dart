import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'models/emaildata.dart';

class EmailDetailScreen extends StatefulWidget {
  final EmailData email;

  EmailDetailScreen({required this.email});

  @override
  State<EmailDetailScreen> createState() => _EmailDetailScreenState();
}

class _EmailDetailScreenState extends State<EmailDetailScreen> {
  late final gemini = Gemini.instance;
  bool showSummarizedText = false;
  String? summarizedText;
  bool isSummarizing = false;
  bool textthere = false;

  @override
  void initState() {
    super.initState();
    // initializing gemini model
    Gemini.init(apiKey: 'AIzaSyBAA2JQYWckwagOCnVaWQnx6H4tb0Kw23k');
    summarizeEmailBody();
  }

  void summarizeEmailBody() {
    if (mounted) {
      setState(() {
        isSummarizing = true;
      });

      if (!widget.email.body.contains("!DOCTYPE html")) {
        gemini.text(' Summarize the following text (if it is a event , then provide important '
            'details like date timing and short description) (give in proper presentable format having spaces in between):  ${widget.email.body} ')
            .then((value) {
          if (mounted) {
            setState(() {
              summarizedText = value?.output;
              isSummarizing = false;
            });
          }
        })
            .catchError((e) {
          if (mounted) {
            setState(() {
              isSummarizing = false;
            });
          }
          print(e);
        });
      } else {
        if (mounted) {
          setState(() {
            isSummarizing = false;
          });
        }
      }
    }
  }


  void toggleSummarizedText() {
    setState(() {
      showSummarizedText = !showSummarizedText;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.email.body != null && !widget.email.body.contains("!DOCTYPE html"))
      textthere = true;
    //print('Debug: email.html = ${email.html}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Email Detail'),
      ),
      body: Center(
        child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/images/bg3.jpg'), // Set your image path here
    fit: BoxFit.cover,
    ),
    ),
          child: Card(
            color: Colors.white,
            margin: EdgeInsets.all(30),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
              //border color
              side: BorderSide(color: Colors.black, width: 2.0),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('From: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  SizedBox(height: 8),
                  Text(widget.email.sender),
                  SizedBox(height: 16),
                  const Text('Subject: ',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 8),
                  Text(widget.email.subject),
                  SizedBox(height: 16),
                  if (widget.email.body != null && !widget.email.body.contains("!DOCTYPE html"))
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                              toggleSummarizedText();
                          },
                          child: Text(showSummarizedText ? 'Show Full Text' : 'Show Summarized Text'),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                        )

                        ),
                        SizedBox(height: 16),
                        if (showSummarizedText)
                          if (isSummarizing)
                            Center(child: CircularProgressIndicator())
                          else if (summarizedText != null)
                             //Text('$summarizedText')
                             MarkdownBody(data: summarizedText!),
                        if (!showSummarizedText)
                            Text('Full Email:\n ${widget.email.body}'),
                      ],
                    )
                  else
                    HtmlWidget(widget.email.body),

                  if (widget.email.html != null && !textthere)
                    HtmlWidget(widget.email.html),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
