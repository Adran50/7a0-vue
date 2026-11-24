<script setup>
import { ref, computed, onMounted } from "vue"
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["enviar-equipo", "back"])

const props = defineProps({
  mode: {
    type: String,
    default: "teams"
  }
})

// Cantidad de personajes segun el modo
const maxJugadores = computed(() => (props.mode === "duel" ? 1 : 3))

const lista = ref([])
const rival = ref([])
const jugadorActivo = ref(null)

// Casillas del tablero
const botones = ref([])

function inicializarTablero() {
  const cantidad = maxJugadores.value
  botones.value = Array.from({ length: cantidad }, (_, i) => ({
    numero: i + 1,
    jugador: null
  }))
}

const tableroCompleto = computed(() => {
  return botones.value.length > 0 && botones.value.every(b => b.jugador !== null)
})

// Personajes de respaldo si el backend PHP no esta activo
const personajesLocales = [
  { id: 1, nombre: "Lionel Messi", img: "/jugadores/1_messi.avif", poder: 14, tipo: "Líder" },
  { id: 2, nombre: "Guido Kaczka", img: "/jugadores/2_guido.avif", poder: 6, tipo: "Conductor" },
  { id: 4, nombre: "Javier Milei", img: "/jugadores/4_milei.avif", poder: 6, tipo: "Economista" },
  { id: 5, nombre: "Vladimir Putin", img: "/jugadores/5_putin.avif", poder: 11, tipo: "Estratega" },
  { id: 8, nombre: "Super Hijitus", img: "/jugadores/8_hijitus_sombreritus.avif", poder: 90, tipo: "Héroe" },
  { id: 10, nombre: "Larguirucho", img: "/jugadores/10_larguirucho.avif", poder: 12, tipo: "Amigo" },
  { id: 12, nombre: "Profesor Neurus", img: "/jugadores/12_profesor neurus.avif", poder: 15, tipo: "Científico" },
  { id: 19, nombre: "Mafalda", img: "/jugadores/19_mafalda.avif", poder: 3, tipo: "Filósofa" },
  { id: 30, nombre: "Patoruzú", img: "/jugadores/30_patoruzu.avif", poder: 95, tipo: "Cacique" },
  { id: 34, nombre: "Walter White", img: "/jugadores/34_walter white.avif", poder: 28, tipo: "Químico" },
  { id: 37, nombre: "Mike Ehrmantraut", img: "/jugadores/37_mike ehrmantraut.avif", poder: 36, tipo: "Operador" },
  { id: 40, nombre: "Tuco Salamanca", img: "/jugadores/40_tuco salamanca.avif", poder: 42, tipo: "Fuerza" }
]

const sortear = async () => {
  const cantidad = maxJugadores.value
  let obtenidos = null

  try {
    const res = await fetch(`http://localhost/php/obtenerEquipo.php?cantidad=${cantidad}`)
    if (res.ok) {
      const data = await res.json()
      if (data && data.lista && data.rival) {
        obtenidos = data
      }
    }
  } catch (e) {
    // Si falla el backend, continua con fallback local
  }

  if (obtenidos) {
    lista.value = obtenidos.lista
    rival.value = obtenidos.rival
  } else {
    // Sorteo local aleatorio sin repeticiones
    const mezclados = [...personajesLocales].sort(() => 0.5 - Math.random())
    const yaAsignados = botones.value.map(b => b.jugador?.id).filter(Boolean)
    const disponibles = mezclados.filter(p => !yaAsignados.includes(p.id))

    lista.value = disponibles.slice(0, 3)
    rival.value = disponibles.slice(3, 3 + cantidad)
  }
}

const seleccionarJugador = (jugador) => {
  if (jugadorActivo.value?.id === jugador.id) {
    jugadorActivo.value = null
  } else {
    jugadorActivo.value = jugador
  }
}

const asignarJugador = (boton) => {
  if (boton.jugador || !jugadorActivo.value) return
  boton.jugador = jugadorActivo.value
  jugadorActivo.value = null

  if (!tableroCompleto.value) {
    sortear()
  }
}

const removerJugador = (boton) => {
  if (!boton.jugador) return
  boton.jugador = null
  sortear()
}

const enviarEquipo = () => {
  const equipo = botones.value.map(b => b.jugador).filter(Boolean)
  emit("enviar-equipo", {
    equipo: equipo,
    rival: rival.value
  })
}

onMounted(() => {
  inicializarTablero()
  sortear()
})
</script>

<template>
  <section class="screen game-screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver a Modos
    </button>

    <div class="game-container">
      <div class="header">
        <h2 class="title section-title">
          {{ props.mode === 'duel' ? 'Duelo Individual' : 'Alineación de Equipo' }}
        </h2>
        <p class="subtitle instructions">
          {{ tableroCompleto ? 'Tablero listo para combatir.' : 'Selecciona un personaje y colócalo en una casilla.' }}
        </p>
      </div>

      <!-- Tablero del Jugador -->
      <div class="board">
        <div
          v-for="boton in botones"
          :key="boton.numero"
          class="board-slot card"
          :class="{ filled: boton.jugador !== null, selectable: jugadorActivo && !boton.jugador }"
          @click="asignarJugador(boton)"
        >
          <template v-if="boton.jugador">
            <img :src="boton.jugador.img" :alt="boton.jugador.nombre" class="slot-img" />
            <div class="slot-info">
              <span class="slot-name">{{ boton.jugador.nombre }}</span>
              <span class="slot-power">Poder: {{ boton.jugador.poder }}</span>
            </div>
            <button class="btn-remove" type="button" @click.stop="removerJugador(boton)" title="Quitar">
              <AppIcon name="close" size="12" />
            </button>
          </template>
          <template v-else>
            <div class="slot-empty">
              <span class="slot-label">Casilla {{ boton.numero }}</span>
              <span class="slot-hint">{{ jugadorActivo ? 'Haz clic para asignar' : 'Vacía' }}</span>
            </div>
          </template>
        </div>
      </div>

      <!-- Personajes Disponibles para Elegir -->
      <div v-if="!tableroCompleto" class="selection-area">
        <h3 class="selection-title">Opciones Disponibles</h3>
        <div class="cards-grid">
          <div
            v-for="jugador in lista"
            :key="jugador.id"
            class="card player-card"
            :class="{ active: jugadorActivo?.id === jugador.id }"
            @click="seleccionarJugador(jugador)"
          >
            <img :src="jugador.img" :alt="jugador.nombre" class="player-thumb" />
            <div class="player-details">
              <h4 class="player-name">{{ jugador.nombre }}</h4>
              <p class="player-meta">{{ jugador.tipo || 'Combatiente' }}</p>
              <span class="player-power">Poder: {{ jugador.poder }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Accion Final -->
      <div v-else class="action-footer">
        <button class="btn-primary start-fight-btn" @click="enviarEquipo">
          <AppIcon name="swords" size="16" />
          Continuar a la Batalla
        </button>
      </div>
    </div>
  </section>
</template>

<style scoped>
.game-screen {
  justify-content: flex-start;
  padding-top: 48px;
}

.game-container {
  max-width: 860px;
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 24px;
}

.header {
  text-align: center;
}

.section-title {
  margin-bottom: 4px;
  font-size: 24px;
}

.instructions {
  margin-bottom: 0;
  font-size: 14px;
}

.board {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  gap: 16px;
  width: 100%;
}

.board-slot {
  position: relative;
  min-height: 140px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px;
  border-style: dashed;
  cursor: default;
}

.board-slot.selectable {
  border-color: var(--accent);
  background-color: #fff5f5;
  cursor: pointer;
}

.board-slot.filled {
  border-style: solid;
  border-color: var(--border-dark);
}

.slot-img {
  width: 64px;
  height: 64px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}

.slot-info {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
}

.slot-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-main);
  text-align: center;
}

.slot-power {
  font-size: 13px;
  color: var(--accent);
  font-weight: 600;
}

.btn-remove {
  position: absolute;
  top: 8px;
  right: 8px;
  background: transparent;
  border: 1px solid var(--border-color);
  color: var(--text-muted);
  width: 24px;
  height: 24px;
  border-radius: var(--radius);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 12px;
}

.btn-remove:hover {
  color: var(--accent);
  border-color: var(--accent);
}

.slot-empty {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 4px;
}

.slot-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--text-muted);
}

.slot-hint {
  font-size: 12px;
  color: #9ca3af;
}

.selection-area {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.selection-title {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-main);
}

.cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 12px;
}

.player-card {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  cursor: pointer;
  transition: border-color 0.15s ease, background-color 0.15s ease;
}

.player-card:hover {
  border-color: var(--border-dark);
  background-color: #f3f4f6;
}

.player-card.active {
  border-color: var(--accent);
  background-color: #fff5f5;
}

.player-thumb {
  width: 52px;
  height: 52px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}

.player-details {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.player-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-main);
}

.player-meta {
  font-size: 12px;
  color: var(--text-muted);
}

.player-power {
  font-size: 13px;
  font-weight: 600;
  color: var(--accent);
}

.action-footer {
  display: flex;
  justify-content: center;
  padding-top: 8px;
}

.start-fight-btn {
  min-width: 260px;
}
</style>
