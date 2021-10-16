import 'package:flutter/material.dart';
import 'package:testovoe/repo.dart';

import 'repo_info_screen.dart';

class RepoWidget extends StatelessWidget {
  RepoWidget(this.repo);

  final RepoInfo repo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RepoInfoScreen(repo.name)));
      },
      child: Container(
        constraints: BoxConstraints.expand(height: 150, width: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  repo.name,
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  child: Text(
                    repo.id,
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              'by ${repo.owner}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    repo.description,
                    style: TextStyle(fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
