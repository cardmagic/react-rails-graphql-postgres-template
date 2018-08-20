import gql from 'graphql-tag'
import client from '../../utils/apolloClient'

const CREATE_USER = gql`
  mutation CreateUser($name: String!, $email: String!, $authId: String!) {
    createUser(name: $name, email: $email, authId: $authId) {
      user {
        id
        name
        email
        authId
        admin
      }
    }
  }
`

const createUser = async ({ name, email, authId }) => {
  if (!client) return null

  const {
    data: {
      createUser: { user },
    },
  } = await client.mutate({
    mutation: CREATE_USER,
    variables: {
      name,
      email,
      authId,
    },
  })

  return user
}

export default createUser
