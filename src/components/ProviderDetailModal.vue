<template>
  <div v-if="provider" class="modal-overlay">
    <div>
      <v-card v-click-outside="{ handler: closeModal }" class="mx-auto" width="500" style="border-radius: 15px;">
        <div style="height: 330px;">
          <v-img cover height="200" :srcset="`${provider.thumb} 1x, ${provider.thumb2x} 2x`" :src="`${provider.thumb}`"
            style="margin: 0px; border-radius: 0px;" />
          <div @mouseover="hover = true" @mouseleave="hover = false" :class="{ active: hover }">
            <v-rating v-model="newReview.rating" dense color="orange" density="default" hover class="me-2 modal-rating"
              half-increments @click="showReviewForm = true" />
          </div>
          <v-card-text style="padding-top: 20px; padding-bottom: 10px;">
            <div class="text-h6" style="padding-bottom: 5px;">
              <template v-if="!showReviewForm && !hover">
                {{ provider.name }}
              </template>
              <template v-else>
                Share Your Experience!
              </template>
            </div>
            <div class="text-subtitle-1" style="color: grey;">
              <template v-if="!showReviewForm && !hover">
                {{ provider.description }}
              </template>
              <template v-else>
                Rate and review your service experiences to help others make informed choices and contribute to our
                community.
              </template>
            </div>
          </v-card-text>

        </div>
        <v-divider />
        <v-progress-linear :active="loading" color="red" height="6" indeterminate
          style="position: absolute; top: 330px" />
        <div class="reviews-container">
          <div style="height: 100%; margin-bottom: 50px !important;">
            <div v-if="loading" class="loader">
              Fetching Reviews...
            </div>
            <div>

              <div v-if="showReviewForm" style="height: 320px; padding: 25px;">
                <form ref="form">
                  <v-text-field :max-length="20" :counter="20" v-model="newReview.nickname" variant="underlined"
                    :rules="[v => (v || '').length <= 20 || 'Name must be 20 characters or less']"
                    label="Name"></v-text-field>
                  <v-textarea style="height: 160px;" :max-length="80" :counter="80"
                    :rules="[v => (v || '').length <= 80 || 'Comments must be 80 characters or less']"
                    v-model="newReview.content" no-resize variant="underlined" label="Comments"></v-textarea>
                  <v-btn variant="flat" color="#E57373" @click="submitReview" style="margin-top: 10px;">Submit</v-btn>
                </form>
              </div>
              <div v-else style="overflow-y: auto; max-height: 320px; padding-left: 30px; padding-right: 30px;">
                <v-card v-for="review in reviews" :key="review.id" class="my-3 review-card"
                  style="padding: 10px; display: flex; flex-direction: column; min-height: 100px;">
                  <v-card-title>
                    <span>{{ review.nickname }}</span>
                    <span>
                      <v-rating :model-value="review.rating" color="amber" density="comfortable" size="small" class="me-2"
                        style="position: absolute; right: 10px;" half-increments readonly></v-rating>
                    </span>
                  </v-card-title>
                  <v-card-text style="padding-bottom: 10px;">{{ review.content }}</v-card-text>
                </v-card>
              </div>
            </div>
          </div>
        </div>
      </v-card>
    </div>
  </div>
</template>

<style>
.loader {
  text-align: center;
  padding: 20px;
  font-weight: bold;
}

.modal-rating {
  position: absolute;
  top: 158px;
  right: -8px;
  border-top-left-radius: 60px;
  background-color: white;
  padding: 5px;
  padding-left: 20px;
  padding-right: 10px;
}

.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.6);
  display: flex;
  justify-content: center;
  align-items: center;
}

.review-card {
  border-radius: 20px;
  margin-top: 30px !important;
  margin-bottom: 30px !important;
}

.reviews-container {
  background-color: #f7f8fb;
  height: 320px;
  padding-bottom: 100px !important;
}
</style>


<script>
import axios from 'axios';
export default {
  props: {
    provider: Object,
  },
  data() {
    return {
      reviews: [],
      loading: false,
      hover: false,
      showReviewForm: false,
      newReview: {
        nickname: '',
        content: '',
        rating: 0,
        provider_id: -1,
      },
    };
  },
  methods: {
    closeModal() {
      this.newReview = {}
      this.$emit('close-modal');
      this.reviews = [];
      this.showReviewForm = false;
    },
    fetchReviews() {
      if (!this.provider) { return; }
      this.loading = true;

      axios.get(`/reviews?provider_id=${this.provider.id}`)
        .then(response => {
          this.reviews = response.data.response.items;
        })
        .catch(error => {
          console.error("Error fetching reviews: ", error);
        })
        .finally(() => {
          this.loading = false;
        });
    },
    submitReview() {
      // Validation checks for nickname and comment
      if (this.newReview.nickname.length < 4 || this.newReview.nickname.length > 20) {
        alert('Name should be in between 4 and 20 characters.');
        return;
      }
      if (this.newReview.content.length < 5 || this.newReview.content.length > 80) {
        alert('Comment should be between 5 and 80 characters.');
        return;
      }
      axios
        .post('/review/add', this.newReview)
        .then((response) => {
          console.log('Review submitted successfully: ', response);
        })
        .catch((error) => {
          console.error('Error submitting review:', error);
        })
      this.closeModal();
    },
  },
  watch: {
    provider: {
      immediate: true,
      handler(newProvider, oldProvider) {
        if (newProvider !== oldProvider) {
          this.newReview.rating = this.provider ? this.provider.average_rating : 0;
          this.newReview.provider_id = this.provider ? this.provider.id : 0;
          this.fetchReviews();
        }
      },
    },
  },
}
</script>
