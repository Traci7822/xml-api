import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';

const Filer = (props) => {
  const id = useParams()['id'];
  const [filer, setFiler] = React.useState({})

  React.useEffect(() => {
    if (props?.filer) {
      setFiler(props.filer);
    } else if (Object.keys(filer).length == 0) {
      fetch(`http://localhost:3001/filers/${id}`)
      .then((response) => response.json())
      .then((data) => {
        setFiler(data);
      })
      .catch()
    }
  });

  const renderFiler = () => {
    return (
      <table>
        <tr>
          <th>EIN</th>
          <th>Name</th>
          <th>Address</th>
          <th>Awards</th>
        </tr>
        <tr>
          <td key={filer.ein}>
            {filer.ein}
          </td>
          <td key={filer.name}>
            {filer.name}
          </td>
          <td key={filer.address}>
            <Link to={"/address/filers/" + filer.id}>Address</Link>
          </td>
          <td key={filer.id}>
            <Link to={"/awards/" + filer.id}>Awards</Link> 
          </td>
        </tr>
      </table>
    )
  }

  return (
    <div className="Filer">
      {console.log(filer)}
      {renderFiler()}
    </div>
  );
}

export default Filer;