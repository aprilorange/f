var HomeRouter, loading, render;

render = function(tpl, data) {
  var html;
  html = $(tpl + '-template').innerHTML;
  return nunjucks.renderString(html, data);
};

loading = function() {
  var html;
  html = render('loading');
  return $('output').innerHTML = html;
};

HomeRouter = function() {
  return console.log('Home');
};

Q.reg('home', HomeRouter);

Q.init({
  index: 'home',
  key: '/'
});
