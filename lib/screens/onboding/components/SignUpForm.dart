import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';
import 'package:iconsax/iconsax.dart';
import '../../entryPoint/entry_point.dart';
import 'package:iconsax/iconsax.dart';
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedGender;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singIn(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    Future.delayed(
      const Duration(seconds: 1),
      () {
        if (_formKey.currentState!.validate()) {
          success.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
              // Navigate & hide confetti
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EntryPoint(),
                  ),
                );
              });
            },
          );
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              reset.fire();
            },
          );
        }
      },
    );
  }

TextEditingController weightController = TextEditingController();
TextEditingController heightController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController ageController = TextEditingController();
 
 Future<void> processSignUp(BuildContext context) async {
  setState(() {
    isShowConfetti = true;
    isShowLoading = true;
  });

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );

    // User successfully created
    success.fire();

    // Store additional user information and create 'activityData' in Firestore
    String userUid = userCredential.user?.uid ?? '';
    await FirebaseFirestore.instance.collection('users').doc(userUid).set({
      'email': emailController.text,
      'height': heightController.text,
      'weight': weightController.text,
      'gender': selectedGender,
      'age':ageController.text,
      'activityData': {
        'distance': 0.0,
        'calories': 0.0,
        'bpms': 0,
      },
    });

    // Print user information
    print("User created with UID: $userUid");

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  } catch (e) {
    print("Error during user creation: $e");
    error.fire();
  } finally {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isShowLoading = false;
      });
      reset.fire();
    });
  }
}




  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Email",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            

              
            Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    // You can add more specific validation logic here if needed
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Iconsax.message,
                        color: Color.fromARGB(255, 125, 131, 247),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
const Text(
                "Password",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    // You can add more specific validation logic here if needed
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Iconsax.lock,
                        color: Color.fromARGB(255, 125, 131, 247),
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),





               const Text(
                "height",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
             Padding(
  padding: const EdgeInsets.only(top: 8, bottom: 16),
  child: TextFormField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: heightController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a number';
      }
      // You can add more specific validation logic here if needed
      return null;
    },
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.height,
          color: Color.fromARGB(255, 125, 131, 247),
          size: 24, // Adjust the size as needed
        ),
      ),
    ),
  ),
),



              const Text(
                "Weight",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
              Padding(
  padding: const EdgeInsets.only(top: 8, bottom: 16),
  child: TextFormField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: weightController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a number';
      }
      // You can add more specific validation logic here if needed
      return null;
    },
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Iconsax.weight,
          color: Color.fromARGB(255, 125, 131, 247),
          size: 24, // Adjust the size as needed
        ),
      ),
    ),
  ),
),

const Text(
                "age",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),

 Padding(
  padding: const EdgeInsets.only(top: 8, bottom: 16),
  child: TextFormField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    controller: ageController,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a number';
      }
      // You can add more specific validation logic here if needed
      return null;
    },
    decoration: InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Iconsax.weight,
          color: Color.fromARGB(255, 125, 131, 247),
          size: 24, // Adjust the size as needed
        ),
      ),
    ),
  ),
),

// ...

const Text(
  "Gender",
  style: TextStyle(
    color: Colors.black54,
  ),
),
Container(
  width: selectedGender == null ? 270 : 270, // Adjust the width as needed
  child:Padding(
  
  padding: const EdgeInsets.only(top: 8, bottom: 16),
  child: DropdownButtonFormField<String>(
    decoration: const InputDecoration(
      prefixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Icon(
                    Icons.male,
                    size: 25,
                    color: Color.fromARGB(255, 125, 131, 247),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Icon(
                    Icons.female,
                    size: 25,
                    color: Color.fromARGB(255, 125, 131, 247),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    value: selectedGender,
    onChanged: (String? newValue) {
      setState(() {
        selectedGender = newValue;
      });
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Gender is required';
      }
      return null;
    },
    items: ["Male", "Female"].map((String value) {
      return DropdownMenuItem<String>(
        
        value: value,
        child: Text(value),
      );
    }).toList(),
  ),
),),


              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 24),
                child: ElevatedButton.icon(
                  onPressed: () {
                    processSignUp(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 125, 131, 247),
                    minimumSize: const Size(double.infinity, 56),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                  ),
                  icon: const Icon(
                    CupertinoIcons.arrow_right,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  label: const Text("Sign Up" ,style: TextStyle(
      color: Colors.white,
      
    ),),
                ),
              ),

            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  fit: BoxFit.cover,
                  onInit: _onCheckRiveInit,
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: _onConfettiRiveInit,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
      ],
    );
  }






}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
