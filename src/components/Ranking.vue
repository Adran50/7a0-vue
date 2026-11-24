<script setup>
import { ref, onMounted } from "vue"
import AppIcon from "./AppIcon.vue"

const emit = defineEmits(["back"])

const ranking = ref([])
const cargando = ref(true)

const verRanking = async () => {
  cargando.value = true
  try {
    const res = await fetch("http://localhost/php/ranking.php")
    if (res.ok) {
      const data = await res.json()
      if (Array.isArray(data)) {
        ranking.value = data
        cargando.value = false
        return
      }
    }
  } catch (_) {
    // Si falla el servidor PHP, cargar desde localStorage
  }

  try {
    const local = JSON.parse(localStorage.getItem("versus_ranking") || "[]")
    ranking.value = local.sort((a, b) => b.poder - a.poder)
  } catch (_) {
    ranking.value = []
  } finally {
    cargando.value = false
  }
}

onMounted(verRanking)
</script>

<template>
  <section class="screen ranking-screen">
    <button class="btn-back" @click="emit('back')">
      <AppIcon name="back" size="14" />
      Volver al Inicio
    </button>

    <div class="ranking-container">
      <div class="header">
        <div class="header-icon">
          <AppIcon name="trophy" size="30" />
        </div>
        <h2 class="title section-title">Tabla de Posiciones</h2>
        <p class="subtitle">Mejores puntuaciones registradas en combates y torneos</p>
      </div>

      <div v-if="cargando" class="card empty-card">
        <p class="empty-text">Cargando registros...</p>
      </div>

      <div v-else-if="ranking.length === 0" class="card empty-card">
        <p class="empty-text">Aún no hay puntuaciones guardadas.</p>
      </div>

      <div v-else class="ranking-list">
        <div
          v-for="(item, index) in ranking"
          :key="item.id || index"
          class="card ranking-item"
        >
          <div class="rank-pos">
            #{{ index + 1 }}
          </div>

          <div class="rank-user">
            <h4 class="user-name">{{ item.usuario }}</h4>
            <span class="user-power">Poder: {{ item.poder }}</span>
          </div>

          <div v-if="item.equipo && item.equipo.length > 0" class="rank-team">
            <div
              v-for="p in item.equipo"
              :key="p.id"
              class="team-thumb-box"
              :title="p.nombre"
            >
              <img :src="p.img" :alt="p.nombre" class="team-thumb" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.ranking-screen {
  justify-content: flex-start;
  padding-top: 48px;
}

.ranking-container {
  max-width: 680px;
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.header {
  text-align: center;
}

.header-icon {
  color: #eab308;
  margin-bottom: 4px;
}

.section-title {
  margin-bottom: 4px;
}

.empty-card {
  text-align: center;
  padding: 32px;
}

.empty-text {
  font-size: 14px;
  color: var(--text-muted);
}

.ranking-list {
  display: flex;
  flex-direction: column;
  gap: 8px;
}

.ranking-item {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  padding: 12px 16px;
  transition: transform 0.15s ease;
}

.ranking-item:hover {
  transform: translateY(-1px);
}

.rank-pos {
  font-size: 16px;
  font-weight: 700;
  color: var(--text-muted);
  min-width: 32px;
}

.rank-user {
  display: flex;
  flex-direction: column;
  flex: 1;
}

.user-name {
  font-size: 15px;
  font-weight: 600;
  color: var(--text-main);
}

.user-power {
  font-size: 13px;
  font-weight: 600;
  color: var(--accent);
}

.rank-team {
  display: flex;
  gap: 6px;
}

.team-thumb {
  width: 36px;
  height: 36px;
  border-radius: var(--radius);
  object-fit: cover;
  background-color: #e5e7eb;
}
</style>
