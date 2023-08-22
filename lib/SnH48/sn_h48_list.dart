import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SnH48List extends StatefulWidget {
  const SnH48List({super.key});

  @override
  State<SnH48List> createState() => _SnH48ListState();
}

class _SnH48ListState extends State<SnH48List> {
  List<Member> _members = [];

  @override
  initState() {
    _fetchMemberList();
    super.initState();
  }

  // 获取列表
  _fetchMemberList() async {
    setState(() => _members.clear());
    const url = 'https://h5.48.cn/resource/jsonp/allmembers.php?gid=10';
    final res = await http.get(Uri.parse(url));
    if (res.statusCode != 200) {
      throw ('error::');
    }

    final jsonData = convert.jsonDecode(res.body);
    final members = jsonData['rows'].map<Member>((row) {
      return Member(id: row['sid'], name: row['sname'], team: row['tname']);
    });

    setState(() => _members = members.toList());
  }

  // 构造每个组的列表
  SliverList _buildTeamList(String teamName) {
    List<Member> teamMembers = _members.where((row) => row.team == teamName).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        Member member = teamMembers[index];
        return ListTile(
          leading: ClipOval(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Image.network(member.avatarUrl),
            ),
          ),
          title: Text(member.name),
          subtitle: Text(member.id),
          trailing: Text(member.team),
        );
      }, childCount: teamMembers.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('hello, SNH48'),
        centerTitle: true,
      ),
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () => _fetchMemberList(),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(),
              // SII
              SliverPersistentHeader(
                delegate: _TeamDelegate('Team SII', const Color(0xff91cdeb)),
                pinned: true,
              ),
              _buildTeamList('SII'),
              // NII
              SliverPersistentHeader(
                delegate: _TeamDelegate('Team NII', const Color(0xffae86bb)),
                pinned: true,
              ),
              _buildTeamList('NII'),
              // HII
              SliverPersistentHeader(
                delegate: _TeamDelegate('Team HII', const Color(0xfff39800)),
                pinned: true,
              ),
              _buildTeamList('HII'),
              // X
              SliverPersistentHeader(
                delegate: _TeamDelegate('Team X', const Color(0xffa9cc29)),
                pinned: true,
              ),
              _buildTeamList('X'),
            ],
          ),
        ),
      ),
    );
  }
}

// 会员组的代理
class _TeamDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final Color color;
  _TeamDelegate(this.title, this.color);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 32,
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant _TeamDelegate oldDelegate) {
    return oldDelegate.title != title;
  }
}

class Member {
  final String id;
  final String name;
  final String team;

  Member({required this.id, required this.name, required this.team});

  String get avatarUrl {
    return 'https://www.snh48.com/images/member/zp_$id.jpg';
  }

  @override
  String toString() => '$id: $name';
}
