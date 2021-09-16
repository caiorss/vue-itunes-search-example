<template>
<div id="app" class="container">
    <h1 class="text-center text-uppercase" >Itunes album Search / Itunes API</h1>

    <div class="container">
      <p><input class="form-control" type="text" v-on:keyup.enter="search()" v-model="inputText" /></p>
      <br>
      <button class="btn btn-primary" @click="search()">Search</button>
      <button class="btn btn-primary" @click="clear()">Clear</button>
    </div>

    <hr>

    <h2 class="text-center text-uppercase">Results</h2>
    
    Results: {{ data.resultCount }}

    <div class="container" v-for="entry in results" v-bind:key="entry">
         <h3> {{ entry.collectionName }} </h3>

         Artist name: {{ entry.artistName }} <br>
         Collection: <a class="text-info" :href="entry.collectionViewUrl" target="_blank">{{ entry.collectionName }}</a>   <br> 
         Collection price: {{ entry.collectionPrice }} <br>
         Genre: {{ entry.primaryGenreName }} <br>
         Country: {{ entry.country }}
         <br>
         
         <img :src="entry.artworkUrl100" alt=""/>
         <hr>
    </div>
</div>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

import "bootstrap/dist/css/bootstrap.min.css";

interface RequestResult {
   res: Response;
   data: JSON;
}

export interface ItunesTypes {
  resultCount?: number;
  results?: Result[];
}

export interface Result {
  wrapperType: string;
  collectionType: string;
  artistId: number;
  collectionId: number;
  amgArtistId?: number;
  artistName: string;
  collectionName: string;
  collectionCensoredName: string;
  artistViewUrl: string;
  collectionViewUrl: string;
  artworkUrl60: string;
  artworkUrl100: string;
  collectionPrice: number;
  collectionExplicitness: string;
  contentAdvisoryRating?: string;
  trackCount: number;
  copyright: string;
  country: string;
  currency: number;
  releaseDate: string;
  primaryGenreName: string;
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
          , data: {} as ItunesTypes 
          , results: [] as Result[]
        , 
    }}

  , methods: {
       reset(){ this.inputText = ""; }

      ,async search(){
           let entry = this.inputText;
           let url = `https://itunes.apple.com/search?term=${entry}&entity=album`;
           let result = await request_get(url);
           console.log(result.data);
           this.data = result.data as ItunesTypes;
           this.results = this.data.results as Result[];
      }
      , clear(){
          this.inputText = "";
      }
  }

  , computed: {
        count(): number { return this.inputText.length; }
  }
});
</script>

<style>
  body {
    background: black;
  }
  #app {
      background: black;
      color: white;

  }

  /* ----- Layout for Desktop Screens -------- */
  @media only screen and (min-width: 600px) {
      #app {
          max-width: 800px; 
          margin: 20px;
          padding: 10px;
          border-radius: 20px;
      }
  }


</style>
