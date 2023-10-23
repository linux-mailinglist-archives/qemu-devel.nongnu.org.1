Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CD87D3ECA
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:15:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRF-0005kA-Gq; Mon, 23 Oct 2023 14:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR7-0005cj-Vn
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:59 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR2-0008GG-De
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b201a93c9cso2726895b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084831; x=1698689631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JvjLY5SZ74SJJZ4Z/bCpNskQetGcwIwHRaw0bsKKJdY=;
 b=Wl1Gor1ESbvaRp2JJuheKJWFGCOvJ0JCgxYMbsOU5sEH3SUXpYaZYjlXBOI4EkOeB+
 KL1kuo0SioOsKScXeN91f7EGltHA7TSeecRFGhHXmFMiGHsG5zl7tRAIA4Y9pMjR24E+
 Iv66Rxd+JnUhLi147x0moiMtGdA2w8/cNo7NAH/wraJRs+qlsEfeLm5CxLIk0cU1aHOX
 X9Okf03dsAu5tKi+ZQcBfG9me37smzl/Nyw4kAD7uSj0ba7pW3KxO2mtQRBrGF0Lc/A4
 8B3uRQKD4wZ99BCV//fHHBPHcrrS+aNTWJdBe5JxYCR2mIh9Ro9YTZQNzWb/CuBhyjCq
 JjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084831; x=1698689631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvjLY5SZ74SJJZ4Z/bCpNskQetGcwIwHRaw0bsKKJdY=;
 b=Qpat1aNjXM4ECzZRY6Lz7N3KyrxJoxyNMUHpvLqeAWPLPNRj7Vclpaz6hQygJf3LBP
 nGdO3kgbqzrYz71am3E+sb2u2JKq+nQoUYEMyi4xTaPtS8syx91CF3Qwtmf3y3FTt0No
 apJ3mbxanWjWOHxgCFzTAa4sdn8oP9+tSOB1azTlKUsrVJMn72JwD4bKg/QrNiqDMEWu
 Ri3jGxQWa/nVvAhByEn5NDKy4H1PXtbSHrWLJnvi6uXj0664DuJjOWsMSVm/KPFDqyng
 jCoHvZrxRLPi9NccvH70eQI04Yfz4Fk5+6bBiGPzf5wbvV97Nd6A2ElyXpSzqdTcsjbk
 FfaQ==
X-Gm-Message-State: AOJu0Yw/6rFgyAvrrlK6OrTDLIAxOxPnXreJGQDz8Z/+QmSQ8PkOjhLh
 5BiUmu/um87VEfyPh7oCg5HjMFGLNn4zFw3tjoM=
X-Google-Smtp-Source: AGHT+IGzHL1BN0hEbHl1Y3QpUv6gnYFSR3fd6wWlKOT4aPFVFYOX3hcAWgas37KWkbdSN6JyEXIssA==
X-Received: by 2002:a05:6a21:66c4:b0:16c:b60c:953c with SMTP id
 ze4-20020a056a2166c400b0016cb60c953cmr390648pzb.58.1698084831083; 
 Mon, 23 Oct 2023 11:13:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 23/38] tcg/riscv: Use tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:14 -0700
Message-Id: <20231023181329.171490-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tcg/riscv/tcg-target.c.inc | 185 +++++++++++++++++++------------------
 1 file changed, 94 insertions(+), 91 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index dc71f829d1..34e10e77d9 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -1245,105 +1245,110 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, TCGReg *pbase,
     aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
     a_mask = (1u << aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    unsigned s_bits = opc & MO_SIZE;
-    unsigned s_mask = (1u << s_bits) - 1;
-    int mem_index = get_mmuidx(oi);
-    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
-    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
-    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
-    int compare_mask;
-    TCGReg addr_adj;
+    if (tcg_use_softmmu) {
+        unsigned s_bits = opc & MO_SIZE;
+        unsigned s_mask = (1u << s_bits) - 1;
+        int mem_index = get_mmuidx(oi);
+        int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+        int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+        int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
+        int compare_mask;
+        TCGReg addr_adj;
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addr_reg;
-
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
-
-    tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addr_reg,
-                    s->page_bits - CPU_TLB_ENTRY_BITS);
-    tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
-    tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
-
-    /*
-     * For aligned accesses, we check the first byte and include the alignment
-     * bits within the address.  For unaligned access, we check that we don't
-     * cross pages using the address of the last byte of the access.
-     */
-    addr_adj = addr_reg;
-    if (a_mask < s_mask) {
-        addr_adj = TCG_REG_TMP0;
-        tcg_out_opc_imm(s, addr_type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI,
-                        addr_adj, addr_reg, s_mask - a_mask);
-    }
-    compare_mask = s->page_mask | a_mask;
-    if (compare_mask == sextreg(compare_mask, 0, 12)) {
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
-    } else {
-        tcg_out_movi(s, addr_type, TCG_REG_TMP1, compare_mask);
-        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addr_adj);
-    }
-
-    /* Load the tlb comparator and the addend.  */
-    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
-    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
-               is_ld ? offsetof(CPUTLBEntry, addr_read)
-                     : offsetof(CPUTLBEntry, addr_write));
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
-               offsetof(CPUTLBEntry, addend));
-
-    /* Compare masked address with the TLB entry. */
-    ldst->label_ptr[0] = s->code_ptr;
-    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
-
-    /* TLB Hit - translate address using addend.  */
-    if (addr_type != TCG_TYPE_I32) {
-        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
-    } else if (have_zba) {
-        tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
-    } else {
-        tcg_out_ext32u(s, TCG_REG_TMP0, addr_reg);
-        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, TCG_REG_TMP0, TCG_REG_TMP2);
-    }
-    *pbase = TCG_REG_TMP0;
-#else
-    TCGReg base;
-
-    if (a_mask) {
         ldst = new_ldst_label(s);
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
-        /* We are expecting alignment max 7, so we can always use andi. */
-        tcg_debug_assert(a_mask == sextreg(a_mask, 0, 12));
-        tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_reg, a_mask);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
 
-        ldst->label_ptr[0] = s->code_ptr;
-        tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP1, TCG_REG_ZERO, 0);
-    }
+        tcg_out_opc_imm(s, OPC_SRLI, TCG_REG_TMP2, addr_reg,
+                        s->page_bits - CPU_TLB_ENTRY_BITS);
+        tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
+        tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
 
-    if (guest_base != 0) {
-        base = TCG_REG_TMP0;
-        if (addr_type != TCG_TYPE_I32) {
-            tcg_out_opc_reg(s, OPC_ADD, base, addr_reg, TCG_GUEST_BASE_REG);
-        } else if (have_zba) {
-            tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg, TCG_GUEST_BASE_REG);
-        } else {
-            tcg_out_ext32u(s, base, addr_reg);
-            tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_GUEST_BASE_REG);
+        /*
+         * For aligned accesses, we check the first byte and include the
+         * alignment bits within the address.  For unaligned access, we
+         * check that we don't cross pages using the address of the last
+         * byte of the access.
+         */
+        addr_adj = addr_reg;
+        if (a_mask < s_mask) {
+            addr_adj = TCG_REG_TMP0;
+            tcg_out_opc_imm(s, addr_type == TCG_TYPE_I32 ? OPC_ADDIW : OPC_ADDI,
+                            addr_adj, addr_reg, s_mask - a_mask);
         }
-    } else if (addr_type != TCG_TYPE_I32) {
-        base = addr_reg;
+        compare_mask = s->page_mask | a_mask;
+        if (compare_mask == sextreg(compare_mask, 0, 12)) {
+            tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_adj, compare_mask);
+        } else {
+            tcg_out_movi(s, addr_type, TCG_REG_TMP1, compare_mask);
+            tcg_out_opc_reg(s, OPC_AND, TCG_REG_TMP1, TCG_REG_TMP1, addr_adj);
+        }
+
+        /* Load the tlb comparator and the addend.  */
+        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
+        tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
+                   is_ld ? offsetof(CPUTLBEntry, addr_read)
+                         : offsetof(CPUTLBEntry, addr_write));
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
+                   offsetof(CPUTLBEntry, addend));
+
+        /* Compare masked address with the TLB entry. */
+        ldst->label_ptr[0] = s->code_ptr;
+        tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
+
+        /* TLB Hit - translate address using addend.  */
+        if (addr_type != TCG_TYPE_I32) {
+            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0, addr_reg, TCG_REG_TMP2);
+        } else if (have_zba) {
+            tcg_out_opc_reg(s, OPC_ADD_UW, TCG_REG_TMP0,
+                            addr_reg, TCG_REG_TMP2);
+        } else {
+            tcg_out_ext32u(s, TCG_REG_TMP0, addr_reg);
+            tcg_out_opc_reg(s, OPC_ADD, TCG_REG_TMP0,
+                            TCG_REG_TMP0, TCG_REG_TMP2);
+        }
+        *pbase = TCG_REG_TMP0;
     } else {
-        base = TCG_REG_TMP0;
-        tcg_out_ext32u(s, base, addr_reg);
+        TCGReg base;
+
+        if (a_mask) {
+            ldst = new_ldst_label(s);
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addr_reg;
+
+            /* We are expecting alignment max 7, so we can always use andi. */
+            tcg_debug_assert(a_mask == sextreg(a_mask, 0, 12));
+            tcg_out_opc_imm(s, OPC_ANDI, TCG_REG_TMP1, addr_reg, a_mask);
+
+            ldst->label_ptr[0] = s->code_ptr;
+            tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP1, TCG_REG_ZERO, 0);
+        }
+
+        if (guest_base != 0) {
+            base = TCG_REG_TMP0;
+            if (addr_type != TCG_TYPE_I32) {
+                tcg_out_opc_reg(s, OPC_ADD, base, addr_reg,
+                                TCG_GUEST_BASE_REG);
+            } else if (have_zba) {
+                tcg_out_opc_reg(s, OPC_ADD_UW, base, addr_reg,
+                                TCG_GUEST_BASE_REG);
+            } else {
+                tcg_out_ext32u(s, base, addr_reg);
+                tcg_out_opc_reg(s, OPC_ADD, base, base, TCG_GUEST_BASE_REG);
+            }
+        } else if (addr_type != TCG_TYPE_I32) {
+            base = addr_reg;
+        } else {
+            base = TCG_REG_TMP0;
+            tcg_out_ext32u(s, base, addr_reg);
+        }
+        *pbase = base;
     }
-    *pbase = base;
-#endif
 
     return ldst;
 }
@@ -2075,12 +2080,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#if !defined(CONFIG_SOFTMMU)
-    if (guest_base) {
+    if (!tcg_use_softmmu && guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
 
     /* Call generated code */
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-- 
2.34.1


