Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF2E7359B6
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFtP-0001En-Re; Mon, 19 Jun 2023 10:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsl-0000bi-1C
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBFsi-0002DU-Vu
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:29:26 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so8620755e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184963; x=1689776963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=grRrhMxoKNz9VHeMIDBGTUawovkjPz3zJ6U9jbCL8Ps=;
 b=L9z/Lr4/nKaNQS6DUjUehMP1i96lbcwsiaINO7Z6UiiOxh2qSSlnNXkuTDkFU3Ex4N
 ohVlYSi9BQ7Qg6dxhUOWCtEw2cDyn3X+hGFBRka4zGww8u28b1mTbXxfpmZLh1zeCUIy
 fP4LHBzRs9iXEWMpvuI47Y23KfnCKDFfTeC1fdKq2Da7tTGhWr8gjICu3JoeAMzuXu3x
 r6EqHgVLIX30K+dVtXs49htiG2TjRDhge9WzzhTPlK/42e5hZk2RSRAT3hnUL0qGZ8s5
 dcDn1Rk6dsW2m8t8eDV4/SqFJ7ORyDvlCuK6GCPg9eXqXZdgqBJqQ6N6hvkqpd/s5h0+
 itiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184963; x=1689776963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grRrhMxoKNz9VHeMIDBGTUawovkjPz3zJ6U9jbCL8Ps=;
 b=TW/fPscCpl0huR9mHgY4aiJmQL5v2l2QoeMzTx3dul+sZXTBnJs5izFTvnMjiZaJ0E
 /lsb3pqE3xxkV5tpAHL6j2u8BKwx0SNmoQZ8H5sFGp0PR7VTViBBqPR45t4gngbPPJJV
 0kntKNhgkZdPavymN1ZsiOVVsDvoqV3rf7XVqb3Bi+bvkqL/OLKuWoHZed+8uEZSOiwa
 BOEJCJlgSBFbMW6OnnIgiG4DMHK86/czmYFEZ3dEJpDPlImQXVPaEdC7oqbe+xzbXcW6
 8CdtUrQW2uM9rJn+KUrl+xnV5hqX6PnTScCLjn2nb/4uc+0TCLf74JHKKcORMCnXrIDo
 O5Ng==
X-Gm-Message-State: AC+VfDwhLYuAJ8Yr+xtnDHjsxHfZ+AQoUNT1ghI2SJcngZiL5uT3N0gu
 2TRqYwfFEyRUfSzCT436qvd+fXslTtZfnpqDw7w=
X-Google-Smtp-Source: ACHHUZ6MIw47EsEyFiyWlnlKa5FVb/QBClQRwA0Y6CBrgIDJfHtvhs3nIPqFOjobm99qbmeRJx5RYg==
X-Received: by 2002:a7b:c34d:0:b0:3f7:b1df:26d with SMTP id
 l13-20020a7bc34d000000b003f7b1df026dmr11376578wmj.38.1687184963564; 
 Mon, 19 Jun 2023 07:29:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a05600c224200b003f9b53959a4sm429012wmm.43.2023.06.19.07.29.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:29:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/33] target/arm: Convert LDR/STR with 12-bit immediate to
 decodetree
Date: Mon, 19 Jun 2023 15:28:57 +0100
Message-Id: <20230619142914.963184-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142914.963184-1-peter.maydell@linaro.org>
References: <20230619142914.963184-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Convert the LDR and STR instructions which use a 12-bit immediate
offset to decodetree. We can reuse the existing LDR and STR
trans functions for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230602155223.2040685-14-peter.maydell@linaro.org
---
 target/arm/tcg/a64.decode      |  25 ++++++++
 target/arm/tcg/translate-a64.c | 104 +++++----------------------------
 2 files changed, 41 insertions(+), 88 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index d55c09684a7..d6b31c10838 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -395,3 +395,28 @@ STR_v_i         sz:2 111 1 00 00 0 ......... 11 ..... ..... @ldst_imm_pre sign=0
 STR_v_i         00 111 1 00 10 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0 sz=4
 LDR_v_i         sz:2 111 1 00 01 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0
 LDR_v_i         00 111 1 00 11 0 ......... 11 ..... ..... @ldst_imm_pre sign=0 ext=0 sz=4
+
+# Load/store with an unsigned 12 bit immediate, which is scaled by the
+# element size. The function gets the sz:imm and returns the scaled immediate.
+%uimm_scaled   10:12 sz:3 !function=uimm_scaled
+
+@ldst_uimm      .. ... . .. .. ............ rn:5 rt:5 &ldst_imm unpriv=0 p=0 w=0 imm=%uimm_scaled
+
+STR_i           sz:2 111 0 01 00 ............ ..... ..... @ldst_uimm sign=0 ext=0
+LDR_i           00 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=0
+LDR_i           01 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=1
+LDR_i           10 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=1 sz=2
+LDR_i           11 111 0 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=3
+LDR_i           00 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=0
+LDR_i           01 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=1
+LDR_i           10 111 0 01 10 ............ ..... ..... @ldst_uimm sign=1 ext=0 sz=2
+LDR_i           00 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=0
+LDR_i           01 111 0 01 11 ............ ..... ..... @ldst_uimm sign=1 ext=1 sz=1
+
+# PRFM
+NOP             11 111 0 01 10 ------------ ----- -----
+
+STR_v_i         sz:2 111 1 01 00 ............ ..... ..... @ldst_uimm sign=0 ext=0
+STR_v_i         00 111 1 01 10 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=4
+LDR_v_i         sz:2 111 1 01 01 ............ ..... ..... @ldst_uimm sign=0 ext=0
+LDR_v_i         00 111 1 01 11 ............ ..... ..... @ldst_uimm sign=0 ext=0 sz=4
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index a1ddb1a9cdd..82da83d9733 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -46,6 +46,22 @@ enum a64_shift_type {
     A64_SHIFT_TYPE_ROR = 3
 };
 
+/*
+ * Helpers for extracting complex instruction fields
+ */
+
+/*
+ * For load/store with an unsigned 12 bit immediate scaled by the element
+ * size. The input has the immediate field in bits [14:3] and the element
+ * size in [2:0].
+ */
+static int uimm_scaled(DisasContext *s, int x)
+{
+    unsigned imm = x >> 3;
+    unsigned scale = extract32(x, 0, 3);
+    return imm << scale;
+}
+
 /*
  * Include the generated decoders.
  */
@@ -3234,91 +3250,6 @@ static void disas_ldst_reg_roffset(DisasContext *s, uint32_t insn,
     }
 }
 
-/*
- * Load/store (unsigned immediate)
- *
- * 31 30 29   27  26 25 24 23 22 21        10 9     5
- * +----+-------+---+-----+-----+------------+-------+------+
- * |size| 1 1 1 | V | 0 1 | opc |   imm12    |  Rn   |  Rt  |
- * +----+-------+---+-----+-----+------------+-------+------+
- *
- * For non-vector:
- *   size: 00-> byte, 01 -> 16 bit, 10 -> 32bit, 11 -> 64bit
- *   opc: 00 -> store, 01 -> loadu, 10 -> loads 64, 11 -> loads 32
- * For vector:
- *   size is opc<1>:size<1:0> so 100 -> 128 bit; 110 and 111 unallocated
- *   opc<0>: 0 -> store, 1 -> load
- * Rn: base address register (inc SP)
- * Rt: target register
- */
-static void disas_ldst_reg_unsigned_imm(DisasContext *s, uint32_t insn,
-                                        int opc,
-                                        int size,
-                                        int rt,
-                                        bool is_vector)
-{
-    int rn = extract32(insn, 5, 5);
-    unsigned int imm12 = extract32(insn, 10, 12);
-    unsigned int offset;
-    TCGv_i64 clean_addr, dirty_addr;
-    bool is_store;
-    bool is_signed = false;
-    bool is_extended = false;
-    MemOp memop;
-
-    if (is_vector) {
-        size |= (opc & 2) << 1;
-        if (size > 4) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = !extract32(opc, 0, 1);
-        if (!fp_access_check(s)) {
-            return;
-        }
-        memop = finalize_memop_asimd(s, size);
-    } else {
-        if (size == 3 && opc == 2) {
-            /* PRFM - prefetch */
-            return;
-        }
-        if (opc == 3 && size > 1) {
-            unallocated_encoding(s);
-            return;
-        }
-        is_store = (opc == 0);
-        is_signed = !is_store && extract32(opc, 1, 1);
-        is_extended = (size < 3) && extract32(opc, 0, 1);
-        memop = finalize_memop(s, size + is_signed * MO_SIGN);
-    }
-
-    if (rn == 31) {
-        gen_check_sp_alignment(s);
-    }
-    dirty_addr = read_cpu_reg_sp(s, rn, 1);
-    offset = imm12 << size;
-    tcg_gen_addi_i64(dirty_addr, dirty_addr, offset);
-
-    clean_addr = gen_mte_check1(s, dirty_addr, is_store, rn != 31, memop);
-
-    if (is_vector) {
-        if (is_store) {
-            do_fp_st(s, rt, clean_addr, memop);
-        } else {
-            do_fp_ld(s, rt, clean_addr, memop);
-        }
-    } else {
-        TCGv_i64 tcg_rt = cpu_reg(s, rt);
-        bool iss_sf = disas_ldst_compute_iss_sf(size, is_signed, opc);
-        if (is_store) {
-            do_gpr_st(s, tcg_rt, clean_addr, memop, true, rt, iss_sf, false);
-        } else {
-            do_gpr_ld(s, tcg_rt, clean_addr, memop,
-                      is_extended, true, rt, iss_sf, false);
-        }
-    }
-}
-
 /* Atomic memory operations
  *
  *  31  30      27  26    24    22  21   16   15    12    10    5     0
@@ -3618,9 +3549,6 @@ static void disas_ldst_reg(DisasContext *s, uint32_t insn)
             return;
         }
         break;
-    case 1:
-        disas_ldst_reg_unsigned_imm(s, insn, opc, size, rt, is_vector);
-        return;
     }
     unallocated_encoding(s);
 }
-- 
2.34.1


