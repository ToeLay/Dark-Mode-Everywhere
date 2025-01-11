import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import { viteStaticCopy } from 'vite-plugin-static-copy';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      include: ["**/*.res.js"],
    }),
    viteStaticCopy({
      targets: [
        {
          src: 'src/ContentScript.res.js',
          dest: '.',
        },
        // {
        //   src: 'node_modules/rescript/lib/es6/caml_obj.js',
        //   dest: '.',
        // }
      ],
    }),
  ],
});
