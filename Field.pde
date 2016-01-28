class Field{
//Member variable
int xpoint; //Fieldのx座標を管理する変数
int ypoint; //Fieldのy座標を管理する変数
boolean usable; //駒を配置可能かを管理する変数 0:配置不可能 1:配置可能
int chass; //駒が配置されているか管理する関数 0:駒がない 1:黒 2:白

//Constructer
Field(int x, int y){ //引数でx,y座標を渡す
xpoint = x; //x座標を代入
ypoint = y; //y座標を代入
if(x==2 && y==3){ //初期状態で配置可能な座標
usable = true; //配置可能にする
chass = 0; //駒は配置されていない
}else if(x==3 && y==2){ //初期状態で配置可能な座標
usable = true; //配置可能にする
chass = 0; //駒は配置されていない
}else if(x*y == 20){ //初期状態で配置可能な座標
usable = true; //配置可能にする
chass = 0; //駒は配置されていない
}else if(x==3 && y==4){ //初期状態で黒が配置される座標
usable = false; //配置不可能にする
chass = 1; //黒を配置する
}else if(x==4 && y==3){ //初期状態で黒が配置される座標
usable = false; //配置不可能にする
chass = 1; //黒を配置する
}else if(x*y==9 || x*y==16){//初期状態で白が配置される座標
usable = false; //配置不可能にする
chass =2; //白を配置する
}else{ //初期状態で駒が配置されず、配置不可能な座標
usable=false; //配置不可能にする
chass=0; //駒は配置しない
}
}

//Method
int update(){ //マス状態を更新する関数
stroke(0); //枠を黒にする
fill(0,150,0);//緑で塗りつぶす
rect(50*xpoint,50*ypoint,50,50);//マスを上書きする
Ellipse(xpoint, ypoint, chass);//駒を配置する　chassが0:配置されない 1:黒が配置される 2:白が配置される
if(usable == true){ //配置可能なマスか判断
fill(102,204,102); //水色で塗りつぶす
rect(50*xpoint,50*ypoint,50,50);//マスを上書きする
return 1; //配置可能を知らせる
}else return 0; // 配置不可能を知らせる
}
} 
