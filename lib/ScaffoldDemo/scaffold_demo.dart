import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScaffoldDemo extends StatefulWidget {
  const ScaffoldDemo({super.key});

  @override
  State<ScaffoldDemo> createState() => _ScaffoldDemoState();
}

class _ScaffoldDemoState extends State<ScaffoldDemo> with TickerProviderStateMixin {
  final int _currentTabIndex = 0;
  late bool _isAnimation = false;
  late TabController _tabController;
  late Animation<Color?> _animationColor;
  late Animation<double> _animationIcon;
  late AnimationController _animationController;
  late TextEditingController _phoneController;

  final Curve _curve = Curves.easeOut;
  final GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  final List<Widget> _pages = [
    const Center(child: Text('首页')),
    const Center(child: Text('我的')),
  ];

  @override
  void initState() {
    // 初始化tabBar的控制器
    _tabController = TabController(length: 2, vsync: this);

    // 初始化动画控制器
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });

    // 初始化颜色
    _animationColor = ColorTween(
      end: const Color.fromARGB(255, 177, 88, 236),
      begin: const Color.fromARGB(99, 222, 15, 237),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.0, 1.0, curve: _curve)),
    );

    // 初始化icon
    _animationIcon = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    // 初始化手机号码输入的控制器
    _phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _animationController.dispose();
    _phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldStateKey,
      appBar: AppBar(
        title: const Text('Scaffold'),
        backgroundColor: const Color.fromARGB(255, 220, 201, 240),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 30),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: TextButton(
          onPressed: () {
            _scaffoldStateKey.currentState!.openDrawer();
          },
          child: const Icon(Icons.menu, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(onPressed: () {}, tooltip: '扫一扫', icon: const Icon(Icons.qr_code)),
          IconButton(onPressed: () {}, tooltip: '添加', icon: const Icon(Icons.add)),
        ],
        bottom: TabBar(
          tabs: const [
            Tab(text: 'Tab1'),
            Tab(text: 'Tab2'),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          isScrollable: true,
        ),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          debugPrint('空白区域被点击了');
        },
        child: _pages[_currentTabIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _isAnimation ? _animationController.reverse() : _animationController.forward();
          _isAnimation = !_isAnimation;
        },
        shape: const CircleBorder(),
        splashColor: const Color.fromARGB(99, 222, 15, 237),
        backgroundColor: _animationColor.value,
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      // persistentFooterButtons: <Widget>[
      //   TextButton(onPressed: () {}, child: const Text('取消')),
      //   TextButton(onPressed: () {}, child: const Text('确认授权')),
      // ],
      // 对应的有endDrawer
      drawer: const Drawer(
        child: Center(child: Text('我是抽屉')),
      ),
      // 对应的有onEndDrawerChanged
      onDrawerChanged: (isOpen) {
        debugPrint(isOpen ? '我被打开了' : '我被关闭了');
      },
      drawerScrimColor: Colors.black54,
      drawerEdgeDragWidth: 50,
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: '首页'),
      //     BottomNavigationBarItem(icon: Icon(Icons.my_library_add), label: '账户'),
      //   ],
      //   currentIndex: _currentTabIndex,
      //   onTap: (value) {
      //     setState(() {
      //       _currentTabIndex = value;
      //     });
      //   },
      // ),
      bottomSheet: SizedBox(
        width: MediaQuery.of(context).size.width - 0,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                cursorColor: Colors.green,
                cursorWidth: 2,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(11),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                decoration: const InputDecoration(
                  hintText: '请输入手机号码',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('发送'),
            ),
          ],
        ),
      ),
    );
  }
}
