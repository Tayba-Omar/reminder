import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';



class ReminderService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<void> addReminder(String reminderText, DateTime reminderTime) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _firestore
        .collection("USERS")
        .doc(user.uid)
        .collection("REMINDERS")
        .add({
      "text": reminderText,
      "timestamp": Timestamp.fromDate(reminderTime),
    });
  }



  Stream<List<Map<String, dynamic>>> getReminders() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection("USERS")
        .doc(user.uid)
        .collection("REMINDERS")
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // إضافة المعرف لتسهيل الحذف
        return data;
      }).toList();
    });
  }



  Future<void> deleteReminder(String reminderId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    await _firestore
        .collection("USERS")
        .doc(user.uid)
        .collection("REMINDERS")
        .doc(reminderId)
        .delete();
  }
}
