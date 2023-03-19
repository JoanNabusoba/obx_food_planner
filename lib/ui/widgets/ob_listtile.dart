import 'package:flutter/material.dart';

class OBListTile extends StatelessWidget {
  const OBListTile({
    super.key,
    required this.img,
    required this.title,
    required this.subTitle,
    required this.onTileClick,
    required this.deleteClick,
  });

  final String img;
  final String title;
  final String subTitle;
  final VoidCallback onTileClick;
  final VoidCallback deleteClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTileClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //img
          Container(
            width: MediaQuery.of(context).size.height * .08,
            height: MediaQuery.of(context).size.height * .08,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: img == ""
                  ? const DecorationImage(
                      image: AssetImage("images/chef_purple.png"),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: NetworkImage(img),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black45),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: deleteClick,
              icon: Icon(
                Icons.delete_outline,
                color: Colors.red.shade300,
              ))
        ],
      ),
    );
  }
}
