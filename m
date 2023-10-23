Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 315997D3EDB
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRH-0005rw-T6; Mon, 23 Oct 2023 14:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR1-0005ag-6F
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:51 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQy-0008Bv-QQ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:50 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5b837dc2855so2423579a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084827; x=1698689627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXxMfityb0ik1K4HMzfaPfkTROJcCUZstvsWWJk+1bM=;
 b=wnBHzH7FqJD8kSlOF05/VHaozXtAOqG/0boWOs9cKKwZV4wab+WsJxrSZVHDk4RzvJ
 PkmWYh+UU3BgF3rvHL0065lB3abRxHwY92ATGBAltRPUYQenmcVp+iqSVG7DxRuWk8eh
 6uWuKS0SUj6RpTwEKDpPAASSFG4Tq6ufB6CekG807LNFT0tTdOXj11FXFMPB9XixQ9t7
 69kmvymooxVN8KnmM+2YzE2T/V2L7thRC2FsJOUVjsxbrZbSiWgEdF7Lh+2pFUtZtq25
 r6+P0u3YDy0vumYxQOXAJeRnZPk99ifGmwLHuBcpvPe21AE9UjBNPNV1Fm2rbQaKv25p
 B7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084827; x=1698689627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXxMfityb0ik1K4HMzfaPfkTROJcCUZstvsWWJk+1bM=;
 b=WniH1sQmFg5CbNQJU5iqcWYxeTzI9Lq6mJPyobw60tBRFbOoWMLuGkWj5Szk4EfOEU
 8c23gdpDUUApS9Sa50bWGzv00bc1PASFSy9J7288p+mvNPqpRYO3KdSf+vA6OlyG1Xwc
 2agq4N8ocsQC7ldAW81EMnVI2CRU1jk5eCwjTvaG/Wg/RQ8Wr8RpUTKw0yYFeDB3pdsL
 ypJuQ86crUOBr828LsmN+FHy/1+h1nA4RI7vElalCNam4fiCxo8796gkzNqFBlADxPSY
 5MhsHTMSkFs3Yu0bMeh8zMoejD3QWuA8BB798GTBw+VdKoDKhpTve3BdDzZpdpfTQ+mM
 7+/w==
X-Gm-Message-State: AOJu0YzQuzR9BnHp+xxM1X4Orun2MOSWFSeHGAsxpTE08RnDBIMJ2Z/6
 0uV0kYBkUVmU1FbwGa63lIfBVKZmiT/3ER01qzc=
X-Google-Smtp-Source: AGHT+IFwkq7BtSDuAgO1padcHA7n1uOSSlkMLGspKklfrbKOYJc7aHKM/RfOYgfpZfEHrjpjcpMMZw==
X-Received: by 2002:a05:6a21:1a0:b0:15e:7323:5bf3 with SMTP id
 le32-20020a056a2101a000b0015e73235bf3mr450152pzb.26.1698084827401; 
 Mon, 23 Oct 2023 11:13:47 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v3 19/38] tcg/loongarch64: Use tcg_use_softmmu
Date: Mon, 23 Oct 2023 11:13:10 -0700
Message-Id: <20231023181329.171490-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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
 tcg/loongarch64/tcg-target.c.inc | 126 +++++++++++++++----------------
 1 file changed, 61 insertions(+), 65 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 801302d85d..ccf133db4b 100644
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


