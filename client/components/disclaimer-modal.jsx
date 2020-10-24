import React from 'react';

function DisclaimerModal(props) {
  function handleClick() {
    props.setView('home', {});
  }

  return (
    <div className="row justify-content-center align-items-center mt-5">
      <div className="d-flex flex-wrap justify-content-center col-9 rounded p-4 modal1">
        <h2 className="col-12 d-flex justify-content-center">Disclaimer</h2>
        <p className="col-12">This website is just a demo and no real purchases will be made. Please do not use any personal information. Please click the button below to continue. Thank you and enjoy!</p>
        <button className="btn-primary btn" onClick={handleClick}>Okay</button>
      </div>
    </div>
  );
}

export default DisclaimerModal;
