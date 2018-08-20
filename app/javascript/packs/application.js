// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React, { Fragment } from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import Home from '../routes/home'
import Post from '../routes/post'
import GraphiQL from '../routes/graphiql'

const App = () => (
  <Router>
    <Fragment>
      <Route exact path="/" component={Home} />
      <Route exact path="/posts/:id" component={Post} />
      <Route exact path="/graphiql" component={GraphiQL} />
    </Fragment>
  </Router>
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <App />,
    document.body.appendChild(document.getElementById('app'))
  )
})
