import React, {Component} from "react"
import Chat from "./Chat.jsx"

class App extends Component {
  render() {
    return (
      <div>
        <Chat channel={this.props.channel} />
      </div>
    )
  }
}
export default App;
