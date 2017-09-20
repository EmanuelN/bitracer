import React from 'react';
import PropTypes from 'prop-types';

const mute = (e) => {
  const players = document.getElementsByClassName('audioPlayer')
  for (let i = 0; i < players.length; i += 1) {
    players[i].muted = !players[i].muted;
  }
  if (e.currentTarget.className === 'mute') {
    e.currentTarget.className = 'unmute';
  } else {
    e.currentTarget.className = 'mute';
  }
}

const AudioPlayer = props => (
  <span className="audio-player">
    <audio
      className="audioPlayer"
      src={props.src}
      autoPlay={props.autoPlay}
      loop={props.loop}
    />
    <button className="mute" onClick={mute} />
    <label for="un-mute"></label>
  </span>
);

AudioPlayer.propTypes = {
  autoPlay: PropTypes.bool.isRequired,
  loop: PropTypes.bool.isRequired,
  src: PropTypes.string.isRequired,
};

export default AudioPlayer;
