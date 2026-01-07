import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'add_contact_screen.dart';
import 'settings_screen.dart';
import 'trash_screen.dart';
import 'manage_contacts_screen.dart';
import 'create_group_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // قائمة لتخزين جهات الاتصال في الذاكرة (بدون قاعدة بيانات)
  List<Contact> _allContacts = [
    Contact(firstName: 'المهندس محمد الاشعري', phone: 'IT', lastName: ''),
    Contact(firstName: 'My heart', phone: '', lastName: ''),
    Contact(firstName: 'مبارك الجبري', phone: '', lastName: ''),
    Contact(firstName: 'اصيل صاحب منير', phone: '', lastName: ''),
    Contact(firstName: 'عمر ال قاسم', phone: '', lastName: ''),
    Contact(firstName: 'صقر السوري', phone: '', lastName: ''),
    Contact(firstName: 'محمد طلال', phone: '', lastName: ''),
  ];

  List<Contact> _filteredContacts = [];
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredContacts = _allContacts;
  }

  void _filterContacts(String query) {
    setState(() {
      _filteredContacts = _allContacts
          .where((contact) => contact.fullName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white), // الزر رقم 1
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'بحث...',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onChanged: _filterContacts,
        )
            : null,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white), // الزر رقم 2
            onPressed: () async {
              final newContact = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddContactScreen()),
              );
              if (newContact != null && newContact is Contact) {
                setState(() {
                  _allContacts.add(newContact);
                  _filteredContacts = _allContacts;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                if (!_isSearching) {
                  _filteredContacts = _allContacts;
                  _searchController.clear();
                }
              });
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'delete_all') {
                setState(() {
                  _allContacts.clear();
                  _filteredContacts = [];
                });
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'qr', child: Text('مسح QR code')),
              PopupMenuItem(value: 'delete_all', child: Text('حذف جهات الاتصال')),
              PopupMenuItem(value: 'share', child: Text('مشاركة جهات الاتصال')),
              PopupMenuItem(value: 'cloud', child: Text('Verizon Cloud')),
              PopupMenuItem(value: 'reorder', child: Text('إعادة ترتيب المفضلة')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child: Text(
                      contact.firstName.isNotEmpty ? contact.firstName[0].toUpperCase() : '?',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(contact.fullName, style: TextStyle(color: Colors.white)),
                  subtitle: contact.phone.isNotEmpty ? Text(contact.phone, style: TextStyle(color: Colors.grey)) : null,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[900],
          child: Image(image: AssetImage("assets/images/OIP (2).webp"))
        ),
        SizedBox(height: 10),
        Text('مهند الاحمدي', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('المفضلة', style: TextStyle(color: Colors.grey)),
              Spacer(),
              Icon(Icons.star, color: Colors.grey, size: 16),
            ],
          ),
        ),
        Divider(color: Colors.grey[900]),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Color(0xFF121212),
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.settings, color: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context); // يغلق القائمة الجانبية
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsScreen()),
                    );
                  },
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: Colors.grey[900], borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 12, backgroundColor: Colors.orange, child: Icon(Icons.person, size: 16, color: Colors.white)),
                      SizedBox(width: 10),
                      Text('جميع جهات الاتصال', style: TextStyle(color: Colors.white)),
                      Spacer(),
                      Text('${_allContacts.length}', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.group, 'المجموعات', trailing: Icon(Icons.keyboard_arrow_up, color: Colors.grey)),
          _buildDrawerItem(null, 'جهات اتصال للطوارئ', isSub: true),
          _buildDrawerItem(null, 'غير محددة', isSub: true, count: '381'),
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 32),
            leading: Icon(Icons.add, color: Colors.white),
            title: Text('إنشاء مجموعة', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة الجانبية
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroupScreen()),
              );
            },
          ),

          Divider(color: Colors.grey[900]),
          _buildDrawerItem(Icons.business, 'الشركات', trailing: Icon(Icons.keyboard_arrow_down, color: Colors.grey)),
          Divider(color: Colors.grey[900]),
          ListTile(
            leading: Icon(Icons.manage_accounts, color: Colors.white),
            title: Text('إدارة جهات الاتصال', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة الجانبية
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ManageContactsScreen()),
              );
            },
          ),

          ListTile(
            leading: Icon(Icons.delete_outline, color: Colors.white),
            title: Text('سلة المحذوفات', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // إغلاق القائمة الجانبية
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrashScreen()),
              );
            },
          ),

        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData? icon, String title, {bool isSub = false, String? count, Widget? trailing}) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: isSub ? 32 : 16),
      leading: icon != null ? Icon(icon, color: Colors.white) : null,
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: count != null ? Text(count, style: TextStyle(color: Colors.grey)) : trailing,
      onTap: () {},
    );
  }
}
