import React from 'react';
import { Link } from 'react-router-dom';
import { useParams } from 'react-router-dom';

const Award = (props) => {
  const id = useParams()['id'];
  const [award, setAward] = React.useState({});

  React.useEffect(() => {
    if (props.award) {
      setAward(props.award);
    } else if (Object.keys(award).length == 0) {
      fetch(`http://localhost:3001/awards/${id}`)
      .then((response) => response.json())
      .then((data) => setAward(data))
      .catch()
    }
  });

  const renderAward = () => {
    return (
      <>
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
        <td key={award.receiver_id}>
          <Link to={`/receivers/${award.receiver_id}`}>Receiver</Link>
        </td>
      </>
    );
}

  return (
    <tr className="Award">
      {renderAward()}
    </tr>
  );
}

export default Award;