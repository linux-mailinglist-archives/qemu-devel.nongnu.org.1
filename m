Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BD7B7029
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRU-0003hm-FO; Tue, 03 Oct 2023 13:44:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRR-0003cg-Bz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRD-0001N0-4z
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c77449a6daso10491045ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355041; x=1696959841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DYZjoe2reECi39pHaaHUCezel0Z+iTAHZbGMLS8MBgc=;
 b=WTaJqaFQUzOrxZGWS2539n1d1C6Ue+mbgnqpoyOLL8yYzdATD1AslClJq8sK8jGw8R
 q+lqakbhw+Aa6uMUtqdjtEmpqvbHp3wETZfm7T53Luw7+/UmnNrxDC+6hZkDHsz1qp6G
 RerGail7q1Hvd8QOFUoDbEFrkOtAJ7iSIktrJF18OtLhiNXutiNYUzhJBfzrF9cHG22K
 Gxv37y9dN09Q/SXtL9clsG/a+kHB0sIx6jZG7U37svg4CXzBxhLqsyDhHrBccDS6Jf2W
 xmz2oddd0Q+49AtzfubKay8ns8xxkw04IxT5ez0Qf//r2i19wEw9PTmzi5++sTc+PeEk
 hIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355041; x=1696959841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DYZjoe2reECi39pHaaHUCezel0Z+iTAHZbGMLS8MBgc=;
 b=qW+kvm0icoVq5Qo4UvC/qSumWcmmH8f6CVJiipSR9s9CMQjNrh9ypgLjdtmj4uaIKN
 0dV2wAIzK9hde0rwmwLd84Zxc2O55z91kPsBjmTAAUVoU89hD+fy+7lD9IYk0RAD3Nl9
 n/hbn+UqgXQbn0q3rFZWtIG8r6BmsKEpJCzwF/Qf2Y0rNtISuJEkpdwI5L+wDmyGfdNE
 WVZi9910sT7yXu72VYFWvVEhnMAx/c8If3KBxkRK9PslV13WWhwXfH9Fjyt3RcuXO1A5
 CQBJ1zwp9+poLiwbS6ItSlRXG/Hq6CYCuXQaj1oWiSb0TsH5Jo27u+6k3783HJWkjIgn
 yLwQ==
X-Gm-Message-State: AOJu0YzfFuE04qLH+rCV/hy/RyvoZWTJzYuKtcWd1yPl8lDELnOfW/tD
 51gpPLtjtAKwuh9Ia3M2oD1ai9osp3GbHJWnk+w=
X-Google-Smtp-Source: AGHT+IGmU5ZlJR3mDZEsGRFY6oepVPN6xP1dzAwTNwoxAqDh19cXBwVu0CDUIombjajQIVMIPHJraw==
X-Received: by 2002:a17:903:228f:b0:1c7:66a4:27ba with SMTP id
 b15-20020a170903228f00b001c766a427bamr235996plh.48.1696355041493; 
 Tue, 03 Oct 2023 10:44:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/10] tcg/aarch64: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:50 -0700
Message-Id: <20231003174356.1602279-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/aarch64/tcg-target.c.inc | 177 +++++++++++++++++------------------
 1 file changed, 88 insertions(+), 89 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 69f2daf2c2..6745f51476 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -77,9 +77,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_REG_TMP2 TCG_REG_X30
 #define TCG_VEC_TMP0 TCG_REG_V31
 
-#ifndef CONFIG_SOFTMMU
 #define TCG_REG_GUEST_BASE TCG_REG_X28
-#endif
 
 static bool reloc_pc26(tcg_insn_unit *src_rw, const tcg_insn_unit *target)
 {
@@ -1664,97 +1662,98 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
                                    s_bits == MO_128);
     a_mask = (1 << h->aa.align) - 1;
 
-#ifdef CONFIG_SOFTMMU
-    unsigned s_mask = (1u << s_bits) - 1;
-    unsigned mem_index = get_mmuidx(oi);
-    TCGReg addr_adj;
-    TCGType mask_type;
-    uint64_t compare_mask;
+    if (tcg_use_softmmu) {
+        unsigned s_mask = (1u << s_bits) - 1;
+        unsigned mem_index = get_mmuidx(oi);
+        TCGReg addr_adj;
+        TCGType mask_type;
+        uint64_t compare_mask;
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addr_reg;
-
-    mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
-                 ? TCG_TYPE_I64 : TCG_TYPE_I32);
-
-    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
-    QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
-    tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
-                 tlb_mask_table_ofs(s, mem_index), 1, 0);
-
-    /* Extract the TLB index from the address into X0.  */
-    tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
-                 TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
-                 s->page_bits - CPU_TLB_ENTRY_BITS);
-
-    /* Add the tlb_table pointer, forming the CPUTLBEntry address in TMP1. */
-    tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
-
-    /* Load the tlb comparator into TMP0, and the fast path addend into TMP1. */
-    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
-    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP1,
-               is_ld ? offsetof(CPUTLBEntry, addr_read)
-                     : offsetof(CPUTLBEntry, addr_write));
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
-               offsetof(CPUTLBEntry, addend));
-
-    /*
-     * For aligned accesses, we check the first byte and include the alignment
-     * bits within the address.  For unaligned access, we check that we don't
-     * cross pages using the address of the last byte of the access.
-     */
-    if (a_mask >= s_mask) {
-        addr_adj = addr_reg;
-    } else {
-        addr_adj = TCG_REG_TMP2;
-        tcg_out_insn(s, 3401, ADDI, addr_type,
-                     addr_adj, addr_reg, s_mask - a_mask);
-    }
-    compare_mask = (uint64_t)s->page_mask | a_mask;
-
-    /* Store the page mask part of the address into TMP2.  */
-    tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_TMP2,
-                     addr_adj, compare_mask);
-
-    /* Perform the address comparison. */
-    tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
-
-    /* If not equal, we jump to the slow path. */
-    ldst->label_ptr[0] = s->code_ptr;
-    tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
-
-    h->base = TCG_REG_TMP1;
-    h->index = addr_reg;
-    h->index_ext = addr_type;
-#else
-    if (a_mask) {
         ldst = new_ldst_label(s);
-
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
-        /* tst addr, #mask */
-        tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, a_mask);
+        mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
+                     ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-        /* b.ne slow_path */
+        /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+        QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
+        QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
+        tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
+                     tlb_mask_table_ofs(s, mem_index), 1, 0);
+
+        /* Extract the TLB index from the address into X0.  */
+        tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
+                     TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
+                     s->page_bits - CPU_TLB_ENTRY_BITS);
+
+        /* Add the tlb_table pointer, forming the CPUTLBEntry address. */
+        tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
+
+        /* Load the tlb comparator into TMP0, and the fast path addend. */
+        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
+        tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP1,
+                   is_ld ? offsetof(CPUTLBEntry, addr_read)
+                         : offsetof(CPUTLBEntry, addr_write));
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
+                   offsetof(CPUTLBEntry, addend));
+
+        /*
+         * For aligned accesses, we check the first byte and include
+         * the alignment bits within the address.  For unaligned access,
+         * we check that we don't cross pages using the address of the
+         * last byte of the access.
+         */
+        if (a_mask >= s_mask) {
+            addr_adj = addr_reg;
+        } else {
+            addr_adj = TCG_REG_TMP2;
+            tcg_out_insn(s, 3401, ADDI, addr_type,
+                         addr_adj, addr_reg, s_mask - a_mask);
+        }
+        compare_mask = (uint64_t)s->page_mask | a_mask;
+
+        /* Store the page mask part of the address into TMP2.  */
+        tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_TMP2,
+                         addr_adj, compare_mask);
+
+        /* Perform the address comparison. */
+        tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
+
+        /* If not equal, we jump to the slow path. */
         ldst->label_ptr[0] = s->code_ptr;
         tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
-    }
 
-    if (guest_base || addr_type == TCG_TYPE_I32) {
-        h->base = TCG_REG_GUEST_BASE;
+        h->base = TCG_REG_TMP1;
         h->index = addr_reg;
         h->index_ext = addr_type;
     } else {
-        h->base = addr_reg;
-        h->index = TCG_REG_XZR;
-        h->index_ext = TCG_TYPE_I64;
+        if (a_mask) {
+            ldst = new_ldst_label(s);
+
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addr_reg;
+
+            /* tst addr, #mask */
+            tcg_out_logicali(s, I3404_ANDSI, 0, TCG_REG_XZR, addr_reg, a_mask);
+
+            /* b.ne slow_path */
+            ldst->label_ptr[0] = s->code_ptr;
+            tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
+        }
+
+        if (guest_base || addr_type == TCG_TYPE_I32) {
+            h->base = TCG_REG_GUEST_BASE;
+            h->index = addr_reg;
+            h->index_ext = addr_type;
+        } else {
+            h->base = addr_reg;
+            h->index = TCG_REG_XZR;
+            h->index_ext = TCG_TYPE_I64;
+        }
     }
-#endif
 
     return ldst;
 }
@@ -3117,16 +3116,16 @@ static void tcg_target_qemu_prologue(TCGContext *s)
     tcg_set_frame(s, TCG_REG_SP, TCG_STATIC_CALL_ARGS_SIZE,
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
-#if !defined(CONFIG_SOFTMMU)
-    /*
-     * Note that XZR cannot be encoded in the address base register slot,
-     * as that actually encodes SP.  Depending on the guest, we may need
-     * to zero-extend the guest address via the address index register slot,
-     * therefore we need to load even a zero guest base into a register.
-     */
-    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
-    tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
-#endif
+    if (!tcg_use_softmmu) {
+        /*
+         * Note that XZR cannot be encoded in the address base register slot,
+         * as that actually encodes SP.  Depending on the guest, we may need
+         * to zero-extend the guest address via the address index register slot,
+         * therefore we need to load even a zero guest base into a register.
+         */
+        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
+        tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
+    }
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
     tcg_out_insn(s, 3207, BR, tcg_target_call_iarg_regs[1]);
-- 
2.34.1


