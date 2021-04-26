function price (){
  const item_price = document.getElementById("item-price");
  item_price.addEventListener("input", () => {
    const inputValue = item_price.value;
    const price_fee = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");
    price_fee.innerHTML = Math.floor(inputValue * 0.1);
    profit.innerHTML = inputValue - (inputValue * 0.1);
  });
}

window.addEventListener('input', price);