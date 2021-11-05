import './App.css';
import React from 'react';
import { Link } from 'react-router-dom';


function Home() {
  return (
    <div>
      <Link to="/awards">Awards</Link>
    </div>
  );
}

export default Home;
