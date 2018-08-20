import React from 'react'
import { Collapse, Navbar as ReactNavbar, NavbarBrand, Nav, NavItem, NavLink } from 'reactstrap'

const Navbar = () => (
  <ReactNavbar color="light" light expand="md">
    <NavbarBrand href="/">My Template App</NavbarBrand>
    <Collapse isOpen navbar>
      <Nav className="ml-auto" navbar>
        <NavItem>
          <NavLink href="/">Home</NavLink>
        </NavItem>
        <NavItem>
          <NavLink href="/graphiql">GraphiQL</NavLink>
        </NavItem>
      </Nav>
    </Collapse>
  </ReactNavbar>
)

export default Navbar
