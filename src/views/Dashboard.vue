<template>
  <v-container class="fill-height">
    <v-responsive class="align-center text-center fill-height">
      <v-img min-height="100" max-height="200" style="margin-left: 20%; margin-right: 20%;" src="@/assets/logo.svg" />
    </v-responsive>
  </v-container>
  <v-row justify="center" align="start" class="my-5 provider-row">
    <v-col v-for="provider in serviceProviders" :key="provider.id" cols="12" sm="6" md="4" lg="4" xl="6">
      <ServiceProviderCard :provider="provider" @goToDetail="showDetails" />
    </v-col>
  </v-row>
  <ProviderDetailModal :provider="selectedProvider" @close-modal="selectedProvider = null" />
</template>

<style>
.provider-row {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  margin-left: 5%;
  margin-right: 5%;
  /* gap: 2%; */
}
</style>

<script>
import axios from 'axios';
import ServiceProviderCard from '@/components/ServiceProviderCard.vue';
import ProviderDetailModal from '@/components/ProviderDetailModal.vue';

export default {
  data() {
    return {
      serviceProviders: [],
      selectedProvider: null
    };
  },
  components: {
    ServiceProviderCard,
    ProviderDetailModal
  },
  methods: {
    showDetails(provider) {
      this.selectedProvider = provider;
    }
  },
  mounted() {
    const city = this.$route.query.city;
    let apiUrl = '/providers';

    if (city) {
      apiUrl += `?city=${city}`;
    } else {
      apiUrl += `?city=${encodeURIComponent('%')}`;
    }

    axios.get(apiUrl)
      .then(response => {
        this.serviceProviders = response.data.response.items;
        for (let provider of this.serviceProviders) {
          const formattedName = provider.name.replace(/\s+/g, '-');
          provider.thumb = `/resources/services/thumbs/${formattedName}.jpg`;
          provider.thumb2x = `/resources/services/thumbs/${formattedName}@2x.jpg`;
        }
      });
  }
};
</script>
