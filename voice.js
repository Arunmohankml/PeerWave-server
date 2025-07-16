let myPeerId = null;
let peer = null;
let myMediaStream = null;
let connectedPeers = [];


let audioContext = null;
let gainNode = null;
async function getMedia() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia({
            audio: true
        });
        audioContext = new(window.AudioContext || window.webkitAudioContext)();
        //connecting mic to audio web audio system
        const source = audioContext.createMediaStreamSource(stream);
        gainNode = audioContext.createGain();
        gainNode.gain.value = 1.0;
        source.connect(gainNode);
        const destination = audioContext.createMediaStreamDestination();
        gainNode.connect(destination);

        //storing modifed voice as  output
        myMediaStream = destination.stream;
    } catch (err) {
        console.log(err);
    }
}

function connectToServer(mid) {
    console.log(mid)
    if (mid == "") {
        console.log("Input is empty");
    } else {
        //create peer id
        peer = new Peer(mid, {
            config: {
                      iceServers: [
                        // ✅ STUN (fast + reliable)
                        { urls: "stun:stun.l.google.com:19302" },
                        { urls: "stun:stun1.l.google.com:19302" },
                        { urls: "stun:stun2.l.google.com:19302" },
                    
                        // ✅ TURN (required for NAT traversal across networks)
                        {
                          urls: "turn:numb.viagenie.ca",
                          credential: "muazkh",
                          username: "webrtc@live.com"
                        },
                        {
                          urls: "turn:turn.bistri.com:80",
                          credential: "homeo",
                          username: "homeo"
                        },
                        {
                          urls: "turn:turn.anyfirewall.com:443?transport=tcp",
                          credential: "webrtc",
                          username: "webrtc"
                        }
                      ]
                    },
            debug: 3
        });
        //whn ourself connect to peerjs server
        peer.on('open', function(id) {
            myPeerId = id;
            console.log("Your peer id is " + id);
        });

        peer.on('call', async function(call) {
            console.log("Got call from " + call.peer);
            await getMedia();
            //accepting call and sending back our voice stream
            call.answer(myMediaStream);

            call.on('stream', function(stream) {
                updList(call.peer, call, "add");
                //cretaing audio obj of opp player
                let audioElement = document.createElement('audio');
                audioElement.srcObject = stream;
                audioElement.id = call.peer + "-audio";
                audioElement.autoplay = true;
                document.body.appendChild(audioElement);
            });
        });
    }
}

//call a peer
async function callPeer(pid) {
    const inputId = document.getElementById('target-peerid').value;
    if (!peer) return console.log("havnt connected to server");
    if (inputId === "") return console.log("enter id");

    await getMedia();

    const call = peer.call(inputId, myMediaStream);

    call.on('stream', function(stream) {
        console.log("✅ Successfully connected with " + call.peer);
        updList(call.peer, call, "add");

        const audioElement = document.createElement('audio');
        audioElement.srcObject = stream;
        audioElement.id = call.peer + "-audio";
        audioElement.autoplay = true;
        document.body.appendChild(audioElement);
    });
    call.on('iceStateChanged', () => {
        console.log("ICE connection state changed");
    });

    call.on('error', function(err) {
        console.log("❌ Call error: " + err);
    });

    call.on('close', function() {
        updList(call.peer, call, "remove");
        console.log("❌ Disconnected from " + call.peer);
    });

    console.log("📞 Calling " + inputId + "...");
}


function updList(id, call, type) {
    if (type == "add") {
        connectedPeers.push({
            peer_id: id,
            call: call
        });
    } else {
        connectedPeers = connectedPeers.filter(i => i.peer_id !== call.peer);
    }
}

function setUserVolume(id, value) {
    if (document.getElementById(id + "-audio") !== null) {
        let audio = document.getElementById(id + "-audio");
        audio.volume = value;;
        console.log(id + " muted;");
    }
}

function getAllUsers() {
    return connectedPeers;
}

function setMyVolume(value) {
    gainNode.gain.value = value;
}

window.PW = {
    connectToVoice: connectToServer,
    callUser: callPeer,
    setUserVolume: setUserVolume,
    getConnectedUsers: getAllUsers,
    setMyVolume: setMyVolume,
}
