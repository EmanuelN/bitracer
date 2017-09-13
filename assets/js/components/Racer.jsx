import React, {Component} from "react"

class Racer extends Component {




  render() {

      // var style = {
      //   height: "100px",
      //   width: "100px",
      //   top: this.state.x,
      //   position: "absolute",
      //   src: "/images/sprite.gif",
      //   backgroundColor: "red"
      // }

      return (

        <div className = "racer" style={{ position: "relative", height: "40px", margin: "50px"}} >
          <img
            src="images/sprite.gif"
            className="sprite"
            style={{
              position: "absolute",
              left: `${this.props.racer}px`
            }}
          />

        </div>

      );

  }

  // componentDidMount() {
  //   Loop(function(tick) {
  //     // animation code here
  //     this.setState({
  //       x: this.state.x + (this.props.racer * tick)
  //     })
  //   }.bind(this))

  // }


}

export default Racer;
