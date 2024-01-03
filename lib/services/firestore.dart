// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // get collection of notes
  final CollectionReference education =
      FirebaseFirestore.instance.collection('education');

  final CollectionReference namecontact =
      FirebaseFirestore.instance.collection('details');

  //create: add a new note
  Future<void> adddata(
      String year, String educationqualification, String educationloaction) {
    return education.add({
      'year': year,
      'educationqualification': educationqualification,
      'educationloaction': educationloaction,
      //'timestamp': Timestamp.now(),
    });
  }

  // Home Page Details
  Future<void> addNameContact(String name, String contact) => namecontact.add({
        'name': name,
        'contact': contact,
        'timestamp': Timestamp.now(),
      });
  //

  Stream<QuerySnapshot> getEducationsStream() {
    final EducationsStream =
        education.orderBy('timestamp', descending: true).snapshots();

    return EducationsStream;
  }

  Future<void> updateData(String docID, String newYear,
      String newEducationqualification, String newEducationloaction) {
    return education.doc(docID).update({
      'year': newYear,
      'educationqualification': newEducationqualification,
      'educationloaction': newEducationloaction,
      'timestamp': Timestamp.now(),
    });
  }

  Future<void> deleteEducation(String docID) {
    return education.doc(docID).delete();
  }
}
