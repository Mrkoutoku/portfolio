import 'package:flutter/material.dart';
import 'package:fashion_store/theme/color.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';



void main() => runApp(const MailApp());

class MailApp extends StatelessWidget {
  const MailApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      debugShowCheckedModeBanner: false,
      home: MailScreen(),
    );
  }
}

class MailScreen extends StatefulWidget {
  const MailScreen({Key? key}) : super(key: key);

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  late TextEditingController _emailController;
  late TextEditingController _bodyController;
  late TextEditingController _subjectController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _bodyController = TextEditingController();
    _subjectController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _bodyController.dispose();
    _subjectController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bottomBarColor,
      appBar: AppBar(
          backgroundColor: appBgColor,
          title: Text(
            'お問い合わせ/ご注文',
            style: TextStyle(
              color: Colors.black,
            ),
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: '上記メールアドレスをご記入ください',
                  labelText: 'koutoku0513engineer@gmail.com',

                ),

              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _subjectController,
                decoration: InputDecoration(hintText: '件名'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(hintText: '本文: インスタグラムアカウント/商品名/個数'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: buttonColor, // foreground
                  ),
                  onPressed: _sendEmail, child: Text('送信する')),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

    );
  }

  Future<void> _sendEmail() async {
    final email = Email(
      body: _bodyController.text,
      subject: _subjectController.text,
      recipients: [_emailController.text],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
}