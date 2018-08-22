// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter as Router, Route } from 'react-router-dom'
import { ApolloProvider } from 'react-apollo'

import Home from '../routes/home'
import GraphiQL from '../routes/graphiql'

import apolloClient from '../utils/apolloClient'

const App = () => (
  <Router>
    <ApolloProvider client={apolloClient}>
      <Route exact path="/" component={Home} />
      <Route exact path="/graphiql" component={GraphiQL} />
    </ApolloProvider>
  </Router>
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<App />, document.body.appendChild(document.getElementById('app')))
})
