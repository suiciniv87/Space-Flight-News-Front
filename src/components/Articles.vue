<template>
    <v-app>
        <v-main>
            <h1 style="width: 100%; background-color: #D07017; color: #FFF;">SFN - Articles</h1>
            <div class="articles">
                <div v-if="listAllArticles == false">
                    <v-card v-for="item in firstArticlesFiltered" :key="item.id"
                        class="mx-auto cards"
                        max-width="444"
                        outlined
                    >
                        <v-list-item three-line>
                        <v-list-item-content>
                            <div class="text-h5 mb-1">
                            {{ item.title }}
                            </div>
                            <v-list-item-title class="text-overline mb-4">
                            {{ item.dataFormatada }}
                            </v-list-item-title>
                            <v-list-item-subtitle>{{ item.summary }}</v-list-item-subtitle>
                        </v-list-item-content>

                        <v-list-item-avatar
                            tile
                            size="120"
                        ><v-img height="120px"
                            :src="item.imageUrl"
                            />
                        </v-list-item-avatar>
                        </v-list-item>

                        <v-card-actions>
                            <v-btn
                                color="#D07017"
                                rounded
                                dark
                                text
                                id="#myBtn"
                                @click=abrirModal(item)
                            >
                                Ver mais
                            </v-btn>

                        </v-card-actions>
                    </v-card>
                    <div class="d-flex justify-md-center mb-6 cards" v-if="carregar == false">
                        <v-btn
                            @click.prevent="showAnotherArticles()"
                            right
                            color="#302E53"
                            rounded
                            dark
                        >
                            Carregar mais artigos
                        </v-btn>
                    </div>
                </div>
                <div v-if="listAllArticles == true">
                    <v-card v-for="item in allArticlesFiltered" :key="item.id"
                        class="mx-auto cards"
                        max-width="444"
                        outlined
                    >
                        <v-list-item three-line>
                        <v-list-item-content>
                            <div class="text-h5 mb-1">
                            {{ item.title }}
                            </div>
                            <v-list-item-title class="text-overline mb-4">
                            {{ dataFormatada }}
                            </v-list-item-title>
                            <v-list-item-subtitle>{{ item.summary }}</v-list-item-subtitle>
                        </v-list-item-content>

                        <v-list-item-avatar
                            tile
                            size="120"
                        ><v-img height="120px"
                            :src="item.imageUrl"
                            />
                        </v-list-item-avatar>
                        </v-list-item>

                        <v-card-actions>
                        <v-btn
                            color="#D07017"
                            rounded
                            dark
                            text
                            @click=abrirModal(item)
                        >
                            Ver mais
                        </v-btn>
                        </v-card-actions>
                    </v-card>
                </div>
            </div>
            <div id="myModal" class="modal">

                <div class="modal-content">
                    <span class="close">&times;</span>
                    <div class="containerModal">
                        <div class="imageModal">
                            <v-img :src="itemModal.imageUrl" style="width: 100%;" />
                        </div>
                        <div class="infoModal">
                            <h3>{{itemModal.title}}</h3>
                            <span style="font-size: 10px;">{{dataFormatada}}</span>
                            <p style="padding-top: 10px;">{{itemModal.summary}}</p>
                        </div>
                    </div>
                    <div class="btnModal">
                        <v-btn color="1E2022" dark rounded center @click.prevent="abrirPaginaModal(itemModal.url)">Ir para o site</v-btn>
                    </div>
                </div>

            </div>
        </v-main>
    </v-app>
</template>


<script>

  export default {
    name: 'Articles',

    data: () => ({
        dialog: false,
        firstArticles: [],
        lastArticles: [],
        allItems: [],
        listAllArticles: false,
        itemModal: [],
        carregar: false,
        dataFormatada: '',
        sortDefault: 0
    }),
    props: {
        filter: {
            type: String
        },
        sort: {
            type: String
        }
    },
    computed: {
        firstArticlesFiltered() {
            if (this.filter) {
                let exp = new RegExp(this.filter.trim(), 'i')
                return this.firstArticles.filter(article => exp.test(article.title))
            }
            else {
                return this.firstArticles
            }
        },
        allArticlesFiltered() {
            if (this.filter) {
                let exp = new RegExp(this.filter.trim(), 'i')
                return this.allItems.filter(article => exp.test(article.title))
            }
            else {
                return this.allItems
            }
        }
    },
    watch: {
        filter() {
            if (this.filter) {
                this.carregar = true
            }
            else if (this.filter && this.listAllArticles) {
                this.carregar = false
            }
        },
        sort(value) {
            this.sortArticles(value)
        }
    },
    methods: {
        sortArticles(value) {
            switch(value) {
                case 'Mais antigas':
                    if (this.sortDefault == 1 && this.listAllArticles == false) {
                        this.sortDefault = 0
                        this.firstArticles.reverse()
                    }
                    else if (this.sortDefault == 1 && this.listAllArticles == true) {
                        this.sortDefault = 0
                        this.firstArticles.reverse()
                        this.allItems.reverse()
                    }
                    break
                case 'Mais novas':
                    if (this.sortDefault == 0 && this.listAllArticles == false) {
                        this.sortDefault = 1
                        this.firstArticles.reverse()
                    }
                    else if (this.sortDefault == 0 && this.listAllArticles == true) {
                        this.sortDefault = 1
                        this.firstArticles.reverse()
                        this.allItems.reverse()
                    }
                    break
                default:
                    console.log('default')
                    break
            }
            
        },
        showAnotherArticles() {
            this.listAllArticles = true
            this.carregar = true
        },
        abrirModal(item) {
            let modal = document.getElementById("myModal");
            let span = document.getElementsByClassName("close")[0];

            this.itemModal = item
            this.converterData(this.itemModal.publishedAt)
        
            modal.style.display = "block";

            span.onclick = function() {
                modal.style.display = "none";
            }

            window.onclick = function(event) {
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }
        },
        abrirPaginaModal(item) {
            window.open(item)
        },
        converterData(data) {
            if (!data) return null
            let splitData = data.split(/[-T]/gm);
            this.dataFormatada = splitData[2] + '/' + splitData[1] + '/' + splitData[0];
            return this.dataFormatada
        },
        getArticles() {
            fetch("https://api.spaceflightnewsapi.net/v3/articles")
            .then(r => r.json())
            .then(r => {
                if (r.length > 9) {
                    let allItems = r.map(i => {
                        i.dataFormatada = this.converterData(i.publishedAt)
                        return i
                    })
                    this.allItems = allItems
                    this.firstArticles = allItems.slice(0, 5)
                    this.lastArticles = allItems.slice(5, allItems[-1])
                    this.listAllArticles = false
                    this.carregar = false
                }
                else {
                    let allItems = r.map(i => {
                        i.dataFormatada = this.converterData(i.publishedAt)
                        return i
                    })
                    this.allItems = allItems
                    this.carregar = true
                    this.listAllArticles = true
                }
            })
        }
    },
    created() {
        this.sortDefault = 1
        this.getArticles()
    }
  }
</script>

<style scoped>
@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:400&subset=latin,latin-ext);
h1, p, span {
  font-family: 'Roboto Condensed', sans-serif;
  font-style: normal;
  font-weight: 400;
}

.cards {
    margin-top: 20px;
}

.articles {
    width: 100vw;
    position: flex;
    justify-content: center;
    align-items: center;
}

.modal {
  display: none;
  position: fixed;
  z-index: 1;
  padding-top: 100px;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

/* The Close Button */
.close {
  color: #aaaaaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: #000;
  text-decoration: none;
  cursor: pointer;
}

.containerModal {
    display: grid;
    grid-template-columns: 30% 70%;
}

.imageModal {
    display: grid;
    grid-column: 1;
}

.infoModal {
    display: grid;
    grid-column: 2;
    padding-left: 10px;
}
.btnModal {
    display: flex;
    padding-top: 20px;
    justify-content: center;
    align-items: center;
}
</style>