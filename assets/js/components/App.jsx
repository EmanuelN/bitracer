import React, {Component} from "react"
import Chat from "./Chat.jsx"
import Game from "./Game.jsx"

class App extends Component {
  render() {

    console.log("Rendering <App/>");

    return (

      <div className="wrapper">
        <article className="content">
          <h4>Main game area</h4>

          <Game channel={this.props.channel}/>
        </article>
        <aside className="side">
          <h4>Chat area</h4>
          <Chat channel={this.props.channel} />
        </aside>
      </div>
    )
  }
}
export default App;
