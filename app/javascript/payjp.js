document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('charge-form');
  if (!form) return;

  const payjp = Payjp(process.env.PAYJP_PUBLIC_KEY); // ここ後で直します

  // カード処理の記述（ここに続く）
});