;
;請注意！輸入數字大小不能大於255，也不支援負數
;由於在編寫時我的Console無法開啟，都是由Visual studio的工具進行測試
;因而輸入部分請於第17行""中修改，並且請藉由工具進行變數觀測
;拜託QQQ 我寫了六小時
;我沒想到Bubble sort那麼難QQQQ
.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
INCLUDE Irvine32.inc

.data
buffer	BYTE	1,2,3,4,5,6,100
bufLen	DWORD	LENGTHOF	buffer
count	DWORD	0
input	BYTE	"1 2 3 4 5 6 100",32 ; 字串結尾補空白
iLen	DWORD	LENGTHOF	input
inInt	BYTE	10	DUP(0)
fLen	DWORD	0
myEsi	DWORD	0

.code
main PROC

	mov ecx, iLen ; 紀錄array長度
	dec ecx ; 避免超出索引值
	mov esi, 0 ; init esi
	mov bx, 0 ; 為了符合imul，因而用16 bits(WORD)
	L1:
		
		mov al, input[esi] ; 將input值一個個放入al
		cmp al, 32 ; 判斷是否為null
		je Space
			imul bx, 10 ; 由於imul需要16bits(WORD)，因而用bx
			sub al, 48 ; 轉換為整數
			add bl, al ; 將數值加回去，以便比大小
		jmp Both
		Space:
			push esi ; 將esi存入stack
			mov esi, myEsi ; 把自訂的esi移入
			mov inInt[esi], bl ; 添加數值
			inc esi ; 增加esi
			mov myEsi, esi ; 存回去
			pop esi ; pop 回來
			mov bl, 0 ; 重置bl
		Both:

		inc esi

	loop L1



;開始Bubble sort
	mov ecx, myEsi ; 紀錄array長度
	BL1:
		push ecx ; 要進入內部迴圈，因而先push
		mov count, 0

		mov ecx, myEsi ; 紀錄array長度
		BL2:
			mov esi, count ; 將count移動至esi，當作索引值
			mov ah, inInt[esi] ; 將左邊數值移動到ah
			mov al, inInt[esi+1] ; 將右邊數值移動到al
			cmp ah, al ; 判斷ah al大小
			ja Larage ; 如果ah比較大，不做事，直接jump
			;如果al大於等於ah;交換
			mov inInt[esi], al 
			mov inInt[esi+1], ah
			Larage:
			inc count ; 索引值增加
		loop BL2



		pop ecx ; 要回到外部迴圈，因而pop
	loop BL1

	INVOKE ExitProcess, 0
main ENDP
END main

