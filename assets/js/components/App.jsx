import React, {Component} from "react"
import Chat from "./Chat.jsx"
import Game from "./Game.jsx"

class App extends Component {
  render() {

    console.log("Rendering <App/>");

    return (

      <div className="wrapper">
        <article className="content">
          <center><h5>Main game area</h5></center>
          <Game channel={this.props.channel}/>
        </article>
        <aside className="side">
          <center><h5>Chat area</h5></center>
          <Chat channel={this.props.channel} />
        </aside>
        <footer className="foot"><center><img src="images/horse.gif" className="footer-pic"/><h6>copyright 2017 JES</h6></center></footer>
      </div>
    )
  }
}
export default App;
