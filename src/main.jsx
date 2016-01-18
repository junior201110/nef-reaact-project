import React from 'react';
import ReactDOM from 'react-dom';
import  Toobar from "./Toobar.jsx";
import  Component from "./Component.jsx";

var PropTypes = React.PropTypes;

var Main = React.createClass({

  render: function() {
    return (
      <div className="class">
        <Toobar />
        <Component />
      </div>
    );
  }

});
ReactDOM.render(<Main />,document.getElementById('center'));
