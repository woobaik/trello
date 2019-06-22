<template>
  <draggable v-model="lists" class="row dragList" :group="lists" id="app" @end="changeList">
    <div v-for="list in lists" :key="list.name" class="col-3">
      <h6>{{ list.name}}</h6>
      <hr />

      
      <div v-for="(card, index) in list.cards" :key="index" class="card card-body mb-3">
        {{ card.name}}
      </div>

      <div class="card card-body">
        <textarea rows="3" class="form-control" v-model='messages[list.id]'></textarea>
        <button class="btn btn-secondary" @click="addTask(list)">Add Task</button>
      </div>
    </div>
  
  </draggable>
  
</template>

<script>
import draggable from 'vuedraggable'

export default {
  components: { draggable },
  props: ["original_lists"],
  data: function() {
    return {
      messages: {},
      lists: this.original_lists
    }
  },
  methods: {
    addTask: function(list) {
      if (this.messages[list.id] === undefined) {
        alert('You cannot add empty task. Please try again')
      } else {
        var data = new FormData
        data.append('card[list_id]', list.id)
        data.append('card[name]', this.messages[list.id])

        Rails.ajax({
          url: '/cards',
          type: 'POST',
          data: data,
          dataType: 'json',
          success: (data)  => {
            const index = this.lists.findIndex(item => item.id === list.id)
            
            this.lists[index].cards.push(data)
            this.messages[list.id] = undefined
          }
        })

      }
    },
    changeList: function(evt) {
      var data = new FormData
      data.append('list[position]', evt.newIndex + 1)
      console.log(data)
      Rails.ajax({
        url: `lists/${this.lists[evt.newIndex].id}/move`,
        type: 'PATCH',
        data: data,
        datatype: 'json'
      })
      console.log('hoho')
    } 
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

.dragList {
  min-height: 20px;
}
</style>
