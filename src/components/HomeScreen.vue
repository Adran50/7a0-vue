<script setup>
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["play", "ranking"])
</script>

<template>
  <section class="screen">
    <div class="home-box">
      <h1 class="title">VERSUS</h1>
      <p class="subtitle">Juego de combates por turnos y probabilidades</p>

      <div class="actions">
        <button class="btn-primary" @click="emit('play')">
          <AppIcon name="play" size="16" />
          Jugar
        </button>
        <button class="btn-secondary" @click="emit('ranking')">
          <AppIcon name="trophy" size="16" />
          Ver Ranking
        </button>
      </div>
    </div>
  </section>
</template>

<style scoped>
.home-box {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  max-width: 360px;
  width: 100%;
}

.title {
  font-size: 38px;
  margin-bottom: 2px;
}

.subtitle {
  margin-bottom: 16px;
}

.actions {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

.actions button {
  width: 100%;
}
</style>
