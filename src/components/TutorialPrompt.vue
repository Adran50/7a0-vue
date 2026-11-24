<script setup>
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["yes", "no", "back"])
</script>

<template>
  <section class="screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver
    </button>

    <div class="card prompt-card">
      <div class="icon-header">
        <AppIcon name="help" size="32" />
      </div>
      <h2 class="title prompt-title">¿Deseas ver el tutorial antes de jugar?</h2>
      <p class="subtitle">Aprende el funcionamiento de los modos Duelo, Equipos y el nuevo Modo Torneo.</p>

      <div class="actions">
        <button class="btn-primary" @click="emit('yes')">
          <AppIcon name="help" size="16" />
          Ver Tutorial
        </button>
        <button class="btn-secondary" @click="emit('no')">
          <AppIcon name="play" size="14" />
          Omitir e Ir al Juego
        </button>
      </div>
    </div>
  </section>
</template>

<style scoped>
.prompt-card {
  max-width: 440px;
  width: 100%;
  text-align: center;
  display: flex;
  flex-direction: column;
  gap: 16px;
  align-items: center;
}

.icon-header {
  color: var(--accent);
  margin-top: 4px;
}

.prompt-title {
  font-size: 20px;
  margin-bottom: 4px;
}

.actions {
  display: flex;
  flex-direction: column;
  gap: 10px;
  width: 100%;
  margin-top: 8px;
}

.actions button {
  width: 100%;
}
</style>
