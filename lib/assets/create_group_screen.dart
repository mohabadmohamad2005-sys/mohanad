import 'package:flutter/material.dart';

class CreateGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('إلغاء', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('حفظ', style: TextStyle(color: Colors.grey, fontSize: 16)),
          ),
        ],
        title: Text('الهاتف وكل الحسابات', style: TextStyle(color: Colors.white, fontSize: 18)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'اسم المجموعة',
                      hintStyle: TextStyle(color: Colors.grey),
                      suffixIcon: Icon(Icons.group_outlined, color: Colors.grey),
                      border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text('نغمة رنين مجموعة', style: TextStyle(color: Colors.white)),
                    subtitle: Text('نغمة الرنين الافتراضية', style: TextStyle(color: Colors.orangeAccent)),
                    trailing: Icon(Icons.music_note, color: Colors.grey),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('الأعضاء', style: TextStyle(color: Colors.grey, fontSize: 14)),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.grey[800], shape: BoxShape.circle),
                  child: Icon(Icons.add, color: Colors.white, size: 20),
                ),
                title: Text('إضافة عضو', style: TextStyle(color: Colors.white)),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
