import React from 'react';
import FlatButton from 'material-ui/lib/flat-button';
import FloatingActionButton from 'material-ui/lib/floating-action-button';
import ContentAdd from 'material-ui/lib/svg-icons/content/add';
import FAB from './FAB.jsx'
var CommentForm = React.createClass({
  getInitialState: function() {
    return {author: '', text: ''};
  },
  handleAuthorChange: function(e) {
    this.setState({author: e.target.value});
  },
  handleTextChange: function(e) {
    this.setState({text: e.target.value});
  },
  handleSubmit: function(){
    var author = this.state.author.trim();
    var text = this.state.text.trim();
    if (!text || !author) {
      return;
    }
    this.setState({author: '', text: ''});
    this.props.onCommentSubmit({author: author, text: text});
  },
  render: function() {
    return (
      <form className="commentForm">
        <input type="text" id="name" placeholder="Your name"
          value={this.state.author}
          onChange={this.handleAuthorChange}
          />
        <input type="text" placeholder="Say something..."
          value={this.state.text}
          onChange={this.handleTextChange}
          />
        <FAB action={this.handleSubmit} />
        <FlatButton label="SEND" primary={true} onClick={this.handleSubmit} disabled={false} />
      </form>
    );
  }
});

export default CommentForm;
