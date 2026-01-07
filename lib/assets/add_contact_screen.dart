import 'package:flutter/material.dart';
import '../models/contact.dart';

class AddContactScreen extends StatefulWidget {
  @override
  _AddContactScreenState createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _saveContact() {
    if (_formKey.currentState!.validate()) {
      final newContact = Contact(
        firstName: _firstNameController.text,
        middleName: _middleNameController.text,
        lastName: _lastNameController.text,
        phone: _phoneController.text,
        email: _emailController.text,
      );
      // نعيد جهة الاتصال الجديدة للواجهة السابقة
      Navigator.pop(context, newContact);
    }
  }

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
            onPressed: _saveContact,
            child: Text('حفظ', style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
        title: Text('الهاتف', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
               // backgroundColor: Colors.orangeAccent.withOpacity(0.6),
                child: Icon(Icons.camera_alt, color: Colors.white, size: 40),
              ),
              SizedBox(height: 30),
              _buildSection([
                _buildTextField(_firstNameController, 'الاسم الأول', Icons.person),
                _buildTextField(_middleNameController, 'الاسم الأوسط', null),
                _buildTextField(_lastNameController, 'اسم العائلة', null),
              ]),
              SizedBox(height: 20),
              _buildSection([
                _buildTextField(_phoneController, 'الهاتف', Icons.phone, keyboardType: TextInputType.phone),
              ]),
              SizedBox(height: 20),
              _buildSection([
                _buildTextField(_emailController, 'البريد الإلكتروني', Icons.email),
              ]),
              SizedBox(height: 20),
              _buildSection([
                ListTile(
                  leading: Icon(Icons.group, color: Colors.grey),
                  title: Text('المجموعات', style: TextStyle(color: Colors.white)),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                ),
              ]),
              TextButton(
                onPressed: () {},
                child: Text('عرض المزيد', style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData? icon, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey) : null,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      validator: (value) => (label == 'الاسم الأول' || label == 'الهاتف') && (value == null || value.isEmpty) ? 'مطلوب' : null,
    );
  }
}
