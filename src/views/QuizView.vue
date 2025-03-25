<template>
  <main>
    <div class="container">
      <button class="button" @click="resetQuiz">回到主页</button>
      <div class="content">
        <div class="header">
          <h2>问题 {{ currentQuestion + 1 }}/{{ questions.length }}</h2>
          <p v-if="$route.query.debug">当前分数：{{ totalScore }}</p>
        </div>
        <div class="question-container">
          <p class="question-text">{{ questions[currentQuestion].text }}</p>
          <div class="options-container">
            <div
              v-for="(option, index) in questions[currentQuestion].options"
              :key="index"
              class="option-item"
              @click="selectAnswer(index)"
            >
              <span class="option-label">{{ String.fromCharCode(65 + index) }}.</span>
              <span>{{ option }}</span>
            </div>
          </div>
          <div class="button-container">
            <button
              v-if="$route.query.debug"
              @click="prevQuestion"
              :disabled="currentQuestion === 0"
              class="secondary-button"
            >
              上一题
            </button>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.question-container {
  margin-top: 1rem;
}

.question-text {
  font-size: 1.2rem;
  margin-bottom: 1.5rem;
}

.options-container {
  display: flex;
  flex-direction: column;
  gap: 12px;
  margin-bottom: 2rem;
}

.option-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  cursor: pointer;
}

.option-item:hover {
  background-color: #f5f5f5;
}

.option-label {
  font-weight: bold;
}

.button-container {
  display: flex;
  justify-content: center;
  gap: 16px;
}

.secondary-button {
  background-color: #f0f0f0;
  color: #333;
  padding: 8px 24px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

.secondary-button:hover {
  background-color: #e0e0e0;
}
</style>

<script>
export default {
  data() {
    return {
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
      const response = await fetch('/remw.md')
      const text = await response.text()
      this.parseMarkdown(text)
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
