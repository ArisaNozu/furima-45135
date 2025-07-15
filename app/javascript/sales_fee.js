const price = () => {
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");


  if (!priceInput || !addTaxDom || !profitDom) return;

  priceInput.addEventListener("input", () => {
    const inputValue = Number(priceInput.value);

    if (isNaN(inputValue)) {
      addTaxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return;
    }

    const tax = Math.floor(inputValue * 0.1);
    const profit = inputValue - tax;

    addTaxDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
