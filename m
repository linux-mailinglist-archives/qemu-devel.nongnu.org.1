Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F582A43B
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:48:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLK-0007Ai-IB; Wed, 10 Jan 2024 17:46:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKh-0005dT-8n
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:59 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKe-00039m-QY
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:45:58 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-42989a64713so28034031cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926754; x=1705531554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+gt0CjYg4HfuULsURoNWzr2njchZ3xEe5eZdBzd0U4=;
 b=DJXceG7YPV9e6jLxkwPUnNenPBf/NwgfpVfUNe4PjWTxYrLyu0wlDc3IWL1TRP3F7C
 0gz+QGwrz1suxWlQ0Ii20vqKw0KGCQXOGAHicfAd5t4gJOAhuApTPkh/UVugWUA4zhX8
 wmQCuf/0P7zPMngUiTLAEqAfu4WhMBotVCLlAeEF1wzImW8/Bh4E7GFdy/2TpHKMyg0P
 sWyc7g+brTbJj82a4YoSAlZNYURp3MA/u8xV8C6eeGG5uCJZAVs6RmBKCGQPO7lCbHi4
 AqT6XX8PgHe532p+3daT8keUbnF/mZvxzHBi0N9D24X7LZjOY+EyktxOwVtTiNBvLv7A
 H+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926754; x=1705531554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+gt0CjYg4HfuULsURoNWzr2njchZ3xEe5eZdBzd0U4=;
 b=YRJ4q8xY/s4SasmUKtWYwBDp1T4JEwzjgyZwiMlkHybNIQu+erccZMLWXxPk2qi0lq
 YClDRwGGPuVknhgXi14AzP6bx4jiLJjDvMduQyg8cXGZlS5A8yZILpxOVXbvdGFggGkB
 8RXK1hvj1Fn0kwyHNyjOfCYGuNr+l8eMQ3Zylv+mFTHuLe9DVRoK35/mm79W7gKFH0f2
 /ndYNB9tpeZfQNpsYYRaxnYUx767BK+mwG9qWt2MQfppptlIoId9c/N/GfAu+IOrtkXf
 uEbx0waw4WJSscicIfMu7OsX2/PH+VY0q4VLTWaMfVKAVzWnLPGz3agoi/7EGcu0CiXH
 m++Q==
X-Gm-Message-State: AOJu0YwJfe/Q2okUdxWLmXd6B0fUFTqji3ml4k95jHmPsSer45iGpBkS
 ZTSoa0DufKN07QUM4UiP1Ae06LgecvP+6dMToeE1a59QvCdyWMii
X-Google-Smtp-Source: AGHT+IEf5YSlTgRfaVYYubS225sE9f5PCRVQkXjNHRmmm6er68u4ThHJn1Bt4E16iouW72MEhGYtpw==
X-Received: by 2002:ac8:7c4c:0:b0:429:bdb8:a581 with SMTP id
 o12-20020ac87c4c000000b00429bdb8a581mr273153qtv.7.1704926752228; 
 Wed, 10 Jan 2024 14:45:52 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:45:51 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 18/38] tcg/aarch64: Generate TBZ, TBNZ
Date: Thu, 11 Jan 2024 09:43:48 +1100
Message-Id: <20240110224408.10444-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


