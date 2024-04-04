import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rive/rive.dart';
import 'package:rive_animated_login/screens/home/components/graph.dart';
import '../../constants.dart';
import '../../model/menu.dart';
import '../../utils/rive_utils.dart';
import '../home/home_screen.dart';
import 'components/menu_btn.dart';
import 'components/side_bar.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
       int currentIndex = 0;
List<IconData> listOfIcons = [
    Iconsax.home,
    Iconsax.calendar_search,
    Iconsax.notification,
    Iconsax.user,
  ];

  List<String> listOfStrings = [
    'Home',
    'Search',
    'Help',
    'Profile',
  ];
  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  late SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor2,
      body: Stack(
        
        children: [
          
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 0 : -288,
            top: 0,
            child: const SideBar(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  1 * animation.value - 30 * (animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scalAnimation.value,
                child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: HomePage(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideBarOpen ? 220 : 0,
            top: 16,
            child: MenuBtn(
              press: () {
                isMenuOpenInput.value = !isMenuOpenInput.value;

                if (_animationController.value == 0) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }

                setState(
                  () {
                    isSideBarOpen = !isSideBarOpen;
                  },
                );
              },
              riveOnInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                artboard.addController(controller!);

                isMenuOpenInput =
                    controller.findInput<bool>("isOpen") as SMIBool;
                isMenuOpenInput.value = true;
              },
            ),
          ),

        

        ],

        
      ),
   





 bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .05),
        height: displayWidth * .155,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.13),
              blurRadius: 30,
              offset: Offset(0, 10),
            ),
          ],
          borderRadius: BorderRadius.circular(50),
        ),
        child: ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: displayWidth * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              setState(() {
                currentIndex = index;
                HapticFeedback.lightImpact();
                 if (index == 3) {
                  // Navigate to the other page when the fourth item is clicked
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) =>  Visitor(id: '', phone: '', userName: '', floorName: '', selectedHour: '', selectedDay: '', selectedDateText: '', selectedImagePath: '',build_id : widget.build_id, ),
                  // ));
                }
                 if (index == 2) {
                  // Navigate to the other page when the fourth item is clicked
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) =>  employeeProfileScreen(id : widget.id, build_id: widget.build_id,),
                  // ));
                }
                if (index == 1) {
                  // Navigate to the other page when the fourth item is clicked
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => Holiday(build_id:widget.build_id),
                  // ));
                }
                if (index == 0) {
                  // Navigate to the other page when the fourth item is clicked
                  // Navigator.of(context).push(MaterialPageRoute(
                  //  builder: (context) => DashboardPage(id: widget.id, build_id: widget.build_id),
                  // ));
                }
              });
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(seconds: 1, milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .32
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1, milliseconds: 500),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? displayWidth * .12 : 0,
                    width: index == currentIndex ? displayWidth * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == currentIndex
                          ? Color.fromARGB(255, 125, 131, 247).withOpacity(.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                duration: Duration(seconds: 1, milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == currentIndex
                      ? displayWidth * .31
                      : displayWidth * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                           duration: Duration(seconds: 1, milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .13 : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == currentIndex ? 1 : 0,
                           duration: Duration(seconds: 1, milliseconds: 500),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                              index == currentIndex
                                  ? '${listOfStrings[index]}'
                                  : '',
                              style: TextStyle(
                                color: Color.fromARGB(255, 125, 131, 247),
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? displayWidth * .03 : 20,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: displayWidth * .076,
                            color: index == currentIndex
                                ? Color.fromARGB(255, 125, 131, 247)
                                : Colors.black26,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom :10.0),
      //   child: Transform.translate(
      //     offset: Offset(0, 100 * animation.value),
      //     child: SafeArea(
      //       child: Container(
      //         padding:
      //             const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
      //         margin: const EdgeInsets.symmetric(horizontal: 24),
      //         decoration: BoxDecoration(
      //           color: backgroundColor2.withOpacity(0.8),
      //           borderRadius: const BorderRadius.all(Radius.circular(24)),
      //           boxShadow: [
      //             BoxShadow(
      //               color: backgroundColor2.withOpacity(0.3),
      //               offset: const Offset(0, 20),
      //               blurRadius: 20,
      //             ),
      //           ],
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             ...List.generate(
      //               bottomNavItems.length,
      //               (index) {
      //                 Menu navBar = bottomNavItems[index];
      //                 return BtmNavItem(
      //                   navBar: navBar,
      //                   press: () {
      //                     RiveUtils.chnageSMIBoolState(navBar.rive.status!);
      //                     updateSelectedBtmNav(navBar);
      //                   },
      //                   riveOnInit: (artboard) {
      //                     navBar.rive.status = RiveUtils.getRiveInput(artboard,
      //                         stateMachineName: navBar.rive.stateMachineName);
      //                   },
      //                   selectedNav: selectedBottonNav,
      //                 );
      //               },
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
