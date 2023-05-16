Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D9F705833
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0f6-00042N-V4; Tue, 16 May 2023 15:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cU-0000iN-NT
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:03 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cO-0003qG-MD
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:46:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so8239521b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266355; x=1686858355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8mhdjpDzRobguZAE7O6O+FOFP4jRA9PZjO71HHlvs0=;
 b=fMrHdoTloprN/u9EVdHAZvckWKQrDAabuZt1NjrBqaPjJhKznMLclXPVz+njhTG6q5
 hmsi9uYCtMTDZcVywYFVo7ZtQRJ5o2RABrf3PXXFfvJEPZwmyWScQPoXBhJIbdTcKIC0
 Igoddwd+g0QD7/iHxYG9zZCIvuG7h8mHOpRuHUoqSoJ2fWqs1J+Nh4SIpWA0drFLOB0D
 Tq5y6nh7hm880ndMWWtA2/R75vfYIrJNf6IPoi47gRP8HjWHqrjJQz21hd/NS4EJE0Zi
 sR9HAT4Q8W2NGy7LcCAxMjAVVxse3/aIL9xe7VbZADtpD73n9U7a/67Bu6Z7P9TDvYQZ
 gyuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266355; x=1686858355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m8mhdjpDzRobguZAE7O6O+FOFP4jRA9PZjO71HHlvs0=;
 b=LxLDcwPwcjnuy8a1OYuN/YBCqVXfh+oE3oYEkQ2mo/mn5EhlMRrtH8gl7rxl//KgUG
 vVBI3APC4UK4DfqcrTZ2FOPbglv+UMYY09ZvEId39i9g/BBmJpPZPGq5np6sgs8KyZW9
 5vINNaiqiu0pgz8MTkBwdDxsvTDZENA1AEeXbPu8sC5+eZU9fGEqgLl0P1hvTuNSEwFV
 n5myRpUrkzh7xeRjamyE9aCrFhRRsIv5feYO8qmNRtgn+6gYtk+9xw2f9N9sk3PCG1K+
 VYxWBputexmXs3/lKspz2SdR29eXuhhRkJ5vUiEJ1gfrRvz6TfmHsWrE0VqxzcWEn9DH
 WLEQ==
X-Gm-Message-State: AC+VfDxJV4cwhVu4Ujuf5a1PPnOupvscw2QDLk87Q4SbGeXidScfzIBV
 XUxJ6x5NKLh/4C9KmW3AGGEN/hXbcjXsymYAkoU=
X-Google-Smtp-Source: ACHHUZ6dUShmosjJPrx3LosOe7YJZmL1/kKu5EOlWEpL03yJtlKhJa8pzVEY9bm1AaANSuT8C3ggsw==
X-Received: by 2002:a17:90a:d78f:b0:23f:962e:825d with SMTP id
 z15-20020a17090ad78f00b0023f962e825dmr45269329pju.1.1684266355022; 
 Tue, 16 May 2023 12:45:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
Subject: [PULL 78/80] tcg: Add page_bits and page_mask to TCGContext
Date: Tue, 16 May 2023 12:41:43 -0700
Message-Id: <20230516194145.1749305-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Disconnect guest page size from TCG compilation.
While this could be done via exec/target_page.h, we want to cache
the value across multiple memory access operations, so we might
as well initialize this early.

The changes within tcg/ are entirely mechanical:

    sed -i s/TARGET_PAGE_BITS/s->page_bits/g
    sed -i s/TARGET_PAGE_MASK/s->page_mask/g

Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h                |  5 +++++
 accel/tcg/translate-all.c        |  4 ++++
 tcg/aarch64/tcg-target.c.inc     |  6 +++---
 tcg/arm/tcg-target.c.inc         | 10 +++++-----
 tcg/i386/tcg-target.c.inc        |  6 +++---
 tcg/loongarch64/tcg-target.c.inc |  4 ++--
 tcg/mips/tcg-target.c.inc        |  6 +++---
 tcg/ppc/tcg-target.c.inc         | 14 +++++++-------
 tcg/riscv/tcg-target.c.inc       |  4 ++--
 tcg/s390x/tcg-target.c.inc       |  4 ++--
 tcg/sparc64/tcg-target.c.inc     |  4 ++--
 11 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index b9748fd0c5..db57c4d492 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -560,6 +560,11 @@ struct TCGContext {
     int nb_ops;
     TCGType addr_type;            /* TCG_TYPE_I32 or TCG_TYPE_I64 */
 
+#ifdef CONFIG_SOFTMMU
+    int page_mask;
+    uint8_t page_bits;
+#endif
+
     TCGRegSet reserved_regs;
     intptr_t current_frame_offset;
     intptr_t frame_start;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 99a9d0e34f..ca306f67da 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -357,6 +357,10 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb_set_page_addr1(tb, -1);
     tcg_ctx->gen_tb = tb;
     tcg_ctx->addr_type = TCG_TYPE_TL;
+#ifdef CONFIG_SOFTMMU
+    tcg_ctx->page_bits = TARGET_PAGE_BITS;
+    tcg_ctx->page_mask = TARGET_PAGE_MASK;
+#endif
 
  tb_overflow:
 
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 41838f8170..8b7c679349 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1685,7 +1685,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->oi = oi;
     ldst->addrlo_reg = addr_reg;
 
-    mask_type = (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32
+    mask_type = (s->page_bits + CPU_TLB_DYN_MAX_BITS > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
     /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
@@ -1699,7 +1699,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* Extract the TLB index from the address into X0.  */
     tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
                  TCG_REG_X0, TCG_REG_X0, addr_reg,
-                 TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                 s->page_bits - CPU_TLB_ENTRY_BITS);
 
     /* Add the tlb_table pointer, creating the CPUTLBEntry address into X1.  */
     tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
@@ -1723,7 +1723,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                      TCG_REG_X3, addr_reg, s_mask - a_mask);
         x3 = TCG_REG_X3;
     }
-    compare_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
+    compare_mask = (uint64_t)s->page_mask | a_mask;
 
     /* Store the page mask part of the address into X3.  */
     tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_X3, x3, compare_mask);
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 3c38e868e2..20cc1cc477 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1424,7 +1424,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     /* Extract the tlb index from the address into R0.  */
     tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
-                    SHIFT_IMM_LSR(TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS));
+                    SHIFT_IMM_LSR(s->page_bits - CPU_TLB_ENTRY_BITS));
 
     /*
      * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
@@ -1468,8 +1468,8 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t_addr,
                         addrlo, s_mask - a_mask);
     }
-    if (use_armv7_instructions && TARGET_PAGE_BITS <= 16) {
-        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(TARGET_PAGE_MASK | a_mask));
+    if (use_armv7_instructions && s->page_bits <= 16) {
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(s->page_mask | a_mask));
         tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
                         t_addr, TCG_REG_TMP, 0);
         tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R2, TCG_REG_TMP, 0);
@@ -1479,10 +1479,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
         }
         tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
-                        SHIFT_IMM_LSR(TARGET_PAGE_BITS));
+                        SHIFT_IMM_LSR(s->page_bits));
         tcg_out_dat_reg(s, (a_mask ? COND_EQ : COND_AL), ARITH_CMP,
                         0, TCG_REG_R2, TCG_REG_TMP,
-                        SHIFT_IMM_LSL(TARGET_PAGE_BITS));
+                        SHIFT_IMM_LSL(s->page_bits));
     }
 
     if (s->addr_type != TCG_TYPE_I32) {
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index e173853dc4..d766e8652c 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -1979,7 +1979,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         trexw = (ttype == TCG_TYPE_I32 ? 0 : P_REXW);
         if (TCG_TYPE_PTR == TCG_TYPE_I64) {
             hrexw = P_REXW;
-            if (TARGET_PAGE_BITS + CPU_TLB_DYN_MAX_BITS > 32) {
+            if (s->page_bits + CPU_TLB_DYN_MAX_BITS > 32) {
                 tlbtype = TCG_TYPE_I64;
                 tlbrexw = P_REXW;
             }
@@ -1988,7 +1988,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     tcg_out_mov(s, tlbtype, TCG_REG_L0, addrlo);
     tcg_out_shifti(s, SHIFT_SHR + tlbrexw, TCG_REG_L0,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                   s->page_bits - CPU_TLB_ENTRY_BITS);
 
     tcg_out_modrm_offset(s, OPC_AND_GvEv + trexw, TCG_REG_L0, TCG_AREG0,
                          TLB_MASK_TABLE_OFS(mem_index) +
@@ -2009,7 +2009,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_modrm_offset(s, OPC_LEA + trexw, TCG_REG_L1,
                              addrlo, s_mask - a_mask);
     }
-    tlb_mask = TARGET_PAGE_MASK | a_mask;
+    tlb_mask = s->page_mask | a_mask;
     tgen_arithi(s, ARITH_AND + trexw, TCG_REG_L1, tlb_mask, 0);
 
     /* cmp 0(TCG_REG_L0), TCG_REG_L1 */
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index e5f98845a0..0bae922982 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -870,7 +870,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
     tcg_out_opc_srli_d(s, TCG_REG_TMP2, addr_reg,
-                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                    s->page_bits - CPU_TLB_ENTRY_BITS);
     tcg_out_opc_and(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
     tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
@@ -894,7 +894,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_mov(s, addr_type, TCG_REG_TMP1, addr_reg);
     }
     tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
-                          a_bits, TARGET_PAGE_BITS - 1);
+                          a_bits, s->page_bits - 1);
 
     /* Compare masked address with the TLB entry.  */
     ldst->label_ptr[0] = s->code_ptr;
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 209d95992e..ef146b193c 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -1189,10 +1189,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* Extract the TLB index from the address into TMP3.  */
     if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
         tcg_out_opc_sa(s, OPC_SRL, TCG_TMP3, addrlo,
-                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                       s->page_bits - CPU_TLB_ENTRY_BITS);
     } else {
         tcg_out_dsrl(s, TCG_TMP3, addrlo,
-                     TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                     s->page_bits - CPU_TLB_ENTRY_BITS);
     }
     tcg_out_opc_reg(s, OPC_AND, TCG_TMP3, TCG_TMP3, TCG_TMP0);
 
@@ -1214,7 +1214,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * For unaligned accesses, compare against the end of the access to
      * verify that it does not cross a page boundary.
      */
-    tcg_out_movi(s, addr_type, TCG_TMP1, TARGET_PAGE_MASK | a_mask);
+    tcg_out_movi(s, addr_type, TCG_TMP1, s->page_mask | a_mask);
     if (a_mask < s_mask) {
         if (TCG_TARGET_REG_BITS == 32 || addr_type == TCG_TYPE_I32) {
             tcg_out_opc_imm(s, OPC_ADDIU, TCG_TMP2, addrlo, s_mask - a_mask);
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index f74218b13f..7e2c0b26ab 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2090,10 +2090,10 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     /* Extract the page index, shifted into place for tlb index.  */
     if (TCG_TARGET_REG_BITS == 32) {
         tcg_out_shri32(s, TCG_REG_R0, addrlo,
-                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                       s->page_bits - CPU_TLB_ENTRY_BITS);
     } else {
         tcg_out_shri64(s, TCG_REG_R0, addrlo,
-                       TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                       s->page_bits - CPU_TLB_ENTRY_BITS);
     }
     tcg_out32(s, AND | SAB(TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_R0));
 
@@ -2132,7 +2132,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
             a_bits = s_bits;
         }
         tcg_out_rlw(s, RLWINM, TCG_REG_R0, addrlo, 0,
-                    (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
+                    (32 - a_bits) & 31, 31 - s->page_bits);
     } else {
         TCGReg t = addrlo;
 
@@ -2153,13 +2153,13 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* Mask the address for the requested alignment.  */
         if (TARGET_LONG_BITS == 32) {
             tcg_out_rlw(s, RLWINM, TCG_REG_R0, t, 0,
-                        (32 - a_bits) & 31, 31 - TARGET_PAGE_BITS);
+                        (32 - a_bits) & 31, 31 - s->page_bits);
         } else if (a_bits == 0) {
-            tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - TARGET_PAGE_BITS);
+            tcg_out_rld(s, RLDICR, TCG_REG_R0, t, 0, 63 - s->page_bits);
         } else {
             tcg_out_rld(s, RLDICL, TCG_REG_R0, t,
-                        64 - TARGET_PAGE_BITS, TARGET_PAGE_BITS - a_bits);
-            tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, TARGET_PAGE_BITS, 0);
+                        64 - s->page_bits, s->page_bits - a_bits);
+            tcg_out_rld(s, RLDICL, TCG_REG_R0, TCG_REG_R0, s->page_bits, 0);
         }
     }
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index de61edb5df..ff6334980f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -937,7 +937,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
     tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addr_reg,
-                    TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                    s->page_bits - CPU_TLB_ENTRY_BITS);
     tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
     tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
@@ -952,7 +952,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
         tcg_out_opc_imm(s, TARGET_LONG_BITS == 32 ? OPC_ADDIW : OPC_ADDI,
                         addr_adj, addr_reg, s_mask - a_mask);
     }
-    compare_mask = TARGET_PAGE_MASK | a_mask;
+    compare_mask = s->page_mask | a_mask;
     if (compare_mask == sextreg(compare_mask, 0, 12)) {
         tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
     } else {
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 7606073c81..503126cd66 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -1768,7 +1768,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrlo_reg = addr_reg;
 
     tcg_out_sh64(s, RSY_SRLG, TCG_TMP0, addr_reg, TCG_REG_NONE,
-                 TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS);
+                 s->page_bits - CPU_TLB_ENTRY_BITS);
 
     QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
     QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -(1 << 19));
@@ -1781,7 +1781,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * cross pages using the address of the last byte of the access.
      */
     a_off = (a_mask >= s_mask ? 0 : s_mask - a_mask);
-    tlb_mask = (uint64_t)TARGET_PAGE_MASK | a_mask;
+    tlb_mask = (uint64_t)s->page_mask | a_mask;
     if (a_off == 0) {
         tgen_andi_risbg(s, TCG_REG_R0, addr_reg, tlb_mask);
     } else {
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 6e6c26d470..d2d0f604c2 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1056,7 +1056,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
 
     /* Extract the page index, shifted into place for tlb index.  */
     tcg_out_arithi(s, TCG_REG_T1, addr_reg,
-                   TARGET_PAGE_BITS - CPU_TLB_ENTRY_BITS, SHIFT_SRL);
+                   s->page_bits - CPU_TLB_ENTRY_BITS, SHIFT_SRL);
     tcg_out_arith(s, TCG_REG_T1, TCG_REG_T1, TCG_REG_T2, ARITH_AND);
 
     /* Add the tlb_table pointer, creating the CPUTLBEntry address into R2.  */
@@ -1068,7 +1068,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->base = TCG_REG_T1;
 
     /* Mask out the page offset, except for the required alignment. */
-    compare_mask = TARGET_PAGE_MASK | a_mask;
+    compare_mask = s->page_mask | a_mask;
     if (check_fit_tl(compare_mask, 13)) {
         tcg_out_arithi(s, TCG_REG_T3, addr_reg, compare_mask, ARITH_AND);
     } else {
-- 
2.34.1


