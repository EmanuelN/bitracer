import React, {Component} from "react"

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      randData: 0,
    }
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('game_data', (payload) => {
      const randData = payload.content;
      this.setState({ randData });
    });
  }

  render() {
    return (
      <div className="game">
      </div>
    )
  }
}
export default Game;
