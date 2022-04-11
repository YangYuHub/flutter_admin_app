import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_app/page/dashboard/dashboard_screen.dart';

class DynamicPage extends StatefulWidget {
  const DynamicPage({Key? key}) : super(key: key);

  @override
  State<DynamicPage> createState() => DynamicPageState();
}

class DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(child: DashboardScreen(), color: Color(0xFF212332));
  }
}
