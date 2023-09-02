import 'member_info.dart';
import 'member_model.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SnH48Grid2 extends StatefulWidget {
  const SnH48Grid2({super.key});

  @override
  State<SnH48Grid2> createState() => _SnH48Grid2State();
}

class _SnH48Grid2State extends State<SnH48Grid2> {
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
      return Member(
        id: row['sid'],
        name: row['sname'],
        team: row['tname'],
        pinyin: row['pinyin'],
        abbr: row['abbr'],
        tid: row['tid'],
        pid: row['pid'],
        pname: row['pname'],
        nickname: row['nickname'],
        company: row['company'],
        join_day: row['join_day'],
        height: row['height'],
        birth_day: row['birth_day'],
        star_sign_12: row['star_sign_12'],
        star_sign_48: row['star_sign_48'],
        birth_place: row['birth_place'],
        speciality: row['speciality'],
        hobby: row['hobby'],
      );
    });

    setState(() => _members = members.toList());
  }

  // 构造每个组的列表
  Widget _buildTeamList(String teamName) {
    List<Member> teamMembers = _members.where((row) => row.team == teamName).toList();
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          Member member = teamMembers[index];
          UniqueKey heroKey = UniqueKey();
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                CupertinoPageRoute(builder: (_) => MemberInfo(info: member, heroKey: heroKey)),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: heroKey,
                  child: ClipOval(
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      child: Image.network(member.avatarUrl),
                    ),
                  ),
                ),
                Text(member.name),
              ],
            ),
          );
        },
        childCount: teamMembers.length,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100,
      ),
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
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _TeamDelegate('Team SII', const Color(0xff91cdeb)),
                    pinned: true,
                  ),
                  _buildTeamList('NII'),
                ],
              ),

              // NII
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _TeamDelegate('Team NII', const Color(0xffae86bb)),
                    pinned: true,
                  ),
                  _buildTeamList('NII'),
                ],
              ),

              // HII
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _TeamDelegate('Team HII', const Color(0xfff39800)),
                    pinned: true,
                  ),
                  _buildTeamList('HII'),
                ],
              ),

              // X
              SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    delegate: _TeamDelegate('Team X', const Color(0xffa9cc29)),
                    pinned: true,
                  ),
                  _buildTeamList('X'),
                ],
              ),
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
