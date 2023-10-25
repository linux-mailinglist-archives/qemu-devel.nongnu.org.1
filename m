Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 346B77D6311
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:33:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIp-0000N2-SQ; Wed, 25 Oct 2023 03:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIk-0000LH-4I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:38 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIi-0004jm-2w
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:37 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5ab53b230f1so3455114a12.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218853; x=1698823653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wPe+9mvEGZleEWGbkTca1tKdwjbDs6ccbxNSMhBGMcE=;
 b=TuQmDtL+Pqo3kiraltdwwSzyJhi0H8Y4QadxXi1w0qcXNZWbHILJn7zXuenVKlBVJv
 uSGn0s+b0am2Ym4xz4t9hWY9NizGMYRTTW8P0CT2A3o1KtZz9Ba8j10DhRHMnVeQCf3G
 c8pU2stDiqtHG+bGL2q2Aw8G+fyRNMFmdAR2JOnHqhdOZuK+xOmNBlVMWdSZjiXBSGAO
 2bio7t1IvslrzkY2TnwFLZc3+UfQl5nZoQ1Y/KMLcOfuV1N1aosWUvOunVwwIMWfvBxd
 wFzWv6737O9uaSdiHy6AkLqqOfE308fqBcMX7xO8oCe/pd4Ut5Gd9lAFeR7J4z5rEtZg
 M8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218853; x=1698823653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wPe+9mvEGZleEWGbkTca1tKdwjbDs6ccbxNSMhBGMcE=;
 b=eKyAdH23+e2cAqzfu8nOYpLuHvwIveP86FgyZZg7vVTHNGy7W75zt3eDQyv7CTiIDp
 QyCWLI+GxCxIqHsFqEa6PRxCPxX0yBt7JqpI5QVcmrQcsVldPqlfCYrCzb9hRiic24SL
 b9VJV0KPbV2sMtkL/rMm2MFVp57K9dR7m7VEDGg7Gjav2VmP6n8u9JzUqeUoy2/r5sju
 n3Z+Dcx2vv8PIDYjxkf065ZlSCLHcOuQF/cbaUOxVuhYza1QahC1Vnd/aOmzTBtBdhRS
 AMZm2iR9UDue5BkLsvzaBAskKzSjfl0aOEHdSMZNpiAGIjIx9VhBUBG+xoNiA9hwvl/v
 wBzQ==
X-Gm-Message-State: AOJu0YxEf3fyJDGqQHTI4TGah6EM1wSRzHTZ5u2hD8Y60cq8Y8tk3NKN
 Bd+3OivEURW51GziNWCmKs/z7+ivit/O5DCMLHU=
X-Google-Smtp-Source: AGHT+IEh4CKv8/w1I+IhV91c7qjJ2ELXcAX9GQ5bHyx2tdn35DULJtK2ke6g+edIWGBXH4vcsrHU6g==
X-Received: by 2002:a05:6a21:7906:b0:171:737:df99 with SMTP id
 bg6-20020a056a21790600b001710737df99mr4320672pzc.40.1698218852729; 
 Wed, 25 Oct 2023 00:27:32 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 25/29] tcg/s390x: Support TCG_COND_TST{EQ,NE}
Date: Wed, 25 Oct 2023 00:27:03 -0700
Message-Id: <20231025072707.833943-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/s390x/tcg-target.c.inc | 127 +++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 39 deletions(-)

diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index fbee43d3b0..ef3cb87e9f 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -111,6 +111,9 @@ typedef enum S390Opcode {
     RI_OILH     = 0xa50a,
     RI_OILL     = 0xa50b,
     RI_TMLL     = 0xa701,
+    RI_TMLH     = 0xa700,
+    RI_TMHL     = 0xa703,
+    RI_TMHH     = 0xa702,
 
     RIEb_CGRJ    = 0xec64,
     RIEb_CLGRJ   = 0xec65,
@@ -403,10 +406,15 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define S390_CC_NEVER   0
 #define S390_CC_ALWAYS  15
 
+#define S390_TM_EQ      8  /* CC == 0 */
+#define S390_TM_NE      7  /* CC in {1,2,3} */
+
 /* Condition codes that result from a COMPARE and COMPARE LOGICAL.  */
-static const uint8_t tcg_cond_to_s390_cond[] = {
+static const uint8_t tcg_cond_to_s390_cond[16] = {
     [TCG_COND_EQ]  = S390_CC_EQ,
     [TCG_COND_NE]  = S390_CC_NE,
+    [TCG_COND_TSTEQ] = S390_CC_EQ,
+    [TCG_COND_TSTNE] = S390_CC_NE,
     [TCG_COND_LT]  = S390_CC_LT,
     [TCG_COND_LE]  = S390_CC_LE,
     [TCG_COND_GT]  = S390_CC_GT,
@@ -420,9 +428,11 @@ static const uint8_t tcg_cond_to_s390_cond[] = {
 /* Condition codes that result from a LOAD AND TEST.  Here, we have no
    unsigned instruction variation, however since the test is vs zero we
    can re-map the outcomes appropriately.  */
-static const uint8_t tcg_cond_to_ltr_cond[] = {
+static const uint8_t tcg_cond_to_ltr_cond[16] = {
     [TCG_COND_EQ]  = S390_CC_EQ,
     [TCG_COND_NE]  = S390_CC_NE,
+    [TCG_COND_TSTEQ] = S390_CC_ALWAYS,
+    [TCG_COND_TSTNE] = S390_CC_NEVER,
     [TCG_COND_LT]  = S390_CC_LT,
     [TCG_COND_LE]  = S390_CC_LE,
     [TCG_COND_GT]  = S390_CC_GT,
@@ -843,6 +853,9 @@ static const S390Opcode oi_insns[4] = {
 static const S390Opcode lif_insns[2] = {
     RIL_LLILF, RIL_LLIHF,
 };
+static const S390Opcode tm_insns[4] = {
+    RI_TMLL, RI_TMLH, RI_TMHL, RI_TMHH
+};
 
 /* load a register with an immediate value */
 static void tcg_out_movi(TCGContext *s, TCGType type,
@@ -1203,6 +1216,40 @@ static int tgen_cmp2(TCGContext *s, TCGType type, TCGCond c, TCGReg r1,
     TCGCond inv_c = tcg_invert_cond(c);
     S390Opcode op;
 
+    if (is_tst_cond(c)) {
+        tcg_debug_assert(!need_carry);
+
+        if (c2const) {
+            int i;
+
+            if (type == TCG_TYPE_I32) {
+                c2 = (uint32_t)c2;
+            }
+
+            i = is_const_p16(c2);
+            if (i >= 0) {
+                tcg_out_insn_RI(s, tm_insns[i], r1, c2 >> (i * 16));
+                *inv_cc = TCG_COND_TSTEQ ? S390_TM_NE : S390_TM_EQ;
+                return *inv_cc ^ 15;
+            }
+
+            if (risbg_mask(c2)) {
+                tgen_andi_risbg(s, TCG_REG_R0, r1, c2);
+                goto exit;
+            }
+
+            tcg_out_movi(s, type, TCG_REG_R0, c2);
+            c2 = TCG_REG_R0;
+        }
+
+        if (type == TCG_TYPE_I32) {
+            tcg_out_insn(s, RRFa, NRK, TCG_REG_R0, r1, c2);
+        } else {
+            tcg_out_insn(s, RRFa, NGRK, TCG_REG_R0, r1, c2);
+        }
+        goto exit;
+    }
+
     if (c2const) {
         if (c2 == 0) {
             if (!(is_unsigned && need_carry)) {
@@ -1516,46 +1563,49 @@ static void tgen_brcond(TCGContext *s, TCGType type, TCGCond c,
                         TCGReg r1, TCGArg c2, int c2const, TCGLabel *l)
 {
     int cc;
-    bool is_unsigned = is_unsigned_cond(c);
-    bool in_range;
-    S390Opcode opc;
 
-    cc = tcg_cond_to_s390_cond[c];
+    if (!is_tst_cond(c)) {
+        bool is_unsigned = is_unsigned_cond(c);
+        bool in_range;
+        S390Opcode opc;
 
-    if (!c2const) {
-        opc = (type == TCG_TYPE_I32
-               ? (is_unsigned ? RIEb_CLRJ : RIEb_CRJ)
-               : (is_unsigned ? RIEb_CLGRJ : RIEb_CGRJ));
-        tgen_compare_branch(s, opc, cc, r1, c2, l);
-        return;
-    }
+        cc = tcg_cond_to_s390_cond[c];
 
-    /*
-     * COMPARE IMMEDIATE AND BRANCH RELATIVE has an 8-bit immediate field.
-     * If the immediate we've been given does not fit that range, we'll
-     * fall back to separate compare and branch instructions using the
-     * larger comparison range afforded by COMPARE IMMEDIATE.
-     */
-    if (type == TCG_TYPE_I32) {
-        if (is_unsigned) {
-            opc = RIEc_CLIJ;
-            in_range = (uint32_t)c2 == (uint8_t)c2;
-        } else {
-            opc = RIEc_CIJ;
-            in_range = (int32_t)c2 == (int8_t)c2;
+        if (!c2const) {
+            opc = (type == TCG_TYPE_I32
+                   ? (is_unsigned ? RIEb_CLRJ : RIEb_CRJ)
+                   : (is_unsigned ? RIEb_CLGRJ : RIEb_CGRJ));
+            tgen_compare_branch(s, opc, cc, r1, c2, l);
+            return;
         }
-    } else {
-        if (is_unsigned) {
-            opc = RIEc_CLGIJ;
-            in_range = (uint64_t)c2 == (uint8_t)c2;
+
+        /*
+         * COMPARE IMMEDIATE AND BRANCH RELATIVE has an 8-bit immediate field.
+         * If the immediate we've been given does not fit that range, we'll
+         * fall back to separate compare and branch instructions using the
+         * larger comparison range afforded by COMPARE IMMEDIATE.
+         */
+        if (type == TCG_TYPE_I32) {
+            if (is_unsigned) {
+                opc = RIEc_CLIJ;
+                in_range = (uint32_t)c2 == (uint8_t)c2;
+            } else {
+                opc = RIEc_CIJ;
+                in_range = (int32_t)c2 == (int8_t)c2;
+            }
         } else {
-            opc = RIEc_CGIJ;
-            in_range = (int64_t)c2 == (int8_t)c2;
+            if (is_unsigned) {
+                opc = RIEc_CLGIJ;
+                in_range = (uint64_t)c2 == (uint8_t)c2;
+            } else {
+                opc = RIEc_CGIJ;
+                in_range = (int64_t)c2 == (int8_t)c2;
+            }
+        }
+        if (in_range) {
+            tgen_compare_imm_branch(s, opc, cc, r1, c2, l);
+            return;
         }
-    }
-    if (in_range) {
-        tgen_compare_imm_branch(s, opc, cc, r1, c2, l);
-        return;
     }
 
     cc = tgen_cmp(s, type, c, r1, c2, c2const, false);
@@ -1834,11 +1884,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             ldst->oi = oi;
             ldst->addrlo_reg = addr_reg;
 
-            /* We are expecting a_bits to max out at 7, much lower than TMLL. */
             tcg_debug_assert(a_mask <= 0xffff);
             tcg_out_insn(s, RI, TMLL, addr_reg, a_mask);
 
-            tcg_out16(s, RI_BRC | (7 << 4)); /* CC in {1,2,3} */
+            tcg_out16(s, RI_BRC | (S390_TM_NE << 4));
             ldst->label_ptr[0] = s->code_ptr++;
         }
 
@@ -1919,7 +1968,7 @@ static void tcg_out_qemu_ldst_i128(TCGContext *s, TCGReg datalo, TCGReg datahi,
             l2 = gen_new_label();
 
             tcg_out_insn(s, RI, TMLL, addr_reg, 15);
-            tgen_branch(s, 7, l1); /* CC in {1,2,3} */
+            tgen_branch(s, S390_TM_NE, l1);
         }
 
         tcg_debug_assert(!need_bswap);
-- 
2.34.1


