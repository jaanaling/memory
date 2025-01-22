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

  unknown(
    path: '',
  );

  final String path;
  const RouteValue({
    required this.path,
  });
}
