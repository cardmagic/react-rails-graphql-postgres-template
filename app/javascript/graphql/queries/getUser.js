import gql from 'graphql-tag'
import client from '../../utils/apolloClient'

const GET_USER = gql`
  query GetUser($authId: String!) {
    user(authId: $authId) {
      id
      name
      email
      authId
      admin
    }
  }
`

const getUser = async ({ authId }) => {
  if (!client) return null

  const {
    data: { user },
  } = await client.query({
    query: GET_USER,
    variables: { authId },
  })

  return user
}

export default getUser
