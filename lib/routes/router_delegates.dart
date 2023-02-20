import 'package:dicoding_intermediate/model/quote.dart';
import 'package:dicoding_intermediate/screen/form_screen.dart';
import 'package:dicoding_intermediate/screen/quote_detail_page.dart';
import 'package:dicoding_intermediate/screen/quote_detail_screen.dart';
import 'package:dicoding_intermediate/screen/quotes_list_screen.dart';
import 'package:flutter/material.dart';

class MyRouteDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  MyRouteDelegate() : _navigatorKey = GlobalKey<NavigatorState>();
  String? selectedQoete;
  bool isForm = false;
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      pages: [
        MaterialPage(
          child: QuotesListScreen(
            quotes: quotes,
            toFormSceen: () {
              isForm = true;
              notifyListeners();
            },
            onTapped: (quoteId) {
              selectedQoete = quoteId;
              notifyListeners();
            },
          ),
          key: const ValueKey(
            'QuotesListPage',
          ),
        ),
        if (selectedQoete != null)
          QuoteDetailsPage(
            key: const ValueKey('QuoteDetailsPage'),
            child: QuoteDetailsScreen(
              quoteId: selectedQoete!,
            ),
          ),
        if (isForm)
          MaterialPage(
            key: const ValueKey("FormScreen"),
            child: FormScreen(
              onSend: () {
                isForm = false;
                notifyListeners();
              },
            ),
          )
      ],
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        selectedQoete = null;
        isForm = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
