<script setup>
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["continue", "back"])
</script>

<template>
  <section class="screen tutorial-screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver
    </button>

    <h1 class="title">Guía de Juego</h1>
    <p class="subtitle">Conoce los modos disponibles y el sistema de probabilidades</p>

    <div class="cards-grid">
      <div class="card tutorial-card">
        <div class="card-icon">
          <AppIcon name="user" size="20" />
        </div>
        <h3 class="card-heading">Duelo (1 vs 1)</h3>
        <p class="card-text">
          Combate directo y rápido. Eliges 1 personaje y te enfrentas a un contrincante al azar.
        </p>
      </div>

      <div class="card tutorial-card">
        <div class="card-icon">
          <AppIcon name="users" size="20" />
        </div>
        <h3 class="card-heading">Equipos (3 vs 3)</h3>
        <p class="card-text">
          Estrategia por turnos. Asignas 3 personajes en el tablero sumando sus poderes contra el equipo rival.
        </p>
      </div>

      <div class="card tutorial-card">
        <div class="card-icon">
          <AppIcon name="tournament" size="20" />
        </div>
        <h3 class="card-heading">Torneo Eliminatorio</h3>
        <p class="card-text">
          Cuadro de 8 participantes. Eliges a tu campeón y debes ganar Cuartos, Semifinal y la Gran Final para coronarte.
        </p>
      </div>

      <div class="card tutorial-card">
        <div class="card-icon">
          <AppIcon name="dice" size="20" />
        </div>
        <h3 class="card-heading">Sistema de Probabilidad</h3>
        <p class="card-text">
          Cada personaje tiene un nivel de poder. A mayor poder total frente a tu rival, mayor es tu porcentaje de victoria.
        </p>
      </div>
    </div>

    <button class="btn-primary continue-btn" @click="emit('continue')">
      Continuar
      <AppIcon name="play" size="14" />
    </button>
  </section>
</template>

<style scoped>
.tutorial-screen {
  justify-content: flex-start;
  padding-top: 48px;
}

.cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 16px;
  max-width: 900px;
  width: 100%;
  margin-bottom: 24px;
}

.tutorial-card {
  display: flex;
  flex-direction: column;
  gap: 8px;
  text-align: left;
}

.card-icon {
  color: var(--accent);
}

.card-heading {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-main);
}

.card-text {
  font-size: 14px;
  color: var(--text-muted);
  line-height: 1.45;
}

.continue-btn {
  margin-top: 8px;
}
</style>
