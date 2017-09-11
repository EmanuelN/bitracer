import React, {Component} from "react"

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      horse_a: 0,
      horse_b: 0
    }
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('game_data', (payload) => {
      const horseA = payload.horse_a;
      const horseB = payload.horse_b;
      this.setState({ horse_a: horseA });
      this.setState({ horse_b: horseB })
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
