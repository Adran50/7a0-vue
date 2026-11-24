<script setup>
import { ref, computed, onMounted } from "vue"
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["back", "ver-ranking"])

// Estados del torneo: 'seleccion' | 'bracket' | 'combate' | 'campeon' | 'eliminado'
const estado = ref("seleccion")
const campeonJugador = ref(null)
const opcionesCampeon = ref([])
const rondaActual = ref(0) // 0: Cuartos, 1: Semifinal, 2: Final
const rivalActual = ref(null)
const combateResultado = ref(null)
const guardando = ref(false)
const nombreUsuario = ref("")

// Llaves del torneo (8 participantes iniciales)
// Cada participante: { id, nombre, img, poder, esJugador }
const participantes = ref([])
const semifinalistas = ref([])
const finalistas = ref([])
const ganadorTorneo = ref(null)

const personajesBase = [
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

function mezclar(arr) {
  return [...arr].sort(() => 0.5 - Math.random())
}

function iniciarSeleccion() {
  const disponibles = mezclar(personajesBase)
  opcionesCampeon.value = disponibles.slice(0, 4)
  campeonJugador.value = null
  estado.value = "seleccion"
}

function elegirCampeon(pj) {
  campeonJugador.value = { ...pj, esJugador: true }
  armarCuadroTorneo()
}

function armarCuadroTorneo() {
  const rivales = mezclar(personajesBase.filter(p => p.id !== campeonJugador.value.id)).slice(0, 7)
  const lista = [
    campeonJugador.value,
    ...rivales.map(r => ({ ...r, esJugador: false }))
  ]

  participantes.value = lista
  semifinalistas.value = [null, null, null, null]
  finalistas.value = [null, null]
  ganadorTorneo.value = null
  rondaActual.value = 0
  estado.value = "bracket"
}

// Nombre de la ronda
const nombreRonda = computed(() => {
  if (rondaActual.value === 0) return "Cuartos de Final"
  if (rondaActual.value === 1) return "Semifinales"
  return "Gran Final"
})

// Preparar el combate del jugador para la ronda activa
function irACombate() {
  combateResultado.value = null
  if (rondaActual.value === 0) {
    rivalActual.value = participantes.value[1]
  } else if (rondaActual.value === 1) {
    rivalActual.value = semifinalistas.value[1]
  } else {
    rivalActual.value = finalistas.value[1]
  }
  estado.value = "combate"
}

const chanceVictoria = computed(() => {
  if (!campeonJugador.value || !rivalActual.value) return 50
  const total = campeonJugador.value.poder + rivalActual.value.poder
  return total > 0 ? Math.round((campeonJugador.value.poder / total) * 100) : 50
})

function simularDuelo(p1, p2) {
  const total = p1.poder + p2.poder
  const prob1 = total > 0 ? p1.poder / total : 0.5
  return Math.random() <= prob1 ? p1 : p2
}

async function resolverRonda() {
  let gano = false
  try {
    const res = await fetch("http://localhost/php/combate.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        poderJugador: campeonJugador.value.poder,
        poderRival: rivalActual.value.poder
      })
    })
    if (res.ok) {
      const data = await res.json()
      gano = data.resultado === "victoria"
    } else {
      gano = Math.random() <= (chanceVictoria.value / 100)
    }
  } catch (_) {
    gano = Math.random() <= (chanceVictoria.value / 100)
  }

  combateResultado.value = gano ? "victoria" : "derrota"

  if (gano) {
    if (rondaActual.value === 0) {
      // Avanzar a semis y simular las otras 3 llaves
      semifinalistas.value[0] = campeonJugador.value
      semifinalistas.value[1] = simularDuelo(participantes.value[2], participantes.value[3])
      semifinalistas.value[2] = simularDuelo(participantes.value[4], participantes.value[5])
      semifinalistas.value[3] = simularDuelo(participantes.value[6], participantes.value[7])
    } else if (rondaActual.value === 1) {
      // Avanzar a final y simular la otra semi
      finalistas.value[0] = campeonJugador.value
      finalistas.value[1] = simularDuelo(semifinalistas.value[2], semifinalistas.value[3])
    } else {
      // Campeon absoluto
      ganadorTorneo.value = campeonJugador.value
    }
  }
}

function continuarDespuesCombate() {
  if (combateResultado.value === "victoria") {
    if (rondaActual.value < 2) {
      rondaActual.value += 1
      estado.value = "bracket"
    } else {
      estado.value = "campeon"
    }
  } else {
    estado.value = "eliminado"
  }
}

// Guardar puntaje de torneo en ranking
async function guardarCampeon() {
  const nombre = nombreUsuario.value.trim()
  if (!nombre) {
    alert("Ingresa un nombre para registrar el título.")
    return
  }

  guardando.value = true
  const puntajeTotal = campeonJugador.value.poder * 3 // Bonus por coronarse campeon

  try {
    await fetch("http://localhost/php/guardarRanking.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        usuario: `${nombre} [Campeón Torneo]`,
        poder: puntajeTotal,
        equipo: [campeonJugador.value.id]
      })
    })
  } catch (_) {
    try {
      const local = JSON.parse(localStorage.getItem("versus_ranking") || "[]")
      local.push({
        id: Date.now(),
        usuario: `${nombre} [Campeón Torneo]`,
        poder: puntajeTotal,
        fecha: new Date().toISOString().slice(0, 10),
        equipo: [campeonJugador.value]
      })
      localStorage.setItem("versus_ranking", JSON.stringify(local))
    } catch (_) {}
  } finally {
    guardando.value = false
    emit("ver-ranking")
  }
}

onMounted(iniciarSeleccion)
</script>

<template>
  <section class="screen tournament-screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver
    </button>

    <!-- FASE 1: SELECCION DE CAMPEON -->
    <div v-if="estado === 'seleccion'" class="tournament-box">
      <h2 class="title section-title">Modo Torneo: Elige tu Campeón</h2>
      <p class="subtitle">Selecciona al combatiente que representará tu bandera en el cuadro eliminatorio</p>

      <div class="cards-grid">
        <div
          v-for="p in opcionesCampeon"
          :key="p.id"
          class="card champion-card"
          @click="elegirCampeon(p)"
        >
          <img :src="p.img" :alt="p.nombre" class="champion-thumb" />
          <div class="champion-info">
            <h4 class="champion-name">{{ p.nombre }}</h4>
            <span class="champion-type">{{ p.tipo }}</span>
            <span class="champion-power">Poder: {{ p.poder }}</span>
          </div>
          <button class="btn-primary choose-btn" type="button">
            Elegir
            <AppIcon name="check" size="14" />
          </button>
        </div>
      </div>
    </div>

    <!-- FASE 2: CUADRO DE LLAVES (BRACKET) -->
    <div v-else-if="estado === 'bracket'" class="tournament-box">
      <div class="header">
        <h2 class="title section-title">Cuadro del Torneo</h2>
        <p class="subtitle">
          Ronda actual: <strong>{{ nombreRonda }}</strong>
        </p>
      </div>

      <div class="bracket-tree">
        <!-- Columna Cuartos -->
        <div class="round-column">
          <h4 class="round-title">Cuartos</h4>
          <div class="match-box card" :class="{ current: rondaActual === 0 }">
            <div class="competitor" :class="{ me: participantes[0]?.esJugador }">
              <span class="c-name">{{ participantes[0]?.nombre }}</span>
              <span class="c-p">{{ participantes[0]?.poder }}</span>
            </div>
            <div class="vs-divider">vs</div>
            <div class="competitor">
              <span class="c-name">{{ participantes[1]?.nombre }}</span>
              <span class="c-p">{{ participantes[1]?.poder }}</span>
            </div>
          </div>

          <div class="match-box card">
            <div class="competitor">
              <span class="c-name">{{ participantes[2]?.nombre }}</span>
              <span class="c-p">{{ participantes[2]?.poder }}</span>
            </div>
            <div class="vs-divider">vs</div>
            <div class="competitor">
              <span class="c-name">{{ participantes[3]?.nombre }}</span>
              <span class="c-p">{{ participantes[3]?.poder }}</span>
            </div>
          </div>
        </div>

        <!-- Columna Semis -->
        <div class="round-column">
          <h4 class="round-title">Semifinal</h4>
          <div class="match-box card" :class="{ current: rondaActual === 1 }">
            <div class="competitor" :class="{ me: semifinalistas[0]?.esJugador }">
              <span class="c-name">{{ semifinalistas[0] ? semifinalistas[0].nombre : 'Ganador Llave 1' }}</span>
              <span class="c-p" v-if="semifinalistas[0]">{{ semifinalistas[0].poder }}</span>
            </div>
            <div class="vs-divider">vs</div>
            <div class="competitor">
              <span class="c-name">{{ semifinalistas[1] ? semifinalistas[1].nombre : 'Ganador Llave 2' }}</span>
              <span class="c-p" v-if="semifinalistas[1]">{{ semifinalistas[1].poder }}</span>
            </div>
          </div>
        </div>

        <!-- Columna Final -->
        <div class="round-column">
          <h4 class="round-title">Final</h4>
          <div class="match-box card" :class="{ current: rondaActual === 2 }">
            <div class="competitor" :class="{ me: finalistas[0]?.esJugador }">
              <span class="c-name">{{ finalistas[0] ? finalistas[0].nombre : 'Finalista 1' }}</span>
              <span class="c-p" v-if="finalistas[0]">{{ finalistas[0].poder }}</span>
            </div>
            <div class="vs-divider">vs</div>
            <div class="competitor">
              <span class="c-name">{{ finalistas[1] ? finalistas[1].nombre : 'Finalista 2' }}</span>
              <span class="c-p" v-if="finalistas[1]">{{ finalistas[1].poder }}</span>
            </div>
          </div>
        </div>
      </div>

      <div class="bracket-action">
        <button class="btn-primary" @click="irACombate">
          <AppIcon name="swords" size="16" />
          Disputar {{ nombreRonda }}
        </button>
      </div>
    </div>

    <!-- FASE 3: ENFRENTAMIENTO DE LA RONDA -->
    <div v-else-if="estado === 'combate'" class="tournament-box">
      <h2 class="title section-title">{{ nombreRonda }}</h2>
      <p class="subtitle">
        Tu probabilidad calculada de clasificar: <strong>{{ chanceVictoria }}%</strong>
      </p>

      <div class="duel-arena">
        <!-- Tu campeon -->
        <div class="card fighter-card me">
          <img :src="campeonJugador.img" :alt="campeonJugador.nombre" class="fighter-img" />
          <h3 class="fighter-name">{{ campeonJugador.nombre }}</h3>
          <span class="fighter-power">Poder: {{ campeonJugador.poder }}</span>
        </div>

        <div class="card center-combat">
          <template v-if="!combateResultado">
            <AppIcon name="swords" size="32" class="combat-icon" />
            <button class="btn-primary" @click="resolverRonda">
              Luchar Ronda
            </button>
          </template>

          <template v-else>
            <div class="result-badge" :class="combateResultado">
              {{ combateResultado === 'victoria' ? '¡Victoria! Has avanzado' : 'Has sido eliminado' }}
            </div>
            <button class="btn-primary" @click="continuarDespuesCombate">
              {{ combateResultado === 'victoria' ? 'Continuar en el Torneo' : 'Ver Resultados' }}
              <AppIcon name="play" size="14" />
            </button>
          </template>
        </div>

        <!-- Rival -->
        <div class="card fighter-card">
          <img :src="rivalActual.img" :alt="rivalActual.nombre" class="fighter-img" />
          <h3 class="fighter-name">{{ rivalActual.nombre }}</h3>
          <span class="fighter-power">Poder: {{ rivalActual.poder }}</span>
        </div>
      </div>
    </div>

    <!-- FASE 4: CAMPEON DEL TORNEO -->
    <div v-else-if="estado === 'campeon'" class="card end-card">
      <div class="crown-icon">
        <AppIcon name="crown" size="40" />
      </div>
      <h2 class="title">¡Campeón del Torneo!</h2>
      <p class="subtitle">
        Tu luchador <strong>{{ campeonJugador.nombre }}</strong> se consagró invicto en todas las fases eliminatorias.
      </p>

      <div class="save-box">
        <label for="cName" class="input-label">Registrar título en la Tabla de Posiciones:</label>
        <input
          id="cName"
          v-model="nombreUsuario"
          type="text"
          maxlength="50"
          placeholder="Nombre del Campeón"
          class="name-input"
        />
        <button class="btn-primary" :disabled="guardando" @click="guardarCampeon">
          <AppIcon name="trophy" size="16" />
          {{ guardando ? 'Guardando...' : 'Guardar y Ver Ranking' }}
        </button>
        <button class="btn-secondary" @click="emit('back')">
          Volver al Menú
        </button>
      </div>
    </div>

    <!-- FASE 5: ELIMINADO -->
    <div v-else-if="estado === 'eliminado'" class="card end-card">
      <h2 class="title">Eliminado en {{ nombreRonda }}</h2>
      <p class="subtitle">Tu combatiente fue derrotado en esta fase por el contrincante.</p>
      <div class="actions-row">
        <button class="btn-primary" @click="iniciarSeleccion">
          <AppIcon name="refresh" size="14" />
          Reintentar Torneo
        </button>
        <button class="btn-secondary" @click="emit('back')">
          Volver a Modos
        </button>
      </div>
    </div>
  </section>
</template>

<style scoped>
.tournament-screen {
  justify-content: flex-start;
  padding-top: 48px;
}

.tournament-box {
  max-width: 860px;
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.section-title {
  margin-bottom: 4px;
}

.cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(190px, 1fr));
  gap: 16px;
}

.champion-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  padding: 16px;
  cursor: pointer;
  text-align: center;
}

.champion-card:hover {
  border-color: var(--accent);
  transform: translateY(-2px);
}

.champion-thumb {
  width: 64px;
  height: 64px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}

.champion-info {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.champion-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-main);
}

.champion-type {
  font-size: 12px;
  color: var(--text-muted);
}

.champion-power {
  font-size: 13px;
  font-weight: 600;
  color: var(--accent);
}

.choose-btn {
  min-width: unset;
  width: 100%;
  padding: 8px 12px;
  font-size: 13px;
  margin-top: 4px;
}

/* Bracket Tree */
.bracket-tree {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  align-items: center;
}

.round-column {
  display: flex;
  flex-direction: column;
  gap: 12px;
}

.round-title {
  font-size: 14px;
  font-weight: 600;
  color: var(--text-muted);
  text-align: center;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.match-box {
  padding: 12px;
  display: flex;
  flex-direction: column;
  gap: 6px;
  border-left: 3px solid var(--border-color);
}

.match-box.current {
  border-left-color: var(--accent);
  background-color: #fffbfb;
}

.competitor {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
  color: var(--text-main);
}

.competitor.me {
  font-weight: 600;
  color: var(--accent);
}

.vs-divider {
  font-size: 11px;
  color: var(--text-muted);
  text-align: center;
  text-transform: uppercase;
}

.c-p {
  font-size: 12px;
  color: var(--text-muted);
}

.bracket-action {
  display: flex;
  justify-content: center;
  margin-top: 8px;
}

/* Arena Duelo */
.duel-arena {
  display: grid;
  grid-template-columns: 1fr 1.2fr 1fr;
  gap: 16px;
  align-items: center;
}

.fighter-card {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 8px;
  padding: 20px;
  text-align: center;
}

.fighter-card.me {
  border-color: #fca5a5;
}

.fighter-img {
  width: 72px;
  height: 72px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}

.fighter-name {
  font-size: 15px;
  font-weight: 600;
}

.fighter-power {
  font-size: 13px;
  font-weight: 600;
  color: var(--accent);
}

.center-combat {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  padding: 24px;
}

.combat-icon {
  color: var(--accent);
}

.result-badge {
  padding: 8px 16px;
  border-radius: var(--radius);
  font-weight: 600;
  font-size: 14px;
}

.result-badge.victoria {
  background-color: #fef2f2;
  color: var(--accent);
  border: 1px solid #fecaca;
}

.result-badge.derrota {
  background-color: #f3f4f6;
  color: var(--text-muted);
  border: 1px solid var(--border-dark);
}

/* Pantalla Final */
.end-card {
  max-width: 480px;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 16px;
}

.crown-icon {
  color: #eab308;
}

.save-box {
  display: flex;
  flex-direction: column;
  gap: 10px;
  width: 100%;
}

.input-label {
  font-size: 13px;
  color: var(--text-muted);
  text-align: left;
}

.name-input {
  width: 100%;
  padding: 10px 12px;
  font-size: 14px;
  border: 1px solid var(--border-dark);
  border-radius: var(--radius);
  outline: none;
}

.name-input:focus {
  border-color: var(--accent);
}

.save-box button {
  width: 100%;
}

.actions-row {
  display: flex;
  flex-direction: column;
  gap: 10px;
  width: 100%;
}

.actions-row button {
  width: 100%;
}

@media (max-width: 768px) {
  .bracket-tree,
  .duel-arena {
    grid-template-columns: 1fr;
  }
}
</style>
