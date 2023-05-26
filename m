Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C201A711B1A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 02:26:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2LFG-0002bC-Rw; Thu, 25 May 2023 20:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFE-0002Zk-GG
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:48 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2LFB-0002AL-Tk
 for qemu-devel@nongnu.org; Thu, 25 May 2023 20:23:48 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-528dd896165so104908a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 17:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685060622; x=1687652622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cPi7/umNFT9yA55UTYS9B+2Cw8yXVqd5/fVGdM9ye4=;
 b=ETKEwRHj8aLnNU+hFxol8zCD0AIva0jScKufj/IqpYdcjrF11ORc40YwjpPzkFZG8B
 Ki8LKqM9FlGI8n5RhatSNZZaGwgVJd7QCU9EtDWxswfprUFvLsrMs+kNiuT9okM0vXYT
 GBNr3uF2sjUiN9Y0MH6MSKefqorLsWgcdiFUftdDmxCbG8UvASR9/9u2YfddEysy6jLs
 sJqXo0CHYCiSUCyOkFvhkwer5LVn02Tuy2ciFd/T0mLevWv1v0UuBYz2It6SLKcGZxSE
 9hUsrod85kgUUQ5VChTcOzrrVySH+bpMyi0voXKlwO2Gb3fyhTyN7imWdqe/tI80y+Sv
 owKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685060622; x=1687652622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6cPi7/umNFT9yA55UTYS9B+2Cw8yXVqd5/fVGdM9ye4=;
 b=UDL2GmZbm46WYMMoJJsF1/B8L7qCiWFMk1dxTaCAgPLNqL55mRmivroaXMXY5p3JAL
 vW3k/YhTcIh6i64LjZmQvAc/a8PE99PbOqC70OJZWoiI8ZXmMDhjQF96vtpisSvrch96
 Piy0dJs4+4I5l5srb/64xiOH8znyLz+RgEvHk/QkvucNsdqavpVyqo+LegGEsPBskIP/
 04122ms8lUeRlrRhe5di++uE3vGaDr5e6o0eZ3i/Yw96TsNe3rdZ2TPKZ94icK5Ihr84
 rOyorFPk7iBCl0AZIUAvyJ8Kgw34Usbnyy0/iuskpe8+Kfw7t7ntG/FohUjeDsHAl5aU
 6qtg==
X-Gm-Message-State: AC+VfDz/f4x4SwTBSSZAxkrB2A6rZmpLf0rT2YErreiBnVMZSGUSKmQ8
 hXtDHuDCnRcY2mt7VmaFHtvrI2mIs4UI6Md3w+M=
X-Google-Smtp-Source: ACHHUZ7Rm/ag7WiAHKSxLfRVnojs4nFzA42pZvVqr8hTtcEn/FEgybstvfifes8M4ie5H6udOO91qw==
X-Received: by 2002:a05:6a20:244f:b0:10b:5347:304 with SMTP id
 t15-20020a056a20244f00b0010b53470304mr27353pzc.7.1685060622022; 
 Thu, 25 May 2023 17:23:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s188-20020a635ec5000000b0053491d92b65sm1675593pgb.84.2023.05.25.17.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 17:23:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v4 08/16] tcg/aarch64: Simplify constraints on qemu_ld/st
Date: Thu, 25 May 2023 17:23:26 -0700
Message-Id: <20230526002334.1760495-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230526002334.1760495-1-richard.henderson@linaro.org>
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


