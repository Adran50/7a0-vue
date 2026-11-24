<script setup>
import { ref, computed } from "vue"
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["ver-ranking"])

const props = defineProps({
  equipo: {
    type: Array,
    required: true
  },
  rival: {
    type: Array,
    required: true
  }
})

const batallaIniciada = ref(false)
const resultado = ref(null) // 'victoria' | 'derrota' | 'empate'
const guardando = ref(false)
const usuario = ref("")

const poderJugador = computed(() => {
  return props.equipo.reduce((acc, p) => acc + Number(p.poder || 0), 0)
})

const poderRival = computed(() => {
  return props.rival.reduce((acc, p) => acc + Number(p.poder || 0), 0)
})

// Calculo de probabilidad ponderada
const chanceVictoria = computed(() => {
  const total = poderJugador.value + poderRival.value
  if (total === 0) return 50
  return Math.round((poderJugador.value / total) * 100)
})

async function resolverBatalla() {
  try {
    const res = await fetch("http://localhost/php/combate.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        poderJugador: poderJugador.value,
        poderRival: poderRival.value
      })
    })
    if (res.ok) {
      const data = await res.json()
      if (data && data.resultado) {
        resultado.value = data.resultado
        batallaIniciada.value = true
        return
      }
    }
  } catch (_) {}

  // Resolucion local de probabilidad de respaldo
  const prob = chanceVictoria.value / 100
  const tirada = Math.random()

  if (poderJugador.value === poderRival.value && tirada > 0.48 && tirada < 0.52) {
    resultado.value = "empate"
  } else if (tirada <= prob) {
    resultado.value = "victoria"
  } else {
    resultado.value = "derrota"
  }
  batallaIniciada.value = true
}

const publicarRanking = async () => {
  const nombre = usuario.value.trim()
  if (!nombre) {
    alert("Ingresa un nombre para guardar tu puntaje.")
    return
  }

  guardando.value = true

  try {
    const res = await fetch("http://localhost/php/guardarRanking.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        usuario: nombre,
        poder: poderJugador.value,
        equipo: props.equipo.map(p => p.id)
      })
    })

    if (!res.ok) {
      throw new Error("Error en servidor")
    }

    emit("ver-ranking")
  } catch (err) {
    // Si no hay conexion con backend PHP, guardar localmente para no bloquear
    try {
      const actual = JSON.parse(localStorage.getItem("versus_ranking") || "[]")
      actual.push({
        id: Date.now(),
        usuario: nombre,
        poder: poderJugador.value,
        fecha: new Date().toISOString().slice(0, 10),
        equipo: props.equipo
      })
      localStorage.setItem("versus_ranking", JSON.stringify(actual))
    } catch (_) {}

    emit("ver-ranking")
  } finally {
    guardando.value = false
  }
}
</script>

<template>
  <section class="screen battle-screen">
    <div class="battle-container">
      <div class="header">
        <h2 class="title section-title">Campo de Batalla</h2>
        <p class="subtitle">
          Probabilidad de victoria estimada: <strong>{{ chanceVictoria }}%</strong>
        </p>
      </div>

      <!-- Comparativa de Equipos -->
      <div class="teams-grid">
        <!-- Equipo Propio -->
        <div class="team-column card">
          <div class="team-header">
            <h3 class="team-title">Tu Equipo</h3>
            <span class="team-total">Poder Total: {{ poderJugador }}</span>
          </div>
          <div class="members-list">
            <div v-for="p in equipo" :key="p.id" class="member-item">
              <img :src="p.img" :alt="p.nombre" class="member-thumb" />
              <div class="member-info">
                <span class="member-name">{{ p.nombre }}</span>
                <span class="member-power">Poder: {{ p.poder }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Zona Central de Resultado o Accion -->
        <div class="center-action card">
          <template v-if="!batallaIniciada">
            <button class="btn-primary start-btn" @click="resolverBatalla">
              <AppIcon name="swords" size="16" />
              Iniciar Combate
            </button>
          </template>

          <template v-else>
            <div class="result-badge" :class="resultado">
              <span class="result-text">
                {{ resultado === 'victoria' ? 'Victoria' : resultado === 'derrota' ? 'Derrota' : 'Empate' }}
              </span>
            </div>

            <div class="save-form">
              <label for="userName" class="input-label">Guardar Registro en Ranking</label>
              <input
                id="userName"
                v-model="usuario"
                type="text"
                maxlength="50"
                placeholder="Tu nombre"
                class="name-input"
              />
              <button
                class="btn-primary"
                :disabled="guardando"
                @click="publicarRanking"
              >
                <AppIcon name="trophy" size="16" />
                {{ guardando ? 'Guardando...' : 'Guardar y Ver Ranking' }}
              </button>
              <button class="btn-secondary" @click="emit('ver-ranking')">
                <AppIcon name="play" size="14" />
                Omitir y Ver Ranking
              </button>
            </div>
          </template>
        </div>

        <!-- Equipo Rival -->
        <div class="team-column card">
          <div class="team-header">
            <h3 class="team-title">Equipo Rival</h3>
            <span class="team-total">Poder Total: {{ poderRival }}</span>
          </div>
          <div class="members-list">
            <div v-for="r in rival" :key="r.id" class="member-item">
              <img :src="r.img" :alt="r.nombre" class="member-thumb" />
              <div class="member-info">
                <span class="member-name">{{ r.nombre }}</span>
                <span class="member-power">Poder: {{ r.poder }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.battle-screen {
  justify-content: flex-start;
  padding-top: 40px;
}

.battle-container {
  max-width: 980px;
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.section-title {
  margin-bottom: 4px;
}

.teams-grid {
  display: grid;
  grid-template-columns: 1fr 1.2fr 1fr;
  gap: 16px;
  align-items: start;
}

.team-column {
  display: flex;
  flex-direction: column;
  gap: 12px;
  padding: 16px;
}

.team-header {
  display: flex;
  flex-direction: column;
  gap: 2px;
  border-bottom: 1px solid var(--border-color);
  padding-bottom: 8px;
}

.team-title {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-main);
}

.team-total {
  font-size: 13px;
  color: var(--accent);
  font-weight: 600;
}

.members-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.member-item {
  display: flex;
  align-items: center;
  gap: 10px;
}

.member-thumb {
  width: 44px;
  height: 44px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}

.member-info {
  display: flex;
  flex-direction: column;
}

.member-name {
  font-size: 13px;
  font-weight: 500;
  color: var(--text-main);
}

.member-power {
  font-size: 12px;
  color: var(--text-muted);
}

.center-action {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 16px;
  padding: 24px;
  text-align: center;
  min-height: 240px;
}

.start-btn {
  width: 100%;
}

.result-badge {
  padding: 8px 16px;
  border-radius: var(--radius);
  font-size: 18px;
  font-weight: 700;
  letter-spacing: 0.5px;
  width: 100%;
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

.result-badge.empate {
  background-color: #f3f4f6;
  color: var(--text-main);
  border: 1px solid var(--border-color);
}

.save-form {
  display: flex;
  flex-direction: column;
  gap: 8px;
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

.save-form button {
  width: 100%;
}

@media (max-width: 800px) {
  .teams-grid {
    grid-template-columns: 1fr;
  }
}
</style>
