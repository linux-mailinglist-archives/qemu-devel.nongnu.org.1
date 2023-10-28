Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 900397DA91B
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:49:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFs-0004ok-U6; Sat, 28 Oct 2023 15:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFY-0004in-BT
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFW-00046s-3x
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:36 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1c77449a6daso27557855ad.0
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522332; x=1699127132; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+gt0CjYg4HfuULsURoNWzr2njchZ3xEe5eZdBzd0U4=;
 b=SKojQMpetIQroFyANyAose+wX9fYIlrUvheJ5gxZs18GdUky9al8JSUF8KijCtar41
 jmRdiWSYDUwK0tH/0xbrfuaYu2g8Ss8O4xubcesPWQgjaM9XqCirgBIlPgeU219a8UNz
 Bqh2HGCq0P4Y6TEnZbWpq+X0CTye+6Vcdqvmo5KgVQjgxPXYC3G3PIoP6BHXKvTom/DD
 QorBPmOhTC6Dk9xdEg1lgwJe1A2r06xIsIpsQNt02Hs/0782dN6sLiRngAGADYzXo00X
 ouL26TZ4WjevjUSTgJQd+Z1nkE1PqdF4WFarIVxF7Dj/s7Z5Y3opssVJwmu5GGVioyNY
 drWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522332; x=1699127132;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+gt0CjYg4HfuULsURoNWzr2njchZ3xEe5eZdBzd0U4=;
 b=TzG1eMR/r+Imy9sm/Vzc0gNJ8UrvgkJnFTUYxY7uCcJyFBilvNmaXy/DMgD4mFEp7z
 9fKy+ukmUUJ2TaJv+yoymca7lV3N1vcfKlf6YZXsIiU1BYkTPKBJpiJUKZykPfUdfrXQ
 1T3EQtDn7IB72JIsg58J/pYZ5BfJsb6dRRpnZ5Zgi6moMmbIb5I2vzoYJu/Id5vxxOZj
 ohjF95rYRmZTCX1S0ef7O9/wtNGpZmFgdMD8HeA8iF/svxJVNbuCCOsjZ88IPBerFmUS
 OJ2VudYzjilLmqGu5fCbC044yAaGERFmfFEaidj5F+FVsOgeSrTGB5LYMxC64qokVUy5
 j4Xw==
X-Gm-Message-State: AOJu0YxHThB+mL8YjRkHAkkmpMp0epV66kA3SGMeZ5VS8aipMhAfwiAz
 i60nd+d1OLSkjdhqsZaOQ+9p4uEHofYhmHSYP3s=
X-Google-Smtp-Source: AGHT+IHs+vXLlm48V53MSv21N1wltJ9jdZu0Ea5C4spLoPj/uNOtAUte03Eugpf3Lov4e6XJU7+LFA==
X-Received: by 2002:a17:902:d401:b0:1cc:2f90:6291 with SMTP id
 b1-20020a170902d40100b001cc2f906291mr2818017ple.54.1698522332518; 
 Sat, 28 Oct 2023 12:45:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 09/35] tcg/aarch64: Generate TBZ, TBNZ
Date: Sat, 28 Oct 2023 12:44:56 -0700
Message-Id: <20231028194522.245170-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Test the sign bit for LT/GE vs 0, and TSTNE/EQ vs a power of 2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 100 ++++++++++++++++++++++++++++-------
 1 file changed, 81 insertions(+), 19 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 70df250c04..55225313ad 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -105,6 +105,18 @@ static bool reloc_pc19(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
     return false;
 }
 
+static bool reloc_pc14(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
+{
+    const tcg_insn_unit *src_rx = tcg_splitwx_to_rx(src_rw);
+    ptrdiff_t offset = target - src_rx;
+
+    if (offset == sextract64(offset, 0, 14)) {
+        *src_rw = deposit32(*src_rw, 5, 14, offset);
+        return true;
+    }
+    return false;
+}
+
 static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
                         intptr_t value, intptr_t addend)
 {
@@ -115,6 +127,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
         return reloc_pc26(code_ptr, (const tcg_insn_unit *)value);
     case R_AARCH64_CONDBR19:
         return reloc_pc19(code_ptr, (const tcg_insn_unit *)value);
+    case R_AARCH64_TSTBR14:
+        return reloc_pc14(code_ptr, (const tcg_insn_unit *)value);
     default:
         g_assert_not_reached();
     }
@@ -380,6 +394,10 @@ typedef enum {
     /* Conditional branch (immediate).  */
     I3202_B_C       = 0x54000000,
 
+    /* Test and branch (immediate).  */
+    I3205_TBZ       = 0x36000000,
+    I3205_TBNZ      = 0x37000000,
+
     /* Unconditional branch (immediate).  */
     I3206_B         = 0x14000000,
     I3206_BL        = 0x94000000,
@@ -660,6 +678,14 @@ static void tcg_out_insn_3202(TCGContext *s, AArch64Insn insn,
     tcg_out32(s, insn | tcg_cond_to_aarch64[c] | (imm19 & 0x7ffff) << 5);
 }
 
+static void tcg_out_insn_3205(TCGContext *s, AArch64Insn insn,
+                              TCGReg rt, int imm6, int imm14)
+{
+    insn |= (imm6 & 0x20) << (31 - 5);
+    insn |= (imm6 & 0x1f) << 19;
+    tcg_out32(s, insn | (imm14 & 0x3fff) << 5 | rt);
+}
+
 static void tcg_out_insn_3206(TCGContext *s, AArch64Insn insn, int imm26)
 {
     tcg_out32(s, insn | (imm26 & 0x03ffffff));
@@ -1415,30 +1441,66 @@ static inline void tcg_out_goto_label(TCGContext *s, TCGLabel *l)
 static void tcg_out_brcond(TCGContext *s, TCGType ext, TCGCond c, TCGArg a,
                            TCGArg b, bool b_const, TCGLabel *l)
 {
-    intptr_t offset;
-    bool need_cmp;
+    int tbit = -1;
+    bool need_cmp = true;
 
-    if (b_const && b == 0 && (c == TCG_COND_EQ || c == TCG_COND_NE)) {
-        need_cmp = false;
-    } else {
-        need_cmp = true;
-        tcg_out_cmp(s, ext, c, a, b, b_const);
-    }
-
-    if (!l->has_value) {
-        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
-        offset = tcg_in32(s) >> 5;
-    } else {
-        offset = tcg_pcrel_diff(s, l->u.value_ptr) >> 2;
-        tcg_debug_assert(offset == sextract64(offset, 0, 19));
+    switch (c) {
+    case TCG_COND_EQ:
+    case TCG_COND_NE:
+        if (b_const && b == 0) {
+            need_cmp = false;
+        }
+        break;
+    case TCG_COND_LT:
+    case TCG_COND_GE:
+        if (b_const && b == 0) {
+            c = (c == TCG_COND_LT ? TCG_COND_TSTNE : TCG_COND_TSTEQ);
+            tbit = ext ? 63 : 31;
+            need_cmp = false;
+        }
+        break;
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        if (b_const && is_power_of_2(b)) {
+            tbit = ctz64(b);
+            need_cmp = false;
+        }
+        break;
+    default:
+        break;
     }
 
     if (need_cmp) {
-        tcg_out_insn(s, 3202, B_C, c, offset);
-    } else if (c == TCG_COND_EQ) {
-        tcg_out_insn(s, 3201, CBZ, ext, a, offset);
+        tcg_out_cmp(s, ext, c, a, b, b_const);
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+        tcg_out_insn(s, 3202, B_C, c, 0);
+        return;
+    }
+
+    if (tbit >= 0) {
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_TSTBR14, l, 0);
+        switch (c) {
+        case TCG_COND_TSTEQ:
+            tcg_out_insn(s, 3205, TBZ, a, tbit, 0);
+            break;
+        case TCG_COND_TSTNE:
+            tcg_out_insn(s, 3205, TBNZ, a, tbit, 0);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     } else {
-        tcg_out_insn(s, 3201, CBNZ, ext, a, offset);
+        tcg_out_reloc(s, s->code_ptr, R_AARCH64_CONDBR19, l, 0);
+        switch (c) {
+        case TCG_COND_EQ:
+            tcg_out_insn(s, 3201, CBZ, ext, a, 0);
+            break;
+        case TCG_COND_NE:
+            tcg_out_insn(s, 3201, CBNZ, ext, a, 0);
+            break;
+        default:
+            g_assert_not_reached();
+        }
     }
 }
 
-- 
2.34.1


