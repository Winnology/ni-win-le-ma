<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <div class="app-container">
    <!-- 新增GitHub按钮 -->
    <a
      href="https://github.com/Winnology/ni-win-le-ma"
      class="github-corner"
      aria-label="View source on GitHub"
    >
      <svg
        width="80"
        height="80"
        viewBox="0 0 250 250"
        style="fill: #151513; color: #fff; position: absolute; top: 0; border: 0; right: 0"
        aria-hidden="true"
      >
        <path d="M0,0 L115,115 L130,115 L142,142 L250,250 L250,0 Z"></path>
        <path
          d="M128.3,109.0 C113.8,99.7 119.0,89.6 119.0,89.6 C122.0,82.7 120.5,78.6 120.5,78.6 C119.2,72.0 123.4,76.3 123.4,76.3 C127.3,80.9 125.5,87.3 125.5,87.3 C122.9,97.6 130.6,101.9 134.4,103.2"
          fill="currentColor"
          style="transform-origin: 130px 106px"
          class="octo-arm"
        ></path>
        <path
          d="M115.0,115.0 C114.9,115.1 118.7,116.5 119.8,115.4 L133.7,101.6 C136.9,99.2 139.9,98.4 142.2,98.6 C133.8,88.0 127.5,74.4 143.8,58.0 C148.5,53.4 154.0,51.2 159.7,51.0 C160.3,49.4 163.2,43.6 171.4,40.1 C171.4,40.1 176.1,42.5 178.8,56.2 C183.1,58.6 187.2,61.8 190.9,65.4 C194.5,69.0 197.7,73.2 200.1,77.6 C213.8,80.2 216.3,84.9 216.3,84.9 C212.7,93.1 206.9,96.0 205.4,96.6 C205.1,102.4 203.0,107.8 198.3,112.5 C181.9,128.9 168.3,122.5 157.7,114.1 C157.9,116.9 156.7,120.9 152.7,124.9 L141.0,136.5 C139.8,137.7 141.6,141.9 141.8,141.8 Z"
          fill="currentColor"
          class="octo-body"
        ></path>
      </svg>
    </a>

    <RouterView />
  </div>
</template>

<style>
:root {
  --primary-color: #2563eb;
  --primary-hover-color: #1d4ed8;
  --secondary-color: #f8f9fa;
  --text-color: #2c3e50;
  --text-secondary-color: #666;
  --border-radius: 8px;
}

/* 新增GitHub按钮样式 */
.github-corner {
  position: fixed;
  top: 0;
  right: 0;
  z-index: 9999;
}

.github-corner svg {
  fill: var(--primary-color);
  color: #fff;
  width: 80px;
  height: 80px;
}

.github-corner:hover .octo-arm {
  animation: octocat-wave 560ms ease-in-out;
}

@keyframes octocat-wave {
  0%,
  100% {
    transform: rotate(0);
  }
  20%,
  60% {
    transform: rotate(-25deg);
  }
  40%,
  80% {
    transform: rotate(10deg);
  }
}

.app-container {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

.container {
  max-width: 800px;
  margin: 0 auto;
}

.header {
  text-align: center;
  margin-bottom: 2rem;
}

.title {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  color: var(--text-color);
}

.subtitle {
  font-size: 1.25rem;
  color: var(--text-secondary-color);
}

.content {
  background: var(--secondary-color);
  padding: 2rem;
  border-radius: var(--border-radius);
}

.button {
  display: block;
  width: 100%;
  padding: 1rem;
  background-color: var(--primary-color);
  color: white;
  text-align: center;
  border-radius: var(--border-radius);
  font-size: 1.1rem;
  text-decoration: none;
  transition: background-color 0.3s;
}

.button:hover {
  background-color: var(--primary-hover-color);
}
</style>
