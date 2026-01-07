import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _trashEnabled = true;
  bool _showFrequent = false;
  bool _showExternal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text('إعدادات جهات الاتصال', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSection([
            _buildListTile('مشاركة صورة ملف التعريف', null),
            Divider(color: Colors.grey[800], height: 1),
            _buildSwitchTile('سلة المحذوفات', _trashEnabled, (val) => setState(() => _trashEnabled = val)),
          ]),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 8, bottom: 8),
            child: Text('قائمة جهات الاتصال', style: TextStyle(color: Colors.grey, fontSize: 14)),
          ),
          _buildSection([
            _buildListTile('فرز جهات الاتصال بحسب', 'الاسم الأول'),
            Divider(color: Colors.grey[800], height: 1),
            _buildListTile('تنسيق الاسم', 'الاسم الأول، اسم العائلة'),
            Divider(color: Colors.grey[800], height: 1),
            _buildSwitchTile('إظهار المتصل بهم بتكرار', _showFrequent, (val) => setState(() => _showFrequent = val),
                subtitle: 'يتم إظهار جهات الاتصال التي اتصلت بها بشكل متكرر في آخر ٣٠ يوماً.'),
          ]),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.only(right: 8, bottom: 8),
            child: Text('مزيد من الضبط', style: TextStyle(color: Colors.grey, fontSize: 14)),
          ),
          _buildSection([
            _buildSwitchTile('إظهار خيارات الجهة الخارجية', _showExternal, (val) => setState(() => _showExternal = val)),
            Divider(color: Colors.grey[800], height: 1),
            _buildListTile('خدمة التخصيص', 'غير مستخدمة'),
          ]),
          SizedBox(height: 20),
          _buildSection([
            _buildListTile('حول تطبيق جهات الاتصال', null),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(String title, String? subtitle) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.orangeAccent, fontSize: 14)) : null,
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
      onTap: () {},
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged, {String? subtitle}) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      subtitle: subtitle != null ? Text(subtitle, style: TextStyle(color: Colors.grey, fontSize: 12)) : null,
      value: value,
      activeColor: Colors.orangeAccent,
      onChanged: onChanged,
    );
  }
}
