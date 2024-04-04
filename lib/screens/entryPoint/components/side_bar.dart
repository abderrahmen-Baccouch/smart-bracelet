import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive_animated_login/screens/onboding/components/sign_in_form.dart';
import '../../../model/menu.dart';
import '../../../utils/rive_utils.dart';
import 'info_card.dart';
import 'side_menu.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Menu selectedSideMenu = sidebarMenus.first;
   final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInForm(), 
        ),
      );
    } catch (e) {
      print("Error during logout: $e");
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF17203A),
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "Smart Health",
                bio: "Smart Bracelet",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Color(0xFFF77D8E),),
                ),
              ),
              ...sidebarMenus
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "History".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Color(0xFFF77D8E),),
                ),
              ),
              ...sidebarMenus2
                  .map((menu) => SideMenu(
                        menu: menu,
                        selectedMenu: selectedSideMenu,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          setState(() {
                            selectedSideMenu = menu;
                          });
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
                  Padding(
  padding: const EdgeInsets.only(left: 24, top: 30, bottom: 16),
  child: GestureDetector(
    onTap: () {
      // Add your logout logic here
    },
    child: Row(
      children: [
        Icon(
          Icons.logout,  // Replace with your desired logout icon
          color: Color.fromARGB(255, 200, 0, 27),
          size: 24,  // Adjust the size as needed
        ),
        SizedBox(width: 12),  // Adjust the spacing between the icon and text
       
       
       GestureDetector(
      // onTap: () {
      //   _signOut(context);
      // },
      child: Text(
        "Logout".toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Color.fromARGB(255, 255, 255, 255)),
      ),
    ),
      ],
    ),
  ),
),

            ],
          ),
        ),
      ),
    );
  }
}
