let myPeerId = null;
let peer = null;
let myMediaStream = null;
let connectedPeers = [];

let audioContext = null;
let gainNode = null;

// Get mic stream and process it through gain node
async function getMedia() {
    try {
        const stream = await navigator.mediaDevices.getUserMedia({ audio: true });
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
        const source = audioContext.createMediaStreamSource(stream);
        gainNode = audioContext.createGain();
        gainNode.gain.value = 1.0;
        source.connect(gainNode);

        const destination = audioContext.createMediaStreamDestination();
        gainNode.connect(destination);
        myMediaStream = destination.stream;
    } catch (err) {
        console.log("❌ Error accessing microphone:", err);
    }
}

// Connect to PeerJS server with Metered TURN
function connectToServer(mid) {
    console.log(mid);
    if (mid === "") {
        console.log("Input is empty");
        return;
    }

    peer = new Peer(mid, {
        config: {
            iceServers: [
                { urls: "stun:stun.relay.metered.ca:80" },
                {
                    urls: "turn:global.relay.metered.ca:80",
                    username: "42c77072861dbb07cf20ec03",
                    credential: "CnxHreDWSoBxZUev"
                },
                {
                    urls: "turn:global.relay.metered.ca:80?transport=tcp",
                    username: "42c77072861dbb07cf20ec03",
                    credential: "CnxHreDWSoBxZUev"
                },
                {
                    urls: "turn:global.relay.metered.ca:443",
                    username: "42c77072861dbb07cf20ec03",
                    credential: "CnxHreDWSoBxZUev"
                },
                {
                    urls: "turns:global.relay.metered.ca:443?transport=tcp",
                    username: "42c77072861dbb07cf20ec03",
                    credential: "CnxHreDWSoBxZUev"
                }
            ]
        },
        debug: 3
    });

    peer.on('open', function (id) {
        myPeerId = id;
        console.log("Your peer id is " + id);
    });

    peer.on('call', async function (call) {
        console.log("Got call from " + call.peer);
        await getMedia();
        call.answer(myMediaStream);

        call.on('stream', function (stream) {
            updList(call.peer, call, "add");

            const audioElement = document.createElement('audio');
            audioElement.srcObject = stream;
            audioElement.id = call.peer + "-audio";
            audioElement.autoplay = true;
            document.body.appendChild(audioElement);

            // ICE candidate logging
            if (call.peerConnection) {
                call.peerConnection.addEventListener('icecandidate', event => {
                    if (event.candidate) {
                        const cand = event.candidate.candidate;
                        if (cand.includes('typ relay')) {
                            console.log('✅ TURN relay candidate used:', cand);
                        } else if (cand.includes('typ srflx')) {
                            console.log('🌐 STUN (reflexive) candidate:', cand);
                        } else if (cand.includes('typ host')) {
                            console.log('🏠 Local host candidate:', cand);
                        }
                    }
                });
            }
        });
    });
}

// Call another peer
async function callPeer(pid) {
    
    if (!peer) return console.log("havnt connected to server");

    await getMedia();
    const call = peer.call(pid, myMediaStream);

    call.on('stream', function (stream) {
        console.log("✅ Successfully connected with " + call.peer);
        updList(call.peer, call, "add");

        const audioElement = document.createElement('audio');
        audioElement.srcObject = stream;
        audioElement.id = call.peer + "-audio";
        audioElement.autoplay = true;
        document.body.appendChild(audioElement);

        if (call.peerConnection) {
            call.peerConnection.addEventListener('icecandidate', event => {
                if (event.candidate) {
                    const cand = event.candidate.candidate;
                    if (cand.includes('typ relay')) {
                        console.log('✅ TURN relay candidate used:', cand);
                    } else if (cand.includes('typ srflx')) {
                        console.log('🌐 STUN (reflexive) candidate:', cand);
                    } else if (cand.includes('typ host')) {
                        console.log('🏠 Local host candidate:', cand);
                    }
                }
            });
        }
    });

    call.on('iceStateChanged', () => {
        console.log("ICE connection state changed");
    });

    call.on('error', function (err) {
        console.log("❌ Call error: " + err);
    });

    call.on('close', function () {
        updList(call.peer, call, "remove");
        console.log("❌ Disconnected from " + call.peer);
    });

    console.log("📞 Calling " + pid + "...");
}

// Manage connected peer list
function updList(id, call, type) {
    if (type === "add") {
        connectedPeers.push({ peer_id: id, call: call });
    } else {
        connectedPeers = connectedPeers.filter(i => i.peer_id !== call.peer);
    }
}

// Control volume of a specific user
function setUserVolume(id, value) {
    const audio = document.getElementById(id + "-audio");
    if (audio) {
        audio.volume = value;
        console.log(id + " volume set to", value);
    }
}

// Get all connected users
function getAllUsers() {
    return connectedPeers;
}

// Set your own microphone gain
function setMyVolume(value) {
    if (gainNode) {
        gainNode.gain.value = value;
        console.log("set my volume to ",value)
    }
}

// Expose API to global window
window.PW = {
    connectToVoice: connectToServer,
    callUser: callPeer,
    setUserVolume: setUserVolume,
    getConnectedUsers: getAllUsers,
    setMyVolume: setMyVolume
};
