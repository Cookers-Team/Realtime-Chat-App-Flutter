import 'package:cms_chat_app/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final Color primaryColor;
  final Color secondaryColor;

  const HomeScreen({
    Key? key,
    this.primaryColor = const Color(0xFF1565C0),
    this.secondaryColor = const Color(0xFF1E88E5),
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = [
    'Xét duyệt bài đăng',
    'Tùy chỉnh hệ thống',
    'Thống kê chi tiết',
    'Thông báo của tôi',
    'Thông tin cá nhân',
  ];

  final List<Widget> _pages = [
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0).withOpacity(0.1), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add, size: 64, color: Color(0xFF1565C0)),
            SizedBox(height: 16),
            Text(
              'Bài đăng',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5).withOpacity(0.1), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.settings, size: 64, color: Color(0xFF1E88E5)),
            SizedBox(height: 16),
            Text(
              'Cài đặt',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E88E5),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1565C0).withOpacity(0.1), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bar_chart, size: 64, color: Color(0xFF1565C0)),
            SizedBox(height: 16),
            Text(
              'Thống kê',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5).withOpacity(0.1), Colors.white],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notifications_none, size: 64, color: Color(0xFF1565C0)),
            SizedBox(height: 16),
            Text(
              'Thông báo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1E88E5).withOpacity(0.1), Colors.white],
        ),
      ),
      child: Center(child: ProfileScreen()),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainArea = AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: _pages[_selectedIndex],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_selectedIndex],
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: widget.primaryColor,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return Column(
                children: [
                  Expanded(child: mainArea),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, -2),
                        ),
                      ],
                    ),
                    child: BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.post_add),
                          label: 'Bài đăng',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.settings),
                          label: 'Cài đặt',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.bar_chart),
                          label: 'Thống kê',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.notifications_none),
                          label: 'Thông báo',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.account_circle),
                          label: 'Cá nhân',
                        ),
                      ],
                      currentIndex: _selectedIndex,
                      selectedItemColor: widget.primaryColor,
                      unselectedItemColor: Colors.grey,
                      onTap: _onItemTapped,
                      type: BottomNavigationBarType.fixed,
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
                ],
              );
            } else {
              return Row(
                children: [
                  NavigationRail(
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _onItemTapped,
                    backgroundColor: Colors.white,
                    selectedIconTheme:
                        IconThemeData(color: widget.secondaryColor),
                    unselectedIconTheme:
                        IconThemeData(color: widget.primaryColor),
                    selectedLabelTextStyle:
                        TextStyle(color: widget.secondaryColor),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.post_add),
                        label: Text('Bài đăng'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Cài đặt'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.bar_chart),
                        label: Text('Thống kê'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.notifications_none),
                        label: Text('Thông báo'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.account_circle),
                        label: Text('Cá nhân'),
                      ),
                    ],
                    extended: constraints.maxWidth >= 800,
                  ),
                  Expanded(child: mainArea),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
