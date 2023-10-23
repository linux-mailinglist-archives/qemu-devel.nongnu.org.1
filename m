Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3007A7D3EC0
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRB-0005fb-Gy; Mon, 23 Oct 2023 14:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQz-0005Y8-2N
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:49 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQx-0008B6-4t
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:48 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-583552eafd3so1945340eaf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084826; x=1698689626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+PnCNXxM75sZlgHHFx2OEqwx4bspJhNCS0HMsehl/Y=;
 b=tDRknbAVpuAijBJZ3ciFzBLOBG0Szsk0s2BPO+NemsfHakJrfodj4jlTbZwxzPirdJ
 lw7kF1RXqFmXXZ+y5g265NYJenV+1MBFdVQhOQaOY+CVCIb1Ld7SvvHgdHxzwr4ehRh2
 sTslmD9f4NPYiyidS/Y9680y70oj+6ymUL75DsYK0z1aDowHmqUwYULsP7NeJode3YUr
 3lCUjTZtKzcmB8CSu9PRNg2DgJ1s9ddbLtOYUOvRdUJPPGrX8UK+PqehEI7y1b/tMOuX
 eieKQAAiMkl3QP/9E3iuvV0d2OFgBBTDOnIO2lAhKVqQfb9Xvka5cRKWOGvP0pLsCa9W
 U7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084826; x=1698689626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+PnCNXxM75sZlgHHFx2OEqwx4bspJhNCS0HMsehl/Y=;
 b=tKSAzXb5Qa9F1Ia3VGwi9py8nuF2YO908XzNShg2DmwbDT/A0zJ6Q3iEn18WpP8H57
 eFBN6PEOumzqcMCYwYUNfLb/B/VHMUKfzhVFQ+KFq+DkgBfhC0Nfxq8uV930IUFCHabL
 ABTyt+v3q8a51gMoLro1MTAf/NbP/EmXlmRNivKMDurSSiEW4MpJLmwLVeRihCRhkfXC
 d/eInxkvgrjaXToekBYnGNtTFz4sp+/05jeYxGMuYz0aL7oIGaj/7qE1T/S/2f+qsI5I
 tBcOYauhm8skc6hSZSv9WfQHK/bRHEVApBwCebsnAo6Z+7Nex+sqQVyEa30EoYjPavkJ
 hU5A==
X-Gm-Message-State: AOJu0YwVGqJew4TqdfqgdKiEhwEoLbvxY/rWVC9WoUUoMcZ0YKu1L/IY
 x77GWGpE6ylkLlerXTTxfGChJNlgsBU3GwHWwhw=
X-Google-Smtp-Source: AGHT+IHYaWfQ/AtM4TrR+NRHMWkCFGjBd1JOU0m5PAIWkk1WBsvuvNRMXcAqc0O7gWb8NgaVOIIOBg==
X-Received: by 2002:a05:6359:6a2:b0:168:ec55:d164 with SMTP id
 ei34-20020a05635906a200b00168ec55d164mr1028207rwb.25.1698084825796; 
 Mon, 23 Oct 2023 11:13:45 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 17/38] tcg/aarch64: Use tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:08 -0700
Message-Id: <20231023181329.171490-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 177 +++++++++++++++++------------------
 1 file changed, 88 insertions(+), 89 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 3afb896a3a..a3efa1e67a 100644
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


