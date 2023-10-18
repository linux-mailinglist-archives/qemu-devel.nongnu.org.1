Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD477CEB47
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:30:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzl-0008Dm-LM; Wed, 18 Oct 2023 18:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzh-0008Bx-MR
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEze-0002W5-GO
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:25 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so50502375ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667979; x=1698272779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JvjLY5SZ74SJJZ4Z/bCpNskQetGcwIwHRaw0bsKKJdY=;
 b=pAnPQLJDqUNvHB+i5d86GjO8/IL2YL95hgDtq2iTSxvPH4TNAjW+kg9iY5QFN0KbJ6
 VBk61h88RpIiPLhEQ2leEr32t0zc36sZnsZ3kySQ6QgMUAmoQcmnnLhH+Cb3YbSHQ0JD
 IzLoOh58ThmRl+SH5JGBOIQBPU4nPi/dRjGsJ94ubCNDnB7+f/pRAlrUR1sLIQ8ctdmm
 XJr6s2E0UskU3zIWta49wWP0ARTqPrU1/E/vXzpVWedyNuX4wviSf7TzRTDSzIDMoX7z
 P0oG34nrBEAc+IWt/SsdjxzXC/V5VVtnqUJNNlv7FAbqM6wo7jmsWhwuVFjCh7njNI2L
 IHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667979; x=1698272779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JvjLY5SZ74SJJZ4Z/bCpNskQetGcwIwHRaw0bsKKJdY=;
 b=nd/A+7EGcPaZXxmSFIT4Cxxar9rKbTpThcJiGAYwMZLIBp/ktZ2zd2s1zA7+CLkkSe
 UbByaiA3XGD8grS/OJ63l778rKfgw83Vxh6BdfJP88M6UrWqwe33AQT1BFf+Z3wS7v1U
 devcy5bxbWy/OvONXyAlTxYRteZk5XE7zH8AD+wdvtUd8NMtGkPdLfnDFkQRaQVB4D37
 edHwJu6KwgrUALQ+RymgmRIrQfZazIfb1DV0SSn/QUjoSoUT2MsAy0r9b54bCF7FoHk5
 GldwVqHBUpnT5ZaCKvgBoEKZzpS7EFF5IH0CTeUjNKW5tjB3/kSo+evyuQUGuDqtpENW
 0ptw==
X-Gm-Message-State: AOJu0YyWWOGitHyHE+d2dkfXb1ZSAdS7jhVNAm0TCnLDxALZR1BF6j18
 bjzmrw4x+V0MBrM+lSNmKDQCYiZWDNqXTdZhwv8=
X-Google-Smtp-Source: AGHT+IEz4tjdPg1CgEl7xlvgLsrfkkmDrxD92u0IX487XPAUed3e5eYpJJgqWphZx8xZXEwQu6I9lg==
X-Received: by 2002:a17:903:210d:b0:1c9:97b7:b3cc with SMTP id
 o13-20020a170903210d00b001c997b7b3ccmr554869ple.47.1697667979439; 
 Wed, 18 Oct 2023 15:26:19 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/29] tcg/riscv: Use tcg_use_softmmu
Date: Wed, 18 Oct 2023 15:25:51 -0700
Message-Id: <20231018222557.1562065-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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


