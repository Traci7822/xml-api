import React from 'react';
import { Link } from 'react-router-dom';
import Address from './address';

export default function Filers() {
  const [filers, setFilers] = React.useState([]);

  React.useEffect(() => {
    fetch('http://localhost:3001/filers')
    .then((response) => response.json())
    .then((data) => setFilers(data))
    // .catch()
  });

  const renderFilers = () => {
    return (
      <table>
        <tr>
          <th>EIN</th>
          <th>Name</th>
          {/* <th>Street Address</th>
          <th>City</th>
          <th>State</th>
          <th>Zip Code</th>
          <th>Awards</th> */}
          <th>Address</th>
        </tr>
        {filers.map((filer) => (
          <tr>
            <td key={filer.ein}>
              {filer.ein}
            </td>
            <td key={filer.name}>
              {filer.name}
            </td>
            {/* <td key={filer.address}>
              {filer.address}
            </td>
            <td key={filer.city}>
              {filer.city}
            </td>
            <td key={filer.state}>
              {filer.state}
            </td>
            <td key={filer.zip_code}>
              {filer.zip_code}
            </td> */}
            <td key={filer.address}>
              <Link to={"/address/" + filer.id}>Address</Link>
            </td>
            <td key={filer.id}>
              <Link to={"/awards/" + filer.id}>Awards</Link> 
            </td>
          </tr>
        ))}
      </table>
    );
  }

  return (
    <div className="Filers">
      {renderFilers()}
    </div>
  );
}