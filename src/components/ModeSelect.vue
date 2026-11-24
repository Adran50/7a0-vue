<script setup>
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["select", "back"])
</script>

<template>
  <section class="screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver
    </button>

    <div class="mode-box">
      <h1 class="title">Modo de Juego</h1>
      <p class="subtitle">Elige el tipo de enfrentamiento</p>

      <div class="mode-options">
        <!-- Duelo 1 vs 1 -->
        <div class="card mode-card" @click="emit('select', 'duel')">
          <div class="mode-icon-box">
            <AppIcon name="user" size="24" />
          </div>
          <div class="mode-info">
            <h3 class="mode-name">Duelo (1 vs 1)</h3>
            <p class="mode-desc">Combate individual rápido entre un personaje y un rival sorteado.</p>
          </div>
          <button class="btn-secondary mode-action" type="button">
            Elegir
            <AppIcon name="play" size="12" />
          </button>
        </div>

        <!-- Equipos 3 vs 3 -->
        <div class="card mode-card" @click="emit('select', 'teams')">
          <div class="mode-icon-box">
            <AppIcon name="users" size="24" />
          </div>
          <div class="mode-info">
            <h3 class="mode-name">Equipos (3 vs 3)</h3>
            <p class="mode-desc">Arma una alineación de tres combatientes sumando puntuaciones contra el rival.</p>
          </div>
          <button class="btn-secondary mode-action" type="button">
            Elegir
            <AppIcon name="play" size="12" />
          </button>
        </div>

        <!-- Modo Torneo -->
        <div class="card mode-card featured" @click="emit('select', 'tournament')">
          <div class="mode-icon-box accent">
            <AppIcon name="tournament" size="24" />
          </div>
          <div class="mode-info">
            <h3 class="mode-name">Torneo Eliminatorio</h3>
            <p class="mode-desc">Supera 3 rondas eliminatorias (Cuartos, Semifinal y Final) para alcanzar la corona.</p>
          </div>
          <button class="btn-primary mode-action" type="button">
            Elegir
            <AppIcon name="play" size="12" />
          </button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.mode-box {
  max-width: 580px;
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.mode-options {
  display: flex;
  flex-direction: column;
  gap: 14px;
  width: 100%;
}

.mode-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 16px 20px;
  cursor: pointer;
  transition: all 0.18s ease;
}

.mode-card:hover {
  border-color: var(--border-dark);
  transform: translateY(-2px);
}

.mode-card.featured {
  border-color: #fca5a5;
  background-color: #ffffff;
}

.mode-card.featured:hover {
  border-color: var(--accent);
}

.mode-icon-box {
  color: var(--text-muted);
  display: flex;
  align-items: center;
  justify-content: center;
  width: 44px;
  height: 44px;
  border-radius: var(--radius);
  background-color: #f3f4f6;
  flex-shrink: 0;
}

.mode-icon-box.accent {
  background-color: #fee2e2;
  color: var(--accent);
}

.mode-info {
  display: flex;
  flex-direction: column;
  gap: 3px;
  flex: 1;
}

.mode-name {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-main);
}

.mode-desc {
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.35;
}

.mode-action {
  min-width: 95px;
  padding: 8px 14px;
  font-size: 13px;
  gap: 6px;
}
</style>
