class Post extends React.Component {
  render () {
    return (
      <div>
        <div>Title: {this.props.title}</div>
        Hej
      </div>
    );
  }
}

Post.propTypes = {
  title: React.PropTypes.string
};
