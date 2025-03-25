<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <v-app>
    <v-main class="main-content">
      <v-container
        fluid
        class="pa-4 fill-height d-flex align-center justify-center"
        style="
          max-width: 100vw;
          overflow-x: hidden;
          padding-left: 0;
          padding-right: 0;
          word-wrap: break-word;
        "
      >
        <!-- GitHub按钮 -->
        <v-btn
          href="https://github.com/Winnology/ni-win-le-ma"
          class="github-corner"
          icon
          color="primary"
          target="_blank"
          style="position: fixed; top: 0; right: 0; margin: 12px; z-index: 1000"
        >
          <v-icon>mdi-github</v-icon>
        </v-btn>

        <RouterView style="width: 100%; max-width: 100%; overflow: hidden" />
      </v-container>
    </v-main>
  </v-app>
</template>

<style scoped>
.main-content {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}

.container {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>
