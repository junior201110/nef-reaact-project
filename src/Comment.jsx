import React from 'react';
import marked from 'marked';

var Comment = React.createClass({
  render: function() {
    return (
      <div className="comment">
        <div className="commentAuthor">
          {this.props.author}
        </div>
        <span >
          {this.props.children}
        </span>
      </div>
    );
  }
});


export default Comment;
