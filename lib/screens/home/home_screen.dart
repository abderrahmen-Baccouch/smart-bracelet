import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:rive_animated_login/model/helpers.dart';
import 'package:rive_animated_login/screens/home/components/QuestionPage.dart';
import 'package:rive_animated_login/screens/home/components/dates.dart';
import 'package:rive_animated_login/screens/home/components/graph.dart';
import 'package:rive_animated_login/screens/home/components/info.dart';
import 'package:rive_animated_login/screens/home/components/stats.dart';
import 'package:rive_animated_login/screens/home/components/steps.dart';
import '../../model/question.dart';
import 'components/Question_card.dart';
import 'components/Question_card.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {

  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}










class _HomePageState extends State<HomePage> {

  




  
   
Color container1Color = Color.fromARGB(255, 125, 131, 247); // Original color
Color container2Color = Color.fromARGB(255, 238, 238, 238); // Original color
Color container3Color = Color.fromARGB(255, 238, 238, 238);  // Original color
Color container4Color = Color.fromARGB(255, 238, 238, 238); // Original color

Color iconColor1 = Colors.black; // Original icon color for container 1
Color iconColor2 = Colors.black; // Original icon color for container 2
Color iconColor3 = Colors.black; // Original icon color for container 3
Color iconColor4 = Colors.black; // Original icon color for container 4

Color textColor1 = Colors.white; // Original text color for container 1
Color textColor2 = Colors.black; // Original text color for container 2
Color textColor3 = Colors.black; // Original text color for container 3
Color textColor4 = Colors.black; // Original text color for container 4

Color descColor1 = Colors.white; // Original text color for container 1
Color descColor2 = Color.fromARGB(255, 113, 113, 113); // Original text color for container 2
Color descColor3 = Color.fromARGB(255, 113, 113, 113); // Original text color for container 3
Color descColor4 = Color.fromARGB(255, 113, 113, 113); // Original text color for container 4

Color bgColor1 =  Color(0xFFF77D8E); // Original text color for container 1
Color bgColor2 =  Color.fromARGB(255, 105, 101, 101); // Original text color for container 2
Color bgColor3 =  Color.fromARGB(255, 105, 101, 101); // Original text color for container 3
Color bgColor4 =  Color.fromARGB(255, 105, 101, 101);// Original text color for container 4

Color icColor1 =  Colors.white;
Color icColor2 =  Colors.black;
Color icColor3 =  Colors.black;
Color icColor4 =  Colors.black;

void _updateContainerColor(int containerNumber) {
  setState(() {
    container1Color = containerNumber == 1 ? Color.fromARGB(255, 125, 131, 247) : Color.fromARGB(255, 238, 238, 238);
    container2Color = containerNumber == 2 ? Color.fromARGB(255, 125, 131, 247) : Color.fromARGB(255, 238, 238, 238);
    container3Color = containerNumber == 3 ? Color.fromARGB(255, 125, 131, 247) : Color.fromARGB(255, 238, 238, 238);
    container4Color = containerNumber == 4 ? Color.fromARGB(255, 125, 131, 247) : Color.fromARGB(255, 238, 238, 238);

    iconColor1 = containerNumber == 1 ? Colors.white : Colors.black;
    iconColor2 = containerNumber == 2 ? Colors.white : Colors.black;
    iconColor3 = containerNumber == 3 ? Colors.white : Colors.black;
    iconColor4 = containerNumber == 4 ? Colors.white : Colors.black;

    textColor1 = containerNumber == 1 ? Colors.white : Colors.black;
    textColor2 = containerNumber == 2 ? Colors.white : Colors.black;
    textColor3 = containerNumber == 3 ? Colors.white : Colors.black;
    textColor4 = containerNumber == 4 ? Colors.white : Colors.black;

    descColor1 = containerNumber == 1 ? Colors.white : Color.fromARGB(255, 113, 113, 113);
    descColor2 = containerNumber == 2 ? Colors.white : Color.fromARGB(255, 113, 113, 113);
    descColor3 = containerNumber == 3 ? Colors.white : Color.fromARGB(255, 113, 113, 113);
    descColor4 = containerNumber == 4 ? Colors.white : Color.fromARGB(255, 113, 113, 113);

    bgColor1 = containerNumber == 1 ?  Color(0xFFF77D8E) : Color.fromARGB(255, 113, 113, 113);
    bgColor2 = containerNumber == 2 ?  Color(0xFFF77D8E) : Color.fromARGB(255, 113, 113, 113);
    bgColor3 = containerNumber == 3 ?  Color(0xFFF77D8E) : Color.fromARGB(255, 113, 113, 113);
    bgColor4 = containerNumber == 4 ?  Color(0xFFF77D8E) : Color.fromARGB(255, 113, 113, 113);

    icColor1 = containerNumber == 1 ? Colors.white : Colors.black;
    icColor2 = containerNumber == 2 ? Colors.white : Colors.black;
    icColor3 = containerNumber == 3 ? Colors.white : Colors.black;
    icColor4 = containerNumber == 4 ? Colors.white : Colors.black;
  });
}



double calculateBMI(double height, double weight) {
 
  if (height > 0 && weight > 0) {
 
    double bmi = weight / (height * height);
    return bmi;
  } else {
   
    return -1.0;
  }
}
double heightDouble = 0.0;
double weightDouble = 0.0;
double agetDouble = 0.0;
double bmi =0.0;
String bmiString ='';
String formattedBMI = '';
double TMB = 0.0;
String tmbString = '';
double tmbDouble = 0.0 ;
late DatabaseReference _tmbRef;
late DatabaseReference _fcmaxRef;
double FCMAX = 0.0;


Future<void> fetchCurrentUserInfoFromFirebase() async {
  
  try {
    // Get the currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String currentUserUid = user.uid;

      // Access the user's document in the 'users' collection using the UID
      var userDocument = FirebaseFirestore.instance.collection('users').doc(currentUserUid);
      var documentSnapshot = await userDocument.get();

      if (documentSnapshot.exists) {
        var userData = documentSnapshot.data();

        // Access specific fields
        String email = userData?['email'] ?? '';
        String gender = userData?['gender'] ?? '';
        String height = userData?['height'] ?? '';
        String age = userData?['age'] ?? '';

        // Access nested data
        Map<String, dynamic> userInformation = userData?['userInformation'] ?? {};
        Map<String, dynamic> activityData = userData?['activityData'] ?? {};

        // Access other fields similarly
        String dailyNourishment = userData?['Daily Nourishment Inquiry'] ?? '';
        String fitnessGoals = userData?['Fitness Goals'] ?? '';
        String heartHealthInquiry = userData?['Heart Health Inquiry'] ?? '';
        String physicalActivity = userData?['Physical activity'] ?? '';
        String situationOfStress = userData?['Situation of stress'] ?? '';
        String sleepDurationInquiry = userData?['Sleep Duration Inquiry'] ?? '';
        String waterConsumption = userData?['water consumption'] ?? '';
        String weight = userData?['weight'] ?? '';
        
        // Print the values to the console
        print('Email: $email');
        print('Gender: $gender');
        print('Height: $height');
        print('User Information: $userInformation');
        print('User activityData: $activityData');
        print('Weight: $weight');
       
        // Calculate BMI
         heightDouble = double.tryParse(height) ?? 0.0;
         weightDouble = double.tryParse(weight) ?? 0.0;
         agetDouble = double.tryParse(age) ?? 0.0;

        // Call the function
         bmi = calculateBMI(heightDouble, weightDouble);

         TMB = (88.362 + (13.397 * weightDouble ) + (4.799 * heightDouble * 100)-(5.677* agetDouble));
         tmbString = TMB.toStringAsFixed(2);
         tmbDouble = double.parse(tmbString);

            await _tmbRef.set(tmbDouble);

        bmiString = bmi.toStringAsFixed(2);
        print('BMI: $bmi');

        FCMAX = 290 - agetDouble ;
          await _fcmaxRef.set(FCMAX);

          
      } else {
        print('User document does not exist in the collection.');
      }
    } else {
      print('No user is currently signed in.');
    }
  } catch (e) {
    print('Error fetching user information: $e');
  }
}



int currentQuestionIndex = 0;
  List<List<String>> questions = [
    ['Question 1', 'Option 1', 'Option 2', 'Option 3'],
    ['Question 2', 'Option A', 'Option B', 'Option C'],
    ['Question 3', 'Answer X', 'Answer Y', 'Answer Z'],
  ];


late DateTime _selectedDate;
late DatabaseReference _bpmsRef;
late DatabaseReference _caloriesRef;
late DatabaseReference _tmpRef;

  String _bpmsValue = "2";
   String _caloriesValue = "2";
    String _tmpValue = "2";
   

  @override
  void initState() {
    super.initState();
    _resetSelectedDate();
fetchCurrentUserInfoFromFirebase();

 _tmbRef = FirebaseDatabase.instance.reference().child("tmb");
 _bpmsRef = FirebaseDatabase.instance.reference().child("bpms");
 _caloriesRef = FirebaseDatabase.instance.reference().child("calories");
 _tmpRef = FirebaseDatabase.instance.reference().child("temperature");
_fcmaxRef = FirebaseDatabase.instance.reference().child("fcmax");

    // Écoute en temps réel des changements de valeur
    _bpmsRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _bpmsValue = event.snapshot.value.toString();
        
        });
      }
    }
    );

     _caloriesRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
       _caloriesValue = event.snapshot.value.toString();
        
        });
      }
    }
    
    
    );

      _tmpRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
       _tmpValue = event.snapshot.value.toString();
        
        });
      }
    } );
      
         
  }

  void _resetSelectedDate() {
    _selectedDate = DateTime.now();
  }
 int l=0;





  @override
  Widget build(BuildContext context) {
       double doubleValue = double.tryParse(_tmpValue) ?? 0.0;
       int integerValue = doubleValue.toInt();
       String tmpv = integerValue.toString();
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
          Stack(
  children: [
    Positioned(
  top: 5,
  right: 30,
  child: AnimatedContainer(
    duration: Duration(seconds: 1),
    height: 60,
    width: 60,
    decoration: BoxDecoration(
      color: Color(0xFFF77D8E),
      image: DecorationImage(
        image: AssetImage('assets/swatch.png'),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15), 
          spreadRadius: 2, 
          blurRadius: 3, 
          offset: Offset(0, 2), 
        ),
      ],
    ),
  ),
),

    Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Text(
            "Dashboard",
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ],
      ),
    ),
  ],
),



SizedBox(height: 10,),
               Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: [
              SizedBox(width: 25),
              
            Padding(
              padding: const EdgeInsets.all(0),
             child: Text(
  'Calendar Timeline',
  style: GoogleFonts.poppins(
    textStyle: Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: Color.fromARGB(255, 68, 71, 144)),
  ),
),

            ),
           
        
            SizedBox(width: 75,),
          InkWell(
      child: Icon(l == 1 ? Icons.light_mode : Iconsax.moon, size: 25),
      onTap: () {
        setState(() {
          if (l == 0) {
            AdaptiveTheme.of(context).setDark();
            l = 1;
          } else {
            AdaptiveTheme.of(context).setLight();
            l = 0;
          }
        });
      },
    ),
          ]),
            SizedBox(height: 10),
           Theme(
  data: Theme.of(context).copyWith(
    textTheme: TextTheme(
      bodyText1:  GoogleFonts.poppins( textStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,)),
    ),
  ),
  child: MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: CalendarTimeline(
      initialDate: _selectedDate,
      selectableDayPredicate: (date) => true,
      showYears: true,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 4)),
      onDateSelected: (date) => setState(() => _selectedDate = date),
      leftMargin: 20,
      monthColor: Color.fromARGB(255, 0, 0, 0),
      dayColor: Color.fromARGB(255, 0, 0, 0),
      dayNameColor: const Color(0xFF333A47),
      activeDayColor: Color.fromARGB(255, 251, 251, 251),
      shrink: false,
      activeBackgroundDayColor: Colors.redAccent[100],
      dotsColor: const Color(0xFF333A47),
    //  selectableDayPredicate: (date) => date.day != 23,
      locale: 'en',
      ),
  ),

            ),
            
            
            const SizedBox(height: 20),
            // Center(
            //   child: Text(
            //     'Selected date is $_selectedDate',
            //     style: const TextStyle(color:Color.fromARGB(255, 32, 180, 165)),
            //   ),
            // )
          ],
        ),


                SingleChildScrollView(
                scrollDirection: Axis.horizontal,


  child: Transform.translate(
                     offset: Offset(15,10), // Move towards the left with an offset of 10 pixels
                      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: GestureDetector(
                  onTap: () => _updateContainerColor(1),
               child :  Container(
  width: 160,
  height: 165,
  decoration: BoxDecoration(
    color: container1Color,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Stack(
    children: [
      Positioned(
        top: 25,
        left: 25,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor1,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Center(
            child: Icon(
              Icons.directions_run,  // Replace with your desired icon
              color: Color.fromARGB(255, 255, 255, 255), 
            ),
          ),
        ),
      ),
         
       
     
      Positioned(
        top: 50, // Adjust the position as needed
        left: 0,
        right: 0,
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.only(top :35.0,right: 45),
              child: Text(
            tmpv+" °C", // Display the fetched salary value here
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 23,
              fontWeight: FontWeight.w500,
              color : textColor1,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
           ),
           
                Transform.translate(
                     offset: Offset(-15,2), // Move towards the left with an offset of 10 pixels
                      child: Text(
                '     Temperature ',
                style: GoogleFonts.montserrat(  // Replace with your desired font
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: descColor1 ,
                ),
              ),
                ),
          ],
        ),
      ),
    ],
  ),
),


                ),
              ),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () => _updateContainerColor(2),
                child: Container(
                  width: 160,
                  height: 180,
                  decoration: BoxDecoration(
                    color: container2Color,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),

                      
                    ],
                  ),

                  child: Stack(
    children: [
      Positioned(
        top: 25,
        left: 25,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor2,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Center(
            child: Icon(
              Icons.energy_savings_leaf,  // Replace with your desired icon
              color: Color.fromARGB(255, 255, 255, 255), // Icon color
            ),
          ),
        ),
      ),
         
         Padding(
           padding: const EdgeInsets.only(left :130.0,top: 32),
         
         ),




     


      
        Transform.translate(
                     offset: Offset(20,37), 
                     // Move towards the left with an offset of 10 pixels
                      child: Positioned(
        top: 50, // Adjust the position as needed
        left: 0,
        right: 0,
        
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.only(top :60.0,right: 20),
             child : Text(
              _caloriesValue,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: textColor2 ,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  ),
                  
                ],
                
              ),
             ),
           ),
           
                Transform.translate(
                     offset: Offset(-5,5), // Move towards the left with an offset of 10 pixels
                      child: Text(
                'Calories',
                style: GoogleFonts.montserrat(  // Replace with your desired font
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color:  descColor2 ,
                ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.translate(
                offset: Offset(-5, -13),
                child: GestureDetector(
                  onTap: () => _updateContainerColor(3),
                  child: Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      color: container3Color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),

                     child: Stack(
    children: [
      Positioned(
        top: 25,
        left: 25,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bgColor3,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
        //      image: DecorationImage(
        //   image: AssetImage('assets/icons/beat.png'),  // Replace with your image path
        //   fit: BoxFit.cover,
        // ),
          ),

          child: Center(
            child: Icon(
              Iconsax.heart,  // Replace with your desired icon
              color: Color.fromARGB(255, 255, 255, 255), // Icon color
            ),
          ),
        ),
      ),
         

      
        Transform.translate(
                     offset: Offset(-5,37), // Move towards the left with an offset of 10 pixels
                      child: Positioned(
        top: 50, // Adjust the position as needed
        left: 0,
        right: 0,
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.only(top :60.0,left: 30),
             child: Text(
             _bpmsValue,// Display the fetched value here
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w300,
              fontFamily: 'Poppins',
              color: textColor3 ,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 2),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
           ),
           
                Transform.translate(
                     offset: Offset(27,5), // Move towards the left with an offset of 10 pixels
                      child: Text(
                'BPMs',
                 style: GoogleFonts.montserrat(  // Replace with your desired font
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color:  descColor3 ,
                ),
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
              ),
              Transform.translate(
                offset: Offset(5, 0),
                child: GestureDetector(
                  onTap: () => _updateContainerColor(4),
                  child: Container(
                    width: 160,
                    height: 165,
                    decoration: BoxDecoration(
                      color: container4Color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                      
                    ),

                     child: Stack(
    children: [
      Positioned(
        top: 25,
        left: 25,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
           color: bgColor4,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Center(
            child: Icon(
              Icons.scale,  // Replace with your desired icon
              color: Color.fromARGB(255, 255, 255, 255), // Icon color
            ),
          ),
        ),
      ),
         
           


      
        Transform.translate(
                     offset: Offset(20,37), // Move towards the left with an offset of 10 pixels
                      child: Positioned(
        top: 50, // Adjust the position as needed
        left: 0,
        right: 0,
        child: Column(
          children: [
           Padding(
             padding: const EdgeInsets.only(top :50.0,right: 30),
             child : Text(
             bmiString.toString(),
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: textColor4 ,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  ),
                ],
              ),
             ),
           ),
           
                Transform.translate(
                     offset: Offset(-9,2), // Move towards the left with an offset of 10 pixels
                      child: Text(
                'BMI ',
                style: GoogleFonts.montserrat(  // Replace with your desired font
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color:  descColor4 ,
                ),
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
              ),
            ],
          ),
        ],
      ),

      
         ),


         
),

SizedBox(height : 10),
    Transform.translate(
                     offset: Offset(0,10), 
                     child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
  "Statistics",
  style: GoogleFonts.poppins(
    textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
      color: Colors.black,
      fontSize: 25,
      fontWeight: FontWeight.w500,
    ),
  ),
),
                     ),

              ),



Card(  
  color: Colors.white,
  elevation: 3,
  margin: EdgeInsets.all(10),
  shape: RoundedRectangleBorder(
    
    borderRadius: BorderRadius.circular(30), // Set a higher value for circular corners
  ),
  child: Container(
   
    height: 235,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
    ),
    child: Column(
      
      children: [
        
          Transform.translate(
                     offset: Offset(0,-10), 
                      child: Steps(),
                      ),
        SizedBox(
          child: Container(
           
            constraints: BoxConstraints(
              // Adjust constraints as needed
            ),
           child: Transform.translate(
                     offset: Offset(0,-30), 
                      child: Graph(),
                      ),
                     
          ),
           
        ),
      Transform.translate(
                     offset: Offset(0,-20),
                      child :   const Info(),),
      ],
    ),
  ),
),







              // questionnaie *************
              
      //          Column(
      //   children: [
      //     Card(
      //       child: Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Text(
      //           questions[currentQuestionIndex][0],
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(height: 16),
      //     ...List.generate(
      //       3,
      //       (index) => ElevatedButton(
      //         onPressed: () {
      //           setState(() {
      //             currentQuestionIndex++;
      //           });
      //         },
      //         child: Text(questions[currentQuestionIndex][index + 1]),
      //       ),
      //     ),
      //   ],
      // ),
SizedBox(height: 10,),
    
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Objectif",
                  style: GoogleFonts.poppins(
    textStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
      color: Colors.black,
      fontWeight: FontWeight.w500,
      fontSize: 25,
    ),
  ),
                ),
              ),
            ...recentCourses
  .take(1)
  .toList()
  .asMap()
  .entries
  .map(
    (entry) => Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: GestureDetector(
        onTap: () {
          if (entry.key == 0) {
            // Navigate to the first page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>QuestionPage(),
              ),
            );
          } else {
            // Navigate to the second page for other items
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SecondPage(),
            //   ),
            // );
          }
        },
        child: QuestionCard(
          title: entry.value.title,
          iconsSrc: entry.value.iconSrc,
          colorl: entry.value.color,
        ),
      ),
    ),
  )
  .toList(),

SizedBox(height: 80,),
            ],
          ),
        ),
        
      ),
      
    );
  }
}

 