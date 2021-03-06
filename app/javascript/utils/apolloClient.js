import { ApolloClient } from 'apollo-client'
import { HttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import { ApolloLink } from 'apollo-link'
import { withClientState } from 'apollo-link-state'
import { persistCache } from 'apollo-cache-persist'

const cache = new InMemoryCache()

persistCache({
  cache,
  storage: window.localStorage,
})

const stateLink = withClientState({
  cache,
})

const httpLink = new HttpLink({
  uri: process.env.REACT_APP_GRAPHQL_ENDPOINT || 'http://localhost:3000/graphql',
})

const link = ApolloLink.from([stateLink, httpLink])

const defaultOptions = {
  watchQuery: {
    fetchPolicy: 'cache-and-network',
    errorPolicy: 'all',
  },
  query: {
    fetchPolicy: 'cache-and-network',
    errorPolicy: 'all',
  },
  mutate: {
    errorPolicy: 'all',
  },
}

const client = new ApolloClient({
  link,
  cache,
  defaultOptions,
})

export default client
