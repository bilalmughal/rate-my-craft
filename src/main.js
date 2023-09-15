/**
 * main.js
 *
 * Bootstraps Vuetify and other plugins then mounts the App`
 */

// Components
import App from './App.vue'


// Composables
import { createApp } from 'vue'

// Plugins
import { registerPlugins } from '@/plugins'

import axios from 'axios';

axios.defaults.baseURL = 'https://thoughtless-amber.cmd.outerbase.io';

const app = createApp(App)

registerPlugins(app)

app.mount('#app')