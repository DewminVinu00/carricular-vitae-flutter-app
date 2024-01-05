// ignore_for_file: unused_import, unused_local_variable, unnecessary_import, invalid_return_type_for_catch_error, must_be_immutable, override_on_non_overriding_member

import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:curricular_vitae/services/firestore.dart';

class SocialMedia extends StatefulWidget {
  SocialMedia({Key? key}) : super(key: key);
  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  final FirestoreService firestoreService = FirestoreService();

  List<GitHub> Githubs = List.empty(growable: true);
  List<GitLab> Gitlabs = List.empty(growable: true);
  List<Linkedin> Linkedins = List.empty(growable: true);

  TextEditingController githubController = TextEditingController();
  TextEditingController gitlabController = TextEditingController();
  TextEditingController linkedinController =
      TextEditingController(); // Add a controller for LinkedIn

  int selectedIndex = -1;
  var isUpdating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Social Media"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              // Github
              //
              const SizedBox(height: 10),
              TextField(
                controller: githubController,
                decoration: const InputDecoration(
                  hintText: 'Github Link',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (githubController.text.isNotEmpty) {
                        var documentReference = await FirebaseFirestore.instance
                            .collection("github")
                            .add({
                          "github": githubController.text.trim(),
                          'timestamp': Timestamp.now(),
                        });

                        var githubId = documentReference.id;
                        print(githubId);

                        fetchData();
                        setState(() {
                          githubController.text = '';
                          Githubs.add(GitHub(
                            github: githubController.text.trim(),
                            id: githubId,
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
                        if (selectedIndex >= 0 &&
                            selectedIndex < Githubs.length) {
                          setState(() {
                            isUpdating = true;
                          });

                          // Create a Contact object with the updated values
                          GitHub updatedContact = GitHub(
                            github: githubController.text.trim(),
                            id: Githubs[selectedIndex].id,
                          );

                          // Call the update method with the updated contact
                          await update(updatedContact);

                          setState(() {
                            isUpdating = false;
                          });
                        } else {
                          print("Error: selectedIndex out of bounds");
                        }
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
              Githubs.isEmpty
                  ? Text(
                      'No GitHub link yet..',
                      style: TextStyle(fontSize: 22),
                    )
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: Githubs.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    ),
              //
              // GitLab
              //

              Divider(
                color: Color.fromARGB(255, 0, 187, 255),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: gitlabController,
                decoration: const InputDecoration(
                  hintText: 'GitLab Link',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (gitlabController.text.isNotEmpty) {
                        var documentReference = await FirebaseFirestore.instance
                            .collection("gitlab")
                            .add({
                          "gitlab": gitlabController.text.trim(),
                          'timestamp': Timestamp.now(),
                        });

                        var gitlabId = documentReference.id;
                        print(gitlabId);

                        gitlabfetchData();
                        setState(() {
                          gitlabController.text = '';
                          Gitlabs.add(GitLab(
                            gitlab: gitlabController.text.trim(),
                            id: gitlabId,
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
                        if (selectedIndex >= 0 &&
                            selectedIndex < Gitlabs.length) {
                          setState(() {
                            isUpdating = true;
                          });

                          // Create a Contact object with the updated values
                          GitLab gitlabupdatedContact = GitLab(
                            gitlab: gitlabController.text.trim(),
                            id: Gitlabs[selectedIndex].id,
                          );

                          // Call the update method with the updated contact
                          await gitlabupdate(gitlabupdatedContact);

                          setState(() {
                            isUpdating = false;
                          });
                        } else {
                          print("Error: selectedIndex out of bounds");
                        }
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
              Gitlabs.isEmpty
                  ? Text(
                      'No GitLab link yet..',
                      style: TextStyle(fontSize: 22),
                    )
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, gitlabindex) =>
                            gitlabgetRow(gitlabindex),
                      ),
                    ),
              //
              // LinkedIn
              //

              Divider(
                height: 20.0,
                color: Color.fromARGB(255, 0, 187, 255),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: linkedinController,
                decoration: const InputDecoration(
                  hintText: 'LinkedIn Link',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (linkedinController.text.isNotEmpty) {
                        var documentReference = await FirebaseFirestore.instance
                            .collection("linkedin")
                            .add({
                          "linkedin": linkedinController.text.trim(),
                          'timestamp': Timestamp.now(),
                        });

                        var linkedinId = documentReference.id;
                        print(linkedinId);

                        linkedinfetchData();
                        setState(() {
                          linkedinController.text = '';
                          Linkedins.add(Linkedin(
                            linkedin: linkedinController.text.trim(),
                            id: linkedinId,
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
                        if (selectedIndex >= 0 &&
                            selectedIndex < Linkedins.length) {
                          setState(() {
                            isUpdating = true;
                          });

                          // Create a Contact object with the updated values
                          Linkedin linkedinupdatedContact = Linkedin(
                            linkedin: linkedinController.text.trim(),
                            id: Linkedins[selectedIndex].id,
                          );

                          // Call the update method with the updated contact
                          await linkedinupdate(linkedinupdatedContact);

                          setState(() {
                            isUpdating = false;
                          });
                        } else {
                          print("Error: selectedIndex out of bounds");
                        }
                      }
                    },
                    child: const Text('Update'),
                  ),
                ],
              ),
              Linkedins.isEmpty
                  ? Text(
                      'No LinkedIn link yet..',
                      style: TextStyle(fontSize: 22),
                    )
                  : Container(
                      height: 100,
                      child: ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, linkedinindex) =>
                            LinkedingetRow(linkedinindex),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getRow(int githubindex) {
    if (Githubs.isEmpty || githubindex < 0 || githubindex >= Githubs.length) {
      return SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              githubindex % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              skills[index].github,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            Text(Githubs[githubindex].github),
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
                    githubController.text = Githubs[githubindex].github;
                    selectedIndex = githubindex;
                  });
                  // Update the document and githubs list after tapping the "Edit" icon
                  try {
                    // Get the reference to the document with the specified ID
                    var documentReference = FirebaseFirestore.instance
                        .collection("github")
                        .doc(Githubs[githubindex].id);

                    // Update the document
                    await documentReference.update({
                      "github": githubController.text,
                      'timestamp': Timestamp.now(),
                    });

                    // Update the skills list after update
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
                        title: Text("Delete Your github link"),
                        content: Text(
                            "Are you sure you want to delete this github link?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Call the delete function and pass the github's ID
                              await delete(Githubs[githubindex].id);
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

  //gitlab

  Widget gitlabgetRow(int gitlabindex) {
    if (Gitlabs.isEmpty || gitlabindex < 0 || gitlabindex >= Gitlabs.length) {
      return SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              gitlabindex % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              skills[index].github,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            Text(Gitlabs[gitlabindex].gitlab),
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
                    gitlabController.text = Gitlabs[gitlabindex].gitlab;
                    selectedIndex = gitlabindex;
                  });
                  // Update the document and githubs list after tapping the "Edit" icon
                  try {
                    // Get the reference to the document with the specified ID
                    var documentReference = FirebaseFirestore.instance
                        .collection("gitlab")
                        .doc(Gitlabs[gitlabindex].id);

                    // Update the document
                    await documentReference.update({
                      "gitlab": gitlabController.text,
                      'timestamp': Timestamp.now(),
                    });

                    // Update the skills list after update
                    gitlabfetchData();
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
                        title: Text("Delete Your gitlab link"),
                        content: Text(
                            "Are you sure you want to delete this gitlab link?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Call the delete function and pass the github's ID
                              await gitlabdelete(Gitlabs[gitlabindex].id);
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

  //linkedin

  Widget LinkedingetRow(int linkedinindex) {
    if (Linkedins.isEmpty ||
        linkedinindex < 0 ||
        linkedinindex >= Linkedins.length) {
      return SizedBox.shrink();
    }

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              linkedinindex % 2 == 0 ? Colors.deepPurpleAccent : Colors.purple,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Text(
              skills[index].github,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),*/
            Text(Linkedins[linkedinindex].linkedin),
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
                    linkedinController.text = Linkedins[linkedinindex].linkedin;
                    selectedIndex = linkedinindex;
                  });
                  // Update the document and githubs list after tapping the "Edit" icon
                  try {
                    // Get the reference to the document with the specified ID
                    var documentReference = FirebaseFirestore.instance
                        .collection("linkedin")
                        .doc(Linkedins[linkedinindex].id);

                    // Update the document
                    await documentReference.update({
                      "linkedin": linkedinController.text,
                      'timestamp': Timestamp.now(),
                    });

                    // Update the skills list after update
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
                        title: Text("Delete Your linkedin link"),
                        content: Text(
                            "Are you sure you want to delete this linkedin link?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () async {
                              // Call the delete function and pass the github's ID
                              await linkedindelete(Linkedins[linkedinindex].id);
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

  //github

  Future<void> fetchData() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("github").get();
      var tempList = <GitHub>[];

      querySnapshot.docs.forEach((doc) {
        var github = GitHub(
          id: doc.id,
          github: doc['github'],
        );
        tempList.add(github);
      });

      setState(() {
        Githubs.clear();
        Githubs.addAll(tempList);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> update(GitHub github) async {
    try {
      // Get the reference to the document with the specified ID
      var documentReference =
          FirebaseFirestore.instance.collection("github").doc(github.id);

      // Update the document with the values from the github parameter
      await documentReference.update({
        "github": github.github,
        'timestamp': Timestamp.now(),
      });

      // Update the github list after the update
      await fetchData();
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> delete(String id) async {
    try {
      // Delete the document with the specified ID
      await FirebaseFirestore.instance.collection("github").doc(id).delete();

      setState(() {
        // Remove the deleted github from the local list
        Githubs.removeWhere((github) => github.id == id);
      });
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  //gitlab

  Future<void> gitlabfetchData() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("gitlab").get();
      var tempList = <GitLab>[];

      querySnapshot.docs.forEach((doc) {
        var gitlab = GitLab(
          id: doc.id,
          gitlab: doc['gitlab'],
        );
        tempList.add(gitlab);
      });

      setState(() {
        Gitlabs.clear(); // Clear the existing list before adding new data
        Gitlabs.addAll(tempList);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> gitlabupdate(GitLab gitlab) async {
    try {
      // Get the reference to the document with the specified ID
      var documentReference =
          FirebaseFirestore.instance.collection("gitlab").doc(gitlab.id);

      // Update the document with the values from the github parameter
      await documentReference.update({
        "gitlab": gitlab.gitlab,
        'timestamp': Timestamp.now(),
      });

      // Update the github list after the update
      await gitlabfetchData();
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> gitlabdelete(String id) async {
    try {
      // Delete the document with the specified ID
      await FirebaseFirestore.instance.collection("gitlab").doc(id).delete();

      setState(() {
        // Remove the deleted github from the local list
        Gitlabs.removeWhere((gitlab) => gitlab.id == id);
      });
    } catch (e) {
      print("Error deleting data: $e");
    }
  }

  //linkedin

  Future<void> linkedinfetchData() async {
    try {
      var querySnapshot =
          await FirebaseFirestore.instance.collection("linkedin").get();
      var tempList = <Linkedin>[];

      querySnapshot.docs.forEach((doc) {
        var linkedin = Linkedin(
          id: doc.id,
          linkedin: doc['linkedin'],
        );
        tempList.add(linkedin);
      });

      setState(() {
        Linkedins.clear();
        Linkedins.addAll(tempList);
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  Future<void> linkedinupdate(Linkedin linkedin) async {
    try {
      // Get the reference to the document with the specified ID
      var documentReference =
          FirebaseFirestore.instance.collection("linkedin").doc(linkedin.id);

      // Update the document with the values from the github parameter
      await documentReference.update({
        "linkedin": linkedin.linkedin,
        'timestamp': Timestamp.now(),
      });

      // Update the github list after the update
      await linkedinfetchData();
    } catch (e) {
      print("Error updating data: $e");
    }
  }

  Future<void> linkedindelete(String id) async {
    try {
      await FirebaseFirestore.instance.collection("linkedin").doc(id).delete();

      setState(() {
        Linkedins.removeWhere((linkedin) => linkedin.id == id);
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
    gitlabfetchData();
    linkedinfetchData();
  }
}

class GitHub {
  String github;
  String id;

  GitHub({
    required this.github,
    required this.id,
  });

  factory GitHub.fromMap(Map<String, dynamic> map) {
    return GitHub(
      github: map['github'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'github': github,
      'id': id,
    };
  }
}

class GitLab {
  String gitlab;
  String id;

  GitLab({
    required this.gitlab,
    required this.id,
  });

  factory GitLab.fromMap(Map<String, dynamic> map) {
    return GitLab(
      gitlab: map['gitlab'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'gitlab': gitlab,
      'id': id,
    };
  }
}

class Linkedin {
  String linkedin;
  String id;

  Linkedin({
    required this.linkedin,
    required this.id,
  });

  factory Linkedin.fromMap(Map<String, dynamic> map) {
    return Linkedin(
      linkedin: map['linkedin'] ?? '',
      id: map['id'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'linkedin': linkedin,
      'id': id,
    };
  }
}
