import React from 'react';
import { Link } from 'react-router-dom';
import Address from './address';
import Filer from './filer';

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
      <>     
        {filers.map((filer) => (
          <Filer filer={filer} />
         ))}
      </>
    );
  }

  return (
    <div className="Filers">
      {renderFilers()}
    </div>
  );
}