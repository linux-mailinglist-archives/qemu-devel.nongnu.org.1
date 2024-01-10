Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B01FB82A442
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 23:52:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNhLM-0007Op-Lr; Wed, 10 Jan 2024 17:46:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhL2-0006di-0J
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:22 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rNhKy-0003KF-JR
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 17:46:19 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-429bb6677ebso3937601cf.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 14:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704926775; x=1705531575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Od/xSXS8NstAz+sWZVmhj5MEuIknHRPAQGdZXQ5yceo=;
 b=Brt5TXx2g5QiDtF5lhWzY1RmULX7CDr0M++oKikO2u7MhYlPm4Cw3QOLB4vvSjgFLI
 kSfLr7ZE3eHsTO6LBxxEEOR1FNfIKu6X2J74ITZJS30CODoaHg+7f3WJaI91BzFS8MiC
 IrjavhGN1LPxctQuKcbNKUVqwXeRUPFhKVTDbIY3QbjJoubFmK8vfwnFLK7HWWQaKkg4
 82yqdC6VW89xRg1tyjkM6uS6QpBCVDiugpIWBcPuEl4xjJNyBHsBT31jFF+wX7YbVP5Q
 bdI8suD+GxB9I43CZe9lgj8D7lTTrMaPRCPFjQT52vOuWoBwY0VxmEqB4TYf7Wmm8y6X
 lQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704926775; x=1705531575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Od/xSXS8NstAz+sWZVmhj5MEuIknHRPAQGdZXQ5yceo=;
 b=nt/kvCTQ8kiUxuEcAL8usRJ6IeB+AsHjl154AY+i2UDipIMdmo7Fh5JBvlP2RldJDo
 DLLOvf1fcdW7+NeSdjQWx9k63T0g/P65lhtB+9RkceFoe0iPJJGNU5gwdDxEpa9Y2lUj
 ITFa8pkgWNZIKhpQsZx30FV4uQH66t/PsmbSH6ZGuN3+yZP7MbQpnOoDZIxAr5lUYCFf
 g6RqU4G4nOjbJricgK+DbWP4dkf5uj6N12U0/ZcnkKlWYDl59Iz3pJUyQgO+ebLSA9h7
 SA1hoFERiaW1zevngwzWYSy/y4JtdWEvgXpiTfvgaUV1fwNwPqF/tahJsLw+DF0lHjEP
 HJ7A==
X-Gm-Message-State: AOJu0Yyxc/zxi1/fncGDUNUpp8igzN6Nx6+2h2cD3baZuDeAXbEv04Lx
 Eg4iw5TM5F2Tj2K34OqYhu+/3CjIDOdLEEbatqeMoj4ICh7MnNEj
X-Google-Smtp-Source: AGHT+IEL4Lgwo/6EAQ8rWefp3ZCbaYjGri4CdDJo5Ghw7dToxVwodOVEVGm6DsAavAwencItxJutWw==
X-Received: by 2002:a05:622a:18f:b0:429:bc01:b101 with SMTP id
 s15-20020a05622a018f00b00429bc01b101mr239691qtw.25.1704926775421; 
 Wed, 10 Jan 2024 14:46:15 -0800 (PST)
Received: from stoup.. ([172.58.27.160]) by smtp.gmail.com with ESMTPSA id
 ks23-20020ac86217000000b0042987f6874bsm2092281qtb.92.2024.01.10.14.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jan 2024 14:46:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v3 24/38] tcg/i386: Support TCG_COND_TST{EQ,NE}
Date: Thu, 11 Jan 2024 09:43:54 +1100
Message-Id: <20240110224408.10444-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110224408.10444-1-richard.henderson@linaro.org>
References: <20240110224408.10444-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82e.google.com
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

Merge tcg_out_testi into tcg_out_cmp and adjust the two uses.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.h     |  2 +-
 tcg/i386/tcg-target.c.inc | 95 ++++++++++++++++++++++++---------------
 2 files changed, 60 insertions(+), 37 deletions(-)

diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 1dd917a680..a10d4e1fce 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -198,7 +198,7 @@ typedef enum {
 #define TCG_TARGET_HAS_qemu_ldst_i128 \
     (TCG_TARGET_REG_BITS == 64 && (cpuinfo & CPUINFO_ATOMIC_VMOVDQA))
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 /* We do not support older SSE systems, only beginning with AVX1.  */
 #define TCG_TARGET_HAS_v64              have_avx1
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 02718a02d8..f2414177bd 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -506,6 +506,8 @@ static const uint8_t tcg_cond_to_jcc[] = {
     [TCG_COND_GEU] = JCC_JAE,
     [TCG_COND_LEU] = JCC_JBE,
     [TCG_COND_GTU] = JCC_JA,
+    [TCG_COND_TSTEQ] = JCC_JE,
+    [TCG_COND_TSTNE] = JCC_JNE,
 };
 
 #if TCG_TARGET_REG_BITS == 64
@@ -1452,17 +1454,49 @@ static void tcg_out_jxx(TCGContext *s, int opc, TCGLabel *l, bool small)
 static int tcg_out_cmp(TCGContext *s, TCGCond cond, TCGArg arg1,
                        TCGArg arg2, int const_arg2, int rexw)
 {
-    if (const_arg2) {
-        if (arg2 == 0) {
-            /* test r, r */
+    int jz;
+
+    if (!is_tst_cond(cond)) {
+        if (!const_arg2) {
+            tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        } else if (arg2 == 0) {
             tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg1);
         } else {
+            tcg_debug_assert(!rexw || arg2 == (int32_t)arg2);
             tgen_arithi(s, ARITH_CMP + rexw, arg1, arg2, 0);
         }
-    } else {
-        tgen_arithr(s, ARITH_CMP + rexw, arg1, arg2);
+        return tcg_cond_to_jcc[cond];
     }
-    return tcg_cond_to_jcc[cond];
+
+    jz = tcg_cond_to_jcc[cond];
+
+    if (!const_arg2) {
+        tcg_out_modrm(s, OPC_TESTL + rexw, arg1, arg2);
+        return jz;
+    }
+
+    if (arg2 <= 0xff && (TCG_TARGET_REG_BITS == 64 || arg1 < 4)) {
+        tcg_out_modrm(s, OPC_GRP3_Eb | P_REXB_RM, EXT3_TESTi, arg1);
+        tcg_out8(s, arg2);
+        return jz;
+    }
+
+    if ((arg2 & ~0xff00) == 0 && arg1 < 4) {
+        tcg_out_modrm(s, OPC_GRP3_Eb, EXT3_TESTi, arg1 + 4);
+        tcg_out8(s, arg2 >> 8);
+        return jz;
+    }
+
+    if (rexw) {
+        if (arg2 == (uint32_t)arg2) {
+            rexw = 0;
+        } else {
+            tcg_debug_assert(arg2 == (int32_t)arg2);
+        }
+    }
+    tcg_out_modrm(s, OPC_GRP3_Ev + rexw, EXT3_TESTi, arg1);
+    tcg_out32(s, arg2);
+    return jz;
 }
 
 static void tcg_out_brcond(TCGContext *s, int rexw, TCGCond cond,
@@ -1479,18 +1513,21 @@ static void tcg_out_brcond2(TCGContext *s, const TCGArg *args,
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
@@ -1827,23 +1864,6 @@ static void tcg_out_nopn(TCGContext *s, int n)
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
@@ -2104,16 +2124,17 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
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
@@ -2259,9 +2280,10 @@ static void tcg_out_qemu_ld_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
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
@@ -2387,9 +2409,10 @@ static void tcg_out_qemu_st_direct(TCGContext *s, TCGReg datalo, TCGReg datahi,
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


