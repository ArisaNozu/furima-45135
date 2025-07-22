const pay = () => {
  // Payjpの初期化を1回だけに制限する
  if (window._payjpAlreadyInitialized) return;

  // mountされたかチェック
  const numberForm = document.getElementById("number-form");
  if (!numberForm || numberForm.childElementCount > 0) return;

  if (typeof gon === "undefined" || !gon.public_key) {
    console.error("gon.public_key is undefined");
    return;
  }

  window._payjpAlreadyInitialized = true;

  const publicKey = gon.public_key
  
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
  const elements = payjp.elements();

  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  if (!form) return;

  form.addEventListener("submit", (e) => {
    e.preventDefault(); // 最初に送信を止める

 payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        alert(response.error.message); // 空欄や不正入力時のエラーメッセージを表示
        return;
      }

      const token = response.id;

      // hiddenフィールドを作ってフォームに追加
      const tokenInput = document.createElement('input');
      tokenInput.setAttribute('type', 'hidden');
      tokenInput.setAttribute('name', 'order_form[token]');
      tokenInput.setAttribute('value', token);
      form.appendChild(tokenInput);

      form.submit(); // トークンを含めて送信
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
