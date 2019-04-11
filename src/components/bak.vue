<template>
  <div>
    <viewer :images="signImages">
        <img v-for="src in signImages" :src="src" :key="src" width="240" height="240">
    </viewer>
</div>
</template>

<script>
var reader;
import ipfsAPI from "ipfs-api";
const ipfsApiAddress = {
  protocol: "http",
  host: "localhost",
  port: 5001
};
const ipfsGatewayUrl = "http://localhost:5000";

const ipfs = ipfsAPI(ipfsApiAddress);

export default {
  data() {
    return {
      signImages: [
        "http://localhost:5000/ipfs/Qmbhw8aGxK3wERWWUccTc5CYRkV4KbVq2fiqexYUTnTS9J",
        "http://localhost:5000/ipfs/QmdPLwgsAtmm8sqcYKHdpKMMRN3pToMs2Ga28GdKTTYx8t"
      ]
    };
  }
};
</script>