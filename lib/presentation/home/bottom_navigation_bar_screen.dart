import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progresssoft_task/bloc/my_app_bloc.dart';
import 'package:progresssoft_task/constant/my_color.dart';
import 'package:progresssoft_task/presentation/home/bloc/home_bloc.dart';
import 'package:progresssoft_task/presentation/home/widget/home_screen.dart';
import 'package:progresssoft_task/presentation/home/widget/profile_screen.dart';
import 'package:progresssoft_task/utills/model/language_model.dart';

import '../../utills/model/register_model.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({super.key});

  static const String pageRoute = '/navigator';

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
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
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButton(
              icon: Icon(
                Icons.language,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              items: LanguageModel.languageList()
                  .map<DropdownMenuItem<LanguageModel>>((LanguageModel value) {
                return DropdownMenuItem<LanguageModel>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              onChanged: (value) {
                BlocProvider.of<MyAppBloc>(context)
                    .add(ChangeLanguageEvent(value!.languageCode));
              },
            ),
          )
        ],
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
