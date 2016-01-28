Field[][] fields = new Field[8][8]; //Fieldオブジェクトの生成
int player = 1; //プレイヤーを管理する変数 1: Black 2: White
int Bscore = 2; //黒のスコアを管理する変数　初期状態は２
int Wscore = 2; //白のスコアを管理する変数　初期状態は２
int Px = 0; //プレイヤーのx座標
int Py = 0; //プレイヤーのy座標
boolean PutFlag = false; //Enterを押されたことを管理する変数
boolean EndFlag = false; //終了を管理する変数
int vecX[] = {-1, 0, 1, 1, 1, 0,-1,-1}; //状態の判定時にx座標の変化量を保存する配列
int vecY[] = {-1,-1,-1, 0, 1, 1, 1, 0}; //状態の判定時にy座標の変化量を保存する配列


void setup(){
size(600,400); //サイズの設定
smooth(); //見た目を綺麗にする(たぶん)
for(int y = 0; y < 8; y++){ //fields[][]のy座標変化
for(int x = 0; x < 8; x++){ //fields[][]のx座標変化
fields[x][y] = new Field(x,y); //初期化
fields[x][y].update(); //描画
}
}
//スコア表示部分
textSize(50);//テキストサイズ設定
textAlign(CENTER);//中央揃えにする
fill(0,51,0);//色の設定
rect(400,0,200,400);//描画
fill(0,51,255);//色の設定
rect(420,100,70,70);//描画
rect(420,250,70,70);//描画
rect(490,100,70,70);//描画
rect(490,250,70,70);//描画
fill(0);//色の設定
ellipse(455,135,60,60);//黒の駒の描画
text(Bscore,525,150);//黒のスコアを表示
fill(255);//色の設定
ellipse(455,285,60,60);//白の駒の描画
text(Wscore,525,300);//白のスコアの表示
}

void draw(){
if(EndFlag) Finish();
else{
noFill();//塗りつぶさない
stroke(255,204,0);//枠線の色の設定
rect(50*Px,50*Py,50,50);//描画
if(PutFlag){//Enterが押されたか判断
if(fields[Px][Py].usable){//配置可能か判断
fields[Px][Py].chass = player;//プレイヤーの駒を配置
for(int vec=0; vec < 8; vec++){//探索方向が８方向あるので８回繰り返し
if(Search(Px,Py,vec,player,1) == 1){//変化するか判断
Change(Px,Py,vec,player);//成功なら変化させる
}
}
DispScore();//スコアを表示する
ChangePlayer();//プレイヤーを変更する
UpDate(); //状況を更新する
} else{
println("You can't put here!");//エラー表示
}
PutFlag = false;//フラグを下げる
}
}
}

//Ellipse関数
//引数はx，y座標・駒の色
int Ellipse(int x, int y, int Color){
switch(Color){//駒の色で分岐
case 0: return 0;//描画しない
case 1: fill(0,0,0); break;//色を黒に設定
case 2: fill(255,255,255); break;// 色を白に設定
}
stroke(0,0,0); //枠線の太さの設定
ellipse(50*x+25, 50*y+25, 40, 40);//円の描画
return 0;//終了
}

//Search関数
//引数はx，y座標・調べる方向・駒の色・モード
//モードについて 1:駒を裏返すかを調べる 2:配置可能なマスを調べる
int Search(int x, int y, int direction, int Color, int mode){
boolean usableFlag = false;//mode2で使用
while(true){//無限ループ条件式の中に１を入れたら怒られたのでtrueにした
x += vecX[direction];//調べる方向に対するxの変化量をたす
y += vecY[direction];//調べる方向に対するyの変化量をたす
if(x < 0 || x > 7) return 0;//範囲を超えたら終了
if(y < 0 || y > 7) return 0;//範囲を超えたら終了

//駒を裏返すかを調べる
if(mode == 1){
if(fields[x][y].chass == 0) return 0;//駒が配置されてなかったら終了
if(fields[x][y].chass == Color) return 1;//裏返す可能性あり
}
//配置可能なマスを調べる
else if(mode == 2){
if(fields[x][y].chass == 0){//駒が配置されていなかったら
if(usableFlag){//Flagがたっているか調べる
fields[x][y].usable = true;//配置可能に変更
return 1;//成功
} else return 0;//終了
}else if(fields[x][y].chass == Color) return 0;//同じ色の駒が合ったら終了
else usableFlag = true;//可能性があるのでFlagを立てる
}
}
}

//Change関数
//引数はx，y座標・調べる方向・駒の色
int Change(int x, int y, int direction, int Color){
while(true){//無限ループ
x += vecX[direction]; //調べる方向に対するxの変化量をたす
y += vecY[direction]; //調べる方向に対するyの変化量をたす
if(fields[x][y].chass == Color) return 1;//同じ色の駒になったら終了
else if(Color == 1){//プレイヤーが黒の時
fields[x][y].chass = 1;//黒に変更
}
else {//プレイヤーが白の時
fields[x][y].chass = 2;//白に変更
}
}
}

//Playerを変更する関数
void ChangePlayer(){
if(player == 1) player = 2; //黒なら白に変更
else player = 1; //白なら黒に変更
}

//状態を更新する関数
void UpDate(){
boolean PassFlag = true; //パスのフラグを立てる

for(int y = 0; y < 8; y++){ //fields[][]のy座標変化
for(int x = 0; x < 8; x++){ //fields[][]のx座標変化
fields[x][y].usable = false; //usableを一度全てfalseにする
}
}
for(int y = 0; y < 8; y++){ //fields[][]のy座標変化
for(int x = 0; x < 8; x++){ //fields[][]のx座標変化
if(fields[x][y].chass == player){ //現在のプレイヤーと同じ駒ならば、配置可能な場所を探し始める
for(int vec=0; vec < 8; vec++){ //探索方向が８方向あるので８回繰り返し
Search(x,y,vec,player,2); //配置可能か調べ、可能ならば状態を変化させる
}
}
}
}
for(int y = 0; y < 8; y++){ //fields[][]のy座標変化
for(int x = 0; x < 8; x++){//fields[][]のx座標変化
if(fields[x][y].update() == 1) PassFlag = false; //配置可能な場所があればPassFlagを降ろす
}
}
if(PassFlag){ //PassFlagがtrueのままだったら→配置可能な場所がない
ChangePlayer(); //プレイヤーを変更
println("Pass!!"); //パスを知らせる
}
}

void DispScore(){
Bscore = 0; //値を初期化
Wscore = 0; //値を初期化
for(int y = 0; y < 8; y++){ //fields[][]のy座標変化
for(int x = 0; x < 8; x++){ //fields[][]のx座標変化
if(fields[x][y].chass == 1) Bscore++; //駒が黒なら黒のスコアを足す
else if(fields[x][y].chass == 2) Wscore++; //駒が白なら白のスコアを足す
}
}
stroke(0); //外枠の太さの設定
fill(0,51,255); //色の設定
rect(490,100,70,70);//描画
rect(490,250,70,70);//描画
fill(0);//色の設定
text(Bscore,525,150);//スコアの表示
fill(255);//色の設定
text(Wscore,525,300);//スコアの表示
if(Bscore == 0 || Wscore == 0 || Bscore+Wscore == 64){//黒が０点　白が０点　白と黒を合わせて６４点の時終了
EndFlag = true;
}
}

void Finish(){
fill(255,0,0);//色の設定
textSize(75);//テキストのサイズ設定
if(Bscore > Wscore){//黒が勝ちの時
text("WIN!!",500,100); //テキストの表示
}
else{//白が勝ちの時
text("WIN!!",500,380); //テキストの表示
}
}

void keyPressed(){
stroke(0,0,0); //外枠の色設定
noFill(); //塗りつぶさない
rect(50*Px,50*Py,50,50); //描画
switch(keyCode){
case UP: if(Py != 0) Py--; break; //プレイヤーのy座標を引く
case DOWN: if(Py != 7) Py++; break; //プレイヤーのy座標を足す
case LEFT: if(Px != 0) Px--; break; //プレイヤーのx座標を引く
case RIGHT: if(Px != 7) Px++; break; //プレイヤーのx座標を足す
case ENTER: PutFlag = true; break; //PutFlagを立てる
}
} 
