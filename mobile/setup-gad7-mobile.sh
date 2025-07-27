#!/bin/bash

echo "🚀 Iniciando setup da tela GAD-7 no app mobile Vivere..."

cd ~/Vivere/mobile || { echo "❌ Pasta ~/Vivere/mobile não encontrada!"; exit 1; }

# 1. Criar diretório da rota se não existir
mkdir -p app/\(tabs\)

# 2. Criar tela completa com lógica de envio
cat <<'EOF' > app/\(tabs\)/gad7.tsx
import { View, Text, Pressable, ScrollView, Alert } from 'react-native';
import { useState } from 'react';
import { supabase } from '@/lib/supabase';

const questions = [
  'Sentiu-se nervoso, ansioso ou muito tenso?',
  'Não conseguiu parar de se preocupar?',
  'Preocupou-se demais com diferentes coisas?',
  'Teve dificuldade para relaxar?',
  'Ficou tão inquieto que foi difícil ficar parado?',
  'Irritou-se facilmente ou sentiu-se incomodado?',
  'Sentiu medo como se algo horrível pudesse acontecer?',
];

const options = [
  { label: 'Nunca', value: 0 },
  { label: 'Vários dias', value: 1 },
  { label: 'Mais da metade dos dias', value: 2 },
  { label: 'Quase todos os dias', value: 3 },
];

export default function GAD7Screen() {
  const [answers, setAnswers] = useState<number[]>(Array(7).fill(-1));

  const handleSelect = (questionIndex: number, value: number) => {
    const updated = [...answers];
    updated[questionIndex] = value;
    setAnswers(updated);
  };

  const handleSubmit = async () => {
    if (answers.includes(-1)) return Alert.alert('Responda todas as perguntas');
    const total = answers.reduce((a, b) => a + b, 0);
    const { error } = await supabase.from('gad7_results').insert({ answers, score: total });
    if (error) return Alert.alert('Erro ao enviar', error.message);
    Alert.alert('Enviado com sucesso!', `Pontuação total: ${total}`);
  };

  return (
    <ScrollView contentContainerStyle={{ padding: 20 }}>
      <Text style={{ fontSize: 24, fontWeight: 'bold', marginBottom: 16 }}>Questionário GAD-7</Text>
      {questions.map((q, i) => (
        <View key={i} style={{ marginBottom: 20 }}>
          <Text style={{ fontWeight: 'bold', marginBottom: 8 }}>{i + 1}. {q}</Text>
          <View style={{ flexDirection: 'row', flexWrap: 'wrap', gap: 10 }}>
            {options.map((opt, j) => (
              <Pressable
                key={j}
                onPress={() => handleSelect(i, opt.value)}
                style={{
                  padding: 10,
                  borderWidth: 1,
                  borderColor: answers[i] === opt.value ? 'blue' : '#ccc',
                  borderRadius: 6,
                  marginBottom: 6,
                }}>
                <Text>{opt.label}</Text>
              </Pressable>
            ))}
          </View>
        </View>
      ))}
      <Pressable onPress={handleSubmit} style={{ backgroundColor: 'green', padding: 12, borderRadius: 6 }}>
        <Text style={{ color: 'white', textAlign: 'center', fontWeight: 'bold' }}>Enviar</Text>
      </Pressable>
    </ScrollView>
  );
}
EOF

# 3. Criar lib do Supabase
mkdir -p lib

cat <<'EOF' > lib/supabase.ts
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.EXPO_PUBLIC_SUPABASE_URL!;
const supabaseAnonKey = process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY!;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
EOF

# 4. Instalar dependências
echo "📦 Instalando dependências..."
npm install @supabase/supabase-js

# 5. Sugestão de variáveis de ambiente
echo -e "\n🔐 Adicione essas variáveis no arquivo .env:\n"
echo "EXPO_PUBLIC_SUPABASE_URL=https://xxxx.supabase.co"
echo "EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJ..."

echo -e "\n✅ Tela GAD-7 criada com sucesso!"
echo "📱 Acesse pelo app Expo na aba 'gad7'"
