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
      <>
        {awards.map((award) => (
          <Award award={award} />
         ))}
      </>
    );
  }

  return (
    <div className="Awards">
      {renderAwards()}
    </div>
  );
}

export default Awards;