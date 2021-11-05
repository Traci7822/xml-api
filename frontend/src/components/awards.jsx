import React from 'react';
import { Link } from 'react-router-dom';

export default function Awards() {
  const [awards, setAwards] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:3001/awards')
    .then((response) => response.json())
    .then((data) => setAwards(data))
    // .catch()
  });

  const renderAwards = () => {
    return (
      <table>
        <tr>
          <th>ID</th>
          <th>Purpose</th>
          <th>Cash Amount</th>
          <th>Filer</th>
        </tr>
        {awards.map((award) => (
          <tr>
            <td key={award.id}>
              {award.id}
            </td>
            <td key={award.purpose}>
              {award.purpose}
            </td>
            <td key={award.cash_amount}>
              {award.cash_amount}
            </td>   
            <td key={award.filer_id}>
              <Link to={`/filers/${award.filer_id}`}>Filer</Link>
            </td>           
          </tr>
        ))}
      </table>
    );
  }

  return (
    <div className="Awards">
      {renderAwards()}
    </div>
  );
}