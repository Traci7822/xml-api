import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';
import Receiver from './receiver'

export default function Receivers() {
  const awardId = useParams()['award_id'];
  const [receivers, setReceivers] = React.useState([]);

  React.useEffect(() => {
    if (receivers?.length != 0) {
      return
    }
    fetch(`http://localhost:3001/receivers`)
    .then((response) => response.json())
    .then((data) => {
      setReceivers(data)})
    .catch()
  });

  const renderReceivers = () => {
    return (
      <>
        {receivers?.map((receiver) => (
          <Receiver receiver={receiver} />
        ))}
      </>
    );
  }

  return (
    <div className="Receivers">
      {renderReceivers()}
    </div>
  );
}