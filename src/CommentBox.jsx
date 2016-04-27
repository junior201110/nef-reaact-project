import React from 'react';
import ReactDOM from 'react-dom';
import CommentForm from './CommentForm.jsx';
import CommentList from './CommentList.jsx'
var CommentBox = React.createClass({
  loadCommentsFromServer: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  handleCommentSubmit: function(comment) {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      type: 'POST',
      data: comment,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  getInitialState: ()=>{
    return {data:[]}
  },
  componentDidMount: function() {
    this.loadCommentsFromServer();
    setInterval(this.loadCommentsFromServer,this.props.poll)
  },
  render: function() {
    return (
      <div className="commentBox">
        <h1>Comments {this.props.index}</h1>
        <CommentList data={this.state.data} />
        <CommentForm  onCommentSubmit={this.handleCommentSubmit} />
      </div>
    );
  }
});
ReactDOM.render(
  <CommentBox url="/api/comments" index={1} poll={1000} />,
  $("#content")[0]
);
