<template>
  <div id="app" class="row">
    <div v-for="list in original_lists" :key="list.name" class="col-3">
      <h6>{{ list.name}}</h6>
      <hr />

      
      <div v-for="(card, index) in list.cards" :key="index" class="card card-body mb-3">
        {{ card.name}}
      </div>

      <div>
        <textarea rows="3"></textarea>
        <button class="btn btn-secondary"></button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ["original_lists"],
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
