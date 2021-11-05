import React from 'react';
import { Link } from 'react-router-dom';
import Award from './award';


const Awards = () => {
  const [awards, setAwards] = React.useState([]);

  React.useEffect(() => {
    if (awards?.length != 0) {
      return
    }
    fetch('http://localhost:3001/awards')
    .then((response) => response.json())
    .then((data) => setAwards(data))
    .catch()
  });

  const renderAwards = () => {
    return (
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Purpose</th>
            <th>Cash Amount</th>
            <th>Filer</th>
            <th>Receivers</th>
          </tr>
        </thead>
        <tbody>
          {awards.map((award) => (
            <Award award={award} />
          ))}
        </tbody>
      </table>

    );
  }

  return (
    <div className="Awards">
      {renderAwards()}
    </div>
  );
}

export default Awards;