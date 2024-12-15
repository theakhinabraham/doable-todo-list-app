import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.5),
        title: Text(
              'Settings',
              style: Theme.of(context).textTheme.displayLarge,
              ),
      ),

      body: Column(
        children: [

          SizedBox(height: 15,),

          // Allow Notifications Switch
          Center(
               child: currentWidth < 600 ? Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Row(
                  children: [
                  Text(
                  'Allow Notifications', 
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                    ),
                   ),

                   SizedBox(width: 120),

                   Switch(
                    value: true, 
                    onChanged: null,
                    ),
                  ],
                ),
                           ) : null,
             ),

             SizedBox(height: 15,),

          // Delete User Data
          Center(
               child: Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
                ),
                child: Row(
                  children: [
                  Text(
                  'Clear All Data', 
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                    ),
                   ),

                   SizedBox(width: 180),
                   Icon(
                    Icons.delete_outlined, 
                    color: Colors.white,
                    size: 25,
                    ),
                  ],
                ),
                           ),
             ),

             SizedBox(height: 15,),

             Divider(endIndent: 45, indent: 45,),

             SizedBox(height: 15,),

             // GitHub name
             SelectableText(
              "GitHub: @theakhinabraham",
              style: TextStyle(
              ),
             ),

             // Bottom text
             Expanded(
               child: Align(
                alignment: Alignment.bottomCenter,
                 child: Padding(
                   padding: const EdgeInsets.only(left: 20, right: 20),
                   child: Row(
                     children: [
                   
                      // License
                       Expanded(
                         child: Align(
                          alignment: Alignment.bottomLeft,
                           child: SelectableText(
                            "License: MIT",
                            style: TextStyle(
                            ),
                           ),
                         ),
                       ),
                   
                       SizedBox(width: 20,),
                   
                       // Version
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: SelectableText(
                              "Version: 1.0.0",
                              style: TextStyle(
                              ),
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
    );
  }
}