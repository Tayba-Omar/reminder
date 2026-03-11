import 'package:flutter/material.dart';
import '../Design/Color.dart';
import 'WelcomeScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _reminderController = TextEditingController();
  DateTime? _selectedDateTime;

  // 🔹 LOCAL DATA (NO FIREBASE)
  final List<Map<String, dynamic>> _reminders = [];

  void logout() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Welcomescreen()),
    );
  }

  Future<void> pickDateTime() async {
    DateTime now = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text(
              "Add Reminder",
              style: TextStyle(color: txtMainColor),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _reminderController,
                  decoration: InputDecoration(
                    hintText: "Write the reminder",
                    hintStyle:
                    TextStyle(color: txtMainColor.withOpacity(0.6)),
                  ),
                  style: TextStyle(color: txtMainColor),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    await pickDateTime();
                    setStateDialog(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: txtMainColor,
                  ),
                  child: const Text("Select Date & Time"),
                ),
                if (_selectedDateTime != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    "Selected: ${_selectedDateTime!.toString().substring(0, 16)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: txtMainColor,
                    ),
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _reminderController.clear();
                  _selectedDateTime = null;
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: TextStyle(color: txtMainColor)),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_reminderController.text.isNotEmpty &&
                      _selectedDateTime != null) {
                    setState(() {
                      _reminders.add({
                        "text": _reminderController.text,
                        "time": _selectedDateTime!,
                      });
                    });

                    _reminderController.clear();
                    _selectedDateTime = null;
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: txtMainColor,
                ),
                child: const Text("ADD",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _reminderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: showAddDialog,
            backgroundColor: txtMainColor,
            child: Icon(Icons.add, color: Colors.pink[100]),
            heroTag: 'add',
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            onPressed: logout,
            backgroundColor: txtMainColor,
            child: Icon(Icons.logout, color: Colors.pink[100]),
            heroTag: 'logout',
          ),
        ],
      ),
      body: Stack(
        children: [
          // 🔹 BACKGROUND CIRCLES (UNCHANGED)
          Positioned(
            top: -60,
            left: -50,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.pink[300],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: -50,
            right: -145,
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 65,
            right: -175,
            child: Container(
              height: 200,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -250,
            right: 40,
            child: Container(
              height: 500,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -175,
            child: Container(
              height: 200,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.pink[100],
                shape: BoxShape.circle,
              ),
            ),
          ),

          // 🔹 REMINDERS LIST
          Padding(
            padding: const EdgeInsets.all(16),
            child: _reminders.isEmpty
                ? Center(
              child: Text(
                "No reminders yet.",
                style: TextStyle(color: txtMainColor),
              ),
            )
                : ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final reminder = _reminders[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin:
                  const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.alarm,
                        color: Colors.purple),
                    title: Text(
                      reminder['text'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: txtMainColor,
                      ),
                    ),
                    subtitle: Text(
                      reminder['time']
                          .toString()
                          .substring(0, 16),
                      style: TextStyle(
                        color:
                        txtMainColor.withOpacity(0.7),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _reminders.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../Design/Color.dart';
// import '../Services/Auth/AuthServices.dart';
// import '../Services/ReminderServices.dart';
// import 'WelcomeScreen.dart';
//
// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});
//
//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }
//
// class _HomescreenState extends State<Homescreen> {
//   final ReminderService reminderService = ReminderService();
//   final TextEditingController _reminderController = TextEditingController();
//   DateTime? _selectedDateTime;
//
//
//   logout(){
//     AuthService auth = AuthService();
//     auth.logout();
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (context) => Welcomescreen()),
//     );
//   }
//
//   Future<void> pickDateTime() async {
//     DateTime now = DateTime.now();
//
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: now,
//       firstDate: now,
//       lastDate: DateTime(now.year + 5),
//     );
//
//     if (pickedDate == null) return;
//
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: TimeOfDay.now(),
//     );
//
//     if (pickedTime == null) return;
//
//     setState(() {
//       _selectedDateTime = DateTime(
//         pickedDate.year,
//         pickedDate.month,
//         pickedDate.day,
//         pickedTime.hour,
//         pickedTime.minute,
//       );
//     });
//   }
//
//   void showAddDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => StatefulBuilder(
//         builder: (context, setStateDialog) {
//           return AlertDialog(
//             title: Text(
//               "Add Reminder",
//               style: TextStyle(color: txtMainColor),
//             ),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   controller: _reminderController,
//                   decoration: InputDecoration(
//                     hintText: "Write the reminder",
//                     hintStyle: TextStyle(color: txtMainColor.withOpacity(0.6)),
//                   ),
//                   style: TextStyle(color: txtMainColor),
//                 ),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () async {
//                     await pickDateTime();
//                     setStateDialog(() {});
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: txtMainColor,
//                   ),
//                   child: const Text("Select Date & Time"),
//                 ),
//                 if (_selectedDateTime != null) ...[
//                   const SizedBox(height: 8),
//                   Text(
//                     "Selected: ${_selectedDateTime!.toLocal().toString().substring(0, 16)}",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: txtMainColor,
//                     ),
//                   ),
//                 ]
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   _reminderController.clear();
//                   _selectedDateTime = null;
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   "Cancel",
//                   style: TextStyle(color: txtMainColor),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () async {
//                   if (_reminderController.text.isNotEmpty && _selectedDateTime != null) {
//                     await reminderService.addReminder(
//                       _reminderController.text,
//                       _selectedDateTime!,
//                     );
//                     _reminderController.clear();
//                     _selectedDateTime = null;
//                     Navigator.pop(context);
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(
//                         content: Text(
//                           'Please enter reminder text and select time',
//                           style: TextStyle(color: txtMainColor),
//                         ),
//                         backgroundColor: Colors.black87,
//                       ),
//                     );
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: txtMainColor,
//                 ),
//                 child: Text(
//                   "ADD",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           FloatingActionButton(
//             onPressed: showAddDialog,
//             backgroundColor: txtMainColor,
//             child:  Icon(Icons.add,color: Colors.pink[100]),
//             heroTag: 'add',
//           ),
//            SizedBox(height: 12),
//           FloatingActionButton(
//             onPressed: logout,
//             backgroundColor: txtMainColor,
//             child:  Icon(Icons.logout, color: Colors.pink[100]),
//             heroTag: 'logout',
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           Positioned(
//             top: -60,
//             left: -50,
//             child: Container(
//               height: 300,
//               width: 300,
//               decoration: BoxDecoration(
//                 color: Colors.pink[300],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -50,
//             right: -145,
//             child: Container(
//               height: 200,
//               width: 500,
//               decoration: BoxDecoration(
//                 color:Colors.blue[100],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 65,
//             right: -175,
//             child: Container(
//               height: 200,
//               width: 500,
//               decoration: BoxDecoration(
//                 color: Colors.pink[100],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -250,
//             right: 40,
//             child: Container(
//               height: 500,
//               width: 300,
//               decoration: BoxDecoration(
//                 color: Colors.blue[100],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: -40,
//             right: -175,
//             child: Container(
//               height: 200,
//               width: 400,
//               decoration: BoxDecoration(
//                 color: Colors.pink[100],
//                 shape: BoxShape.circle,
//               ),
//             ),
//           ),
//
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: StreamBuilder<List<Map<String, dynamic>>>(
//               stream: reminderService.getReminders(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   final reminders = snapshot.data!;
//                   if (reminders.isEmpty) {
//                     return Center(
//                       child: Text(
//                         "No reminders yet.",
//                         style: TextStyle(color: txtMainColor),
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: reminders.length,
//                     itemBuilder: (context, index) {
//                       final reminder = reminders[index];
//                       return Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         margin: const EdgeInsets.symmetric(vertical: 8),
//                         child: ListTile(
//                           leading: const Icon(Icons.alarm, color: Colors.purple),
//                           title: Text(
//                             reminder['text'],
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: txtMainColor,
//                             ),
//                           ),
//                           subtitle: Text(
//                             reminder['timestamp'].toDate().toLocal().toString().substring(0, 16),
//                             style: TextStyle(
//                               color: txtMainColor.withOpacity(0.7),
//                             ),
//                           ),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.delete, color: Colors.red),
//                             onPressed: () {
//                               reminderService.deleteReminder(reminder['id']);
//                             },
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text(
//                       "Error: ${snapshot.error}",
//                       style: TextStyle(color: txtMainColor),
//                     ),
//                   );
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//
//     );
//   }
// }
