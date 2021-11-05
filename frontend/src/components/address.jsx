import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';


const Address = () => {
  const id = useParams()['id'];
  const [address, setAddress] = React.useState({})

  React.useEffect(() => {
    if (Object.keys(address).length != 0) {
      return
    }
    fetch(`http://localhost:3001/filers/${id}`)
    .then((response) => response.json())
    .then((data) => {
      setAddress({
        "street": data.address,
        "city": data.city,
        "state": data.state,
        "zipCode": data.zip_code
      })
    })
    // .catch()
  });
  const renderAddress = () => {
    return (
      <div>
        {JSON.stringify(address)}
      </div>
    )
  }

  return (
    <div>
      {renderAddress()}
    </div>
  );
}

export default Address;