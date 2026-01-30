/*import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetectionResultsScreen extends StatefulWidget {
  final File capturedImage;

  const DetectionResultsScreen({super.key,required this.capturedImage});

  @override
  State<DetectionResultsScreen> createState() => _DetectionResultsScreenState();
}

class _DetectionResultsScreenState extends State<DetectionResultsScreen> {
  Map<String, dynamic>? resultData;
  bool loading = false;

  Future<void> sendImageToServer(File imageFile) async {
    setState(() => loading = true);
    final uri = Uri.parse("http://192.168.1.17:5000/predict");

    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        setState(() {
          resultData = data;
        });
      } else {
        setState(() {
          resultData = {"error": "Connection Error: ${response.statusCode}"};
        });
      }
    } catch (e) {
      setState(() {
        resultData = {"error": "Error: $e"};
      });
    } finally {
      setState(() => loading = false);
    }
  }

  Widget buildResultCard() {
    if (resultData == null) return SizedBox();

    if (resultData!.containsKey("error")) {
      return Text(resultData!["error"], style: TextStyle(color: Colors.red));
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
            buildRow("✔ Image validity:", resultData!["validity"]),
            buildRow("✔ Trust:", "${(resultData!["confidence"] * 100).toStringAsFixed(2)}%"),
            buildRow("✔ Health status:", resultData!["health"] ?? "Not available"),
            buildRow("✔ Plant type:", resultData!["plant_type"] ?? "Not available"),
            buildRow("✔ Disease:", resultData!["disease"] ?? "None"),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
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
      appBar: AppBar(
        title: Text("Detection Results"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250,
            child: Image.file(
              widget.capturedImage,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: loading ? null : () => sendImageToServer(widget.capturedImage),
            icon: Icon(Icons.search),
            label: Text('Start Detection'),
          ),
          if (loading) const SizedBox(height: 20),
          if (loading) CircularProgressIndicator(),
          buildResultCard(),
        ],
      ),
    );
  }
}
*/

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../core/Models/model.dart';

class DetectionResultsScreen extends StatefulWidget {
  final File capturedImage;

  const DetectionResultsScreen({super.key, required this.capturedImage});

  @override
  State<DetectionResultsScreen> createState() => _DetectionResultsScreenState();
}

class _DetectionResultsScreenState extends State<DetectionResultsScreen> {
  Map<String, dynamic>? resultData;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    sendImageToServer(widget.capturedImage);
  }

  Future<void> sendImageToServer(File imageFile) async {
    setState(() => loading = true);
    final uri = Uri.parse("http://192.168.221.233:5000/predict");
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        setState(() {
          resultData = data;
        });
        final historyItem = HistoryItem(
          image: imageFile,
          diseaseName: data["disease"] ?? "None",
          date: DateTime.now(),
        );
        HistoryManager.addHistoryItem(historyItem);
      } else {
        setState(() {
          resultData = {"error": "Connection Error: ${response.statusCode}"};
        });
      }
    } catch (e) {
      setState(() {
        resultData = {"error": "Error: $e"};
      });
    } finally {
      setState(() => loading = false);
    }
  }

  /*Future<void> sendImageToServer(File imageFile) async {
    setState(() => loading = true);

    // 1. احصل على الـ IP الحالي للجهاز
    final networkInfo = NetworkInfo();
    String? wifiIp;
    try {
      wifiIp = await networkInfo.getWifiIP(); // ⬅️ يحصل على IP الـ Wi-Fi
    } catch (e) {
      setState(() {
        resultData = {"error": "Cannot detect WiFi IP: $e"};
        loading = false;
      });
      return;
    }

    // 2. تأكد من وجود IP
    if (wifiIp == null || wifiIp.isEmpty) {
      setState(() {
        resultData = {"error": "No WiFi connection detected"};
        loading = false;
      });
      return;
    }

    // 3. استخدم الـ IP في عنوان URL (مع افتراض أن البورت هو 5000)
    //final uri = Uri.parse("http://$wifiIp:5000/predict"); // ⬅️ IP ديناميكي
    final uri = Uri.parse("http://192.168.30.233:5000/predict"); // ⬅️ IP ديناميكي


    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        final data = json.decode(respStr);
        setState(() => resultData = data);

        // حفظ التاريخ
        final historyItem = HistoryItem(
          image: imageFile,
          diseaseName: data["disease"] ?? "None",
          date: DateTime.now(),
        );
        HistoryManager.addHistoryItem(historyItem);
      } else {
        setState(() {
          resultData = {"error": "Connection Error: ${response.statusCode}"};
        });
      }
    } catch (e) {
      setState(() {
        resultData = {"error": "Error: $e"};
      });
    } finally {
      setState(() => loading = false);
    }
  }*/

  Widget buildResultCard() {
    if (resultData == null) return SizedBox();

    if (resultData!.containsKey("error")) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(resultData!["error"], style: TextStyle(color: Colors.red)),
      );
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
            buildRow("✔ Image validity:", resultData!["validity"]),
            buildRow("✔ Trust:", "${(resultData!["confidence"] * 100).toStringAsFixed(2)}%"),
            buildRow("✔ Health status:", resultData!["health"] ?? "Not available"),
            buildRow("✔ Plant type:", resultData!["plant_type"] ?? "Not available"),
            buildRow("✔ Disease:", resultData!["disease"] ?? "None"),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value) {
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
      appBar: AppBar(
        title: Text("Detection Results"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image display
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.file(
                widget.capturedImage,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            // loading indicator
            if (loading) Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 10),
                Text("Analyzing...", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            // result card
            if (!loading) buildResultCard(),
          ],
        ),
      ),
    );
  }
}

