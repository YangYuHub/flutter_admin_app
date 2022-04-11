import 'package:flutter/cupertino.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  State<DynamicPage> createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('dy'));
  }
}
