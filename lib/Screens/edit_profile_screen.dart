// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:plant_detection/const_themes.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//
//   File? image;
//   final picker = ImagePicker();
//
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController dobController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();
//
//   Future pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         image = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.kBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(
//           "Personal Information",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           children: [
//             SizedBox(height: 20),
//             Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 65,
//                   //backgroundColor: Colors.white,
//                   backgroundImage: image != null
//                       ? FileImage(image!)
//                       : AssetImage("assets/default_profile.png") as ImageProvider,
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: GestureDetector(
//                     onTap: pickImage,
//                     child: Container(
//                       padding: EdgeInsets.all(6),
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color: Colors.black,
//                       ),
//                       child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 30),
//             buildLabelledField("Name", nameController),
//             buildLabelledField("Email", emailController),
//             buildLabelledField("Mobile number", phoneController),
//             buildLabelledField("Date of Birth", dobController, onTap: () async {
//               DateTime? pickedDate = await showDatePicker(
//                 context: context,
//                 initialDate: DateTime(2002, 5, 31),
//                 firstDate: DateTime(1900),
//                 lastDate: DateTime.now(),
//               );
//               if (pickedDate != null) {
//                 dobController.text = "${pickedDate.day.toString().padLeft(2, '0')}/"
//                     "${pickedDate.month.toString().padLeft(2, '0')}/"
//                     "${pickedDate.year}";
//               }
//             }),
//             buildLabelledField("Country/Region", countryController),
//             SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildTextField(String label, TextEditingController controller,
//       {TextInputType keyboardType = TextInputType.text, VoidCallback? onTap}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         readOnly: onTap != null,
//         onTap: onTap,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }
//
//   Widget buildLabelledField(String label, TextEditingController controller,
//       {VoidCallback? onTap}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
//         SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           readOnly: onTap != null,
//           onTap: onTap,
//           decoration: InputDecoration(
//             filled: true,
//             fillColor: AppTheme.kBackgroundColor,
//             contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(10),
//               borderSide: BorderSide(color: Colors.grey.shade300),
//             ),
//           ),
//         ),
//         SizedBox(height: 16),
//       ],
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_detection/const_themes.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? image;
  final picker = ImagePicker();
  bool _isLoading = false;
  String? _photoUrl;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          final data = doc.data()!;
          setState(() {
            nameController.text = data['name'] ?? '';
            emailController.text = data['email'] ?? '';
            phoneController.text = data['phone'] ?? '';
            dobController.text = data['dob'] ?? '';
            countryController.text = data['country'] ?? '';
            // _photoUrl = data['photoUrl'];
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user data: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => image = File(pickedFile.path));
    }
  }

  Future<String?> _uploadImage() async {
    if (image == null) return null;

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return null;

      final ref = FirebaseStorage.instance
          .ref()
          .child('user_profile_images')
          .child('${user.uid}.jpg');

      await ref.putFile(image!);
      return await ref.getDownloadURL();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: ${e.toString()}')),
      );
      return null;
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      // Upload image if selected
      final imageUrl = await _uploadImage();

      // Update Firestore document
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'name': nameController.text.trim(),
        'phone': phoneController.text.trim(),
        'dob': dobController.text.trim(),
        'country': countryController.text.trim(),
        // if (imageUrl != null) 'photoUrl': imageUrl,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      // Update email in Firebase Auth if changed
      if (emailController.text.trim() != user.email) {
        await user.updateEmail(emailController.text.trim());
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!')),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Failed to update profile.';
      if (e.code == 'requires-recent-login') {
        errorMessage = 'Please re-authenticate to update your email.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Personal Information",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _isLoading ? null : _updateProfile,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CircleAvatar(
                  radius: 65,
                  backgroundImage: const AssetImage("assets/default_profile.png")
                  as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      child: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            buildLabelledField("Name", nameController),
            buildLabelledField("Email", emailController),
            buildLabelledField("Mobile number", phoneController),
            buildLabelledField("Date of Birth", dobController, onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) {
                dobController.text =
                "${pickedDate.day.toString().padLeft(2, '0')}/"
                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                    "${pickedDate.year}";
              }
            }),
            buildLabelledField("Country/Region", countryController),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _updateProfile,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget buildLabelledField(String label, TextEditingController controller,
      {VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: onTap != null,
          onTap: onTap,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.kBackgroundColor,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    dobController.dispose();
    countryController.dispose();
    super.dispose();
  }
}
