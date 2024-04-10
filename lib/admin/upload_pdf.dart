import 'dart:io';
import 'package:admin_college/admin/upload_course.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class UploadPDFScreen extends StatefulWidget {
  final CourseNCode subject;

  const UploadPDFScreen(this.subject, {Key? key}) : super(key: key);

  @override
  _UploadPDFScreenState createState() => _UploadPDFScreenState(subject);
}

class _UploadPDFScreenState extends State<UploadPDFScreen> {
  CourseNCode subject;
  _UploadPDFScreenState(this.subject);
  File? _pdfFile;
  bool _uploading = false;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _subtitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload PDF'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _subtitleController,
              decoration: InputDecoration(labelText: 'Subtitle'),
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf'],
                );

                if (result != null) {
                  setState(() {
                    _pdfFile = File(result.files.single.path!);
                  });
                }
              },
              child: Text('Pick PDF'),
            ),
            SizedBox(height: 20),
            if (_pdfFile != null)
              ElevatedButton(
                onPressed: _uploading ? null : () async {
                  setState(() {
                    _uploading = true;
                  });
                  final downloadUrl = await uploadPDF(_pdfFile!);
                  setState(() {
                    _uploading = false;
                  });
                  if (downloadUrl.isNotEmpty) {
                    await addPDFReferenceToFirestore(downloadUrl);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('PDF uploaded successfully!'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to upload PDF.'),
                      ),
                    );
                  }
                },
                child: _uploading ? CircularProgressIndicator() : Text('Upload PDF'),
              ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadPDF(File file) async {
    try {
      final fileName = file.path.split('/').last;
      final ref = firebase_storage.FirebaseStorage.instance.ref().child('courses').child('btech').child("cse").child(subject.uniqueName).child('pyq').child('medicaps_university').child('pyq').child(fileName);
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading PDF: $e');
      return '';
    }
  }

  Future<void> addPDFReferenceToFirestore(String downloadUrl) async {
    try {
      final collectionRef = FirebaseFirestore.instance
        .collection('courses')
        .doc('btech')
        .collection('cse')
        .doc(subject.uniqueName)
        .collection('pyq')
        .doc('medicaps_university')
        .collection('pyq');

      final timestamp = Timestamp.now();
      await collectionRef.add({
        'title': _titleController.text,
        'subtitle': _subtitleController.text,
        'link': downloadUrl,
        'unique_name': subject.uniqueName,
        'subject_code': subject.subjectCode,
        'timestamp': timestamp,
      });
      print('PDF reference added to Firestore');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PDF reference added to Firestore'),
        ),
      );
    } catch (e) {
      print('Error adding PDF reference to Firestore: $e');
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Error adding PDF reference to Firestore: $e'),
        ),
      );
    }
  }
}
