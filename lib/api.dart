// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'package:email_formatter_poc/sign_up_screen.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'email_list_screen.dart';
import 'models/emaildata.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: <String>[GmailApi.gmailReadonlyScope,
  ],
);


/// The main widget of this demo.
class SignInDemo extends StatefulWidget {
  /// Creates the main widget of this demo.
  const SignInDemo({super.key});

  @override
  State createState() => SignInDemoState();
}

/// The state of the main widget.
class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';
  List<EmailData> emailDataList = [];



  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleFetchEmails();
      }
    });
    _googleSignIn.signInSilently();
  }




  Future<void> _handleFetchEmails() async {
    setState(() {
      _contactText = 'Loading emails...';
    });

    final auth.AuthClient? client = await _googleSignIn.authenticatedClient();
    assert(client != null, 'Authenticated client missing!');
    final GmailApi gmailApi = GmailApi(client!);

    try {
      ListMessagesResponse messagesResponse = await gmailApi.users.messages
          .list('me',maxResults: 100);//TODO : Pagination
      List<Message>? messages = messagesResponse.messages;



      for (Message message in messages!) {
        Message? detailedMessage = await gmailApi.users.messages.get(
            'me', message.id!);


        String sender = '';
        String subject = '';
        String body = '';
        String html='';



        //extracting data
        sender = _getHeaderValue(detailedMessage.payload?.headers, 'From');
        subject = _getHeaderValue(detailedMessage.payload?.headers, 'Subject');
        //body = detailedMessage.snippet ?? '';   //snippet of message
        //Decode base64-encoded body
        String? bodyData = detailedMessage.payload?.body?.data;
        body = bodyData != null ? utf8.decode(base64Url.decode(bodyData)) : '';


        //this part is responsible for fetching html content
        //Text/HTML content
        var parts = detailedMessage.payload?.parts?.where((part) => part.mimeType == 'text/html');
        if (parts != null && parts.isNotEmpty) {
          var bodyData = parts.first.body?.data;
          if (bodyData != null) {
            var decodedBytes = base64Url.decode(bodyData);
             html = utf8.decode(decodedBytes);

          }
        }

        // Handle multipart/alternative content
        var alternativeParts = detailedMessage.payload?.parts
            ?.where((part) => part.mimeType == 'multipart/alternative')
            .toList();
        if (alternativeParts != null && alternativeParts.isNotEmpty) {
          // Extract text/plain content
          body = extractContentByMimeType(alternativeParts, 'text/plain');

          // Extract text/html content
          html = extractContentByMimeType(alternativeParts, 'text/html');

        }

       //Handle multipart/related content
        var a = detailedMessage.payload?.parts?.where((part) => part.mimeType == 'multipart/related').toList();
        if (a != null && a.isNotEmpty) {
          //print("subject = $subject");
          for (var part in a) {
            //print(" part is ${part.mimeType}");
            for (var nestedPart in part.parts ?? []) {
              print(" nestedPart is ${nestedPart.mimeType}");
              if (nestedPart.body?.attachmentId != null)
                {
                  //Do something with attachments
                }
              if (nestedPart.mimeType == 'multipart/alternative') {
                // Handle multipart/alternative content
                String textContent = nestedPart.parts?.firstWhere((subPart) => subPart.mimeType == 'text/plain', orElse: () => MessagePart(body: MessagePartBody(data: '')))?.body?.data ?? '';
                // Now 'textContent' contains the text content from the multipart/alternative part
                body =  utf8.decode(base64Url.decode(textContent)) ;
              }

              if (nestedPart.mimeType == 'image/jpeg' && nestedPart.body?.data != null) {
                // Handle image/jpeg content
                List<int> imageData = base64.decode(nestedPart.body!.data!);

                // TODO: Do something with the image data
              }
            }
          }
        }

        emailDataList.add(
            EmailData(sender: sender, subject: subject, body: body , html:html));
      }


      setState(() {
        _contactText = 'Emails loaded'; // Clear the loading text
      });


    } catch (error) {
      setState(() {
        _contactText = 'Error fetching emails';
      });
      print('Error fetching emails: $error');
    }
  }



  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children:
            <Widget>[  //list of widgets inside column
              Container(
              child :
                Column(
                  children: [
                    ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
         const SizedBox(height: 40,),
          const Text('Signed in successfully.', style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
          const SizedBox(height: 70,),

    Card(
    elevation: 5, // Adjust the elevation as needed
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
      ),
    child: Padding(
    padding: const EdgeInsets.all(18.0),
    child: Text(
    _contactText,
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18, // Adjust the font size as needed
    ),
    ),
    ),
    )

    ],
                ),
    ),

          Container(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Check if emails are loaded before navigating
                    if (emailDataList.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EmailScreen(emails: emailDataList),
                        ),
                      );
                    } else {
                      // Handle case where emails are not loaded
                       ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                    content: Text('Emails not loaded yet.'),
                    ),
                    );
                    }
                  },
                  child: const Text('SHOW MAILS'),
                ),
                ElevatedButton(
                  onPressed:_handleFetchEmails, // Add this method for fetching emails
                  child: const Text('RE-FETCH EMAILS'),
                ),
                ElevatedButton(
                  onPressed: _handleSignOut,
                  child: const Text('SIGN OUT'),
                ),
              ],
            ),
          ),
        ],
      );
    }

    else {
      return SignUpScreen(handleSignIn: _handleSignIn);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),  // this gets changed according to signing
        ));
  }

  String _getHeaderValue(List<MessagePartHeader>? headers, String headerName) {
    MessagePartHeader? header = headers?.firstWhere(
          (header) => header.name == headerName,
      orElse: () => MessagePartHeader(name: headerName, value: 'Unknown'),
    );
    return header?.value ?? 'Unknown';
  }

  String extractContentByMimeType(List<MessagePart>? parts, String mimeType) {

    // if (parts != null) {
    //   print(parts.length);
    //   for (var part in parts) {
    //     print(part.mimeType);
    //   }
    // }
    if (parts != null && parts.length == 1) {
      var alternativeParts = parts.first.parts;
      if (alternativeParts != null) {
        for (var part in alternativeParts) {
          if (part.mimeType == mimeType) {
            //print('Debug: Found MIME type ${part.mimeType}');
            var bodyData = part.body?.data;
            if (bodyData != null) {
              var decodedBytes = base64Url.decode(bodyData);
              return utf8.decode(decodedBytes) ;

            }
          }
        }
      }
    }

    //print('empty');
    return '';
  }

}
