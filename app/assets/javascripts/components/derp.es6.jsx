class Derp extends React.Component {
  render () {
    return (
      <div>
        <div>Title: {this.props.title}</div>
        Hej
      </div>
    );
  }

  Derp.propTypes = {
    title: React.PropTypes.string
  };

}
