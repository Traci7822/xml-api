import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';


const Address = () => {
  const id = useParams()['id'];
  const [address, setAddress] = React.useState('')

  React.useEffect(() => {
    fetch('http://localhost:3001/filers/id')
    .then((response) => response.json())
    .then((data) => {
      console.log(data);  
    })
    // .catch()
  });
  const renderAddress = () => {
    return (
      <div>
        {id}
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