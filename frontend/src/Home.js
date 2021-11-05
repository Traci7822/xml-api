import logo from './logo.svg';
import './App.css';
import React from 'react';

function Home() {
  React.useEffect(() => {
    fetch('http://localhost:3001/awards')
    .then((response) => response.json())
    .then((data) => console.log(data))
    .catch()
  });

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
      </header>
    </div>
  );
}

export default Home;
