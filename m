Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA10A42966
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Feb 2025 18:21:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc3D-00075V-BF; Mon, 24 Feb 2025 12:15:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2r-0006yT-TN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:06 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2p-0005a5-0r
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:15:05 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-221057b6ac4so89508025ad.2
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417301; x=1741022101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNoXg3/mKJgYS9SaXinMJRqwJQxTRDmbhgoTmmr6WrY=;
 b=uURUnduJC61Mzrmyb4Q/P0uEo8KGwjVtS03gS9HJTh8lkW6e//2PhaMpuX3cbeVoSu
 lYZbJ11z0am15r5PcF3u9ixlofeNT9zjYtrBHUbAvhNXpvAXdpgr/yOh5NE41zksXwFY
 18+ZCH5C2BiBAKYRgWq+VXJbpcFqaCJ/beeVLf7eF6Nw/cJqQ7Oha9Y6eyNQZU6teynO
 8ckHv16QeIeVD9E4f7bpVEDfVgfhYFJbTw9BBsNcuv/Ah0JqLo0P+/C+/pWG4vtNcamc
 5eCoUmDW8LLCDvbM3MouCXjTfqA6R3NqxwT+3g0HBqFuyFrvN9Z2nYs3IwhUDpG7f51G
 jfrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417301; x=1741022101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JNoXg3/mKJgYS9SaXinMJRqwJQxTRDmbhgoTmmr6WrY=;
 b=EVyfCCvQ4yLI+0PUM55QRcEfS1PMv+p9d/oIYM1K+RR/8Lfvlv+OxE83TrxXWEUlnz
 M2NhE9kyQDh4xE3688VF3TjTaeHIFIBLFGu3Na2SRHM6VhvlyUsL3Ji/5NaKJw7x5wMH
 bNrG71sAAsN2YnduzpRY4vTrfkgP4ROxwFEsTZ0WZlneA4+fT7Mp6MTBWN1hT7LI4NwD
 xtDHi/ReYfqvCO7/T9BCbZkaVfRIC6L37xxKoy8vmO+6ltT96gxvaRM9dqiBvk7TtZMA
 JL6MUpQyR3LGi3XPcvf2Gaee4fGCbQQDF7crZWUU9QX/hVxpxbVCRw7CNDy79vu2WDIm
 yl2g==
X-Gm-Message-State: AOJu0YyJvSpsAUpO5yoEYNFDtcuf+99Kh4j8Zcq2oLdxDyblHvZRKL1M
 s55dDC3+y2mjjsJQg2pehlBTEZbMhZCS2Pnwzg6RvHjjHt3GeTS3uE2X7Qg3FNvAKQd+ffZXEY0
 k
X-Gm-Gg: ASbGncv8WmCW/dHsubP5kUYZE2Xy3bvu8UQ9ukf/VjsKcXz0y5Mz0dQMA83jvxESyj+
 RRMIoubQ9ar4MK0jBKGQvHQO2jlAoAwvYrQcjRrM9hE5EPjszTB5qNaeMQJ0PrZLbIJNVa3EV3n
 uzVq6wwoUE3xzevHmtXlxMANDnyuG0xcwWh6nVn4LpuhzZ/tspqDVjn+O0K6VM3kp3vBUfKj7aI
 VafLM/PPjCQOBxu0kYLwJLW22Q7/DuagaPN1Qhm/VPBh//Qluiu3I4Ks8c+bTw+iy9lutG6rsAV
 8lVE3wywGV3BOV6f7Usd9hme3FXXynBMTEw=
X-Google-Smtp-Source: AGHT+IH020Zz/Kku0B/lEli7wmyi0aqnC7LpNBHs2Xn/qum3O10h4WAHNy/MSOl37gOIUN9uotMXtg==
X-Received: by 2002:a05:6a00:228b:b0:732:535d:bb55 with SMTP id
 d2e1a72fcca58-73426c7c50amr24136230b3a.4.1740417301514; 
 Mon, 24 Feb 2025 09:15:01 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.15.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:15:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH v4 11/24] target/m68k: Split gen_ea_mode for load/store
Date: Mon, 24 Feb 2025 09:14:31 -0800
Message-ID: <20250224171444.440135-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Replace with gen_load_mode and gen_store_mode.
Return bool for success from gen_store_mode,
which makes store_dummy unused.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 155 ++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 79 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index f16560c85c..d6f848c48d 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -60,8 +60,6 @@ static TCGv_i64 cpu_macc[4];
 
 static TCGv NULL_QREG;
 #define IS_NULL_QREG(t) (t == NULL_QREG)
-/* Used to distinguish stores from bad addressing modes.  */
-static TCGv store_dummy;
 
 void m68k_tcg_init(void)
 {
@@ -105,7 +103,6 @@ void m68k_tcg_init(void)
     }
 
     NULL_QREG = tcg_global_mem_new(tcg_env, -4, "NULL");
-    store_dummy = tcg_global_mem_new(tcg_env, -8, "NULL");
 }
 
 /* internal defines */
@@ -339,21 +336,6 @@ typedef enum {
     EA_LOADS
 } ea_what;
 
-/*
- * Generate an unsigned load if VAL is 0 a signed load if val is -1,
- * otherwise generate a store.
- */
-static TCGv gen_ldst(DisasContext *s, int opsize, TCGv addr, TCGv val,
-                     ea_what what, int index)
-{
-    if (what == EA_STORE) {
-        gen_store(s, opsize, addr, val, index);
-        return store_dummy;
-    } else {
-        return gen_load(s, opsize, addr, what == EA_LOADS, index);
-    }
-}
-
 /* Read a 16-bit immediate constant */
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
@@ -795,9 +777,9 @@ static TCGv gen_lea(CPUM68KState *env, DisasContext *s, uint16_t insn,
  * a write otherwise it is a read (0 == sign extend, -1 == zero extend).
  * ADDRP is non-null for readwrite operands.
  */
-static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
-                        int opsize, TCGv val, TCGv *addrp, ea_what what,
-                        int index)
+static TCGv gen_load_mode(CPUM68KState *env, DisasContext *s,
+                          int mode, int reg0, int opsize, TCGv *addrp,
+                          int sign, int index)
 {
     TCGv reg, ret, addr = NULL;
     int32_t offset;
@@ -805,40 +787,28 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     switch (mode) {
     case 0: /* Data register direct.  */
         reg = cpu_dregs[reg0];
-        if (what == EA_STORE) {
-            gen_partset_reg(opsize, reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 1: /* Address register direct.  */
         reg = get_areg(s, reg0);
-        if (what == EA_STORE) {
-            tcg_gen_mov_i32(reg, val);
-            ret = store_dummy;
-        } else {
-            ret = gen_extend(s, reg, opsize, what == EA_LOADS);
-        }
+        ret = gen_extend(s, reg, opsize, sign);
         break;
 
     case 7: /* Other */
-        if (reg0 == 4 && what != EA_STORE) {
+        if (reg0 == 4) {
             /* Immediate: sign extend values for consistency.  */
             switch (opsize) {
             case OS_BYTE:
-                if (what == EA_LOADS) {
-                    offset = (int8_t)read_im8(env, s);
-                } else {
-                    offset = read_im8(env, s);
+                offset = read_im8(env, s);
+                if (sign) {
+                    offset = (int8_t)offset;
                 }
                 break;
             case OS_WORD:
-                if (what == EA_LOADS) {
-                    offset = (int16_t)read_im16(env, s);
-                } else {
-                    offset = read_im16(env, s);
+                offset = read_im16(env, s);
+                if (sign) {
+                    offset = (int16_t)offset;
                 }
                 break;
             case OS_LONG:
@@ -857,17 +827,13 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     case 4: /* Indirect predecrememnt.  */
     case 5: /* Indirect displacement.  */
     case 6: /* Indirect index + displacement.  */
-        if (what == EA_STORE && addrp && *addrp) {
-            addr = *addrp;
-        } else {
-            addr = gen_lea_mode(env, s, mode, reg0, opsize);
-            if (IS_NULL_QREG(addr)) {
-                ret = addr;
-                addr = NULL;
-                break;
-            }
+        addr = gen_lea_mode(env, s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            ret = addr;
+            addr = NULL;
+            break;
         }
-        ret = gen_ldst(s, opsize, addr, val, what, index);
+        ret = gen_load(s, opsize, addr, sign, index);
         break;
 
     default:
@@ -880,6 +846,43 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
     return ret;
 }
 
+static bool gen_store_mode(CPUM68KState *env, DisasContext *s,
+                           int mode, int reg0, int opsize,
+                           TCGv val, TCGv addr, int index)
+{
+    TCGv reg;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        gen_partset_reg(opsize, reg, val);
+        return true;
+
+    case 1: /* Address register direct.  */
+        reg = get_areg(s, reg0);
+        tcg_gen_mov_i32(reg, val);
+        return true;
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    case 7: /* Other */
+        if (!addr) {
+            addr = gen_lea_mode(env, s, mode, reg0, opsize);
+            if (IS_NULL_QREG(addr)) {
+                return false;
+            }
+        }
+        gen_store(s, opsize, addr, val, index);
+        return true;
+
+    default:
+        g_assert_not_reached();
+    }
+}
+
 static TCGv_ptr gen_fp_ptr(int freg)
 {
     TCGv_ptr fp = tcg_temp_new_ptr();
@@ -1322,13 +1325,9 @@ static void gen_exit_tb(DisasContext *s)
 
 #define SRC_EA(env, result, opsize, op_sign, addrp)                     \
     do {                                                                \
-        TCGv *addrp_ = (addrp);                                         \
-        if (addrp_) {                                                   \
-            *addrp_ = NULL;                                             \
-        }                                                               \
-        result = gen_ea_mode(env, s, extract32(insn, 3, 3),             \
-                             REG(insn, 0), opsize, NULL_QREG, addrp_,   \
-                             op_sign ? EA_LOADS : EA_LOADU, IS_USER(s)); \
+        result = gen_load_mode(env, s, extract32(insn, 3, 3),           \
+                               REG(insn, 0), opsize, addrp,             \
+                               op_sign, IS_USER(s));                    \
         if (IS_NULL_QREG(result)) {                                     \
             gen_addr_fault(s);                                          \
             return;                                                     \
@@ -1337,10 +1336,10 @@ static void gen_exit_tb(DisasContext *s)
 
 #define DEST_EA(env, insn, opsize, val, addrp)                          \
     do {                                                                \
-        TCGv ea_result = gen_ea_mode(env, s, extract32(insn, 3, 3),     \
-                                     REG(insn, 0), opsize, val, addrp,  \
-                                     EA_STORE, IS_USER(s));             \
-        if (IS_NULL_QREG(ea_result)) {                                  \
+        TCGv *addrp_ = (addrp);                                         \
+        if (!gen_store_mode(env, s, extract32(insn, 3, 3),              \
+                            REG(insn, 0), opsize, val,                  \
+                            addrp_ ? *addrp_ : NULL, IS_USER(s))) {     \
             gen_addr_fault(s);                                          \
             return;                                                     \
         }                                                               \
@@ -1702,15 +1701,14 @@ DISAS_INSN(abcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_add(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -1739,15 +1737,14 @@ DISAS_INSN(sbcd_mem)
 
     /* Indirect pre-decrement load (mode 4) */
 
-    src = gen_ea_mode(env, s, 4, REG(insn, 0), OS_BYTE,
-                      NULL_QREG, NULL, EA_LOADU, IS_USER(s));
-    dest = gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE,
-                       NULL_QREG, &addr, EA_LOADU, IS_USER(s));
+    src = gen_load_mode(env, s, 4, REG(insn, 0), OS_BYTE,
+                        NULL, false, IS_USER(s));
+    dest = gen_load_mode(env, s, 4, REG(insn, 9), OS_BYTE,
+                         &addr, false, IS_USER(s));
 
     bcd_sub(dest, src);
 
-    gen_ea_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, &addr,
-                EA_STORE, IS_USER(s));
+    gen_store_mode(env, s, 4, REG(insn, 9), OS_BYTE, dest, addr, IS_USER(s));
 
     bcd_flags(dest);
 }
@@ -3124,11 +3121,11 @@ DISAS_INSN(cmpm)
     TCGv src, dst;
 
     /* Post-increment load (mode 3) from Ay.  */
-    src = gen_ea_mode(env, s, 3, REG(insn, 0), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    src = gen_load_mode(env, s, 3, REG(insn, 0), opsize,
+                        NULL, true, IS_USER(s));
     /* Post-increment load (mode 3) from Ax.  */
-    dst = gen_ea_mode(env, s, 3, REG(insn, 9), opsize,
-                      NULL_QREG, NULL, EA_LOADS, IS_USER(s));
+    dst = gen_load_mode(env, s, 3, REG(insn, 9), opsize,
+                        NULL, true, IS_USER(s));
 
     gen_update_cc_cmp(s, dst, src, opsize);
 }
-- 
2.43.0


