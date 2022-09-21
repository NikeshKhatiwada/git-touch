import 'package:flutter/cupertino.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:git_touch/widgets/link.dart';

class EntryItem extends StatelessWidget {

  const EntryItem({
    required this.text,
    this.count,
    this.url,
  });
  final int? count;
  final String text;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeModel>(context);

    return Expanded(
      child: LinkWidget(
        url: url,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            children: <Widget>[
              Text(
                count == null ? '?' : numberFormat.format(count),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: theme.palette.text,
                ),
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.palette.secondaryText,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
