; ================================
; CapsLock 前缀层 + 单击删除
; ================================

; -------- 状态变量 --------
capsHeld := false      ; Caps 是否正在被按住
capsUsed := false      ; Caps 是否作为前缀被用过

; -------- 禁用 CapsLock 原本功能 --------
SetCapsLockState, AlwaysOff


; ================================
; CapsLock 按下：进入前缀态
; ================================
CapsLock::
    capsHeld := true
    capsUsed := false
return


; ================================
; CapsLock 松开：判断是否单击
; ================================
CapsLock Up::
    capsHeld := false

    ; 如果 Caps 没有和任何键组合过 → 视为单击
    if (!capsUsed)
    {
        Send {Backspace}
    }
return


; ================================
; Caps 前缀层定义
; 只有在 Caps 被按住时生效
; ================================
#If (capsHeld)

; --- Vim 风格光标移动 ---
h::
    capsUsed := true
    Send {Left}
return

j::
    capsUsed := true
    Send {Down}
return

k::
    capsUsed := true
    Send {Up}
return

l::
    capsUsed := true
    Send {Right}
return


; --- 单词级删除（向左）---
m::
    capsUsed := true
    Send ^{Backspace}
return

; --- 长按删除功能（向左）---
n::
    capsUsed := true
    Send {Backspace}
return

; --- 删除功能（向右）---
b::
    capsUsed := true
    Send {Delete}
return

; --- 行首 / 行尾 ---
u::
    capsUsed := true
    Send {Home}
return

o::
    capsUsed := true
    Send {End}
return


; --- Esc（方便退出模式/弹窗）---
q::
    capsUsed := true
    Send {Esc}
return

#If
