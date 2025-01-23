enum RouteValue {
  splash(
    path: '/',
  ),
  home(
    path: '/home',
  ),
  article(
    path: 'article',
  ),
  articles(
    path: '/articles',
  ),
  initial(
    path: 'initial',
  ),
  game(
    path: 'game',
  ),
  answer(
    path: 'answer',
  ),
  achievements(
    path: '/achievements',
  ),

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
