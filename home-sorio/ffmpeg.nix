{ pkgs, ... }:
{
  # I use ffmpeg to convert m4a recordings to mp3

  # create an alias for ffmpeg_5 

  home.packages = with pkgs; [
     ffmpeg_5
  ];

  programs.zsh.initExtra = ''
    m4a2mp3() {
      ffmpeg -i "$1" -acodec libmp3lame -ab 192k "''${2:-''${1%.m4a}.mp3}"
    }
  '';
}
