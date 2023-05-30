Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E1D716D52
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:17:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44o3-0006UT-SH; Tue, 30 May 2023 15:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44nv-00063w-73
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:49 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44ns-0004cj-O6
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:14:46 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d2c865e4eso3692059b3a.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474083; x=1688066083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywmi9L6z6eQWYQYbR+hM2bvxiXGNwKV8h04XC6ZlKog=;
 b=T5aRfsuUE3ZO5ywinPe7JUT8tv51OHkqz6C4MNc2nh4A7VWQcED5jnCbs7UAhEac1G
 HO1WytcBZpUFXvA2WUJN95dQZFcs0AM42I0LUuQiRV1T0oWBX1VQ+D07weokPO8SfROb
 LnzMTdaURvWtPibOwyQPUm7O2wIz4FLsorCbdE2nyKQ48NvE/uUEvyWwhqydz01dxeM9
 IywIchjMtTd57Bx32KaMLcQwsqC/OGANUWu8XFAOl2E0tGAimGTqmGYHBqp9rshAT7JH
 dNj8JM4PRW+BDFawOBitd9bcOOjP8BsYABxsTNSNW4oIfNv6xKcnB+sTM8DXqQ6CBCMk
 JZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474083; x=1688066083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ywmi9L6z6eQWYQYbR+hM2bvxiXGNwKV8h04XC6ZlKog=;
 b=ACMWjVOrKBBjX5YT2/onUeY2lWzNiVU51TmPg6jUmuDpKuZi4pzPFa49LOMjbiE+Px
 PHuG9Y9cqAxQlK79ZN8Ah0aJ+xHTrUfXqYa8P235AsANyK6NLYX/JWLMt8sflhb1i3/y
 81lzYetzaN4/jwuIKXiIFNPK4hzWGd0ZLx5COIEwe1ZNC9cevYpp6YwSonoeF0i7HI3c
 e9fLE0QWaKPOiHBHQgVEyct3DQbCh7VWdMapOqtW3NzfJx6bqSbWltCsJiIhu5y+jpoD
 /9cE6weUv3mBYZw0SB+7gZxbTYDLqMBD1RHPEsV7BAneudayHz3qbJKmV0XUnfmiGnOU
 MyMw==
X-Gm-Message-State: AC+VfDyeEpy9tsdg4WKW7xkypwdlwJjQG7KDMbdWYFt5KZSwRHWJEe+W
 D6/cEGHDmhhSSR5ZrfyFTBzSAJgoH+M9vo03zZE=
X-Google-Smtp-Source: ACHHUZ6s/1ZgTfpqGLx5ywu1kmYTAO2FUZUQNL3MALh3Pxh+HGWHKFIxcPSPvEseOJFRQhzw9B82Lw==
X-Received: by 2002:a05:6a00:14cc:b0:643:96bc:b292 with SMTP id
 w12-20020a056a0014cc00b0064396bcb292mr4540934pfu.5.1685474083439; 
 Tue, 30 May 2023 12:14:43 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 05/20] target/arm: Use tcg_gen_qemu_{st,
 ld}_i128 for do_fp_{st, ld}
Date: Tue, 30 May 2023 12:14:23 -0700
Message-Id: <20230530191438.411344-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

While we don't require 16-byte atomicity here, using a single larger
operation simplifies the code.  Introduce finalize_memop_asimd for this.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


