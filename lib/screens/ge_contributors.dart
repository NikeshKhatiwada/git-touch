import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/S.dart';
import 'package:git_touch/models/auth.dart';
import 'package:git_touch/models/gitee.dart';
import 'package:git_touch/models/theme.dart';
import 'package:git_touch/scaffolds/list_stateful.dart';
import 'package:git_touch/widgets/app_bar_title.dart';
import 'package:provider/provider.dart';

class GeContributorsScreen extends StatelessWidget {
  const GeContributorsScreen(this.owner, this.name);
  final String owner;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ListStatefulScaffold<GiteeContributor, int>(
      title: AppBarTitle(AppLocalizations.of(context)!.contributors),
      fetch: (page) async {
        page = page ?? 1;
        final res = await context
            .read<AuthModel>()
            .fetchGiteeWithPage('/repos/$owner/$name/contributors')
            .then((v) {
          return [
            for (var contributor in v.data)
              GiteeContributor.fromJson(contributor)
          ];
        });
        return ListPayload(
          cursor: page + 1,
          items: res,
          hasMore: res.isNotEmpty,
        );
      },
      itemBuilder: (v) {
        final theme = context.read<ThemeModel>();
        return Container(
          padding: CommonStyle.padding,
          child: Row(
            children: <Widget>[
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          v.name!,
                          style: TextStyle(
                            color: theme.palette.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    if (v.contributions != null)
                      DefaultTextStyle(
                        style: TextStyle(
                          color: theme.palette.secondaryText,
                          fontSize: 16,
                        ),
                        child: Text('Contributions: ${v.contributions}'),
                      ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
