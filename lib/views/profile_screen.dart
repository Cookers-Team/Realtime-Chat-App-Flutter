import 'package:cms_chat_app/components/button.dart';
import 'package:cms_chat_app/components/confirmation_dialog.dart';
import 'package:cms_chat_app/dto/response_dto.dart';
import 'package:cms_chat_app/models/profile.dart';
import 'package:cms_chat_app/services/user_service.dart';
import 'package:cms_chat_app/views/login_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Profile? _profile;
  final _userService = UserService();

  @override
  void initState() {
    super.initState();
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {
    ResponseDto dto = await _userService.getProfile();
    setState(() {
      _profile = Profile.fromJson(dto.data);
    });
  }

  void _navigateToEditProfile() async {
    // final updated = await Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => EditProfileScreen(profile: _profile!)),
    // );
    // if (updated == true) {
    //   _fetchProfileData();
    // }
  }

  void _logout() async {
    await _userService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_profile == null) {
      return Center(
          child: CircularProgressIndicator(
        color: Color(0xFF1565C0),
      ));
    } else {
      return Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    colors: [
                      Color(0xFF1565C0),
                      Color(0xFF1E88E5),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: _profile!.avatarUrl != null
                                ? Image.network(
                                    _profile!.avatarUrl!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey[400],
                                        ),
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/user_icon.png',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          _profile!.displayName,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection(
                      'Thông tin cá nhân',
                      [
                        _buildInfoItem(
                          Icons.email_outlined,
                          'Email',
                          _profile!.email,
                        ),
                        _buildInfoItem(
                          Icons.badge_outlined,
                          'Mã sinh viên',
                          _profile!.studentId,
                        ),
                        _buildInfoItem(
                          Icons.phone_outlined,
                          'Số điện thoại',
                          _profile!.phone,
                        ),
                        _buildInfoItem(
                          Icons.cake_outlined,
                          'Ngày sinh',
                          _profile!.birthDate != null
                              ? _profile!.birthDate!.substring(0, 10)
                              : 'Chưa cập nhật',
                          italic: _profile!.birthDate == null,
                        ),
                        _buildInfoItem(
                          Icons.info_outline,
                          'Tiểu sử',
                          _profile!.bio ?? 'Chưa cập nhật',
                          italic: _profile!.bio == null,
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              buildButton(
                                onPressed: _navigateToEditProfile,
                                buttonText: "CẬP NHẬT THÔNG TIN",
                                backgroundColor: Color(0xFF1565C0),
                                foregroundColor: Colors.white,
                              ),
                              SizedBox(height: 20),
                              TextButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfirmationDialog(
                                      title: "Đăng xuất",
                                      message:
                                          "Bạn có chắc chắn muốn đăng xuất?",
                                      confirmText: "Đăng xuất",
                                      color: Color(0xFFB71C1C),
                                      onConfirm: () {
                                        Navigator.of(context).pop();
                                        _logout();
                                      },
                                      onCancel: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Đăng xuất',
                                  style: TextStyle(
                                      color: Color(0xFFB71C1C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
        SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value,
      {bool italic = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF1565C0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Color(0xFF1565C0),
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16,
                      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
