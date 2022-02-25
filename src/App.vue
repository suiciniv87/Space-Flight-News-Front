<template>
  <v-app>
    <v-main>
        <div class="header">
          <div class="search">
            <v-text-field class="searchBox"
              dark
              outlined
              label="Search"
              append-icon="mdi-magnify"
              @input="handleChange"
              @click:append="search()"
            ></v-text-field>

          </div>
          <div class="changeSort">
            <v-select
            dark
            class="select1"
            :items="items"
            label="Sort"
            v-model="selectedItem"
            outlined
          ></v-select>
          </div>
        </div>
        <div class="logo">
          <img src="./assets/logo.png" alt="logo" height="200" />
        </div>
      <Articles :filter="filter" :sort="selectedItem" />
    </v-main>
  </v-app>
</template>

<script>
import Articles from './components/Articles';

export default {
  name: 'App',

  components: {
    Articles,
  },

  data: () => ({
    items: ['Mais antigas', 'Mais novas'],
    selectedItem: 'Mais novas',
    filter: '',
  }),
  methods: {
    handleChange(value) {
      this.filter = value
    }
  },
  created() {
    let uri = window.location.search.substring(1); 
    let params = new URLSearchParams(uri);
    if (params.get("s")) {
      this.filter = params.get("s")
    }
  }
};
</script>

<style scoped>
@import url(https://fonts.googleapis.com/css?family=Roboto+Condensed:400&subset=latin,latin-ext);
h1, p, span {
  font-family: 'Roboto Condensed', sans-serif;
  font-style: normal;
  font-weight: 400;
}

.header {
  background-color: #1E2022;
  display: grid;
  grid-template-columns: 1fr 1fr 1fr;
  justify-content: flex-end;
  height: 100px;
}

.searchBox {
  min-width: 300px;
}
.search {
  grid-column: 2;
  padding: 20px 0 0 150px;
}
.changeSort {
  padding: 20px 0 0 50px;
  max-width: 120px;
}
.select1 {
  grid-column: 3;
  min-width: 180px;
}

.logo {
  background-color: #302E53;
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 200px;
}
@media (max-width: 577px) {
  .header {
    max-width: 100%;
    display: grid;
    grid-template-rows: 50px 50px;
  }
  .search{
    grid-row: 1;
    background-color: purple;
  }  
  .select1 {
    grid-row: 2;
    background-color: green;
  }
}
</style>