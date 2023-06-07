Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142307264E2
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:41:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vHR-0001WA-H4; Wed, 07 Jun 2023 11:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHP-0001VX-Ln
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:40:59 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6vHN-0001zP-Tm
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:40:59 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-38dec65ab50so6512511b6e.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686152457; x=1688744457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7KdnjcOJ+qNxqu7A3MMGtBdXHktohSTiwAh5//+RHTU=;
 b=SDPmjk2LkJAeZsCwZKZw6OHOOLw0aPJkleq+0CWt3LsD1/B5l4FNACgP9BfHTPaLO6
 TD/G2n7Vn27Em7VsduwP/zOXpEYiVLAo1CNmjWcRHMOQfZzdbgHYEgjy+dj3zJWgNsLd
 UCd/GgNgih/8nCSfMydqb2KKKt1iEF2zRT9OFUyFfRrS2Uy+xiA+H40EYIDOCFrTgE6k
 cyoVTQ10HIW/l9n2sRWCGTKx1InHa5OEsuQUHGBB7+4wLKagvJuZLHDAeuiHYBqqdIyH
 +ip3A6FI5PRzcsKKTf8cIaTWVNdt+PCuv+HSK0XJLbhMR5BqBjUJkbjHpfbRUUJsQp/+
 jpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686152457; x=1688744457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7KdnjcOJ+qNxqu7A3MMGtBdXHktohSTiwAh5//+RHTU=;
 b=e1MtVo5Atma5AbkItsbc4g9kLbGy/PxImEtPlW0qE5H6MRmAsHg/jiYqZa2eGO/lfg
 oXqsHAtdcvmbUPiBbP7Wt9IV6KNB1BqSRsE21M/BHUv1Ie5Sl2ZrWbyTECrsc/P0+vxM
 zvsclArv5ziSEVgJz4lQ960om/pU/iutHAo1yEdx/Ow7zC/PIPEO7OsPG1/TrDnZ7Nj2
 m5+Hl1Q86hT0n4p9s7nqF2y6JVjTHeYvw2iDu1GQ2Ry6s/2YiZyUAdtp0GKVS5QP83z0
 7ZUbBSSd/wHkdcb91k1XvreltjwcOqT3J5+utURWLuDUZEXQ0Z0Gk/NaaCqiyzFZ2lbu
 1d9Q==
X-Gm-Message-State: AC+VfDxZMmI7/h+u5xxkf/eY9W0vIyBohL6dpM7jgqIGxAxWR1cGpwrx
 KI+ldzjI5J3qqrBfeDh4NlwcNTyceYxHdrHQblE=
X-Google-Smtp-Source: ACHHUZ5M5J9nUIV8Ybjk7Y1xqbP1fPkZijzIwPL6nLCFfs8uxasFh+J4ByNUTSfS8zGeE1zGq3F5qw==
X-Received: by 2002:aca:2817:0:b0:398:45bf:6e65 with SMTP id
 23-20020aca2817000000b0039845bf6e65mr5884378oix.9.1686152456840; 
 Wed, 07 Jun 2023 08:40:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:f25d:ffb3:64e4:8ded])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a17090a420b00b002591b957641sm1518066pjg.41.2023.06.07.08.40.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 08:40:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/5] tcg/tci: Adjust passing of MemOpIdx
Date: Wed,  7 Jun 2023 08:40:50 -0700
Message-Id: <20230607154054.625513-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607154054.625513-1-richard.henderson@linaro.org>
References: <20230607154054.625513-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22d.google.com
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

Since adding MO_ATOM_MASK, the maximum MemOpIdx requires 15 bits,
which overflows the 12 bit field allocated for TCI memory ops.
Expand the field to 16 bits for 2-operand memory ops, and place
the value in TCG_REG_TMP for 3-operand memory ops (same as we
already do for 4-operand memory ops).

Cures a debug assert for aarch64, with FEAT_LSE2 enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tci.c                | 30 +++++++++++++-----------------
 tcg/tci/tcg-target.c.inc | 21 ++++-----------------
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/tcg/tci.c b/tcg/tci.c
index 813572ff39..4640902c88 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -106,7 +106,7 @@ static void tci_args_rrm(uint32_t insn, TCGReg *r0,
 {
     *r0 = extract32(insn, 8, 4);
     *r1 = extract32(insn, 12, 4);
-    *m2 = extract32(insn, 20, 12);
+    *m2 = extract32(insn, 16, 16);
 }
 
 static void tci_args_rrr(uint32_t insn, TCGReg *r0, TCGReg *r1, TCGReg *r2)
@@ -141,15 +141,6 @@ static void tci_args_rrrc(uint32_t insn,
     *c3 = extract32(insn, 20, 4);
 }
 
-static void tci_args_rrrm(uint32_t insn,
-                          TCGReg *r0, TCGReg *r1, TCGReg *r2, MemOpIdx *m3)
-{
-    *r0 = extract32(insn, 8, 4);
-    *r1 = extract32(insn, 12, 4);
-    *r2 = extract32(insn, 16, 4);
-    *m3 = extract32(insn, 20, 12);
-}
-
 static void tci_args_rrrbb(uint32_t insn, TCGReg *r0, TCGReg *r1,
                            TCGReg *r2, uint8_t *i3, uint8_t *i4)
 {
@@ -929,8 +920,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
             } else {
-                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
                 taddr = tci_uint64(regs[r2], regs[r1]);
+                oi = regs[r3];
             }
         do_ld_i32:
             regs[r0] = tci_qemu_ld(env, taddr, oi, tb_ptr);
@@ -941,8 +933,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = (uint32_t)regs[r1];
             } else {
-                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
                 taddr = (uint32_t)regs[r2];
+                oi = regs[r3];
             }
             goto do_ld_i64;
         case INDEX_op_qemu_ld_a64_i64:
@@ -972,8 +965,9 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tci_args_rrm(insn, &r0, &r1, &oi);
                 taddr = regs[r1];
             } else {
-                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
                 taddr = tci_uint64(regs[r2], regs[r1]);
+                oi = regs[r3];
             }
         do_st_i32:
             tci_qemu_st(env, taddr, regs[r0], oi, tb_ptr);
@@ -985,9 +979,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
                 tmp64 = regs[r0];
                 taddr = (uint32_t)regs[r1];
             } else {
-                tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
+                tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
                 tmp64 = tci_uint64(regs[r1], regs[r0]);
                 taddr = (uint32_t)regs[r2];
+                oi = regs[r3];
             }
             goto do_st_i64;
         case INDEX_op_qemu_st_a64_i64:
@@ -1293,9 +1288,10 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
                                op_name, str_r(r0), str_r(r1), oi);
             break;
         case 3:
-            tci_args_rrrm(insn, &r0, &r1, &r2, &oi);
-            info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %x",
-                               op_name, str_r(r0), str_r(r1), str_r(r2), oi);
+            tci_args_rrrr(insn, &r0, &r1, &r2, &r3);
+            info->fprintf_func(info->stream, "%-12s  %s, %s, %s, %s",
+                               op_name, str_r(r0), str_r(r1),
+                               str_r(r2), str_r(r3));
             break;
         case 4:
             tci_args_rrrrr(insn, &r0, &r1, &r2, &r3, &r4);
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index c9516a5e8b..5b456e1277 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -331,11 +331,11 @@ static void tcg_out_op_rrm(TCGContext *s, TCGOpcode op,
 {
     tcg_insn_unit insn = 0;
 
-    tcg_debug_assert(m2 == extract32(m2, 0, 12));
+    tcg_debug_assert(m2 == extract32(m2, 0, 16));
     insn = deposit32(insn, 0, 8, op);
     insn = deposit32(insn, 8, 4, r0);
     insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 20, 12, m2);
+    insn = deposit32(insn, 16, 16, m2);
     tcg_out32(s, insn);
 }
 
@@ -392,20 +392,6 @@ static void tcg_out_op_rrrc(TCGContext *s, TCGOpcode op,
     tcg_out32(s, insn);
 }
 
-static void tcg_out_op_rrrm(TCGContext *s, TCGOpcode op,
-                            TCGReg r0, TCGReg r1, TCGReg r2, TCGArg m3)
-{
-    tcg_insn_unit insn = 0;
-
-    tcg_debug_assert(m3 == extract32(m3, 0, 12));
-    insn = deposit32(insn, 0, 8, op);
-    insn = deposit32(insn, 8, 4, r0);
-    insn = deposit32(insn, 12, 4, r1);
-    insn = deposit32(insn, 16, 4, r2);
-    insn = deposit32(insn, 20, 12, m3);
-    tcg_out32(s, insn);
-}
-
 static void tcg_out_op_rrrbb(TCGContext *s, TCGOpcode op, TCGReg r0,
                              TCGReg r1, TCGReg r2, uint8_t b3, uint8_t b4)
 {
@@ -860,7 +846,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
         if (TCG_TARGET_REG_BITS == 64) {
             tcg_out_op_rrm(s, opc, args[0], args[1], args[2]);
         } else {
-            tcg_out_op_rrrm(s, opc, args[0], args[1], args[2], args[3]);
+            tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP, args[4]);
+            tcg_out_op_rrrr(s, opc, args[0], args[1], args[2], TCG_REG_TMP);
         }
         break;
     case INDEX_op_qemu_ld_a64_i64:
-- 
2.34.1


