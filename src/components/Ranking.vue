<script setup>
import { ref, onMounted } from "vue"

const emit = defineEmits(["back"])

const ranking = ref([])

const verRanking = async () => {
    try {
        const respuesta = await fetch("http://localhost/php/ranking.php")

        if (!respuesta.ok) {
            throw new Error("Error al consultar el ranking")
        }

        ranking.value = await respuesta.json()
    } catch (error) {
        console.error(error)
        alert("No se pudo cargar el ranking.")
    }
}

onMounted(verRanking)
</script>

<template>
    <section class="ranking">
        <div
            class="back"
            @click="emit('back')"
        >
            ←
        </div>
        <h2>Ranking de batallas</h2>

        <p v-if="ranking.length === 0">Todavía no hay resultados publicados</p>

        <div class="lista">
            <div
            v-for="(b, index) in ranking"
            :key="b.id"
            class="fila"
            :class="{
                oro: index === 0,
                plata: index === 1,
                bronce: index === 2
            }">
                <span class="posicion">#{{ index + 1 }}</span>

                <div class="datos-usuario">
                    <h3>{{ b.usuario }}</h3>
                    <span class="poder">{{ b.poder }}</span>
                </div>

                <div class="equipo">
                    <div
                    v-for="personaje in b.equipo"
                    :key="personaje.id"
                    class="miembro">
                        <div class="imagen-jugador">
                            <img :src="personaje.img" :alt="personaje.nombre">
                        </div>
                        <span class="nombre">{{ personaje.nombre }}</span>
                    </div>
                </div>
            </div>
        </div>

    </section>
</template>

<style scoped>
.ranking{
    min-height: 100vh;
    background-image:
      linear-gradient(rgba(0, 0, 0, 0.76)),
      url(/imagenes/img2.png);
    background-position: bottom;
    background-repeat: no-repeat;
    background-size: cover;
    display: flex;
    flex-direction: column;
    gap: 20px;
    padding: 20px 50px;

    h2{
        user-select: none;
        text-align: center;
        color: #9e7d4b;
        text-transform: uppercase;
        font-size: 35px;
    }

    p{
        color: #9e7d4b;
        text-align: center;
        font-size: 20px;
    }

    .lista{
        width: 100%;
        max-width: 1000px;
        margin: 0 auto;
        display: flex;
        flex-direction: column;
        gap: 15px;

        .fila{
            display: grid;
            grid-template-columns: 80px 1fr auto;
            align-items: center;
            gap: 25px;
            padding: 20px;
            border: 2px solid #724d21;
            border-radius: 15px;
            background-color: rgba(82, 53, 25, 0.35);
            box-sizing: border-box;

            .posicion{
                font-size: 32px;
                font-weight: 900;
                color: #9e7d4b;
                text-align: center;
            }

            .datos-usuario{
                display: flex;
                flex-direction: column;
                gap: 5px;

                h3{
                    font-size: 30px;
                    color: #d1bb94;
                    word-break: break-word;
                }

                .poder{
                    font-size: 27px;
                    color: purple;
                    font-weight: 700;
                }
            }

            .equipo{
                display: flex;
                gap: 20px;

                .miembro{
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                    gap: 6px;
                    width: 90px;

                    .imagen-jugador{
                        width: 80px;
                        height: 80px;
                        background-color: black;
                        border: 2px solid #724d21;
                        border-radius: 50%;
                        overflow: hidden;

                        img{
                            height: 100%;
                            width: 100%;
                            object-fit: cover;
                        }
                    }

                    .nombre{
                        color: #b79e65;
                        font-size: 14px;
                        text-align: center;
                    }
                }
            }

            &.oro{
                border-color: #d4af37;
                .posicion{ color: #d4af37; }
            }

            &.plata{
                border-color: #c0c0c0;
                .posicion{ color: #c0c0c0; }
            }

            &.bronce{
                border-color: #cd7f32;
                .posicion{ color: #cd7f32; }
            }
        }
    }
}

@media (max-width: 1100px){
    .ranking{
        padding: 20px;

        .lista .fila{
            grid-template-columns: 60px 1fr;

            .equipo{
                grid-column: 1 / -1;
                justify-content: center;
            }
        }
    }
}

@media (max-width: 700px){
    .ranking{
        .lista .fila{
            gap: 15px;

            .datos-usuario h3{
                font-size: 24px;
            }

            .equipo{
                gap: 10px;

                .miembro{
                    width: 70px;

                    .imagen-jugador{
                        width: 60px;
                        height: 60px;
                    }

                    .nombre{
                        font-size: 12px;
                    }
                }
            }
        }
    }
}
</style>