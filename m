Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3337B7034
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRM-0003NA-OK; Tue, 03 Oct 2023 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRI-0003Ed-HY
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRC-0001Mw-9n
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690fa0eea3cso952902b3a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355041; x=1696959841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rd+oQx79qkiulkB9vQFj7ZkEnre0KxNXGV6JWOJAY+0=;
 b=ftgp0+Xl7ZeWIyifIMoJtQjwIRbKnx2I1vc88lBVB1JoqoeSQ1nJGZpdRGGXk+41Ns
 83ANPNl6rJDzesno3TB6blTnH2hx6x7sy+xZahx2z7UsSib4WTq8J/g4HHwnJvaEnkRP
 gLTLCHYSGpHsu4SLT2bST2YppqVcD0mHy/WTaPyBaYZiCw3oPJziaOoKHnhEvZ71cnkH
 O8KCSm20yRSpLgCv+q1RNYY3XoPtU7coFjX8RenqMv5UDIuiX68CHrktHZYBQutESuiT
 JZ47neVs0wEy31MNPzYYAY4ev0+XIsM7ioJFaKsyvGGCTYpxtGJBEES0H11vVC5LSi3q
 lV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355041; x=1696959841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rd+oQx79qkiulkB9vQFj7ZkEnre0KxNXGV6JWOJAY+0=;
 b=g0KuQxNHRvo8IWCgGLqex6tZTlQs+dPg+wEI1Q5Jn5dQUQrGG4na3mzgOYqQMnrdSj
 MLVP+PGGcqhP8NV9xRGLlDybIL0zuUYEFoqnCX0SPfx0+/8YY0hnmxDDPn4clVSL9vQk
 QpmeQjnJQLWecGA3Nf935D2hq+KXbDsJxRqZ1N7ieCwLUSAyk+h5EGO6jCPuT71cJutR
 f80+86875QjrM/RANCqy/GzcQMq8uVq5KtQcr+uC9249j3qzZgAcM66fMUeCZGlxmqSx
 PPXVb6b1h8zuuFMrOX5qIpLw1cHRfbIIzg8WIVqXEhpQg/GuFmKzaoOfgN59Jou2TylC
 nZlg==
X-Gm-Message-State: AOJu0YypBbYYfm012SOEkQmxRWIf/m16xWzLSLgbsxCtgOXZnNE4RwOj
 aW5Cgs4Al2lAJjbD4Qq4IzbctI6+puOe2TK3owk=
X-Google-Smtp-Source: AGHT+IEZ9Nv6tbz8da7NY8yBosM1iX3tl6rBc1669CjZfAdxdO9aqr+6KJCpZ0DtxL1k1JS9OobdTw==
X-Received: by 2002:a05:6a20:3211:b0:14b:ee48:85b4 with SMTP id
 hl17-20020a056a20321100b0014bee4885b4mr131577pzc.60.1696355040658; 
 Tue, 03 Oct 2023 10:44:00 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/10] tcg/arm: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:49 -0700
Message-Id: <20231003174356.1602279-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
 tcg/arm/tcg-target.c.inc | 203 +++++++++++++++++++--------------------
 1 file changed, 97 insertions(+), 106 deletions(-)

diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index a2f60106af..550a06a1b9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -89,9 +89,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 
 #define TCG_REG_TMP  TCG_REG_R12
 #define TCG_VEC_TMP  TCG_REG_Q15
-#ifndef CONFIG_SOFTMMU
 #define TCG_REG_GUEST_BASE  TCG_REG_R11
-#endif
 
 typedef enum {
     COND_EQ = 0x0,
@@ -356,14 +354,8 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * r0-r3 will be overwritten when reading the tlb entry (softmmu only);
  * r14 will be overwritten by the BLNE branching to the slow path.
  */
-#ifdef CONFIG_SOFTMMU
 #define ALL_QLDST_REGS \
-    (ALL_GENERAL_REGS & ~((1 << TCG_REG_R0) | (1 << TCG_REG_R1) | \
-                          (1 << TCG_REG_R2) | (1 << TCG_REG_R3) | \
-                          (1 << TCG_REG_R14)))
-#else
-#define ALL_QLDST_REGS   (ALL_GENERAL_REGS & ~(1 << TCG_REG_R14))
-#endif
+    (ALL_GENERAL_REGS & ~((tcg_use_softmmu ? 0xf : 0) | (1 << TCG_REG_R14)))
 
 /*
  * ARM immediates for ALU instructions are made of an unsigned 8-bit
@@ -1387,113 +1379,115 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     MemOp opc = get_memop(oi);
     unsigned a_mask;
 
-#ifdef CONFIG_SOFTMMU
-    *h = (HostAddress){
-        .cond = COND_AL,
-        .base = addrlo,
-        .index = TCG_REG_R1,
-        .index_scratch = true,
-    };
-#else
-    *h = (HostAddress){
-        .cond = COND_AL,
-        .base = addrlo,
-        .index = guest_base ? TCG_REG_GUEST_BASE : -1,
-        .index_scratch = false,
-    };
-#endif
+    if (tcg_use_softmmu) {
+        *h = (HostAddress){
+            .cond = COND_AL,
+            .base = addrlo,
+            .index = TCG_REG_R1,
+            .index_scratch = true,
+        };
+    } else {
+        *h = (HostAddress){
+            .cond = COND_AL,
+            .base = addrlo,
+            .index = guest_base ? TCG_REG_GUEST_BASE : -1,
+            .index_scratch = false,
+        };
+    }
 
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
     a_mask = (1 << h->aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    int mem_index = get_mmuidx(oi);
-    int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
-                        : offsetof(CPUTLBEntry, addr_write);
-    int fast_off = tlb_mask_table_ofs(s, mem_index);
-    unsigned s_mask = (1 << (opc & MO_SIZE)) - 1;
-    TCGReg t_addr;
+    if (tcg_use_softmmu) {
+        int mem_index = get_mmuidx(oi);
+        int cmp_off = is_ld ? offsetof(CPUTLBEntry, addr_read)
+                            : offsetof(CPUTLBEntry, addr_write);
+        int fast_off = tlb_mask_table_ofs(s, mem_index);
+        unsigned s_mask = (1 << (opc & MO_SIZE)) - 1;
+        TCGReg t_addr;
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addrlo;
-    ldst->addrhi_reg = addrhi;
+        ldst = new_ldst_label(s);
+        ldst->is_ld = is_ld;
+        ldst->oi = oi;
+        ldst->addrlo_reg = addrlo;
+        ldst->addrhi_reg = addrhi;
 
-    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
-    tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
+        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
+        QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+        QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
+        tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
 
-    /* Extract the tlb index from the address into R0.  */
-    tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
-                    SHIFT_IMM_LSR(s->page_bits - CPU_TLB_ENTRY_BITS));
+        /* Extract the tlb index from the address into R0.  */
+        tcg_out_dat_reg(s, COND_AL, ARITH_AND, TCG_REG_R0, TCG_REG_R0, addrlo,
+                        SHIFT_IMM_LSR(s->page_bits - CPU_TLB_ENTRY_BITS));
 
-    /*
-     * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
-     * Load the tlb comparator into R2/R3 and the fast path addend into R1.
-     */
-    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
-    if (cmp_off == 0) {
-        if (s->addr_type == TCG_TYPE_I32) {
-            tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
+        /*
+         * Add the tlb_table pointer, creating the CPUTLBEntry address in R1.
+         * Load the tlb comparator into R2/R3 and the fast path addend into R1.
+         */
+        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
+        if (cmp_off == 0) {
+            if (s->addr_type == TCG_TYPE_I32) {
+                tcg_out_ld32_rwb(s, COND_AL, TCG_REG_R2,
+                                 TCG_REG_R1, TCG_REG_R0);
+            } else {
+                tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2,
+                                 TCG_REG_R1, TCG_REG_R0);
+            }
         } else {
-            tcg_out_ldrd_rwb(s, COND_AL, TCG_REG_R2, TCG_REG_R1, TCG_REG_R0);
+            tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
+                            TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
+            if (s->addr_type == TCG_TYPE_I32) {
+                tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+            } else {
+                tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+            }
         }
-    } else {
-        tcg_out_dat_reg(s, COND_AL, ARITH_ADD,
-                        TCG_REG_R1, TCG_REG_R1, TCG_REG_R0, 0);
-        if (s->addr_type == TCG_TYPE_I32) {
-            tcg_out_ld32_12(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+
+        /* Load the tlb addend.  */
+        tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R1,
+                        offsetof(CPUTLBEntry, addend));
+
+        /*
+         * Check alignment, check comparators.
+         * Do this in 2-4 insns.  Use MOVW for v7, if possible,
+         * to reduce the number of sequential conditional instructions.
+         * Almost all guests have at least 4k pages, which means that we need
+         * to clear at least 9 bits even for an 8-byte memory, which means it
+         * isn't worth checking for an immediate operand for BIC.
+         *
+         * For unaligned accesses, test the page of the last unit of alignment.
+         * This leaves the least significant alignment bits unchanged, and of
+         * course must be zero.
+         */
+        t_addr = addrlo;
+        if (a_mask < s_mask) {
+            t_addr = TCG_REG_R0;
+            tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t_addr,
+                            addrlo, s_mask - a_mask);
+        }
+        if (use_armv7_instructions && s->page_bits <= 16) {
+            tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(s->page_mask | a_mask));
+            tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
+                            t_addr, TCG_REG_TMP, 0);
+            tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0,
+                            TCG_REG_R2, TCG_REG_TMP, 0);
         } else {
-            tcg_out_ldrd_8(s, COND_AL, TCG_REG_R2, TCG_REG_R1, cmp_off);
+            if (a_mask) {
+                tcg_debug_assert(a_mask <= 0xff);
+                tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
+            }
+            tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
+                            SHIFT_IMM_LSR(s->page_bits));
+            tcg_out_dat_reg(s, (a_mask ? COND_EQ : COND_AL), ARITH_CMP,
+                            0, TCG_REG_R2, TCG_REG_TMP,
+                            SHIFT_IMM_LSL(s->page_bits));
         }
-    }
 
-    /* Load the tlb addend.  */
-    tcg_out_ld32_12(s, COND_AL, TCG_REG_R1, TCG_REG_R1,
-                    offsetof(CPUTLBEntry, addend));
-
-    /*
-     * Check alignment, check comparators.
-     * Do this in 2-4 insns.  Use MOVW for v7, if possible,
-     * to reduce the number of sequential conditional instructions.
-     * Almost all guests have at least 4k pages, which means that we need
-     * to clear at least 9 bits even for an 8-byte memory, which means it
-     * isn't worth checking for an immediate operand for BIC.
-     *
-     * For unaligned accesses, test the page of the last unit of alignment.
-     * This leaves the least significant alignment bits unchanged, and of
-     * course must be zero.
-     */
-    t_addr = addrlo;
-    if (a_mask < s_mask) {
-        t_addr = TCG_REG_R0;
-        tcg_out_dat_imm(s, COND_AL, ARITH_ADD, t_addr,
-                        addrlo, s_mask - a_mask);
-    }
-    if (use_armv7_instructions && s->page_bits <= 16) {
-        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, ~(s->page_mask | a_mask));
-        tcg_out_dat_reg(s, COND_AL, ARITH_BIC, TCG_REG_TMP,
-                        t_addr, TCG_REG_TMP, 0);
-        tcg_out_dat_reg(s, COND_AL, ARITH_CMP, 0, TCG_REG_R2, TCG_REG_TMP, 0);
-    } else {
-        if (a_mask) {
-            tcg_debug_assert(a_mask <= 0xff);
-            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
+        if (s->addr_type != TCG_TYPE_I32) {
+            tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
         }
-        tcg_out_dat_reg(s, COND_AL, ARITH_MOV, TCG_REG_TMP, 0, t_addr,
-                        SHIFT_IMM_LSR(s->page_bits));
-        tcg_out_dat_reg(s, (a_mask ? COND_EQ : COND_AL), ARITH_CMP,
-                        0, TCG_REG_R2, TCG_REG_TMP,
-                        SHIFT_IMM_LSL(s->page_bits));
-    }
-
-    if (s->addr_type != TCG_TYPE_I32) {
-        tcg_out_dat_reg(s, COND_EQ, ARITH_CMP, 0, TCG_REG_R3, addrhi, 0);
-    }
-#else
-    if (a_mask) {
+    } else if (a_mask) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
@@ -1505,7 +1499,6 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         /* tst addr, #mask */
         tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, addrlo, a_mask);
     }
-#endif
 
     return ldst;
 }
@@ -2931,12 +2924,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
 
-#ifndef CONFIG_SOFTMMU
-    if (guest_base) {
+    if (!tcg_use_softmmu && guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
     }
-#endif
 
     tcg_out_b_reg(s, COND_AL, tcg_target_call_iarg_regs[1]);
 
-- 
2.34.1


