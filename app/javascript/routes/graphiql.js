import React, { Fragment } from 'react'
import GraphiQL from 'graphiql'
import Navbar from '../components/navbar'
import '../assets/graphiql.css'

const graphQLFetcher = graphQLParams =>
  fetch(`${window.location.origin}/graphql`, {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(graphQLParams),
  }).then(response => response.json())

export default () => (
  <Fragment>
    <Navbar />
    <GraphiQL fetcher={graphQLFetcher} />
  </Fragment>
)
