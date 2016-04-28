var React = require('react'),
    ReactDOM = require('react-dom');

var Router = require('react-router').Router,
    Route = require('react-router').Route,
    IndexRoute = require('react-router').IndexRoute,
    hashHistory = require('react-router').hashHistory;


var Search = require('./components/search'),
    Header = require('./components/layout/header'),
    Footer = require('./components/layout/footer'),
    LoginForm = require('./components/login_form'),
    SignupForm = require('./components/signup_form'),
    ProductForm = require('./components/products/product_form');

var App = React.createClass({
  render: function(){
    return (
        <div id='app'>
          <Header />
          <main>
            <LoginForm />
            <SignupForm />
            {this.props.children}
          </main>
        </div>
    );
  }
});

var Rtr = (
  <Router history={hashHistory}>
    <Route path='/' component={App}>
      <IndexRoute component={Search} />
        <Route path='products/new' component={ProductForm} />
    </Route>
  </Router>
);

document.addEventListener("DOMContentLoaded", function () {
  var root = document.getElementById('root');
  ReactDOM.render(Rtr, root);
});
