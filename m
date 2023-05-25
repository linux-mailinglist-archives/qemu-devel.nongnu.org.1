Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAAE711A98
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 01:28:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2KLh-0005uy-CU; Thu, 25 May 2023 19:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLV-0005mz-B4
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2KLO-0005ld-Lw
 for qemu-devel@nongnu.org; Thu, 25 May 2023 19:26:10 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae454844edso958755ad.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685057164; x=1687649164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rtSYCMxMp7gu1dlc7aLKdss5Sdhc6PP6/xIuz/FTNhg=;
 b=jGXUk8G9TdikrwgLEjvP0EonH9TS/u7MWh3Oz6g/ocvBW+gBIUyXB0pLw7ZiSy7pPQ
 spH8b17JyMOtf/GWtmTZPP+mYKGt2IcQFRtzsBPHZdKYzNvc0DFnES/UnHDJzK78EtMZ
 SLCNqWLbXGeMTpYO3Eg/Kz3tHdjoVn54EOgol9wjRRLhO1IAknZ6DRDhhx5ALDvV6hp8
 Wjs7v+I1+tyj06wxPv14e4PFrx+E2WelxBZ+ZJWBVLX0hu2OYLj3lLUQ3PeBylxfy7Dq
 oWcIxAsUDtTeDsLQB4yYFeoKcUsH8mPtFq0L+xVchPr483S4x/1SYBo9EKFNlr/IdICs
 mM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685057164; x=1687649164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rtSYCMxMp7gu1dlc7aLKdss5Sdhc6PP6/xIuz/FTNhg=;
 b=Nn44cGMu5nuMwo4iFaf+Lx6pEid25Z/MKAqR4UmsETCJLBqFs5kug7f50OwzxeOegL
 o4/g/w3HRKwmYfKmfQYZGtL5sfkUX3EtnxrNXpwNBTNRYA6CPixtwP7ubGjeaHFng+tv
 OUU8vNBL6WvIBvPsPKaEczcjt4EJ7QNoGtpoyQi60DzzbsI7q4Q5O53Ueoq3y9jP9bsc
 S5PmBE4vQ+rH1WrxeC7psrPCvAraddwjoXq9QyvGM5BhLoB+UzBnsbo10pARs8+MKbg3
 sp77q99pSG2+FAmSSOH2ixp1YZqkoC4bpx+RehKNHz996E2ZjusMD6RSuJXQE088uvE3
 smNg==
X-Gm-Message-State: AC+VfDwGkMK+pI1YEb7k+IDbtUrQWVi682wFnmdHAJ2we1UJnsX/HZVY
 1i/mchA2Ll/N+KL+rh2L/4V9fjbMshUlIdFYEFw=
X-Google-Smtp-Source: ACHHUZ6TaxE8VI17yzoFVoHcqPs0/G1rndWzX/otbMFJk6+bTwhgB+GS9wlf8x04iotXqMdraYbLyw==
X-Received: by 2002:a17:902:c3c6:b0:1af:bade:2b0a with SMTP id
 j6-20020a170902c3c600b001afbade2b0amr321794plj.3.1685057163695; 
 Thu, 25 May 2023 16:26:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a170902ea0f00b0019e60c645b1sm1885036plg.305.2023.05.25.16.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 16:26:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/20] target/arm: Use tcg_gen_qemu_{st,
 ld}_i128 for do_fp_{st, ld}
Date: Thu, 25 May 2023 16:25:43 -0700
Message-Id: <20230525232558.1758967-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525232558.1758967-1-richard.henderson@linaro.org>
References: <20230525232558.1758967-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

While we don't require 16-byte atomicity here, using a single larger
operation simplifies the code.  Introduce finalize_memop_asimd for this.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h     | 24 +++++++++++++++++++++++
 target/arm/tcg/translate-a64.c | 35 +++++++++++-----------------------
 2 files changed, 35 insertions(+), 24 deletions(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 9a33076c3d..626cf07970 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -604,6 +604,30 @@ static inline MemOp finalize_memop_pair(DisasContext *s, MemOp opc)
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
index 0e720f2612..6bb68618a0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -921,26 +921,20 @@ static void do_fp_st(DisasContext *s, int srcidx, TCGv_i64 tcg_addr, int size)
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
 
@@ -952,24 +946,17 @@ static void do_fp_ld(DisasContext *s, int destidx, TCGv_i64 tcg_addr, int size)
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


