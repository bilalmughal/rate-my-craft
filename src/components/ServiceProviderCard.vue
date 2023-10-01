<template>
  <v-hover v-slot="{ isHovering, props }">
    <v-card class="mx-auto" @click="emitGoToDetailEvent(provider)" v-bind="props" style="margin: 3% !important;">
      <v-img cover :srcset="`${provider.thumb} 1x, ${provider.thumb2x} 2x`" :src="`${provider.thumb}`" />
      <v-card-item>
        <v-card-title>{{ provider.name }}</v-card-title>
        <div style="display: flex; align-items: center;">
          <v-card-subtitle>
            <span class="me-1">{{ provider.city }}</span>
            <v-icon color="error" icon="mdi-store" size="small"></v-icon>
            <v-chip class="ma-2" color="red" small label> {{ provider.services }} </v-chip>
          </v-card-subtitle>
        </div>
      </v-card-item>
      <v-card-text class="card-content">
        <v-row class="rating-row mx-0">
          <v-rating :model-value="provider.average_rating" color="orange" density="comfortable" half-increments readonly
            size="small" style="align-items: center; margin-top: 0px;"></v-rating>

          <div class="text-grey mx-1 hide-on-small-screen" style="align-items: center; margin-top: 5px;">
            {{ provider.average_rating }} ({{ provider.total_ratings }})
          </div>

        </v-row>
        <div class="my-4 text-subtitle-1 truncate-single-line">
          {{ provider.contact_info }}
        </div>

        <div class="my-4 text-body-1 truncate-2-lines">
          {{ provider.description }}
        </div>
      </v-card-text>
      <v-overlay :model-value="isHovering" contained scrim="#036358" class="justify-center">
        <v-btn variant="flat" color="#E78277" style="top:120px;">Check Reviews</v-btn>
      </v-overlay>
    </v-card>
  </v-hover>
</template>

<style>
.truncate-single-line {
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
  max-width: 100%;
}

.truncate-2-lines {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-content {
  height: 140px;
  margin-top: -2px;
  text-align: left;
}

.rating-row {
  height: 30px;
  flex: 0 0 auto !important;
}
.hide-on-small-screen {
  display: none;
}

@media screen and (min-width: 300px) {
  .hide-on-small-screen {
    display: inline-block;
    /* background-color: red; */
  }
}
</style>


<script>
export default {
  methods: {
    emitGoToDetailEvent(provider) {
      this.$emit('goToDetail', provider);
    }
  },
  emits: ["goToDetail"],
  props: {
    provider: {
      type: Object,
      required: true
    }
  }
}
</script>
