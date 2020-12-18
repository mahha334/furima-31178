window.addEventListener('load', () => {

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵 ⇨ 環境変数を呼び込みへ修正

// フォーム送信時にイベントが発火させる
  const form = document.getElementById("charge-form");  
  form.addEventListener("submit", (e) => {             
    e.preventDefault();
   });

// フォームの情報を取得  
  const formResult = document.getElementById("charge-form");
  const formData = new FormData(formResult);

  const card = {
    number: formData.get("user_purchase[number]"),               // user_purchase <= order
    cvc: formData.get("user_purchase[cvc]"),                     
    exp_month: formData.get("user_purchase[exp_month]"),         
    exp_year: `20${formData.get("user_purchase[exp_year]")}`,    
  };
// カードの情報をトークン化  
  Payjp.createToken(card, (status, response) => {
    if (status == 200) {
      const token = response.id;

//  トークンの値をフォームに含め
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden"> `;   //トークンの値を非表示
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
      debugger;
    }

//  クレジットカードの情報を削除
    document.getElementById("user_purchase_number").removeAttribute("name");          // user_purchase <= order
    document.getElementById("user_purchase_cvc").removeAttribute("name");             
    document.getElementById("user_purchase_exp_month").removeAttribute("name");       
    document.getElementById("user_purchase_exp_year").removeAttribute("name");       
//  フォームの情報をサーバーサイドに送信
    document.getElementById("charge-form").submit();
  });

  const priceInput = document.getElementById("item-price")        //金額を入力する場所のid
  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;

    const addTaxDom = document.getElementById("add-tax-price");   //手数料を表示する場所のid
    addTaxDom.innerHTML = Math.floor(inputValue * 0.1)     //入力した金額をもとに販売手数料を計算する処理

    const profitDom = document.getElementById("profit");   //利益を表示する場所のid
    profitDom.innerHTML = Math.floor(inputValue * 0.9)    //入力した金額をもとに利益を計算する処理

  });
})
