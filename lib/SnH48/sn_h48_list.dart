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

  SliverList _buildTeamList(String teamName) {
    List<Member> teamMembers = _members.where((row) => row.team == teamName).toList();

    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        debugPrint('result: $index');
        Member member = teamMembers[index];
        return ListTile(
          leading: ClipOval(
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: Image.network(member.getAvatarUrl),
            ),
          ),
          title: Text(member.name),
          subtitle: Text(member.id),
          trailing: Text(member.team),
        );
      }, childCount: _members.length),
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
      body: CustomScrollView(
        slivers: [
          _buildTeamList('SII'),
          _buildTeamList('NII'),
          _buildTeamList('HII'),
          _buildTeamList('X'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
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
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class Member {
  final String id;
  final String name;
  final String team;

  Member({required this.id, required this.name, required this.team});

  String get getAvatarUrl {
    return 'https://www.snh48.com/images/member/zp_$id.jpg';
  }

  @override
  String toString() => '$id: $name';
}