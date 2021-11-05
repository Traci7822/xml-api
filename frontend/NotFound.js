import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class NotFound extends Component {
  render () {
    return (
      <>
        <h1>404: Not found</h1>
       <Button as={Link} to='/'>Back to home</Button>
      </>
    )
  }
}

export default NotFound;