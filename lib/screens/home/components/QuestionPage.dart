import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive_animated_login/screens/home/components/button.dart';
import 'package:rive_animated_login/screens/onboding/components/animated_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../onboding/components/sign_in_dialog.dart';
class QuestionPage extends StatefulWidget {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with SingleTickerProviderStateMixin {
 CarouselController _carouselController = new CarouselController();
  int _current = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
void _onPressed() async {
  _animationController.forward();
  bool allQuestionsAnswered = isAllOptionsSelected();

  if (allQuestionsAnswered) {
    try {
    
      User? user = FirebaseAuth.instance.currentUser;

     
      if (user != null) {
        
        String userId = user.uid;

        // Create a map to store user information
        Map<String, dynamic> userInformation = {};

        // Iterate through each movie and add the selected values to the userInformation map
        for (var movie in _movies) {
          String category = movie['title'];

          String selectedValue = "";

          if (movie['selections']['rating']) {
            selectedValue = movie['rating'] ?? "";
          } else if (movie['selections']['duration']) {
            selectedValue = movie['duration'] ?? "";
          } else if (movie['selections']['action']) {
            selectedValue = movie['action'] ?? "";
          }

          // Add the selected value to the userInformation map
          userInformation[category] = selectedValue;
        }

        try {
          
          // Set user information in the 'users' collection
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'userInformation': userInformation,
            // Add any other user-specific fields here
          }, SetOptions(merge: true));

          // Set user information in the 'userInformations' collection
          await FirebaseFirestore.instance.collection('userInformations').doc(userId).set(userInformation, SetOptions(merge: true));
        } catch (e, stackTrace) {
          print("Error saving data to Firestore: $e\n$stackTrace");
          // Handle the error as needed
        }

        try {
          // Check if the widget is still mounted before navigating
          if (mounted) {
            Navigator.pop(context); 
          }
        } catch (e, stackTrace) {
          print("Error navigating: $e\n$stackTrace");
         
        }
      } else {
        print("User is null. Unable to retrieve UID.");
        // Handle the case where the user is not authenticated
      }
    } catch (e, stackTrace) {
      print("Error getting current user: $e\n$stackTrace");
      
    }
  } else {
    try {
      // Check if the widget is still mounted before showing the snackbar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  'Please answer all questions.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e, stackTrace) {
      print("Error showing snackbar: $e\n$stackTrace");
      
    }
  }

  _animationController.forward();
}






 List<Map<String, dynamic>> _movies = [
  {
    'title': 'Situation of stress',
    'image': 'https://img.freepik.com/free-photo/portrait-young-male-pole-dancer_23-2148411978.jpg',
    'description': 'Preferred stress relief?',
    'rating': 'THINK',
    'duration': 'MOVE',
    'action': 'GASP',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },
  {
    'title': 'Physical activity',
    'image': 'https://img.freepik.com/premium-photo/portrait-young-sportive-girl-training-gym-doing-ball-slams-exrcises-isolated-green-background-neon_155003-45634.jpg?size=626&ext=jpg&ga=GA1.1.1880011253.1699056000&semt=ais',
    'description': 'How much do you play sports?',
    'rating': 'DAILY',
    'duration': 'WEEKLY',
    'action': 'RARE',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },
  { 
    'title': 'water consumption',
    'image': 'https://media.istockphoto.com/id/639088538/photo/muscular-athlete-with-strong-abs-drinking-water.jpg?s=612x612&w=0&k=20&c=5LDB-HSbXB7Aql7FaTER0vRSq-yN3AsT5VcW0oJ1MTE=',
    'description': "your daily water consumption?",
    'rating': 'LOW',
    'duration': 'MEDIUM',
    'action': 'HIGH',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },
  {
    'title': 'Heart Health Inquiry',
    'image': 'https://e0.pxfuel.com/wallpapers/146/326/desktop-wallpaper-sports-running-track-iphone-8-track-and-field.jpg',
    'description': 'Do you have any heart issues?',
    'rating': 'YES',
    'duration': 'NO',
    'action': 'NO IDEA',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },

   {
    'title': 'Sleep Duration Inquiry',
    'image': 'https://thumbs.dreamstime.com/b/love-top-view-young-professional-tennis-player-sleeping-his-bedroom-sportwear-racket-loving-sport-even-more-than-198113805.jpg',
    'description': 'Your nightly sleep duration??',
    'rating': 'SHORT',
    'duration': 'MOY',
    'action': 'LONG',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },

  {
    'title': 'Daily Nourishment Inquiry',
    'image': 'https://images.unsplash.com/photo-1587996597484-04743eeb56b4?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Zml0bmVzcyUyMGZvb2R8ZW58MHx8MHx8fDA%3D',
    'description': 'Daily food habits?',
    'rating': 'HEALTHY',
    'duration': 'MOY',
    'action': 'POOR',
    'selections': {'rating': false, 'duration': false, 'action': false},
  },

   {
    'title': 'Fitness Goals',
    'image': 'https://e0.pxfuel.com/wallpapers/606/355/desktop-wallpaper-iphone-gym-physical-fitness.jpg',
    'description': 'your preferred workout intensity?',
    'rating': 'LOSE',
    'duration': 'KEEP',
    'action': 'BUILD',
    'selections': {'rating': false, 'duration': false, 'action': false},
  }
];




  
String? _selectedRating;
String? _selectedDuration;
String? _selectedAction;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  bool isAllOptionsSelected() {
    for (var movie in _movies) {
      if (!(movie['selections']['rating'] == true ||
          movie['selections']['duration'] == true ||
          movie['selections']['action'] == true)) {
        return false;
      }
    }
    return true;
  }

void _handleRadioChange(String category, bool selected) {
  setState(() {
    switch (category) {
      case 'rating':
        _selectedRating = selected ? 'Reflect' : null;
        break;
      case 'duration':
        _selectedDuration = selected ? 'DAILY' : null;
        break;
      case 'action':
        _selectedAction = selected ? 'LOW' : null;
        break;
    }
  });
}

Widget _buildRadioButtons(String category, List<String> options) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: options.map((option) {
      return Row(
        children: [
          Radio(
            value: option,
            groupValue: _getSelectedValue(category),
            onChanged: (value) {
              _handleRadioChange(category, value.toString() == 'true');
            },
          ),
          Text(option),
        ],
      );
    }).toList(),
  );
}

String? _getSelectedValue(String category) {
  switch (category) {
    case 'rating':
      return _selectedRating;
    case 'duration':
      return _selectedDuration;
    case 'action':
      return _selectedAction;
    default:
      return null;
  }
}

String? _selectedCategory;
void _handleCategoryChange(String category, int index) {
  setState(() {
    if (_movies[index]['selections'] != null) {
      _movies[index]['selections'].forEach((key, value) {
        if (key == category) {
          _movies[index]['selections'][key] = true;
        } else {
          _movies[index]['selections'][key] = false;
        }
      });
    }
  });
}



  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Image.network(_movies[_current]['image'], fit: BoxFit.cover),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(1),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                      Colors.grey.shade50.withOpacity(0.0),
                    ]
                  )
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 500.0,
                  aspectRatio: 16/9,
                  viewportFraction: 0.70,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                carouselController: _carouselController,

                items: _movies.map((movie) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                height: 320,
                                margin: EdgeInsets.only(top: 30),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Image.network(movie['image'], fit: BoxFit.cover),
                              ),
                              SizedBox(height: 20),
                              Text(movie['title'], style: 
                                TextStyle(
                                  
                                  fontSize: 16.0, 
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              // rating
                              SizedBox(height: 5),
                              Container(
                                child: Text(movie['description'], style: TextStyle(
                                  fontSize: 14.0,
                                  color: Color.fromARGB(255, 125, 131, 247) 
                                ), textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 20),
                            AnimatedOpacity(
  duration: Duration(milliseconds: 500),
  opacity: _current == _movies.indexOf(movie) ? 1.0 : 0.0,
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
       InkWell(
  onTap: () {
    setState(() {
      _handleCategoryChange('rating', _current);
    });
  },
  child: Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: (movie['selections']['rating'] == true) ? Colors.blue : Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
  (movie['rating'] as String?) ?? "",
  style: TextStyle(
    fontSize: 14.0,
    color: (movie['selections']['rating'] == true)
        ? Colors.white
        : Colors.grey.shade600,
  ),
),

      ],
    ),
  ),
),


                        // Duration
              // Duration
// Duration
// Duration
InkWell(
  onTap: () {
    setState(() {
      _handleCategoryChange('duration', _current);
    });
  },
  child: Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: (movie['selections']['duration'] == true) ? Colors.blue : Colors.white,

      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Text(
  (movie['duration'] as String?) ?? "",
  style: TextStyle(
    fontSize: 14.0,
    color: (movie['selections']['duration'] == true)
        ? Colors.white
        : Colors.grey.shade600,
  ),
),

      ],
    ),
  ),
),


// Action
InkWell(
  onTap: () {
    setState(() {
      _handleCategoryChange('action', _current);
    });
  },
  child: Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: (movie['selections']['action'] == true) ? Colors.blue : Colors.white,

      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       Text(
  (movie['action'] as String?) ?? "",
  style: TextStyle(
    fontSize: 14.0,
    color: (movie['selections']['action'] == true)
        ? Colors.white
        : Colors.grey.shade600,
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
                            ],
                          ),
                        )
                      );
                    },
                  );
                }).toList(),
              ),
            ),
           Positioned(
            bottom: 3.5,
            right: 16.0,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: ElevatedButton.icon(
  onPressed: _onPressed, // Call the _onPressed method directly
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color(0xFFF77D8E),
    minimumSize: const Size(40, 53),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
        bottomRight: Radius.circular(10),
        bottomLeft: Radius.circular(25),
      ),
    ),
  ),
  icon: const Icon(
    CupertinoIcons.arrow_right,
    color: Color.fromARGB(255, 255, 255, 255),
  ),
  label: Text(
    "Confirm",
    style: GoogleFonts.poppins(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  ),
),
            ),
          ),
        

                    ],
        
        ),
        
      ),
      
  
    );
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}