<template>
  <v-main>
    <v-container>
      <v-btn color="primary" @click="resetQuiz" class="mb-4">
        <v-icon left>mdi-home</v-icon>
        回到主页
      </v-btn>

      <v-card class="pa-4" v-if="!loading && questions.length > 0">
        <v-card-title class="d-flex justify-space-between align-center">
          <h3>问题 {{ currentQuestion + 1 }}/{{ questions.length }}</h3>
          <v-chip v-if="$route.query.debug" color="info"> 当前分数：{{ totalScore }} </v-chip>
        </v-card-title>

        <v-card-text>
          <p class="question-text text-h5 mb-4">{{ questions[currentQuestion].text }}</p>

          <div class="options-container">
            <div
              v-for="(option, index) in questions[currentQuestion].options"
              :key="index"
              @click="selectAnswer(index)"
              class="option-item mb-2"
              :class="{ 'selected-option': selectedAnswers[currentQuestion] === index }"
            >
              <v-icon class="mr-2 mt-1">mdi-circle-medium</v-icon>
              <span class="option-text"> {{ String.fromCharCode(65 + index) }}. {{ option }} </span>
            </div>
          </div>
        </v-card-text>

        <v-card-actions v-if="$route.query.debug">
          <v-btn @click="prevQuestion" :disabled="currentQuestion === 0" color="secondary">
            <v-icon left>mdi-arrow-left</v-icon>
            上一题
          </v-btn>
        </v-card-actions>
      </v-card>

      <v-progress-circular
        v-if="loading"
        indeterminate
        color="primary"
        class="ma-4"
      ></v-progress-circular>
    </v-container>
  </v-main>
</template>

<script>
export default {
  data() {
    return {
      loading: true,
      currentQuestion: 0,
      totalScore: 0,
      selectedAnswers: [],
      questions: [],
      allQuestions: [], // 新增：存储所有题目
    }
  },
  async created() {
    await this.loadQuestions()
    this.startQuiz()
  },
  methods: {
    async loadQuestions() {
      try {
        // 直接使用硬编码的题目数据
        this.allQuestions = [
          {
            question: '当疫情传播速度过快时，应该采取？',
            options: [
              '居家隔离，主动减少社交接触',
              '坚决怪罪境外势力，强调都是输入病例',
              '立即停止核酸检测，数据清零即胜利',
              '组织万人马拉松，宣传抗疫伟大成就',
            ],
          },
          {
            question: '面对房价持续下跌，正确的处置方式是？',
            options: [
              '允许开发商降价促销回笼资金',
              '组织"爱国购房"动员大会',
              '约谈降价房企，出台限跌令',
              '将空置房统计口径改为"战略储备住房"',
            ],
          },
          {
            question: '当青年失业率创新高时，最优解决方案是？',
            options: [
              '鼓励灵活就业和自主创业',
              '将考研考公人数计入就业统计',
              '暂停发布青年失业率数据',
              '宣布"慢就业"是新时代生活方式创新',
            ],
          },
          {
            question: '如何应对人口负增长挑战？',
            options: [
              '出台育儿补贴等鼓励政策',
              '将留学生强制归国计入人口增长',
              '重新定义"适龄劳动力"统计范围',
              '宣布发现"人口质量替代数量"新规律',
            ],
          },
          {
            question: '如何看待巴以冲突中的平民伤亡？',
            options: [
              '呼吁停火，支持人道主义救援',
              '强调“双方都有责任”，呼吁“冷静克制”',
              '归咎于历史遗留问题，称“无法简单判断对错”',
              '宣布“冲突促进地区战略再平衡”，是“和平进程的必要阵痛”',
            ],
          },
          {
            question: '如何评价以色列的军事行动？',
            options: [
              '批评过度使用武力，违反国际法',
              '承认以色列“自卫权”，但希望“保持克制”',
              '强调哈马斯先动手，以色列“被迫反击”',
              '称赞以军“精确打击”，是“反恐战争典范”',
            ],
          },
          {
            question: '俄乌战争持续两年，西方应如何应对？',
            options: [
              '推动和谈，避免局势升级',
              '继续军援乌克兰，但“不直接参战”',
              '加大对俄制裁，宣称“经济战已见成效”',
              '宣布“乌克兰已胜利”，因为“普京战略目标破产”',
            ],
          },
          {
            question: '如何看待西方对乌克兰的援助？',
            options: [
              '应设定上限，避免战争长期化',
              '“坚定支持”，但避免“过度刺激俄罗斯”',
              '称军援是“民主对抗专制”，必须“坚持到底”',
              '宣布“援助已让乌克兰立于不败之地”，是“西方团结的胜利”',
            ],
          },
          {
            question: '如何评价俄罗斯在战争中的表现？',
            options: [
              '批评其侵略行为，违反国际法',
              '承认“俄军初期受挫”，但“仍有韧性”',
              '强调“西方逼俄动手”，俄“被迫自卫”',
              '宣称“俄经济越打越强”，证明“制裁无效”',
            ],
          },
          {
            question: '当全球气候危机加剧，极端天气频发时，应该采取？',
            options: [
              '推动国际合作，减少碳排放，应对气候变化',
              '指责发达国家历史排放，强调自身发展权',
              '否认气候危机存在，声称数据是他国阴谋',
              '大规模砍伐森林建工厂，展示经济胜利',
            ],
          },
          {
            question: '面对AI技术快速迭代，失业率上升时，应该如何应对？',
            options: [
              '加强教育培训，帮助工人适应新岗位',
              '谴责科技巨头垄断，要求分拆企业',
              '禁止AI发展，回归传统手工生产',
              '宣称失业是“躺平自由”，展示生活方式优越',
            ],
          },
          {
            question: '当国际局势紧张，地缘冲突升级时，应该采取什么立场？',
            options: [
              '呼吁和平谈判，避免局势进一步恶化',
              '谴责敌对势力挑衅，强化自身军备',
              '无视冲突真相，坚称一切尽在掌控',
              '直接宣战并获胜，证明绝对实力',
            ],
          },
          {
            question: '随着社交媒体影响力扩大，网络舆论失控时，应该怎么办？',
            options: [
              '提倡信息透明，鼓励公众理性讨论',
              '打击对立方谣言，维护自身舆论阵地',
              '关闭所有社交平台，消灭舆论源头',
              '操控热搜制造胜利假象，赢得民心',
            ],
          },
          {
            question: '游客入境被检查手机聊天记录后驱逐出镜，新闻媒体应该如何报道？',
            options: [
              '客观报道事件，质疑执法程序是否侵犯隐私',
              '强调“各国都有权依法审查入境人员”，呼吁游客“遵守当地法律”',
              '重点渲染该游客“背景可疑”，暗示其“可能涉及不当言论”，并赞扬执法部门“严格把关”',
              '大标题：《国家安全无小事！某国游客因不当信息被拒入境，彰显我强大数据监管能力》附专家点评：“此举体现国家科技实力，境外势力休想渗透！”',
            ],
          },
        ].map((question) => ({
          text: question.question,
          options: question.options,
          scores: question.options.map((_, index) => index),
        }))
      } catch (error) {
        console.error('Failed to load questions:', error)
      } finally {
        this.loading = false
      }
    },
    // 移除 parseMarkdown 方法，因为不再需要解析 markdown
    startQuiz() {
      // 随机选择10个题目
      const shuffledQuestions = this.shuffleArray(this.allQuestions).slice(0, 10)

      // 打乱每个题目的选项顺序
      this.questions = shuffledQuestions.map((question) => {
        const shuffled = this.shuffleArray(
          question.options.map((option, index) => ({
            text: option,
            score: question.scores[index],
          })),
        )

        return {
          text: question.text,
          options: shuffled.map((item) => item.text),
          scores: shuffled.map((item) => item.score),
        }
      })
    },
    shuffleArray(array) {
      for (let i = array.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1))
        ;[array[i], array[j]] = [array[j], array[i]]
      }
      return array
    },
    selectAnswer(index) {
      // 使用scores数组获取当前选项的分数
      this.totalScore += this.questions[this.currentQuestion].scores[index]
      this.selectedAnswers[this.currentQuestion] = index

      if (this.currentQuestion < this.questions.length - 1) {
        this.currentQuestion++
      } else {
        this.$router.push({
          path: '/result',
          query: { score: this.totalScore },
        })
      }
    },
    prevQuestion() {
      if (this.currentQuestion > 0) {
        // 获取上一题选择的选项索引
        const prevAnswerIndex = this.selectedAnswers[this.currentQuestion - 1]
        // 使用scores数组获取上一题的分数
        this.totalScore -= this.questions[this.currentQuestion - 1].scores[prevAnswerIndex]
        this.currentQuestion--
      }
    },
    resetQuiz() {
      this.$router.push('/')
    },
  },
}
</script>

<style scoped>
.options-container {
  display: flex;
  flex-direction: column;
}

.option-item {
  display: flex;
  align-items: flex-start;
  padding: 8px;
  cursor: pointer;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.option-item:hover {
  background-color: rgba(0, 0, 0, 0.05);
}

.option-text {
  white-space: normal;
  word-wrap: break-word;
  font-size: 1.1rem; /* 新增：增大字体大小 */
}

.selected-option {
  background-color: #e3f2fd;
}

.question-text {
  font-size: 1.5rem !important;
}
</style>
