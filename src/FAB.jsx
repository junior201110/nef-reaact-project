import React from 'react';
import FlatButton from 'material-ui/lib/flat-button';
import FloatingActionButton from 'material-ui/lib/floating-action-button';
import ContentSend from 'material-ui/lib/svg-icons/content/send';

const style = {
  marginRight:20
}

const FAB = React.createClass({
   send: function (e) {
     this.props.action;
   },
  render: function(){
    return (
      <div  onClick={this.send}>
        <FloatingActionButton >
          <ContentSend />
        </FloatingActionButton>
      </div>
    )
  }
});

export default FAB;
