import React from 'react';

function LandingPage(props) {
  return (
    <>
      <div className="vh-100 d-flex justify-content-center">
        <div className="loading-spinner m-auto">
          <img src="images/loading.gif" alt="loading.." className="loader"/>
        </div>
      </div>
    </>
  );
}
export default LandingPage;
