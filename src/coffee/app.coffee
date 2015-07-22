render = (tpl, data) ->
  html = $(tpl + '-template').innerHTML
  nunjucks.renderString html, data

loading = ->
  html = render('loading')
  $('output').innerHTML = html

HomeRouter = ->
  console.log 'Home'

Q
  .reg 'home', HomeRouter

Q
  .init
    index: 'home'
    key: '/'
