<template>
  <v-container>
    <v-card class="mx-auto" max-width="800px">
      <v-card-title class="text-center">
        <h1 class="text-h4">「你赢了吗」测试</h1>
        <p class="text-subtitle-1">日耳蛮赢学开源计划</p>
      </v-card-title>
      <v-card-text class="text-center">
        <v-btn block color="primary" size="large" to="/quiz" class="my-4"> 开始测试 </v-btn>
        <v-alert type="info" variant="tonal">
          欢迎通过GitHub Issue投稿更多问答内容，共同完善测试题库。
        </v-alert>
        <p class="text-body-1 mt-4">
          本测试隶属于日耳蛮赢学开源计划，旨在解构西方社会的"胜利闭环"现象。
        </p>
      </v-card-text>
    </v-card>
  </v-container>
</template>
