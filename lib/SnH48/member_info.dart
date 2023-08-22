import 'member_model.dart';
import 'package:flutter/material.dart';

class MemberInfo extends StatelessWidget {
  final Member info;
  final UniqueKey heroKey;
  const MemberInfo({super.key, required this.info, required this.heroKey});

  @override
  Widget build(BuildContext context) {
    // 构建一个行
    Widget buildRow(String label, String content) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(label),
              Text(content, textAlign: TextAlign.right),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            elevation: 0,
            expandedHeight: 300,
            leading: const BackButton(color: Colors.black),
            backgroundColor: Colors.pink[50],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Opacity(
                          opacity: 0.4,
                          child: Image.network(
                            'https://img0.baidu.com/it/u=3862160567,974544341&fm=253&fmt=auto&app=138&f=JPEG?w=480&h=340',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(height: 2, color: Colors.pink[100]),
                      const Expanded(child: SizedBox())
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Hero(
                          tag: heroKey,
                          child: ClipOval(
                            child: Image.network(info.avatarUrl, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                info.name,
                style: TextStyle(color: Colors.grey[800]),
              ),
              collapseMode: CollapseMode.pin,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              buildRow('拼音', info.pinyin),
              buildRow('所属', info.pname),
              buildRow('昵称', info.nickname),
              buildRow('期属', info.join_day),
              buildRow('身高', '${info.height} cm'),
              buildRow('生日', info.birth_day),
              buildRow('星座', info.star_sign_12),
              buildRow('出生地', info.birth_place),
              buildRow('特长', info.speciality),
              buildRow('兴趣', info.hobby),
            ]),
          )
        ],
      ),
    );
  }
}
