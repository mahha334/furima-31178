const pay = () => {

  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); // PAY.JPテスト公開鍵 ⇨ 環境変数を呼び込みへ修正

// フォーム送信時にイベントが発火させる
  const form = document.getElementById("charge-form");  
  form.addEventListener("submit", (e) => {    
    e.preventDefault();
  

// フォームの情報を取得  
  const formResult = document.getElementById("charge-form");
  const formData = new FormData(formResult);

  const card = {
    number: formData.get("user_purchase[number]"),   //.get("indexにある名前（属性）と同じに！")           
    cvc: formData.get("user_purchase[cvc]"),                     
    exp_month: formData.get("user_purchase[exp_month]"),         
    exp_year: `20${formData.get("user_purchase[exp_year]")}`,    
  };
console.log(card)
// カードの情報をトークン化  
  Payjp.createToken(card, (status, response) => {
    if (status == 200) {
      const token = response.id;
//  トークンの値をフォームに含め
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden"> `;   //トークンの値を非表示
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
    }
  

//  クレジットカードの情報を削除
    document.getElementById("card-number").removeAttribute("name");  
  //.getElementById("indexにあるidと同じに！").removeAttribute("何の属性かを記入"); 
    document.getElementById("card-cvc").removeAttribute("name");             
    document.getElementById("card-exp-month").removeAttribute("name");       
    document.getElementById("card-exp-year").removeAttribute("name");   

//  フォームの情報をサーバーサイドに送信
    document.getElementById("charge-form").submit();
  });
  });
  };

    window.addEventListener("load", pay);