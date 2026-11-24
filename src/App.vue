<script setup>
import { ref } from "vue"

import HomeScreen from "./components/HomeScreen.vue"
import TutorialPrompt from "./components/TutorialPrompt.vue"
import TutorialScreen from "./components/TutorialScreen.vue"
import ModeSelect from "./components/ModeSelect.vue"
import Game from "./components/Game.vue"
import Pelea from "./components/Pelea.vue"
import Torneo from "./components/Torneo.vue"
import Ranking from "./components/Ranking.vue"

const screen = ref("home")
const gameMode = ref("teams")
const equipoJugador = ref([])
const equipoRival = ref([])

function goHome() {
  screen.value = "home"
}

function openTutorialQuestion() {
  screen.value = "tutorialPrompt"
}

function startTutorial() {
  screen.value = "tutorial"
}

function skipTutorial() {
  screen.value = "modes"
}

function openModes() {
  screen.value = "modes"
}

function startGame(mode) {
  gameMode.value = mode
  if (mode === "tournament") {
    screen.value = "torneo"
  } else {
    screen.value = "game"
  }
}

function recibirEquipo(datos) {
  equipoJugador.value = datos.equipo
  equipoRival.value = datos.rival
  screen.value = "pelea"
}
</script>

<template>
  <main>
    <Transition name="page" mode="out-in">
      <HomeScreen
        v-if="screen === 'home'"
        key="home"
        @play="openTutorialQuestion"
        @ranking="screen = 'ranking'"
      />

      <TutorialPrompt
        v-else-if="screen === 'tutorialPrompt'"
        key="tutorialPrompt"
        @yes="startTutorial"
        @no="skipTutorial"
        @back="goHome"
      />

      <TutorialScreen
        v-else-if="screen === 'tutorial'"
        key="tutorial"
        @continue="openModes"
        @back="openTutorialQuestion"
      />

      <ModeSelect
        v-else-if="screen === 'modes'"
        key="modes"
        @back="goHome"
        @select="startGame"
      />

      <Game
        v-else-if="screen === 'game'"
        key="game"
        :mode="gameMode"
        @back="openModes"
        @enviar-equipo="recibirEquipo"
      />

      <Pelea
        v-else-if="screen === 'pelea'"
        key="pelea"
        :equipo="equipoJugador"
        :rival="equipoRival"
        @ver-ranking="screen = 'ranking'"
      />

      <Torneo
        v-else-if="screen === 'torneo'"
        key="torneo"
        @back="openModes"
        @ver-ranking="screen = 'ranking'"
      />

      <Ranking
        v-else-if="screen === 'ranking'"
        key="ranking"
        @back="goHome"
      />
    </Transition>
  </main>
</template>
