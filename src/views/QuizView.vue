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
        const response = await fetch('/ni-win-le-ma/remw.md') // 修改这里
        const text = await response.text()
        this.parseMarkdown(text)
      } catch (error) {
        console.error('Failed to load questions:', error)
      } finally {
        this.loading = false
      }
    },
    parseMarkdown(text) {
      const lines = text.split('\n')
      let currentQuestion = null

      lines.forEach((line) => {
        if (line.startsWith('## ')) {
          if (currentQuestion) {
            this.allQuestions.push(currentQuestion)
          }
          currentQuestion = {
            text: line.replace('## ', ''),
            options: [],
            scores: [],
          }
        } else if (line.startsWith('- ')) {
          const option = line.replace('- ', '')
          currentQuestion.options.push(option)
          // 修改得分逻辑：第一个选项0分，第二个1分，以此类推
          currentQuestion.scores.push(currentQuestion.options.length - 1)
        }
      })

      if (currentQuestion) {
        this.allQuestions.push(currentQuestion)
      }
    },
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
