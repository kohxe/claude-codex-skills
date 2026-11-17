import type { Config } from 'tailwindcss';

export default {
  content: ['./app/**/*.{ts,tsx}'],
  theme: {
    extend: {
      colors: {
        brand: { DEFAULT: '#0f3d3e', accent: '#e2b04a' },
      },
    },
  },
  plugins: [],
} satisfies Config;
