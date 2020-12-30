window.addEventListener('load', () => {


    const priceInput = document.getElementById("item-price")        //金額を入力する場所のid
    priceInput.addEventListener('input', () => {   //エラー箇所２

    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");   //手数料を表示する場所のid
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)     //入力した金額をもとに販売手数料を計算する処理

    const profitDom = document.getElementById("profit");   //利益を表示する場所のid
    profitDom.innerHTML = Math.floor(inputValue * 0.9)    //入力した金額をもとに利益を計算する処理

  }); 
  
});
