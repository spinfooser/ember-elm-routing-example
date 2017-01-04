import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('about', {path: '/about'});
  this.route('home', {path: '/'});
  this.route('elm', {path: '/elm'});
});

export default Router;
