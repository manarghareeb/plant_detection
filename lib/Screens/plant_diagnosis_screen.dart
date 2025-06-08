/*import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantDiagnosisScreen extends StatefulWidget {
  @override
  _PlantDiagnosisScreenState createState() => _PlantDiagnosisScreenState();
}

class _PlantDiagnosisScreenState extends State<PlantDiagnosisScreen> {
  File? _image;
  String? _result;
  bool _loading = false;

  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _result = null;
      });
      await _sendImageToServer(_image!);
    }
  }

  Future<void> _sendImageToServer(File imageFile) async {
    setState(() => _loading = true);
    final uri = Uri.parse("http://192.168.1.17:5000/predict");
    //final uri = Uri.parse("http://192.168.1.17:5000/predict"); // <- مهم
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        setState(() {
          _result = jsonEncode(data);
        });
      } else {
        setState(() {
          _result = 'خطأ في الاتصال: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'خطأ: $e';
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plant Diagnosis')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : Placeholder(fallbackHeight: 200),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('Camera'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('Gallery'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _loading
                ? CircularProgressIndicator()
                : _result != null
                ? Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _result!,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
                : Text('اختر صورة لتشخيص النبات'),
          ],
        ),
      ),
    );
  }
}


 */

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantDiagnosisScreen extends StatefulWidget {
  @override
  _PlantDiagnosisScreenState createState() => _PlantDiagnosisScreenState();
}

class _PlantDiagnosisScreenState extends State<PlantDiagnosisScreen> {
  File? _image;
  Map<String, dynamic>? _resultData;
  bool _loading = false;

  final picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _resultData = null;
      });
    }
  }

  Future<void> _sendImageToServer(File imageFile) async {
    setState(() => _loading = true);
    final uri = Uri.parse("http://192.168.1.17:5000/predict");

    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        setState(() {
          _resultData = data;
        });
      } else {
        setState(() {
          _resultData = {"error": "Connection Error: ${response.statusCode}"};
        });
      }
    } catch (e) {
      setState(() {
        _resultData = {"error": "Error: $e"};
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  Widget _buildResultCard() {
    if (_resultData == null) return SizedBox();

    if (_resultData!.containsKey("error")) {
      return Text(_resultData!["error"], style: TextStyle(color: Colors.red));
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.only(top: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow("✔ صلاحية الصورة:", _resultData!["validity"]),
            _buildRow("✔ الثقة:", "${(_resultData!["confidence"] * 100).toStringAsFixed(2)}%"),
            _buildRow("✔ الحالة الصحية:", _resultData!["health"] ?? "غير متاحة"),
            _buildRow("✔ نوع النبات:", _resultData!["plant_type"] ?? "غير متاح"),
            _buildRow("✔ المرض:", _resultData!["disease"] ?? "لا يوجد"),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: Colors.green[800]))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('تشخيص النبات')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null
                ? Image.file(_image!, height: 200)
                : Placeholder(fallbackHeight: 200),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera_alt),
                  label: Text('كاميرا'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: Icon(Icons.photo_library),
                  label: Text('معرض الصور'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_image != null)
              ElevatedButton.icon(
                onPressed: _loading ? null : () => _sendImageToServer(_image!),
                icon: Icon(Icons.search),
                label: Text('ابدأ التشخيص'),
              ),
            if (_loading) const SizedBox(height: 20),
            if (_loading) CircularProgressIndicator(),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }
}
