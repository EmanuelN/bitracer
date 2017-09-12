import React, {Component} from "react"


class Racer extends Component {


  render() {

      return (

        <div className = "racer">

          <img src="/images/sprite.gif" className="sprite" position={this.props.racer}/>


        </div>

      );


  }
}

export default Racer;
