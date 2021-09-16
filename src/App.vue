<template>
<div id="app">
    <h1>Itunes album Search / Itunes API</h1>
    <p><input type="text" v-model="inputText" /></p>
    <p><button @click="search()">Search</button></p>

    Results: {{ data.resultCount }}

    <div v-for="entry in data.results" v-bind:key="entry">
         <h3> {{ entry.collectionName }} </h3>

         Artist name: {{ entry.artistName }} <br>
         Collection: <a :href="entry.collectionViewUrl" target="_blank">{{ entry.collectionName }}</a>   <br> 
         Collection price: {{ entry.collectionPrice }} <br>
         Genre: {{ entry.primaryGenreName }}
         <br>
         
         <img :src="entry.artworkUrl100" alt=""/>
         <hr>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';


interface RequestResult {
   res: Response;
   data: JSON;
}

// Send GET request to REST APIs
async function request_get(url: string): Promise<RequestResult>
{
    const res = await fetch(url,
                            { "method": "GET"
                                , headers: {
                                      'Content-Type': 'application/json'
                                    , 'X-Requested-With': 'XMLHttpRequest'
                                }
                            });

    let data = await res.json();
    return {res: res, data: data};
}

export default defineComponent({
    name: 'App'

  , components: {  }

  , data: () => { 
      return { 
            inputText: '' as string 
          , data: {} as any 
        , 
    }}

  , methods: {
       reset(){ this.inputText = ""; }

      ,async search(){
           let entry = this.inputText;
           let url = `https://itunes.apple.com/search?term=${entry}&entity=album`;
           let result = await request_get(url);
           console.log(result.data);
           this.data = result.data;
      }
  }

  , computed: {
        count(): number { return this.inputText.length; }
  }
});
</script>

<style>
  html {
    background: black;
  }
  #app {
      background: black;
      color: white;
  }
</style>
