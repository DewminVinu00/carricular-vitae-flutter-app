// ignore_for_file: unused_import, unused_local_variable, unnecessary_import, invalid_return_type_for_catch_error, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curricular_vitae/services/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Skills extends StatefulWidget {
  Skills({Key? key}) : super(key: key);
  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  final FirestoreService firestoreService = FirestoreService();

  List<Skill> skills = List.empty(growable: true);
  TextEditingController skillController = TextEditingController();

  int selectedIndex = -1;
  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Skill List"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: skillController,
              decoration: const InputDecoration(
                hintText: 'Contact Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            /*TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                hintText: 'Contact Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),*/
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (skillController.text.isNotEmpty) {
                      var documentReference = await FirebaseFirestore.instance
                          .collection("skills")
                          .add({
                        "skill": skillController.text.trim(),
                        'timestamp': Timestamp.now(),
                      });

                      var contactId = documentReference.id;
                      print(contactId);

                      fetchData();
                      setState(() {
                        skillController.text = '';
                        skills.add(Skill(
                          skill: skillController.text.trim(),
                          id: contactId,
                        ));
                      });
                    } else {
                      print("Error: Enter data");
                    }
                  },
                  child: const Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (!isUpdating) {
                      if (selectedIndex >= 0 && selectedIndex < skills.length) {
                        setState(() {
                          isUpdating = true;
                        });

                        // Create a Contact object with the updated values
                        Skill updatedContact = Skill(
                          skill: skillController.text.trim(),
                          id: skills[selectedIndex].id,
                        );

                        // Call the update method with the updated contact
                        await update(updatedContact);

                        setState(() {
                          isUpdating = false;
                        });
                      } else {
                        // Handle the case where selectedIndex is out of bounds
                        print("Error: selectedIndex out of bounds");
                      }
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            skills.isEmpty
                ? Text(
                    'No Contact yet..',
                    style: TextStyle(fontSize: 22),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: skills.length,
                      itemBuilder: (contact, index) => getRow(index),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    if (skills.isEmpty || index < 0 || index >= skills.length) {
      return SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              index % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              skills[index].skill,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(skills[index].skill),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              // edit
              InkWell(
                onTap: () async {
                  setState(() {
                    skillController.text = skills[index].skill;
                    selectedIndex = index;
                  });
                  // Update the document and contacts list after tapping the "Edit" icon
                  try {
                    // Get the reference to the document with the specified ID
                    var documentReference = FirebaseFirestore.instance
                        .collection("details")
                        .doc(skills[index].id);

                    // Update the document
                    await documentReference.update({
                      "skill": skillController.text,
                      'timestamp': Timestamp.now(),
                    });

                    // Update the contacts list after update
                    fetchData();
                  } catch (e) {
                    print("Error updating data: $e");
                  }
                },
                child: const Icon(Icons.edit),
              ),
              // edit end
              // Delete
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete Contact"),
                        content: Text(
                            "Are you sure you want to delete this contact?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Call the delete function and pass the contact's ID
                              await delete(skills[index].id);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Delete"),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Icon(Icons.delete),
              ), //delete end
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchData() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("details").get();
      var tempList = <Skill>[];

      querySnapshot.docs.forEach((doc) {
        var contact = Skill(
          id: doc.id,
          skill: doc['skill'],
        );
        tempList.add(contact);
      });

      setState(() {
        skills.clear(); // Clear the existing list before adding new data
        skills.addAll(tempList);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> update(Skill contact) async {
    try {
      // Get the reference to the document with the specified ID
      var documentReference =
          FirebaseFirestore.instance.collection("details").doc(contact.id);

      // Update the document with the values from the contact parameter
      await documentReference.update({
        "skill": contact.skill,
        'timestamp': Timestamp.now(),
      });

      // Update the contacts list after the update
      await fetchData();
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> delete(String id) async {
    try {
      // Delete the document with the specified ID
      await FirebaseFirestore.instance.collection("details").doc(id).delete();

      setState(() {
        // Remove the deleted contact from the local list
        skills.removeWhere((contact) => contact.id == id);
      });
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  // Call this method in initState to load data when the widget is created
  @override
  void initState() {
    super.initState();
    fetchData();
  }
}

class Skill {
  String skill;
  String id;

  Skill({
    required this.skill,
    required this.id,
  });

  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      skill: map['skill'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'skill': skill,
      'id': id,
    };
  }
}
