Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 404EC723E6D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6TIu-0007nM-AL; Tue, 06 Jun 2023 05:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIl-0007gW-Mo
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6TIj-0004nL-KR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:48:31 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-30adc51b65cso5323718f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686044907; x=1688636907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X9BEnYkXN4CUvQfYdzeR/kF0zkEdwe1pZxUHeL2BNho=;
 b=dzKmEVAUhDxh577usKbqtnCCJlBCn86v02vAqQKfZy+MxXH55B9F2FtL8ukPOCTMgn
 JS6uT0K4nbV+w8qdXClt5h44uDUiT2AvJuTSVjECWnV4HTVnznDzavScbMyp2w2flds9
 +bKPmTsaQtIzT0W0ZNEElHLbGnrhOp19ShSAs8a55c7DKV6Cxo8jC0Lmfh65n4wJHuSv
 OjklU9VVvlkjlqwoAJLK5bVCKSt3TOTn1OKICMHD6Ra32CqG87FP5qd1/NpPfRyDmjek
 vWp9CqCdBw/Jd/NeC/+N1kynk+eqty2mg1Bl6Whup2kPwa2gpUztj9fmHX9p2ZYoQKcm
 yHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686044907; x=1688636907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9BEnYkXN4CUvQfYdzeR/kF0zkEdwe1pZxUHeL2BNho=;
 b=WM1tfdxNflkHP7rb+q8k5Sy9UgVon1e1zNFy4ei08j8SOnoX+Ol5oJHmLJSYbPCmRy
 eUbCqTd5iPqSs3lPXfi92ZzSYWFwL5f7F5JMYFjtbusubnw3+0Usy0rC4vqQiUqBuQXG
 Ho8mDsZy4gZVHnQAQ6Ye971jNIOGaD/XfBeBn4hoIInQ1QrZebXXy4f9PbAdIrusYKG8
 WnO9/MhtW+qrXgmNY9nd/i9xU2dPRfM1dqFRLqLD7d+C7ANLUsOnFdL2UOcuq/xmxWjV
 aw4SkIiFfKEDnjNDRP5kcm/c4CeULI24ebhcAnvhRtgFJMHFB3WG0h0yKmyQiTzIW8Ga
 0+Mg==
X-Gm-Message-State: AC+VfDxy/lU30CWmo/uAEr1NsiFXR3dNT07c2U326rT3HFRMdofUyxMW
 Hu5MCqo0BgVCQmnWsfl2oqn//aBJSETchqBEbgE=
X-Google-Smtp-Source: ACHHUZ44r3i685C2uzOmjpA1h1SiFrMt/rOvoq9X5RVwKncqIhwEkccwxqcUUTqtOj1vjyxzaD/mbQ==
X-Received: by 2002:a5d:5746:0:b0:30a:e647:fc2e with SMTP id
 q6-20020a5d5746000000b0030ae647fc2emr1624951wrw.19.1686044907804; 
 Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v10-20020a5d4b0a000000b0030789698eebsm12134017wrq.89.2023.06.06.02.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 02:48:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/42] target/arm: Use tcg_gen_qemu_{st, ld}_i128 for do_fp_{st,
 ld}
Date: Tue,  6 Jun 2023 10:47:56 +0100
Message-Id: <20230606094814.3581397-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230606094814.3581397-1-peter.maydell@linaro.org>
References: <20230606094814.3581397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

While we don't require 16-byte atomicity here, using a single larger
operation simplifies the code.  Introduce finalize_memop_asimd for this.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230530191438.411344-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.h     | 24 +++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 35 +++++++++++-----------------------
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index c1e57a52ca2..3aa486a1ab6 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -609,6 +609,30 @@ static inline MemOp finalize_memop_pair(DisasContext *s, MemOp opc)
     return finalize_memop_atom(s, opc, atom);
 }
 
+/**
+ * finalize_memop_asimd:
+ * @s: DisasContext
+ * @opc: size+sign+align of the memory operation
+ *
+ * Like finalize_memop_atom, but with atomicity of AccessType_ASIMD.
+ */
+static inline MemOp finalize_memop_asimd(DisasContext *s, MemOp opc)
+{
+    /*
+     * In the pseudocode for Mem[], with AccessType_ASIMD, size == 16,
+     * if IsAligned(8), the first case provides separate atomicity for
+     * the pair of 64-bit accesses.  If !IsAligned(8), the middle cases
+     * do not apply, and we're left with the final case of no atomicity.
+     * Thus MO_ATOM_IFALIGN_PAIR.
+     *
+     * For other sizes, normal LSE2 rules apply.
+     */
+    if ((opc & MO_SIZE) == MO_128) {
+        return finalize_memop_atom(s, opc, MO_ATOM_IFALIGN_PAIR);
+    }
+    return finalize_memop(s, opc);
+}
+
 /**
  * asimd_imm_const: Expand an encoded SIMD constant value
  *
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 1fff74c73a0..3674fc1bc16 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -911,26 +911,20 @@ static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, int size)
 {
     /* This writes the bottom N bits of a 128 bit wide vector to memory */
     TCGv_i64 tmplo = tcg_temp_new_i64();
-    MemOp mop;
+    MemOp mop = finalize_memop_asimd(s, size);
 
     tcg_gen_ld_i64(tmplo, cpu_env, fp_reg_offset(s, srcidx, MO_64));
 
-    if (size < 4) {
-        mop = finalize_memop(s, size);
+    if (size < MO_128) {
         tcg_gen_qemu_st_i64(tmplo, tcg_addr, get_mem_index(s), mop);
     } else {
-        bool be = s->be_data == MO_BE;
-        TCGv_i64 tcg_hiaddr = tcg_temp_new_i64();
         TCGv_i64 tmphi = tcg_temp_new_i64();
+        TCGv_i128 t16 = tcg_temp_new_i128();
 
         tcg_gen_ld_i64(tmphi, cpu_env, fp_reg_hi_offset(s, srcidx));
+        tcg_gen_concat_i64_i128(t16, tmplo, tmphi);
 
-        mop = s->be_data | MO_UQ;
-        tcg_gen_qemu_st_i64(be ? tmphi : tmplo, tcg_addr, get_mem_index(s),
-                            mop | (s->align_mem ? MO_ALIGN_16 : 0));
-        tcg_gen_addi_i64(tcg_hiaddr, tcg_addr, 8);
-        tcg_gen_qemu_st_i64(be ? tmplo : tmphi, tcg_hiaddr,
-                            get_mem_index(s), mop);
+        tcg_gen_qemu_st_i128(t16, tcg_addr, get_mem_index(s), mop);
     }
 }
 
@@ -942,24 +936,17 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
     /* This always zero-extends and writes to a full 128 bit wide vector */
     TCGv_i64 tmplo = tcg_temp_new_i64();
     TCGv_i64 tmphi = NULL;
-    MemOp mop;
+    MemOp mop = finalize_memop_asimd(s, size);
 
-    if (size < 4) {
-        mop = finalize_memop(s, size);
+    if (size < MO_128) {
         tcg_gen_qemu_ld_i64(tmplo, tcg_addr, get_mem_index(s), mop);
     } else {
-        bool be = s->be_data == MO_BE;
-        TCGv_i64 tcg_hiaddr;
+        TCGv_i128 t16 = tcg_temp_new_i128();
+
+        tcg_gen_qemu_ld_i128(t16, tcg_addr, get_mem_index(s), mop);
 
         tmphi = tcg_temp_new_i64();
-        tcg_hiaddr = tcg_temp_new_i64();
-
-        mop = s->be_data | MO_UQ;
-        tcg_gen_qemu_ld_i64(be ? tmphi : tmplo, tcg_addr, get_mem_index(s),
-                            mop | (s->align_mem ? MO_ALIGN_16 : 0));
-        tcg_gen_addi_i64(tcg_hiaddr, tcg_addr, 8);
-        tcg_gen_qemu_ld_i64(be ? tmplo : tmphi, tcg_hiaddr,
-                            get_mem_index(s), mop);
+        tcg_gen_extr_i128_i64(tmplo, tmphi, t16);
     }
 
     tcg_gen_st_i64(tmplo, cpu_env, fp_reg_offset(s, destidx, MO_64));
-- 
2.34.1


