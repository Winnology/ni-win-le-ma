<script setup></script>

<template>
  <main>
    <div class="container">
      <div class="header">
        <h1 class="title">「你赢了吗」测试</h1>
        <p class="subtitle">日耳蛮赢学开源计划</p>
        <router-link class="start-button" to="/quiz">开始探索</router-link>
      </div>

      <div class="content">
        <div class="description">
          <p class="note highlight">欢迎通过GitHub Issue投稿更多问答内容，共同完善测试题库。</p>
          <p class="lead">本测试隶属于日耳蛮赢学开源计划，旨在解构西方社会的"胜利闭环"现象。</p>
          <p>
            通过一系列精心设计的问题，我们将分析您的赢学特征，计算专属赢指数并得出对应的种姓阶级定位。
          </p>
          <p class="disclaimer">
            免责声明：本测试纯属娱乐，请勿用于任何严肃场合。测试结果仅供参考，最终解释权归日耳蛮赢学开源计划参与者所有。
          </p>
        </div>
      </div>
    </div>
  </main>
</template>

<style scoped>
.container {
  max-width: 800px;
  margin: 0 auto;
  padding: 2rem;
}

.header {
  text-align: center;
  margin-bottom: 2rem;
}

.title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
}

.subtitle {
  font-size: 1.25rem;
  color: #666;
}

.content {
  background: #f8f9fa;
  padding: 2rem;
  border-radius: 8px;
}

.description {
  margin-bottom: 2rem;
}

.lead {
  font-size: 1.1rem;
  font-weight: 500;
  margin-bottom: 1rem;
}

.note {
  font-style: italic;
  color: #666;
  margin-top: 1.5rem;
}

.disclaimer {
  font-size: 0.9rem;
  color: #999;
  margin-top: 1rem;
}

.start-button {
  display: block;
  width: 100%;
  padding: 1rem;
  background-color: #2563eb;
  color: white;
  text-align: center;
  border-radius: 8px;
  font-size: 1.1rem;
  text-decoration: none;
  transition: background-color 0.3s;
}

.start-button:hover {
  background-color: #1d4ed8;
}

.note.highlight {
  background: #e3f2fd;
  padding: 1rem;
  border-radius: 8px;
  border-left: 4px solid #2196f3;
  margin-bottom: 1.5rem;
  font-style: normal;
  color: #1565c0;
}
</style>
