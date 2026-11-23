<script setup>

import { ref, computed} from "vue"

const iniciar = ref(false)

const iniciarBatalla = () => {
    iniciar.value = !iniciar.value
}

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

console.log("Equipo Seleccionado", props.equipo)
console.log("Equipo Rival", props.rival)


const poderJugador = computed(() => {
    return props.equipo.reduce((total, j) => {
        return total + Number(j.poder);
    }, 0);
});


const poderRival = computed(() => {
    return props.rival.reduce((total, j) => {
        return total + Number(j.poder)
    }, 0)
})


const usuario = ref("")

const publicarRanking = async () => {
    const nombre = usuario.value.trim()

    if (!nombre) {
        alert("Escribí tu nombre para publicar el ranking.")
        return
    }

    try {
        const respuesta = await fetch(
            "http://localhost/php/guardarRanking.php",
            {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    usuario: nombre,
                    poder: poderJugador.value,
                    equipo: props.equipo.map(p => p.id)
                })
            }
        )

        const datos = await respuesta.json()

        if (!respuesta.ok) {
            throw new Error(datos.error || "Error al guardar")
        }

        emit("ver-ranking")

    } catch (error) {
        console.error(error)
        alert("No se pudo publicar el resultado.")
    }
}

console.log("Poder del jugador: ", poderJugador.value)
console.log("Poder del equipo rival: ", poderRival.value)


</script>

<template>
    <section class="batalla">
        <div v-if="iniciar" class="mensaje-pantalla">
            <span v-if="poderJugador > poderRival" class="ganaste">
                GANASTE
            </span>
            <span v-if="poderJugador < poderRival" class="perdiste">
                PERDISTE BOLOH
            </span>
            <span v-if="poderJugador == poderRival" class="empate">
                EMPATE C GAME F1 Y AL LOBBY
            </span>
        </div>

        <div class="equipo-propio">
            <div
            v-for="jugador in equipo" :key="jugador.id"
            class="personaje">
                <div class="image-wrapper">
                    <img :src="jugador.img">
                </div>
                <div class="personaje-txt">
                    <span class="nombre">{{ jugador.nombre }}</span>
                    <span class="media">{{ jugador.poder }}</span>
                </div>
            </div>
        </div>

        <div class="resultado">
            <div class="tablero">
                <template v-if="!iniciar">
                    <button
                    @click="iniciarBatalla"
                    >Simular Batalla</button>
                </template>
                
                <template v-else>
                    <input
                    v-model="usuario"
                    type="text"
                    maxlength="100"
                    placeholder="Tu nombre"
                    >
                    <button
                    @click="publicarRanking"
                    >Publicar Ranking y ver el ranking de los demas</button>
                </template>
            </div>
        </div>

        <div class="equipo-propio">
            <div
            v-for="jugador in rival" :key="jugador.id"
            class="personaje">
                <div class="image-wrapper">
                    <img :src="jugador.img">
                </div>
                <div class="personaje-txt">
                    <span class="nombre">{{ jugador.nombre }}</span>
                    <span class="media">{{ jugador.poder }}</span>
                </div>
            </div>
        </div>
    </section>

</template>

<style scoped>
    .batalla{
        display: grid;
        grid-template-columns: 1fr 4fr 1fr;
        min-height: 100vh;
        background-image:
        linear-gradient(rgba(0, 0, 0, 0.8)),
        url(/imagenes/img2.png);
        background-size: cover;
        background-repeat: no-repeat;
        position: relative;
    }

    .mensaje-pantalla {
        position: absolute;
        top: 140px;
        left: 50%;
        transform: translateX(-50%);
        text-align: center;
        z-index: 10;
        width: 100%;
        
        span {
            font-size: 50px;
            font-weight: 900;
            text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.9);
            letter-spacing: 2px;
        }
    }

    .ganaste { color: #4caf50; }
    .perdiste { color: #f44336; }
    .empate { color: #9e7d4b; }

    .resultado{
        height: 100%;
        width: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        padding: 0px;
    }

    .tablero{
        
        min-height: 70vh;
        width: 100%;
        background-image: url(/imagenes/img1.png);
        background-position: center ;
        background-size: cover;
        background-repeat: no-repeat;
        border: 3px solid #38170b;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        color: #9e7d4b;

        span{
            color: #9e7d4b;
            font-size: 32px;
            font-weight: 700;
        }

        button{
            height: 50px;
            width: 200px;
        }
    }

    .equipo-propio{
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 30px;
        justify-content: center;
        border: 1px solid red;

        .personaje{
            width: 180px;
            height: 270px;
            border: 3px solid #724d21;
            border-radius: 70px;
            overflow: hidden;

            .image-wrapper{
                height: 70%;
                width: 100%;

                img{
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }
            }

            .personaje-txt{
                height: 30%;
                width: 100%;
                background-color: #523519;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                color: #b79e65;
                
            }


        }
    }

    @media (max-width: 1200px){
        .resultado{
            .tablero{
                min-height: 50vh;
            }
        }

        .equipo-propio{
            gap: 15px;

            .personaje{
                width: 130px;
                height: 200px;
                border-radius: 40px;
            }
        }
    }

    
</style>