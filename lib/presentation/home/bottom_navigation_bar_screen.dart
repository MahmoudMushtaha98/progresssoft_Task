import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/constant/my_color.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/home/widget/home_screen.dart';
import 'package:progresssoft_task/presentation/home/widget/profile_screen.dart';
import 'package:progresssoft_task/presentation/model/register_model.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  static const String pageRoute = '/navigator';

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int selectedIndex = 0;
  RegisterModel? registerModel;

  @override
  void initState() {
    BlocProvider.of<HomeBloc>(context).add(LoadDataEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    registerModel = ModalRoute.of(context)!.settings.arguments as RegisterModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: progressColor,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: progressColor,
        indicatorColor: Colors.transparent,
        selectedIndex: selectedIndex,
        surfaceTintColor: Colors.transparent,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_filled,
              color: selectedIndex == 0 ? Colors.amber : Colors.white,
            ),
            label: 'Home',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.person,
                color: selectedIndex == 1 ? Colors.amber : Colors.white,
              ),
              label: 'Profile'),
        ],
      ),
      body: [
        const HomeScreen(),
        ProfileScreen(
          registerModel: registerModel!,
        )
      ][selectedIndex],
    );
  }
}
