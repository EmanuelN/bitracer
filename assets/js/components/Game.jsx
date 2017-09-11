import React, {Component} from "react"

class Game extends Component {
  constructor(props) {
    super(props);
    this.state = {
      horse_a: 0,
      horse_b: 0,
      horse_c: 0,
      horse_d: 0,
      horse_e: 0
    }
    this.channel = this.props.channel;
  }

  componentDidMount() {
    this.channel.on('game_data', (payload) => {
      const horse_a = payload.horse_a;
      const horse_b = payload.horse_b;
      const horse_c = payload.horse_a;
      const horse_d = payload.horse_b;
      const horse_e = payload.horse_b;
      this.setState({ horse_a, horse_b, horse_c, horse_d, horse_e });
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
