﻿/* IOS Bug dont Use this code */
'use strict';
/* -------------------------------------------------------------------------
   begin Video Youtube
 * ------------------------------------------------------------------------- */

function onYouTubePlayerAPIReady() {
    var playerYoutube;

    playerYoutube = new YT.Player("video-youtube__content", {
        videoId: "1V4h6FXqsjw",
        playerVars: {
            // 'controls': 0,
            // 'showinfo': 0,
            // 'disablekb': 1
        },
        events: {
            onReady: onYouTubePlayerReady
        }
    });
}

function onYouTubePlayerReady(event) {
    // https://developers.google.com/youtube/iframe_api_reference#Events
    var targetYoutubeVideo = event.target;
    var videoDomElem = document.getElementById(
        event.target.getIframe().getAttribute("id")
    );
    var newPlayBtn = videoDomElem.nextElementSibling;

    newPlayBtn.addEventListener("click", function (event) {
        targetYoutubeVideo.playVideo();
        this.classList.add('hidden');
        videoDomElem.classList.remove('video-youtube__content_hide-origin-play-btn');
        videoDomElem.parentNode.classList.remove('video-youtube_overlay');
    });
}

var tag = document.createElement("script");

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName("script")[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

/* -------------------------------------------------------------------------
   end Video Youtube
 * ------------------------------------------------------------------------- */
