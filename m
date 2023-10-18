Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1787CEB39
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:28:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzg-0008AH-4B; Wed, 18 Oct 2023 18:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEza-00087k-67
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:18 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzY-0002V3-74
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:17 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c9c5a1b87bso52640735ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667974; x=1698272774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+PnCNXxM75sZlgHHFx2OEqwx4bspJhNCS0HMsehl/Y=;
 b=DeIy5+s0wNdYGXBmqFQ2Xv+a0uLNMyhNSgEU8zNexRdffIzacjTbKdpNszvvKNCrzM
 dZNk7zaMlApn68Sdxf6GtZJGNGBD5Q6AMAcvhnvnyLS3pt4jQX3T/g0sjenS++XULEqq
 p5eM6KGBTXfMh7e1dKQEJE8w5q4wln6NH+B8XvjOJPRnONEEgVyUzAs9lqPrTYzP4cS5
 V8AsVh7brvLTPCJNAC0FvGnkmg+JPmlwtLbqjTZ3+CnH7mx/TdDQhSmJTl67tWhA7x0h
 97Do8ZmPlmNdb2V8YqTkCUYxDI8xxo4PU1wOKLY+xpv0Dw47AFPEYp7aNZFo3Z2YK5yV
 Qg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667974; x=1698272774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+PnCNXxM75sZlgHHFx2OEqwx4bspJhNCS0HMsehl/Y=;
 b=XDSyXesVOxYjEhCbZIXN8WS+ACj+mK+/ozFhf8gkBS2sJfPLs5Dq6QZ2iMt9fkd9sl
 mGr2WjfTgHbQO7K9FSKnq6e+aDyOa2Qo7reebP9iEFqY+Dt43Vay19x/7tPtA5T8dTDk
 ptt8bU8pEwfPfvXvn8gWv8O+kMlZ5tFedDLCXutI6bmJO4ev7WlusiYyZZPdBKYQGAXb
 5c6QUZNbVlGkmGLRbmGj2hW+6Vyc+iBxXBWiboCosYPpPBwobjPm5G6iET3we+EFeh1d
 OyAUvryzrj3MtAuHi9KfJezl/uHSd0UKU54U9p0mZgTFKdukgrSswsy79pmn8dXnco7d
 IpeA==
X-Gm-Message-State: AOJu0YxmFP86jAAGWAR/tYrBvYUjeXyjCabTwJjoP4Vkrpxzu8O9jBf4
 ktvStyg0vSq1J2VZAyzB6b5aW7WlDcJFP7pCXdM=
X-Google-Smtp-Source: AGHT+IHdmrTUo3EflmGq4LSeyBNtbktdtfs4HX7DWUf1nz1G3Di378qY9HE/LQUE/NU1s75ZBcBTFg==
X-Received: by 2002:a17:902:f385:b0:1c7:365a:566d with SMTP id
 f5-20020a170902f38500b001c7365a566dmr515297ple.66.1697667974462; 
 Wed, 18 Oct 2023 15:26:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/29] tcg/aarch64: Use tcg_use_softmmu
Date: Wed, 18 Oct 2023 15:25:45 -0700
Message-Id: <20231018222557.1562065-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


