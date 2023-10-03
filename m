Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BEB7B7033
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:45:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRP-0003U5-2r; Tue, 03 Oct 2023 13:44:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRL-0003MV-EU
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:11 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRH-0001Ns-TS
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:11 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c871a095ceso4170475ad.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355046; x=1696959846; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Rv6F1RlDHnOG8jBX5Ab72P1zZQusGlJbjHYE9QfzL4Q=;
 b=AkUII02rtAdZxnLbv6mZ7i5hQ1GubxhPZvP5GP53m5YtM4IpLw6Fk+M/TdqhVuCG8c
 4pH6yAfEySbepL4EiQ4ryWjkILN656du1W0Cw2nkRMqSJY/OujqmYXmo8xCvUBeok9AA
 SG2XUnjP+LO/KCkeWlQpNigc6gWOp4C5CYKUlCmgdO8w2Tni6RHIQqs88vqFkG/f2Jut
 lE6L7ryhvph0Fus267JC0dQRno3+Ir6G7T5zOE4N5Wa57wzA8y3gGBF3bInHHZ2G7u8r
 zLSXDCV8YKRLRLSOa5AabYfg/i4j791uQlwhz7kMoeXxTENPxKbAHDph1lPJGq1dWkMn
 NnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355046; x=1696959846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rv6F1RlDHnOG8jBX5Ab72P1zZQusGlJbjHYE9QfzL4Q=;
 b=CW1eaYsHAKZxo+gkDkwd0EAERItWoTyeEPEPekikfik2gH2Nn9+QhRNujt1wxYFuBG
 fgc9xsd6jVlV2hZGARqlfi6NRkidWLB7Dq3yE2gPF6LuvK6I92VNFA90yG+oZTF0jbmb
 2SCvrhV2qpOBN3AT9hXjUt4tPYAoKFkg7LlgsN9ZByzIEt8rtnqY2N3nue8sLD2WZ+oL
 mGlx8xphIl857Nf6CPAido/IODSRQD5YjerdEYMOHnQxdWK98dixlv3mtzDq+nuvNsk/
 BslhR6AP3sUGw5HUaV6b1fhSIYbAB1428y9JDGAWQY+1anhZIHb2kh8uMtjfjiruT9y9
 tWzQ==
X-Gm-Message-State: AOJu0Yz1tzklvnfwJ4m29MhKYwtdQWkw4CKAD1KzmwGb59AnVP+UEx+x
 2wJO7oTZiB3riWEXTGAM6kIoi7bPZRhyVHpSrU8=
X-Google-Smtp-Source: AGHT+IH/wciE6lsPztRuPFqiHLdndLra1E9LLNJEva2rxD5Rn0xVu/e0SAZWE+LKKcSj4o/7ke2rIw==
X-Received: by 2002:a17:902:c947:b0:1c7:4a8a:32d1 with SMTP id
 i7-20020a170902c94700b001c74a8a32d1mr223058pla.28.1696355046452; 
 Tue, 03 Oct 2023 10:44:06 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/10] tcg/riscv: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:55 -0700
Message-Id: <20231003174356.1602279-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/riscv/tcg-target.c.inc | 189 +++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 92 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index c2bcdea33f..12e3e50297 100644
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
@@ -2075,10 +2080,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#if !defined(CONFIG_SOFTMMU)
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
-    tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
-#endif
+    if (!tcg_use_softmmu && guest_base) {
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
+    }
 
     /* Call generated code */
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-- 
2.34.1


