import React from 'react';
import ReactDOM from 'react-dom';
import  Component from "./Component.jsx";
import  Toobar from "./Toobar.jsx";

var PropTypes = React.PropTypes;

var Main = React.createClass({

  render: function() {
    return (
      <div className="class">Hi</div>
    );
  }

});
ReactDOM.render(<Toobar />,document.getElementById('toobar'));
ReactDOM.render(<Main />,document.getElementById('center'));
ReactDOM.render(<Component />,document.getElementById('footer'));
