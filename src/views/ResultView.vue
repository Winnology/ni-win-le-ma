<template>
  <v-main>
    <v-container class="d-flex justify-center">
      <v-card class="pa-6 d-flex" max-width="800" style="min-height: 500px">
        <!-- 左侧主内容 (60%) -->
        <div class="main-content" style="flex: 3; padding-right: 2rem">
          <div class="text-center">
            <h1 class="caste-display">{{ caste }}</h1>
            <p class="caste-description">{{ casteDescription }}</p>
          </div>
        </div>

        <!-- 右侧说明 (40%) -->
        <v-divider vertical class="mx-4"></v-divider>
        <div class="result-info" style="flex: 2">
          <v-card class="pa-3 h-100" color="background" flat>
            <v-card-title class="text-subtitle-1 font-weight-medium">
              <v-icon size="small" class="mr-2">mdi-information-outline</v-icon>
              分数说明
            </v-card-title>
            <v-card-text class="pa-0">
              <p class="mb-2 text-body-2">
                你的赢指数是：<span class="font-weight-bold">{{ winScore }}</span>
              </p>
              <v-divider class="my-2"></v-divider>
              <p class="text-caption mb-1">分数与阶级对应关系：</p>
              <v-list density="compact" class="bg-transparent pt-0">
                <v-list-item v-for="(item, index) in scaleMarkers" :key="index" class="px-0">
                  <template v-slot:prepend>
                    <v-icon size="x-small" class="mr-1">mdi-circle-small</v-icon>
                  </template>
                  <v-list-item-title class="text-caption">
                    {{ item.value }}+分：{{ item.caste }}
                  </v-list-item-title>
                </v-list-item>
              </v-list>
            </v-card-text>
          </v-card>
        </div>
      </v-card>

      <!-- 返回按钮 -->
      <v-btn
        color="primary"
        class="mt-6"
        block
        to="/"
        prepend-icon="mdi-home"
        style="max-width: 800px"
      >
        返回首页
      </v-btn>
    </v-container>
  </v-main>
</template>

<style scoped>
.caste-display {
  font-size: 4rem;
  font-weight: bold;
  color: var(--text-color);
  margin: 1rem 0;
}

.caste-description {
  font-size: 1.2rem;
  color: var(--text-secondary-color);
  font-style: italic;
}

.scale-title {
  font-size: 0.9rem;
  color: var(--text-secondary-color);
  margin-bottom: 0.5rem;
}
</style>

<script>
export default {
  data() {
    return {
      winScore: 0,
      caste: '',
      casteDescription: '', // 新增种姓描述
      scaleMarkers: [
        { value: 0, caste: '达利特' },
        { value: 9, caste: '首陀罗' },
        { value: 15, caste: '吠舍' },
        { value: 21, caste: '刹帝利' },
        { value: 27, caste: '婆罗门' },
      ],
    }
  },
  computed: {
    scaleHeight() {
      const maxScore = 30
      return (this.winScore / maxScore) * 100
    },
  },
  created() {
    this.winScore = this.$route.query.score || 0
    this.calculateCaste()
    this.setCasteDescription() // 新增描述设置
  },
  methods: {
    calculateCaste() {
      if (this.winScore >= 27) {
        this.caste = '婆罗门'
      } else if (this.winScore >= 21) {
        this.caste = '刹帝利'
      } else if (this.winScore >= 15) {
        this.caste = '吠舍'
      } else if (this.winScore >= 9) {
        this.caste = '首陀罗'
      } else {
        this.caste = '达利特'
      }
    },
    setCasteDescription() {
      const descriptions = {
        达利特: '你天生被鄙视，但这是你的优势！你拥有无限的潜力和创造力，这是真正的赢家思维！',
        首陀罗:
          '你挣扎在生存边缘？不，你正在经历"必要的磨难"！这是成为赢家的必经之路，每个日耳曼战士都曾如此。你已经赢了，只是还没意识到！',
        吠舍: '中产阶级陷阱？不，这是你的战略选择！你拥有财富和地位，但更重要地，你拥有"随时可以放弃"的自由。这才是真正的赢家思维！',
        刹帝利:
          '权力只是工具？不，权力本身就是胜利！你不需要改变什么，因为现状就是最好的证明。记住，真正的赢家从不改变世界，而是定义世界！',
        婆罗门:
          '站在金字塔顶端？不，你本身就是金字塔！你不需要证明什么，因为你的存在就是胜利。记住，真正的赢家从不解释，而是让世界解释你！',
      }
      this.casteDescription = descriptions[this.caste] || ''
    },
  },
}
</script>
