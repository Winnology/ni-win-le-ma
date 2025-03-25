<template>
  <main>
    <div class="container">
      <div class="content">
        <div class="header">
          <h1 class="caste-display">{{ caste }}</h1>
          <p class="caste-description">{{ casteDescription }}</p>
        </div>
        <div class="result-info">
          <h3 class="scale-title">你的赢指数是：{{ winScore }}，分数与阶级对应关系：</h3>
          <ul class="scale-list">
            <li>0-8 分：达利特</li>
            <li>9-14 分：首陀罗</li>
            <li>15-20 分：吠舍</li>
            <li>21-26 分：刹帝利</li>
            <li>27 分及以上：婆罗门</li>
          </ul>
        </div>
        <router-link class="button" to="/">返回首页</router-link>
      </div>
    </div>
  </main>
</template>

<style scoped>
.caste-display {
  font-size: 4rem;
  font-weight: bold;
  color: var(--text-color);
  text-align: center;
  margin: 1rem 0;
}

.caste-description {
  font-size: 1.2rem;
  color: var(--text-secondary-color);
  text-align: center;
  margin: 1rem 0;
  font-style: italic;
}

.result-info {
  margin: 2rem 0;
}

.scale-title {
  font-size: 0.9rem;
  color: var(--text-secondary-color);
  margin-bottom: 0.5rem;
}

.scale-list {
  font-size: 0.8rem;
  color: #999;
  list-style: none;
  padding: 0;
  margin: 0;
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
        达利特:
          '你天生被鄙视，但这是你的优势！因为你已经触底，接下来的每一步都是上升。记住，真正的赢家从不在乎起点！',
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
