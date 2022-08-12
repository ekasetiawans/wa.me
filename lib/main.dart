import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WA Me',
      theme: ThemeData.from(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _txtPhone = TextEditingController();
  @override
  void dispose() {
    _txtPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WA.me'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: FittedBox(
                fit: BoxFit.contain,
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _txtPhone,
                  builder: (context, value, child) {
                    return Text(
                      value.text,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const Divider(),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            childAspectRatio: 1.3,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (int i = 1; i <= 9; i++)
                InkWell(
                  onTap: () {
                    _txtPhone.text += i.toString();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      i.toString(),
                      style: const TextStyle(
                        fontSize: 32,
                      ),
                    ),
                  ),
                ),
              Container(),
              InkWell(
                onTap: () {
                  _txtPhone.text += 0.toString();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    0.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_txtPhone.text.isEmpty) return;
                  _txtPhone.text =
                      _txtPhone.text.substring(0, _txtPhone.text.length - 1);
                },
                child: Container(
                  alignment: Alignment.center,
                  child: const Icon(Icons.backspace),
                ),
              ),
            ],
          ),
          const Divider(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  String phone = _txtPhone.text.replaceAll('+', '');
                  if (phone.startsWith('08')) {
                    phone = '62${phone.substring(1)}';
                  }

                  launchUrlString(
                    'https://api.whatsapp.com/send?phone=$phone',
                    mode: LaunchMode.externalApplication,
                  );
                },
                icon: const Icon(Icons.message),
                label: const Text('Send Message'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  onPrimary: Colors.white,
                  padding: const EdgeInsets.all(16.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
