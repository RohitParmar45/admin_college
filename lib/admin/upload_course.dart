import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UploadCoursesScreen(),
    );
  }
}

class UploadCoursesScreen extends StatelessWidget {

  List<CourseNCode> course_name_n_subject_code_list = [
    CourseNCode('Engineering Mathematics-I', 'EN3BS11', 'engineering_mathematics_i'),
    CourseNCode('Engineering Physics', 'EN3BS13', 'engineering_physics'),
    CourseNCode('Basic Electrical Engineering', 'EN3ES17', 'basic_electrical_engineering'),
    CourseNCode('Environmental Science', 'EN3NG01', 'environmental_science'),
    CourseNCode('Engineering Graphics', 'EN3ES19', 'engineering_graphics'),
    CourseNCode('Programming-I', 'EN3ES21', 'programming_i'),
    CourseNCode('Basic Civil Engineering', 'EN3ES01', 'basic_civil_engineering'),
    CourseNCode('Engineering Mathematics-II', 'EN3BS12', 'engineering_mathematics_ii'),
    CourseNCode('Engineering Chemistry', 'EN3BS14', 'engineering_chemistry'),
    CourseNCode('Basic Mechanical Engineering', 'EN3ES18', 'basic_mechanical_engineering'),
    CourseNCode('Programming-II', 'EN3ES22', 'programming_ii'),
    CourseNCode('Communication Skills', 'EN3HS02', 'communication_skills'),
    CourseNCode('Basic Electronics Engineering', 'EN3ES16', 'basic_electronics_engineering'),
    CourseNCode('Engineering Workshop - I', 'EN3ES20', 'engineering_workshop_i'),
    CourseNCode('History of Science and Technology', 'EN3HS01', 'history_of_science_and_technology'),
    CourseNCode('Discrete Mathematics', 'CS3BS04', 'discrete_mathematics'),
    CourseNCode('Object Oriented Programming', 'CS3CO30', 'object_oriented_programming'),
    CourseNCode('Data Structures', 'CS3CO31', 'data_structures'),
    CourseNCode('Java Programming', 'CS3CO32', 'java_programming'),
    CourseNCode('Digital Electronics', 'CS3CO33', 'digital_electronics'),
    CourseNCode('Data Communication', 'CS3CO28', 'data_communication'),
    CourseNCode('Computer System Architecture', 'CS3CO34', 'computer_system_architecture'),
    CourseNCode('Soft Skills-I', 'EN3NG03', 'soft_skills_i'),
    CourseNCode('Elective-1', 'CS3ELXX', 'elective_1'),
    CourseNCode('Microprocessor and Interfacing', 'CS3CO35', 'microprocessor_and_interfacing'),
    CourseNCode('Operating Systems', 'CS3CO36', 'operating_systems'),
    CourseNCode('Advanced Java Programming', 'CS3CO37', 'advanced_java_programming'),
    CourseNCode('Theory of Computation', 'CS3CO38', 'theory_of_computation'),
    CourseNCode('Database Management Systems', 'CS3CO39', 'database_management_systems'),
    CourseNCode('Sports', 'EN3NG07', 'sports'),
    CourseNCode('Elective-2', 'CS3ELXX', 'elective_2'),
    CourseNCode('Software Engineering', 'CS3CO40', 'software_engineering'),
    CourseNCode('Computer Networks', 'CS3CO41', 'computer_networks'),
    CourseNCode('Open Elective-1', 'OE000XX', 'open_elective_1'),
    CourseNCode('Soft Skills-II', 'EN3NG04', 'soft_skills_ii'),
    CourseNCode('Design and Analysis of Algorithms', 'CS3CO42', 'design_and_analysis_of_algorithms'),
    CourseNCode('Cryptography & Information Security', 'CS3CO43', 'cryptography_and_information_security'),
    CourseNCode('Mini Project-I', 'CS3PC04', 'mini_project_i'),
    CourseNCode('Club Activities', 'EN3NG08', 'club_activities'),
    CourseNCode('Compiler Design', 'CS3CO27', 'compiler_design'),
    CourseNCode('Open Learning Courses', 'EN3NG06', 'open_learning_courses'),
    CourseNCode('Research Methodology', 'CS3ES15', 'research_methodology'),
    CourseNCode('Elective-3', 'CS3ELXX', 'elective_3'),
    CourseNCode('Elective-4', 'CS3ELXX', 'elective_4'),
    CourseNCode('Open Elective-2', 'OE000XX', 'open_elective_2'),
    CourseNCode('Mini Project-II', 'CS3PC05', 'mini_project_ii'),
    CourseNCode('Soft Skills-III', 'EN3NG05', 'soft_skills_iii'),
    CourseNCode('NSS', 'EN3NG09', 'nss'),
    CourseNCode('Elective-5', 'CS3ELXX', 'elective_5'),
    CourseNCode('Elective-6', 'CS3ELXX', 'elective_6'),
    CourseNCode('Open Elective-3', 'OE000XX', 'open_elective_3'),
    CourseNCode('Minor Project', 'CS3PC06', 'minor_project'),
    CourseNCode('Industrial Training', 'CS3PC03', 'industrial_training'),
    CourseNCode('Fundamentals of Management, Economics & Accountancy', 'EN3HS04', 'fundamentals_of_management_economics_and_accountancy'),
    CourseNCode('Universal Human Values & Professional Ethics', 'EN3NG02', 'universal_human_values_and_professional_ethics'),
    CourseNCode('Major Project', 'CS3PC07', 'major_project'),
    CourseNCode('Artificial Intelligence', 'CS3EA01', 'artificial_intelligence'),
    CourseNCode('Digital Image Processing', 'CS3EA02', 'digital_image_processing'),
    CourseNCode('Soft Computing', 'CS3EA03', 'soft_computing'),
    CourseNCode('Pattern Recognition', 'CS3EA04', 'pattern_recognition'),
    CourseNCode('Evolutionary Algorithm', 'CS3EA05', 'evolutionary_algorithm'),
    CourseNCode('Natural Language Processing', 'CS3EA06', 'natural_language_processing'),
    CourseNCode('Machine Learning', 'CS3EA07', 'machine_learning'),
    CourseNCode('Introduction to Cognitive Science', 'CS3EA08', 'introduction_to_cognitive_science'),
    CourseNCode('Graph Theory', 'CS3EA09', 'graph_theory'),
    CourseNCode('Cloud Computing', 'CS3EA10', 'cloud_computing'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Courses'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            uploadCoursesToFirestore();
          },
          child: const Text('Upload Courses to Firestore'),
        ),
      ),
    );
  }

  void uploadCoursesToFirestore() async {
    try {
      await CourseUploadService.uploadCourses(course_name_n_subject_code_list);
      print('Courses uploaded successfully!');
    } catch (e) {
      print('Error uploading courses: $e');
    }
  }
}

class CourseUploadService {
  static Future<void> uploadCourses(List<CourseNCode> courses) async {
    for (var course in courses) {
      String courseName = course.courseName.toLowerCase();
      String courseRes = "";
      for (int i = 0; i < courseName.length; i++) {
        if (courseName[i] == ' ') {
          courseRes += '_';
        } else {
          courseRes += courseName[i];
        }
      }
      final CollectionReference courseCollection = FirebaseFirestore.instance
          .collection('courses')
          .doc('btech')
          .collection('cse')
          .doc('subjects')
          .collection("all_subjects");

      await courseCollection.add({
        'subject_name': course.courseName,
        'subject_code': course.subjectCode,
        'unique_name' : courseRes,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}

class CourseNCode {
  final String courseName;
  final String subjectCode;
  final String uniqueName;
  CourseNCode(this.courseName, this.subjectCode,this.uniqueName);

}
