import React, {Component} from "react"
import Chat from "./Chat.jsx"
import Game from "./Game.jsx"

class App extends Component {
  render() {
    return (
      <div>
        <Game channel={this.props.channel} />
        <Chat channel={this.props.channel} />
      </div>
    )
  }
}
export default App;
