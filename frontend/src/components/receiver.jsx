import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';

const Receiver = (props) => {
  const id = useParams()['id'];
  const [receiver, setReceiver] = React.useState({})

  React.useEffect(() => {
    if (props.receiver) {
      setReceiver(props?.receiver);
    } else if (Object.keys(receiver).length == 0) {
      fetch(`http://localhost:3001/receivers/${id}`)
      .then((response) => response.json())
      .then((data) => {
        setReceiver(data);
      })
      .catch()
    }    
  });

  const renderReceiver = () => {
    return (
      <table>
        <tr>
          <th>EIN</th>
          <th>Name</th>
          <th>Address</th>
          <th>Award</th>
        </tr>
        <tr>
          <td key={receiver.ein}>
            {receiver.ein}
          </td>
          <td key={receiver.name}>
            {receiver.name}
          </td>
          <td key={receiver.address}>
            <Link to={"/address/receivers/" + receiver.id}>Address</Link>
          </td>
          <td key={receiver.id}>
            <Link to={"/awards/" + receiver.id}>Award</Link> 
          </td>
        </tr>
      </table>
    )
  }

  return (
    <div className="Receiver">
      {renderReceiver()}
    </div>
  );
}

export default Receiver;