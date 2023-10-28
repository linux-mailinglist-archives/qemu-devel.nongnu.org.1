Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3D97DA91E
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:50:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpFv-0004pd-GR; Sat, 28 Oct 2023 15:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFc-0004jx-Hf
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:41 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFa-00047w-Ll
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:40 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5b92b852390so2371539a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522337; x=1699127137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSXidM1wbTbYTYZXzWmhm92Wt1k0ggjpkGjdIlsf5fU=;
 b=hnKYRhKWOEppTAZAYi2PL7rhViKVRcyohIXuyebD6uBogrdWlFAmD1xM4P5KCemMaS
 KhgVFnyuvtFRakzdUR56vvaY1GaF3iDShHuozeTDnAhP1OOxdySZc3RnNxp4D8VZ5m9V
 ueScD/057Zh/sNVLJiIPR9MMzyQfJ1vnZyPR1e3tQ4d0wmylliNKudoWG9npOwrC16G8
 t1TN75IQCwapPgyj5/IGOn9yolACH6UvcHucxCL7Wr74V+vxTfnqznlBVYWDqiAJRWzX
 G/PXR3/OlfFPIugA9sWBM+0MraFbTz1AehMeMUpSBG11mxxaRr33N0R1z3d+a9axcgTt
 F22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522337; x=1699127137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iSXidM1wbTbYTYZXzWmhm92Wt1k0ggjpkGjdIlsf5fU=;
 b=Hl/bY871fE4wapGay0uQRs3itSpj6bYsYXJsxdzcd7QCSBrkovdCjZeOAW58CO07QR
 d7bNkm5q1864JHAGxCl0/n9dVLkxkUlRUcN9QLswa0iZb2wmbZIgsBeStHfSTKCuzZXM
 Cxl+MdiDjN3RcF5Rh5VVqBTfJqkZdqAD7kqV5aeQTD2kw3TO8q2tATKVnDmCV2Do00CY
 GpkOA7pXDQqdA0IqQgMA1+3KEfzzTla7gmsBWiZQoouWqCeIzpNggH+UQFLgiFVyIUsm
 nFtTCM84J9+QRO/q0jjjsae3vzN3IY5vMU1+rZMfG3JTLWJhF0jWotj1f3os3KNjOR94
 q04Q==
X-Gm-Message-State: AOJu0YyWlLHG0QVF121lX8Md6tq4VqyBEoTN4iabboKBsX9SM20IAki1
 BkidQLNFJ0cjfwOs+uuSAzlLfY1WbgMdEqEQ+rM=
X-Google-Smtp-Source: AGHT+IFtccTC2tPesOD+F0Nh7PNBozrVGO4M3Gy1r3oZ7rQhqm/bn24jJV8n/EKe0WJpOsDNaHQLfQ==
X-Received: by 2002:a17:90a:8c07:b0:27d:b244:cd28 with SMTP id
 a7-20020a17090a8c0700b0027db244cd28mr4944847pjo.42.1698522337000; 
 Sat, 28 Oct 2023 12:45:37 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 14/35] tcg/i386: Support TCG_COND_TST{EQ,NE}
Date: Sat, 28 Oct 2023 12:45:01 -0700
Message-Id: <20231028194522.245170-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

Merge tcg_out_testi into tcg_out_cmp and adjust the two uses.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 83 ++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 7d5ed0d045..17b250f16f 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -505,6 +505,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_GEU] = JCC_JAE,
     [TCG_COND_LEU] = JCC_JBE,
     [TCG_COND_GTU] = JCC_JA,
+    [TCG_COND_TSTEQ] = JCC_JE,
+    [TCG_COND_TSTNE] = JCC_JNE,
 };
 
 #if TCG_TARGET_REG_BITS == 64
@@ -1422,15 +1424,35 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    if (const_arg2) {
-        if (arg2 == 0) {
-            /* test r, r */
-            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
+    if (is_tst_cond(cond)) {
+        if (!const_arg2) {
+            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
+        } else if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+            tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
+            tcg_out8(s, arg2);
+        } else if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
+            tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
+            tcg_out8(s, arg2 >> 8);
         } else {
-            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
+            if (rexw) {
+                if (arg2 == (uint32_t)arg2) {
+                    rexw = 0;
+                } else {
+                    tcg_debug_assert(arg2 == (int32_t)arg2);
+                }
+            }
+            tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, arg1);
+            tcg_out32(s, arg2);
         }
     } else {
-        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        if (!const_arg2) {
+            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        } else if (arg2 == 0) {
+            tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
+        } else {
+            tcg_debug_assert(!rexw || arg2 == (int32_t)arg2);
+            tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
+        }
     }
     return tcg_cond_to_jcc[cond];
 }
@@ -1449,18 +1471,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
 {
     TCGLabel *label_next = gen_new_label();
     TCGLabel *label_this = arg_label(args[5]);
+    TCGCond cond = args[4];
 
-    switch(args[4]) {
+    switch (cond) {
     case TCG_COND_EQ:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
-                       label_next, 1);
-        tcg_out_brcond(s, 0, TCG_COND_EQ, args[1], args[3], const_args[3],
+    case TCG_COND_TSTEQ:
+        tcg_out_brcond(s, 0, tcg_invert_cond(cond),
+                       args[0], args[2], const_args[2], label_next, 1);
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_NE:
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[0], args[2], const_args[2],
+    case TCG_COND_TSTNE:
+        tcg_out_brcond(s, 0, cond, args[0], args[2], const_args[2],
                        label_this, small);
-        tcg_out_brcond(s, 0, TCG_COND_NE, args[1], args[3], const_args[3],
+        tcg_out_brcond(s, 0, cond, args[1], args[3], const_args[3],
                        label_this, small);
         break;
     case TCG_COND_LT:
@@ -1797,23 +1822,6 @@ static void tcg_out_nopn(TCGContext *s, int n)
     tcg_out8(s, 0x90);
 }
 
-/* Test register R vs immediate bits I, setting Z flag for EQ/NE. */
-static void __attribute__((unused))
-tcg_out_testi(TCGContext *s, TCGReg r, uint32_t i)
-{
-    /*
-     * This is used for testing alignment, so we can usually use testb.
-     * For i686, we have to use testl for %esi/%edi.
-     */
-    if (i <= 0xff && (TCG_TARGET_REG_BITS == 64 || r < 4)) {
-        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, r);
-        tcg_out8(s, i);
-    } else {
-        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_TESTi, r);
-        tcg_out32(s, i);
-    }
-}
-
 typedef struct {
     TCGReg base;
     int index;
@@ -2074,16 +2082,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_L0, TCG_REG_L0,
                    offsetof(CPUTLBEntry, addend));
     } else if (a_mask) {
-        ldst = new_ldst_label(s);
+        int jcc;
 
+        ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addrlo;
         ldst->addrhi_reg = addrhi;
 
-        tcg_out_testi(s, addrlo, a_mask);
         /* jne slow_path */
-        tcg_out_opc(s, OPC_JCC_long + JCC_JNE, 0, 0, 0);
+        jcc = tcg_out_cmp(s, TCG_COND_TSTNE, addrlo, a_mask, true, false);
+        tcg_out_opc(s, OPC_JCC_long + jcc, 0, 0, 0);
         ldst->label_ptr[0] = s->code_ptr;
         s->code_ptr += 4;
     }
@@ -2229,9 +2238,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         } else {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
+            int jcc;
 
-            tcg_out_testi(s, h.base, 15);
-            tcg_out_jxx(s, JCC_JNE, l1, true);
+            jcc = tcg_out_cmp(s, TCG_COND_TSTNE, h.base, 15, true, false);
+            tcg_out_jxx(s, jcc, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_VxWx + h.seg,
                                          TCG_TMP_VEC, 0,
@@ -2357,9 +2367,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
         } else {
             TCGLabel *l1 = gen_new_label();
             TCGLabel *l2 = gen_new_label();
+            int jcc;
 
-            tcg_out_testi(s, h.base, 15);
-            tcg_out_jxx(s, JCC_JNE, l1, true);
+            jcc = tcg_out_cmp(s, TCG_COND_TSTNE, h.base, 15, true, false);
+            tcg_out_jxx(s, jcc, l1, true);
 
             tcg_out_vex_modrm_sib_offset(s, OPC_MOVDQA_WxVx + h.seg,
                                          TCG_TMP_VEC, 0,
-- 
2.34.1


