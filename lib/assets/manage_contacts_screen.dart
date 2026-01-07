import 'package:flutter/material.dart';

class ManageContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('إدارة جهات الاتصال', style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1E),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildManageItem(Icons.merge_type, 'دمج جهات الاتصال'),
                  Divider(color: Colors.grey[800], height: 1, indent: 50),
                  _buildManageItem(Icons.import_export, 'استيراد جهات الاتصال أو تصديرها'),
                  Divider(color: Colors.grey[800], height: 1, indent: 50),
                  _buildManageItem(Icons.sync, 'مزامنة جهات الاتصال'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManageItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      onTap: () {},
    );
  }
}
