Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBB716D2A
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:06:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aZ-0001eq-TR; Tue, 30 May 2023 15:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zh-0000p1-7t
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:05 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zb-0000tp-K4
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:04 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d2f99c8c3so3554528b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473197; x=1688065197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nu78ldlqkMP1+teKPFh/CrHuSOc6YSFz9+/gsYvHD7U=;
 b=fAZfPMYC1XXTtA9A02MyKmZRSjef6Y8V+X4Mwe1lTmwQbzbv6CLimWHPUFEYCFFdzs
 Z5eHDnP4tM6UjzJcQjzAT1c8kATPvApklrRSdPD6H772k6WS+/jZ22wOO8j5aVjMfuj0
 KORU7qib/H4qBL70zD/gfk4MVgXcUpvhnncihJfZ8mBK1Kn+DINw5klF/o2IlxnLwC1A
 iBCUbjx8CKtjChmub63d1zUmliJ4GRcvR1HekcmSX39iuIDNR6eaexHCMj05kCz8YaxC
 kNg9GzJrzf/oW76mIFdR4Z7osR5a3FLpfGOtq7iGBrwMpeq2PCmL0i7mqI8QTcEKSuXk
 4wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473197; x=1688065197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nu78ldlqkMP1+teKPFh/CrHuSOc6YSFz9+/gsYvHD7U=;
 b=YPa22OoO94HTKMwwHS4n3nXZdxJXkvZDg02EhB76qhbZAjEY+v4xJV3zVwZBSJ8upz
 60jqUes+ZJnDNHErlfM9PS6dftyo4RiiRrlyUUMJ+D6b+X+heC2mYxp+00+hkUtNUEvf
 2s1TJZH6ZQn5iZCRd28OjGtSFyBU8plFVr2msBvetvOTVmUsqnU2yi10EqcfRodaavb1
 pe8JWnJKgI0t6sERYdBNPAGNaVz7TRa+hsy3tUy2jmIIeoMKkHChSggqYzlkj4FBgJL6
 NoT9crtDhihdBcyolPRgFZKvOtOX+DMKfrKS2KXxgECQpHdyELCKmDttw/m4fRiSRsHs
 Q7Xg==
X-Gm-Message-State: AC+VfDzwTHS4E31VGN+j2cu/+rKzU8dBUV5WYU+sioUOBE9eQpQaicWt
 Kwd/TqkGcdyiUE4b/tyZJfrZWHsnt4YnZykaHhE=
X-Google-Smtp-Source: ACHHUZ5HkaVE75wbHXK/AQnEa86Ij/Y2vdE9L/FhnPHb1uvanpfW8jzXOp+YM2nJuv5iLxPD2KZrXw==
X-Received: by 2002:a05:6a20:394c:b0:101:5192:18a9 with SMTP id
 r12-20020a056a20394c00b00101519218a9mr3454440pzg.21.1685473197600; 
 Tue, 30 May 2023 11:59:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.11.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 11:59:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 08/27] tcg/aarch64: Simplify constraints on qemu_ld/st
Date: Tue, 30 May 2023 11:59:30 -0700
Message-Id: <20230530185949.410208-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Adjust the softmmu tlb to use TMP[0-2], not any of the normally available
registers.  Since we handle overlap betwen inputs and helper arguments,
we can allow any allocatable reg.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h |  2 --
 tcg/aarch64/tcg-target-con-str.h |  1 -
 tcg/aarch64/tcg-target.c.inc     | 45 ++++++++++++++------------------
 3 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index d6c6866878..109f4ab97c 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -10,11 +10,9 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(lZ, l)
 C_O0_I2(r, rA)
 C_O0_I2(rZ, r)
 C_O0_I2(w, r)
-C_O1_I1(r, l)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
diff --git a/tcg/aarch64/tcg-target-con-str.h b/tcg/aarch64/tcg-target-con-str.h
index 00adb64594..fb1a845b4f 100644
--- a/tcg/aarch64/tcg-target-con-str.h
+++ b/tcg/aarch64/tcg-target-con-str.h
@@ -9,7 +9,6 @@
  * REGS(letter, register_mask)
  */
 REGS('r', ALL_GENERAL_REGS)
-REGS('l', ALL_QLDST_REGS)
 REGS('w', ALL_VECTOR_REGS)
 
 /*
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 5e7ac6fb76..00d9033e2f 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -132,14 +132,6 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define ALL_GENERAL_REGS  0xffffffffu
 #define ALL_VECTOR_REGS   0xffffffff00000000ull
 
-#ifdef CONFIG_SOFTMMU
-#define ALL_QLDST_REGS \
-    (ALL_GENERAL_REGS & ~((1 << TCG_REG_X0) | (1 << TCG_REG_X1) | \
-                          (1 << TCG_REG_X2) | (1 << TCG_REG_X3)))
-#else
-#define ALL_QLDST_REGS   ALL_GENERAL_REGS
-#endif
-
 /* Match a constant valid for addition (12-bit, optionally shifted).  */
 static inline bool is_aimm(uint64_t val)
 {
@@ -1648,7 +1640,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     unsigned s_bits = opc & MO_SIZE;
     unsigned s_mask = (1u << s_bits) - 1;
     unsigned mem_index = get_mmuidx(oi);
-    TCGReg x3;
+    TCGReg addr_adj;
     TCGType mask_type;
     uint64_t compare_mask;
 
@@ -1660,27 +1652,27 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {x0,x1}.  */
+    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
     QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) > 0);
     QEMU_BUILD_BUG_ON(TLB_MASK_TABLE_OFS(0) < -512);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
-    tcg_out_insn(s, 3314, LDP, TCG_REG_X0, TCG_REG_X1, TCG_AREG0,
+    tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
                  TLB_MASK_TABLE_OFS(mem_index), 1, 0);
 
     /* Extract the TLB index from the address into X0.  */
     tcg_out_insn(s, 3502S, AND_LSR, mask_type == TCG_TYPE_I64,
-                 TCG_REG_X0, TCG_REG_X0, addr_reg,
+                 TCG_REG_TMP0, TCG_REG_TMP0, addr_reg,
                  s->page_bits - CPU_TLB_ENTRY_BITS);
 
-    /* Add the tlb_table pointer, creating the CPUTLBEntry address into X1.  */
-    tcg_out_insn(s, 3502, ADD, 1, TCG_REG_X1, TCG_REG_X1, TCG_REG_X0);
+    /* Add the tlb_table pointer, forming the CPUTLBEntry address in TMP1. */
+    tcg_out_insn(s, 3502, ADD, 1, TCG_REG_TMP1, TCG_REG_TMP1, TCG_REG_TMP0);
 
-    /* Load the tlb comparator into X0, and the fast path addend into X1.  */
-    tcg_out_ld(s, addr_type, TCG_REG_X0, TCG_REG_X1,
+    /* Load the tlb comparator into TMP0, and the fast path addend into TMP1. */
+    tcg_out_ld(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP1,
                is_ld ? offsetof(CPUTLBEntry, addr_read)
                      : offsetof(CPUTLBEntry, addr_write));
-    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_X1, TCG_REG_X1,
+    tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP1, TCG_REG_TMP1,
                offsetof(CPUTLBEntry, addend));
 
     /*
@@ -1689,25 +1681,26 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
      * cross pages using the address of the last byte of the access.
      */
     if (a_mask >= s_mask) {
-        x3 = addr_reg;
+        addr_adj = addr_reg;
     } else {
+        addr_adj = TCG_REG_TMP2;
         tcg_out_insn(s, 3401, ADDI, addr_type,
-                     TCG_REG_X3, addr_reg, s_mask - a_mask);
-        x3 = TCG_REG_X3;
+                     addr_adj, addr_reg, s_mask - a_mask);
     }
     compare_mask = (uint64_t)s->page_mask | a_mask;
 
-    /* Store the page mask part of the address into X3.  */
-    tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_X3, x3, compare_mask);
+    /* Store the page mask part of the address into TMP2.  */
+    tcg_out_logicali(s, I3404_ANDI, addr_type, TCG_REG_TMP2,
+                     addr_adj, compare_mask);
 
     /* Perform the address comparison. */
-    tcg_out_cmp(s, addr_type, TCG_REG_X0, TCG_REG_X3, 0);
+    tcg_out_cmp(s, addr_type, TCG_REG_TMP0, TCG_REG_TMP2, 0);
 
     /* If not equal, we jump to the slow path. */
     ldst->label_ptr[0] = s->code_ptr;
     tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
 
-    h->base = TCG_REG_X1,
+    h->base = TCG_REG_TMP1;
     h->index = addr_reg;
     h->index_ext = addr_type;
 #else
@@ -2802,12 +2795,12 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_qemu_ld_a64_i32:
     case INDEX_op_qemu_ld_a32_i64:
     case INDEX_op_qemu_ld_a64_i64:
-        return C_O1_I1(r, l);
+        return C_O1_I1(r, r);
     case INDEX_op_qemu_st_a32_i32:
     case INDEX_op_qemu_st_a64_i32:
     case INDEX_op_qemu_st_a32_i64:
     case INDEX_op_qemu_st_a64_i64:
-        return C_O0_I2(lZ, l);
+        return C_O0_I2(rZ, r);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-- 
2.34.1


