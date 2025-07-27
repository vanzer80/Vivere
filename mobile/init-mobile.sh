#!/bin/bash

echo "🚀 Iniciando setup do app mobile Vivere"

npx create-expo-app@latest . --template tabs --name Vivere

npm install expo-router supabase-js react-i18next i18next expo-constants react-native-paper

npm install -D eslint prettier husky lint-staged babel-plugin-inline-dotenv

npx husky install
npx husky add .husky/pre-commit "npx lint-staged"

echo '{
  "*.{js,ts,tsx}": ["prettier --write", "eslint --fix"]
}' > lint-staged.config.js

echo 'SUPABASE_URL=
SUPABASE_ANON_KEY=
JITSI_SERVER_URL=https://meet.jit.si' > .env

echo '{
  "presets": ["babel-preset-expo"],
  "plugins": [["inline-dotenv"]]
}' > babel.config.js

mkdir -p app && echo "import { Text, View } from 'react-native';

export default function Page() {
  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <Text>🧘‍♀️ Bem-vindo ao Vivere</Text>
    </View>
  );
}" > app/index.tsx

echo "✅ Setup concluído. Rode com: npx expo start"
