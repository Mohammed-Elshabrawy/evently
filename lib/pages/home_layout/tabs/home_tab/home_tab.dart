import 'package:evently/pages/home_layout/tabs/home_tab/widget/custom_app_bar.dart';
import 'package:evently/pages/home_layout/tabs/home_tab/widget/event_item.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => EventItem(),
        itemCount: 10,
      ),
    );
  }
}
