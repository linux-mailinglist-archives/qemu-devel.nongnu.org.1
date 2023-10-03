Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7658A7B702E
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:44:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjRM-0003M7-J2; Tue, 03 Oct 2023 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRI-0003G2-VQ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:09 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjRF-0001NU-A3
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:44:08 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5859a7d6556so839154a12.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696355044; x=1696959844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X1ufzGOCxXLqa4yAWPhY6AkV0xZysTZRXjKBl2TXWO0=;
 b=mK0c8oFhcUTkLgYfeRFpsup23I7YyTMb3eN5TxPF1f7P5de212CVCkJ0bCXk1qBbba
 vw0T/uAP1GNvM8UZWtJqwtuEefY7K96T49UH9MErhovY71NVL+0n3+0M9kn61WJri8gu
 pP7efMmkxFL/cwt8BYHkvXP6rmOZu3mN2JxMjHuPlhFh73HfTeBimhbWsbbFCv3aNyvy
 SCtpugFAejHCRUnzyOEXQzrsIaGJ+lQ6Vx5IUL1vr6Aw4qt/2wwcAAZDAsbCJe8jI7TY
 cVYLDbUt7WVtZrKEUVKJ2L8YrtSmJu8vzG5HxUlCzZmAoaH32M0OfaWws89+rbi9L/bi
 5XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696355044; x=1696959844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X1ufzGOCxXLqa4yAWPhY6AkV0xZysTZRXjKBl2TXWO0=;
 b=BR9UnzqhRY6YkINh7G+CGXmY9m6Tr6RHjceShgZzmDcixeOoiozpvR/MWVy/eCZnfd
 8D6eObLn6W1Z+KKWMXn7ro3xcSJhzoRQFObF6seM/+2VBbtBBnfvgDXlAunNWYnCtPaO
 cgyrKhVHNjeyx1TRqCGAppbzLx+kLYf1He+pgrKW3ApKS0CIOGKVgY23FWM+pCZ5rrVM
 M9coHaVVUdpKC/d7Ac5hDLB7UoiZIjMkVCqB/Ih9RyIMfD/GWqB2Ba3C9WJ3kHmVrl9I
 s0lBi178OQY294G0T25nYEQdZ8BCGS75H/F7cxInFLkuoPyCHfnksma4H+GpRShonjyg
 sODg==
X-Gm-Message-State: AOJu0Yxq60YMrl6ECsf8RjsKw7HbdjjpcFckr5UqEuTNES1ji/25oRId
 HIxOk85PPZ9D4JIhpfdFw6MMLMro9PMI4Hr7nlA=
X-Google-Smtp-Source: AGHT+IFlVYwIDwSc5MFSFkiz6d7hVbxoTO1CTNe1AztbR2bT67k/lwYrqB/Tfh7RAw/67PtB0xjPgA==
X-Received: by 2002:a05:6a21:338b:b0:154:a9bc:12d0 with SMTP id
 yy11-20020a056a21338b00b00154a9bc12d0mr180685pzb.13.1696355043699; 
 Tue, 03 Oct 2023 10:44:03 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jg2-20020a17090326c200b001c32fd9e412sm1876466plb.58.2023.10.03.10.44.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:44:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/10] tcg/loongarch64: Use tcg_use_softmmu
Date: Tue,  3 Oct 2023 10:43:52 -0700
Message-Id: <20231003174356.1602279-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003174356.1602279-1-richard.henderson@linaro.org>
References: <20231003174356.1602279-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 126 +++++++++++++++----------------
 1 file changed, 61 insertions(+), 65 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 8f7091002b..dd3cab545b 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -165,10 +165,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
     return TCG_REG_A0 + slot;
 }
 
-#ifndef CONFIG_SOFTMMU
-#define USE_GUEST_BASE     (guest_base != 0)
 #define TCG_GUEST_BASE_REG TCG_REG_S1
-#endif
 
 #define TCG_CT_CONST_ZERO  0x100
 #define TCG_CT_CONST_S12   0x200
@@ -908,76 +905,77 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     h->aa = atom_and_align_for_opc(s, opc, MO_ATOM_IFALIGN, false);
     a_bits = h->aa.align;
 
-#ifdef CONFIG_SOFTMMU
-    unsigned s_bits = opc & MO_SIZE;
-    int mem_index = get_mmuidx(oi);
-    int fast_ofs = tlb_mask_table_ofs(s, mem_index);
-    int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
-    int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
+    if (tcg_use_softmmu) {
+        unsigned s_bits = opc & MO_SIZE;
+        int mem_index = get_mmuidx(oi);
+        int fast_ofs = tlb_mask_table_ofs(s, mem_index);
+        int mask_ofs = fast_ofs + offsetof(CPUTLBDescFast, mask);
+        int table_ofs = fast_ofs + offsetof(CPUTLBDescFast, table);
 
-    ldst = new_ldst_label(s);
-    ldst->is_ld = is_ld;
-    ldst->oi = oi;
-    ldst->addrlo_reg = addr_reg;
-
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
-
-    tcg_out_opc_srli_d(s, TCG_REG_TMP2, addr_reg,
-                    s->page_bits - CPU_TLB_ENTRY_BITS);
-    tcg_out_opc_and(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
-    tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
-
-    /* Load the tlb comparator and the addend.  */
-    QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
-    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
-               is_ld ? offsetof(CPUTLBEntry, addr_read)
-                     : offsetof(CPUTLBEntry, addr_write));
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
-               offsetof(CPUTLBEntry, addend));
-
-    /*
-     * For aligned accesses, we check the first byte and include the alignment
-     * bits within the address.  For unaligned access, we check that we don't
-     * cross pages using the address of the last byte of the access.
-     */
-    if (a_bits < s_bits) {
-        unsigned a_mask = (1u << a_bits) - 1;
-        unsigned s_mask = (1u << s_bits) - 1;
-        tcg_out_addi(s, addr_type, TCG_REG_TMP1, addr_reg, s_mask - a_mask);
-    } else {
-        tcg_out_mov(s, addr_type, TCG_REG_TMP1, addr_reg);
-    }
-    tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
-                          a_bits, s->page_bits - 1);
-
-    /* Compare masked address with the TLB entry.  */
-    ldst->label_ptr[0] = s->code_ptr;
-    tcg_out_opc_bne(s, TCG_REG_TMP0, TCG_REG_TMP1, 0);
-
-    h->index = TCG_REG_TMP2;
-#else
-    if (a_bits) {
         ldst = new_ldst_label(s);
-
         ldst->is_ld = is_ld;
         ldst->oi = oi;
         ldst->addrlo_reg = addr_reg;
 
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_AREG0, mask_ofs);
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_AREG0, table_ofs);
+
+        tcg_out_opc_srli_d(s, TCG_REG_TMP2, addr_reg,
+                           s->page_bits - CPU_TLB_ENTRY_BITS);
+        tcg_out_opc_and(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP0);
+        tcg_out_opc_add_d(s, TCG_REG_TMP2, TCG_REG_TMP2, TCG_REG_TMP1);
+
+        /* Load the tlb comparator and the addend.  */
+        QEMU_BUILD_BUG_ON(HOST_BIG_ENDIAN);
+        tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2,
+                   is_ld ? offsetof(CPUTLBEntry, addr_read)
+                         : offsetof(CPUTLBEntry, addr_write));
+        tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP2, TCG_REG_TMP2,
+                   offsetof(CPUTLBEntry, addend));
+
         /*
-         * Without micro-architecture details, we don't know which of
-         * bstrpick or andi is faster, so use bstrpick as it's not
-         * constrained by imm field width. Not to say alignments >= 2^12
-         * are going to happen any time soon.
+         * For aligned accesses, we check the first byte and include the
+         * alignment bits within the address.  For unaligned access, we
+         * check that we don't cross pages using the address of the last
+         * byte of the access.
          */
-        tcg_out_opc_bstrpick_d(s, TCG_REG_TMP1, addr_reg, 0, a_bits - 1);
+        if (a_bits < s_bits) {
+            unsigned a_mask = (1u << a_bits) - 1;
+            unsigned s_mask = (1u << s_bits) - 1;
+            tcg_out_addi(s, addr_type, TCG_REG_TMP1, addr_reg, s_mask - a_mask);
+        } else {
+            tcg_out_mov(s, addr_type, TCG_REG_TMP1, addr_reg);
+        }
+        tcg_out_opc_bstrins_d(s, TCG_REG_TMP1, TCG_REG_ZERO,
+                              a_bits, s->page_bits - 1);
 
+        /* Compare masked address with the TLB entry.  */
         ldst->label_ptr[0] = s->code_ptr;
-        tcg_out_opc_bne(s, TCG_REG_TMP1, TCG_REG_ZERO, 0);
-    }
+        tcg_out_opc_bne(s, TCG_REG_TMP0, TCG_REG_TMP1, 0);
 
-    h->index = USE_GUEST_BASE ? TCG_GUEST_BASE_REG : TCG_REG_ZERO;
-#endif
+        h->index = TCG_REG_TMP2;
+    } else {
+        if (a_bits) {
+            ldst = new_ldst_label(s);
+
+            ldst->is_ld = is_ld;
+            ldst->oi = oi;
+            ldst->addrlo_reg = addr_reg;
+
+            /*
+             * Without micro-architecture details, we don't know which of
+             * bstrpick or andi is faster, so use bstrpick as it's not
+             * constrained by imm field width. Not to say alignments >= 2^12
+             * are going to happen any time soon.
+             */
+            tcg_out_opc_bstrpick_d(s, TCG_REG_TMP1, addr_reg, 0, a_bits - 1);
+
+            ldst->label_ptr[0] = s->code_ptr;
+            tcg_out_opc_bne(s, TCG_REG_TMP1, TCG_REG_ZERO, 0);
+        }
+
+        h->index = guest_base ? TCG_GUEST_BASE_REG : TCG_REG_ZERO;
+    }
 
     if (addr_type == TCG_TYPE_I32) {
         h->base = TCG_REG_TMP0;
@@ -2272,12 +2270,10 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                    TCG_REG_SP, SAVE_OFS + i * REG_SIZE);
     }
 
-#if !defined(CONFIG_SOFTMMU)
-    if (USE_GUEST_BASE) {
+    if (!tcg_use_softmmu && guest_base) {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_GUEST_BASE_REG, guest_base);
         tcg_regset_set_reg(s->reserved_regs, TCG_GUEST_BASE_REG);
     }
-#endif
 
     /* Call generated code */
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-- 
2.34.1


