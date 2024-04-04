import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.name,
    required this.bio,
  }) : super(key: key);

  final String name, bio;

  @override
  Widget build(BuildContext context) {
    return ListTile(
       
      leading:  Image.asset(
          "assets/icons/bracelet.png",
          fit: BoxFit.cover,
        ),
     
      
      title: Text(
        name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        bio,
        style: const TextStyle(color: Color(0xFFF77D8E),),
      ),
    );
  }
}
