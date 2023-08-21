import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SnH48 extends StatefulWidget {
  const SnH48({super.key});

  @override
  State<SnH48> createState() => _SnH48State();
}

class _SnH48State extends State<SnH48> {
  List<Member> _members = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('hello, SNH48'),
      ),
      body: ListView.builder(
        itemCount: _members.length,
        itemBuilder: (BuildContext context, int index) {
          Member member = _members[index];
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
          );
        },
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
            return Member(id: row['sid'], name: row['sname']);
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

  Member({required this.id, required this.name});

  String get getAvatarUrl {
    return 'https://www.snh48.com/images/member/zp_$id.jpg';
  }

  @override
  String toString() => '$id: $name';
}
