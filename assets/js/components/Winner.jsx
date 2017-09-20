import React from 'react';

const Winner = (props) => {
  let result;
  switch (props.winner) {
    case 'a':
      result = (
        <div>
          <img className="won" alt="racer1" src="images/pikachu.gif" />
        </div>
      );
      break;
    case 'b':
      result = (
        <div className="won">
          <img className="won" alt="racer2" src="images/flareon.gif" />
        </div>
      );
      break;
    case 'c':
      result = (
        <div className="won">
          <img className="won" alt="racer3" src="images/crossfox.gif" />
        </div>
      );
      break;
    case 'd':
      result = (
        <div className="won">
          <img className="won" alt="racer4" src="images/zoroark.gif" />
        </div>
      );
      break;
    case 'e':
      result = (
        <div className="won">
          <img className="won" alt="racer5" src="images/homer.gif" />
        </div>
      );
      break;
    default:
      break;
  }
  return result;
};
export default Winner;
