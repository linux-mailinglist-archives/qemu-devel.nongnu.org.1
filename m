Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1E371134E
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FQE-0008MU-IZ; Thu, 25 May 2023 14:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQC-0008LO-TQ
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:44 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FQB-0005rh-5y
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:10:44 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae54b623c2so16879635ad.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685038241; x=1687630241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=12R31Su0c3PpVt2JGtk5+3C3Tp4oGsKrL1eCkXeZ4Bk=;
 b=uPUDEvA7F6qt9DC3vKmZD9ITUUai/2JjR+uJ/jdBQSGPNpZi599B1p5+rVsBRNTLVo
 ySvXVqKTSYxs/ci54V0hx/IHisv9OsBigfIH/O0kUmcIkIaGWKRgg6XW7XklMSYwynNO
 umk0Usll5g01EtPplqmUVLr+AuFp9t2Uh2iAMkqgU6tEvJTAEdUQn4hnXOOf5my0dSQq
 u+ntzW2iuC2NSQBOkGGxaeys8wgFx+oDf5x0pPT0t/8X/m/9YbJIJS/kM0RJI30X/0bB
 AJC5i4BzSiYAcn1CFp1XfO7yGcuPOdhlB1pNjwxEjIzo66lARowzMFoucdFOLCTZEj4K
 a2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685038241; x=1687630241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=12R31Su0c3PpVt2JGtk5+3C3Tp4oGsKrL1eCkXeZ4Bk=;
 b=W7nRUs4BlJFl7Dc2+Y+vqMeFWzE7ipq7xAhHtNDXxI2TBxm7jWoV+Zkyyq1PDqQ6m4
 O8DaILnvY07cwGbXzSIyLuU1SXktCkCmu+/Pgg5w4JQdtql9A+waroicmxQ6IP3PbuUT
 ZWm9EN4JxAqpL0Nw5ZAi+FWll18Yf7IRYDXUJLMIERS4/ANjOu/QOVDyhcwJikpdmbjx
 ZTUTmppI9jJKPOmDpgF6UnzhD8oi2FpBfHxiJHrj3nyn/INBgA6OyZ6bbb6wgg/bFoCR
 iMy9nmjbdS2TROT2vH3CRHTLF4EKs0cR0SRpxzIaTtEZpz65xobYw+z95Slj0gIBq2BR
 NTfw==
X-Gm-Message-State: AC+VfDwQmNe8NGSqEOCw9ek0qMOO3enqzSrjhqL3Vmv4f2zCIsFIpgFt
 RDo7vIrFJ4O1ZXc2k9NbNYsrFQCuW5NCLUbHxK4=
X-Google-Smtp-Source: ACHHUZ6jPUv9SCGKInzDRmOhVvVR3EVJEDBC4uh1ehTbRLTqb1RCUG85lSc2bCaGPd51lxcE9z24sg==
X-Received: by 2002:a17:902:714c:b0:1aa:ee36:40a5 with SMTP id
 u12-20020a170902714c00b001aaee3640a5mr2296681plm.34.1685038241046; 
 Thu, 25 May 2023 11:10:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 m18-20020a170902db1200b001aae64e9b36sm1710243plx.114.2023.05.25.11.10.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 11:10:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] tcg/mips: Create and use TCG_REG_TB
Date: Thu, 25 May 2023 11:10:17 -0700
Message-Id: <20230525181036.1559435-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525181036.1559435-1-richard.henderson@linaro.org>
References: <20230525181036.1559435-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

This vastly reduces the size of code generated for 64-bit addresses.
The code for exit_tb, for instance, where we load a (tagged) pointer
to the current TB, goes from

0x400aa9725c:  li       v0,64
0x400aa97260:  dsll     v0,v0,0x10
0x400aa97264:  ori      v0,v0,0xaa9
0x400aa97268:  dsll     v0,v0,0x10
0x400aa9726c:  j        0x400aa9703c
0x400aa97270:  ori      v0,v0,0x7083

to

0x400aa97240:  j        0x400aa97040
0x400aa97244:  daddiu   v0,s6,-189

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target.c.inc | 69 +++++++++++++++++++++++++++++++++------
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index ccb3a1cd9a..6f03b44ac0 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -88,6 +88,11 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #ifndef CONFIG_SOFTMMU
 #define TCG_GUEST_BASE_REG TCG_REG_S7
 #endif
+#if TCG_TARGET_REG_BITS == 64
+#define TCG_REG_TB         TCG_REG_S6
+#else
+#define TCG_REG_TB         (qemu_build_not_reached(), TCG_REG_ZERO)
+#endif
 
 /* check if we really need so many registers :P */
 static const int tcg_target_reg_alloc_order[] = {
@@ -1547,27 +1552,61 @@ static void tcg_out_clz(TCGContext *s, MIPSInsn opcv2, MIPSInsn opcv6,
 
 static void tcg_out_exit_tb(TCGContext *s, uintptr_t a0)
 {
-    TCGReg b0 = TCG_REG_ZERO;
+    TCGReg base = TCG_REG_ZERO;
+    int16_t lo = 0;
 
-    if (a0 & ~0xffff) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_V0, a0 & ~0xffff);
-        b0 = TCG_REG_V0;
+    if (a0) {
+        intptr_t ofs;
+        if (TCG_TARGET_REG_BITS == 64) {
+            ofs = tcg_tbrel_diff(s, (void *)a0);
+            lo = ofs;
+            if (ofs == lo) {
+                base = TCG_REG_TB;
+            } else {
+                base = TCG_REG_V0;
+                tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
+                tcg_out_opc_reg(s, ALIAS_PADD, base, base, TCG_REG_TB);
+            }
+        } else {
+            ofs = a0;
+            lo = ofs;
+            base = TCG_REG_V0;
+            tcg_out_movi(s, TCG_TYPE_PTR, base, ofs - lo);
+        }
     }
     if (!tcg_out_opc_jmp(s, OPC_J, tb_ret_addr)) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_TMP0, (uintptr_t)tb_ret_addr);
         tcg_out_opc_reg(s, OPC_JR, 0, TCG_TMP0, 0);
     }
-    tcg_out_opc_imm(s, OPC_ORI, TCG_REG_V0, b0, a0 & 0xffff);
+    /* delay slot */
+    tcg_out_opc_imm(s, ALIAS_PADDI, TCG_REG_V0, base, lo);
 }
 
 static void tcg_out_goto_tb(TCGContext *s, int which)
 {
+    intptr_t ofs = get_jmp_target_addr(s, which);
+    TCGReg base, dest;
+
     /* indirect jump method */
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_TMP0, TCG_REG_ZERO,
-               get_jmp_target_addr(s, which));
-    tcg_out_opc_reg(s, OPC_JR, 0, TCG_TMP0, 0);
+    if (TCG_TARGET_REG_BITS == 64) {
+        dest = TCG_REG_TB;
+        base = TCG_REG_TB;
+        ofs = tcg_tbrel_diff(s, (void *)ofs);
+    } else {
+        dest = TCG_TMP0;
+        base = TCG_REG_ZERO;
+    }
+    tcg_out_ld(s, TCG_TYPE_PTR, dest, base, ofs);
+    tcg_out_opc_reg(s, OPC_JR, 0, dest, 0);
+    /* delay slot */
     tcg_out_nop(s);
+
     set_jmp_reset_offset(s, which);
+    if (TCG_TARGET_REG_BITS == 64) {
+        /* For the unlinked case, need to reset TCG_REG_TB. */
+        tcg_out_ldst(s, ALIAS_PADDI, TCG_REG_TB, TCG_REG_TB,
+                     -tcg_current_code_size(s));
+    }
 }
 
 void tb_target_set_jmp_target(const TranslationBlock *tb, int n,
@@ -1598,7 +1637,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     case INDEX_op_goto_ptr:
         /* jmp to the given host address (could be epilogue) */
         tcg_out_opc_reg(s, OPC_JR, 0, a0, 0);
-        tcg_out_nop(s);
+        if (TCG_TARGET_REG_BITS == 64) {
+            tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, a0);
+        } else {
+            tcg_out_nop(s);
+        }
         break;
     case INDEX_op_br:
         tcg_out_brcond(s, TCG_COND_EQ, TCG_REG_ZERO, TCG_REG_ZERO,
@@ -2189,7 +2232,7 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_S3,
     TCG_REG_S4,
     TCG_REG_S5,
-    TCG_REG_S6,
+    TCG_REG_S6,       /* used for the tb base (TCG_REG_TB) */
     TCG_REG_S7,       /* used for guest_base */
     TCG_REG_S8,       /* used for the global env (TCG_AREG0) */
     TCG_REG_RA,       /* should be last for ABI compliance */
@@ -2317,6 +2360,9 @@ static void tcg_target_qemu_prologue(TCGContext *s)
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
 #endif
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_out_mov(s, TCG_TYPE_PTR, TCG_REG_TB, tcg_target_call_iarg_regs[1]);
+    }
 
     /* Call generated code */
     tcg_out_opc_reg(s, OPC_JR, 0, tcg_target_call_iarg_regs[1], 0);
@@ -2498,6 +2544,9 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_RA);   /* return address */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_SP);   /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_GP);   /* global pointer */
+    if (TCG_TARGET_REG_BITS == 64) {
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_TB); /* tc->tc_ptr */
+    }
 }
 
 typedef struct {
-- 
2.34.1


