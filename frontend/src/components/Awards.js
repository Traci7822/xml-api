import React from 'react';

function Awards() {
  const [awards, setAwards] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:3001/awards')
    .then((response) => response.json())
    .then((data) => setAwards(data))
    // .catch()
  });

  const renderAwards = () => {
    console.log(awards);
    return (
      <table>
        <tr>
          <th>ID</th>
          <th>Purpose</th>
          <th>Cash Amount</th>
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

export default Awards;
