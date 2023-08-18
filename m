Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3872C78154A
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 00:15:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX7iu-0004wS-4p; Fri, 18 Aug 2023 18:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7iq-0004u6-II
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX7il-0004Lk-AN
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 18:13:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bf0b24d925so10721945ad.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 15:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692396810; x=1693001610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll6eV2dT9hdQRVMHGxDj3iwlPNHJczWyat1cyOxBXHA=;
 b=SXTuWWHTy2lHZweTXwy0H2TBNRGSdsajmSiN4pQtPYm13fopTnEZMMoqzoO5LtCjkv
 IOe0hLhcUqNI9iVHiwuc0oYQknWnBuhWkSd6/TDTVfi8rIhbOyf8TIq+w8zuSsumylEN
 ph3e43fOwrF0lSaUTROPPAcKGjkZJEP4YXf/Hh6LRerNCyhhadEl0wVwCDW7QwRr+t0R
 IhWB+FABSOMaYMn7NhkvIbZYooiMuYj3BcB2R7d2mTkxRr+XU2y7aCYdASWzQucS7GkR
 Gwve+YwyPJW6xK0fdIiucQKdeF90xMIXKhcv75F+YlwCaTC1liBwJ4EI7xfs1zQwsFQj
 QjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692396810; x=1693001610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll6eV2dT9hdQRVMHGxDj3iwlPNHJczWyat1cyOxBXHA=;
 b=V6pa9UYUr7RMj1jhasM0aJQLmzRcXbodGRQoq5IENgf2LtfDDHBw7HGVCqEosNlK0l
 SNgXby5R58Cnk6q3y17JHS8Bgnn1FxhtKFXLLYi8aiAGflS7hzjJz0fBFh5RRcRvjSW4
 5kWpbT+7z0/t75MWL4HjQXOGtnpGFClORsxwSAhKyH3GQ+LvbmL4GZZJhNNlGMqZkdW7
 s/qz10WSINTjpCDOv40l3Mpki3wIAk7mj58QuamMkusX32V5WnmLPyR0VeqDYOGDyTlj
 DmBwcWun91xWwB8MLQPzhPFKX70FssTv33TX39+vliElJJ+1ckL+tEZ2IjRo0j/fqo2F
 R7Sg==
X-Gm-Message-State: AOJu0YyCPapWXohWNMpcbECkzsaDOHcOuX8IKC1Ses6Va2vpKx+aELmZ
 1meZ5JZ2Cjr5vLlVuq6vUkiwQgb+hSjUmO/Fd4s=
X-Google-Smtp-Source: AGHT+IGdJvm7E6qpyRIqChojlEpDpbTH2uENDt+Z5Wed1KeaCWGGu0IzGqfgpuf21P0W6iwRE/bwtQ==
X-Received: by 2002:a17:902:820d:b0:1bb:ee1b:3cdf with SMTP id
 x13-20020a170902820d00b001bbee1b3cdfmr432480pln.67.1692396809766; 
 Fri, 18 Aug 2023 15:13:29 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a17090322c700b001bdb85291casm2231417plg.208.2023.08.18.15.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 15:13:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 01/23] tcg: Introduce negsetcond opcodes
Date: Fri, 18 Aug 2023 15:13:05 -0700
Message-Id: <20230818221327.150194-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818221327.150194-1-richard.henderson@linaro.org>
References: <20230818221327.150194-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Introduce a new opcode for negative setcond.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/tcg-ops.rst       |  6 ++++++
 include/tcg/tcg-op-common.h  |  4 ++++
 include/tcg/tcg-op.h         |  2 ++
 include/tcg/tcg-opc.h        |  2 ++
 include/tcg/tcg.h            |  1 +
 tcg/aarch64/tcg-target.h     |  2 ++
 tcg/arm/tcg-target.h         |  1 +
 tcg/i386/tcg-target.h        |  2 ++
 tcg/loongarch64/tcg-target.h |  3 +++
 tcg/mips/tcg-target.h        |  2 ++
 tcg/ppc/tcg-target.h         |  2 ++
 tcg/riscv/tcg-target.h       |  2 ++
 tcg/s390x/tcg-target.h       |  2 ++
 tcg/sparc64/tcg-target.h     |  2 ++
 tcg/tci/tcg-target.h         |  2 ++
 tcg/optimize.c               | 41 +++++++++++++++++++++++++++++++++++-
 tcg/tcg-op.c                 | 36 +++++++++++++++++++++++++++++++
 tcg/tcg.c                    |  6 ++++++
 18 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 6a166c5665..fbde8040d7 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -498,6 +498,12 @@ Conditional moves
        |
        | Set *dest* to 1 if (*t1* *cond* *t2*) is true, otherwise set to 0.
 
+   * - negsetcond_i32/i64 *dest*, *t1*, *t2*, *cond*
+
+     - | *dest* = -(*t1* *cond* *t2*)
+       |
+       | Set *dest* to -1 if (*t1* *cond* *t2*) is true, otherwise set to 0.
+
    * - movcond_i32/i64 *dest*, *c1*, *c2*, *v1*, *v2*, *cond*
 
      - | *dest* = (*c1* *cond* *c2* ? *v1* : *v2*)
diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index be382bbf77..a53b15933b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -344,6 +344,8 @@ void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
+void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
+                            TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -540,6 +542,8 @@ void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
+void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
+                            TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index d63683c47b..80cfcf8104 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -200,6 +200,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i64
 #define tcg_gen_setcond_tl tcg_gen_setcond_i64
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i64
+#define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i64
 #define tcg_gen_mul_tl tcg_gen_mul_i64
 #define tcg_gen_muli_tl tcg_gen_muli_i64
 #define tcg_gen_div_tl tcg_gen_div_i64
@@ -317,6 +318,7 @@ DEF_ATOMIC2(tcg_gen_atomic_umax_fetch, i64)
 #define tcg_gen_brcondi_tl tcg_gen_brcondi_i32
 #define tcg_gen_setcond_tl tcg_gen_setcond_i32
 #define tcg_gen_setcondi_tl tcg_gen_setcondi_i32
+#define tcg_gen_negsetcond_tl tcg_gen_negsetcond_i32
 #define tcg_gen_mul_tl tcg_gen_mul_i32
 #define tcg_gen_muli_tl tcg_gen_muli_i32
 #define tcg_gen_div_tl tcg_gen_div_i32
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index acfa5ba753..5044814d15 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -46,6 +46,7 @@ DEF(mb, 0, 0, 1, 0)
 
 DEF(mov_i32, 1, 1, 0, TCG_OPF_NOT_PRESENT)
 DEF(setcond_i32, 1, 2, 1, 0)
+DEF(negsetcond_i32, 1, 2, 1, IMPL(TCG_TARGET_HAS_negsetcond_i32))
 DEF(movcond_i32, 1, 4, 1, IMPL(TCG_TARGET_HAS_movcond_i32))
 /* load/store */
 DEF(ld8u_i32, 1, 1, 1, 0)
@@ -111,6 +112,7 @@ DEF(ctpop_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ctpop_i32))
 
 DEF(mov_i64, 1, 1, 0, TCG_OPF_64BIT | TCG_OPF_NOT_PRESENT)
 DEF(setcond_i64, 1, 2, 1, IMPL64)
+DEF(negsetcond_i64, 1, 2, 1, IMPL64 | IMPL(TCG_TARGET_HAS_negsetcond_i64))
 DEF(movcond_i64, 1, 4, 1, IMPL64 | IMPL(TCG_TARGET_HAS_movcond_i64))
 /* load/store */
 DEF(ld8u_i64, 1, 1, 1, IMPL64)
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..f00bff9c85 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -104,6 +104,7 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_negsetcond_i64   0
 /* Turn some undef macros into true macros.  */
 #define TCG_TARGET_HAS_add2_i32         1
 #define TCG_TARGET_HAS_sub2_i32         1
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index ce64de06e5..6080fddf73 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -94,6 +94,7 @@ typedef enum {
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_extrl_i64_i32    0
 #define TCG_TARGET_HAS_extrh_i64_i32    0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_div_i64          1
@@ -129,6 +130,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_negsetcond_i64   0
 
 /*
  * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index c649db72a6..b076d033a9 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -122,6 +122,7 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_mulsh_i32        0
 #define TCG_TARGET_HAS_div_i32          use_idiv_instructions
 #define TCG_TARGET_HAS_rem_i32          0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 30cce01ca4..f3cdc6927a 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -156,6 +156,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 
 #if TCG_TARGET_REG_BITS == 64
 /* Keep 32-bit values zero-extended in a register.  */
@@ -193,6 +194,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        1
 #define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_negsetcond_i64   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 #else
 #define TCG_TARGET_HAS_qemu_st8_i32     1
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 26f1aab780..ce8fa3507e 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -118,6 +118,7 @@ typedef enum {
 #define TCG_TARGET_HAS_ctpop_i32        0
 #define TCG_TARGET_HAS_brcond2          0
 #define TCG_TARGET_HAS_setcond2         0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
@@ -157,6 +158,8 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_negsetcond_i64   0
+
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
 #define TCG_TARGET_DEFAULT_MO (0)
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index dd2efa795c..68e6cc33cc 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -128,6 +128,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
 #define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_negsetcond_i32   0
 
 #if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
@@ -150,6 +151,7 @@ extern bool use_mips32r2_instructions;
 #define TCG_TARGET_HAS_mulsh_i64        1
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_negsetcond_i64   0
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 9a41fab8cc..ba4fd3eb3a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -101,6 +101,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i32        0
 #define TCG_TARGET_HAS_muluh_i32        1
 #define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -141,6 +142,7 @@ typedef enum {
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_negsetcond_i64   0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index e1d8110ee4..b2961fec8e 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -120,6 +120,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_ctpop_i32        have_zbb
 #define TCG_TARGET_HAS_brcond2          1
 #define TCG_TARGET_HAS_setcond2         1
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_movcond_i64      1
@@ -158,6 +159,7 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        1
 #define TCG_TARGET_HAS_mulsh_i64        1
+#define TCG_TARGET_HAS_negsetcond_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 9a405003b9..24e207c2d4 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -104,6 +104,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_mulsh_i32      0
 #define TCG_TARGET_HAS_extrl_i64_i32  0
 #define TCG_TARGET_HAS_extrh_i64_i32  0
+#define TCG_TARGET_HAS_negsetcond_i32 0
 #define TCG_TARGET_HAS_qemu_st8_i32   0
 
 #define TCG_TARGET_HAS_div2_i64       1
@@ -138,6 +139,7 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_muls2_i64      HAVE_FACILITY(MISC_INSN_EXT2)
 #define TCG_TARGET_HAS_muluh_i64      0
 #define TCG_TARGET_HAS_mulsh_i64      0
+#define TCG_TARGET_HAS_negsetcond_i64 0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128 1
 
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index d454278811..1faadc704b 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -112,6 +112,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extrl_i64_i32    1
@@ -149,6 +150,7 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_muls2_i64        0
 #define TCG_TARGET_HAS_muluh_i64        use_vis3_instructions
 #define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_negsetcond_i64   0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 37ee10c959..ca18ddaaad 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -73,6 +73,7 @@
 #define TCG_TARGET_HAS_muls2_i32        1
 #define TCG_TARGET_HAS_muluh_i32        0
 #define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_negsetcond_i32   0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #if TCG_TARGET_REG_BITS == 64
@@ -114,6 +115,7 @@
 #define TCG_TARGET_HAS_mulu2_i64        1
 #define TCG_TARGET_HAS_muluh_i64        0
 #define TCG_TARGET_HAS_mulsh_i64        0
+#define TCG_TARGET_HAS_negsetcond_i64   0
 #else
 #define TCG_TARGET_HAS_mulu2_i32        1
 #endif /* TCG_TARGET_REG_BITS == 64 */
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 956114b631..351d4f7fbd 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1565,14 +1565,22 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
     if (arg_is_const(op->args[3]) && arg_is_const(op->args[4])) {
         uint64_t tv = arg_info(op->args[3])->val;
         uint64_t fv = arg_info(op->args[4])->val;
-        TCGOpcode opc;
+        TCGOpcode opc, negopc = 0;
 
         switch (ctx->type) {
         case TCG_TYPE_I32:
             opc = INDEX_op_setcond_i32;
+            if (TCG_TARGET_HAS_negsetcond_i32) {
+                negopc = INDEX_op_negsetcond_i32;
+            }
+            tv = (int32_t)tv;
+            fv = (int32_t)fv;
             break;
         case TCG_TYPE_I64:
             opc = INDEX_op_setcond_i64;
+            if (TCG_TARGET_HAS_negsetcond_i64) {
+                negopc = INDEX_op_negsetcond_i64;
+            }
             break;
         default:
             g_assert_not_reached();
@@ -1584,6 +1592,14 @@ static bool fold_movcond(OptContext *ctx, TCGOp *op)
         } else if (fv == 1 && tv == 0) {
             op->opc = opc;
             op->args[3] = tcg_invert_cond(cond);
+        } else if (negopc) {
+            if (tv == -1 && fv == 0) {
+                op->opc = negopc;
+                op->args[3] = cond;
+            } else if (fv == -1 && tv == 0) {
+                op->opc = negopc;
+                op->args[3] = tcg_invert_cond(cond);
+            }
         }
     }
     return false;
@@ -1794,6 +1810,26 @@ static bool fold_setcond(OptContext *ctx, TCGOp *op)
     return false;
 }
 
+static bool fold_negsetcond(OptContext *ctx, TCGOp *op)
+{
+    TCGCond cond = op->args[3];
+    int i;
+
+    if (swap_commutative(op->args[0], &op->args[1], &op->args[2])) {
+        op->args[3] = cond = tcg_swap_cond(cond);
+    }
+
+    i = do_constant_folding_cond(ctx->type, op->args[1], op->args[2], cond);
+    if (i >= 0) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], -i);
+    }
+
+    /* Value is {0,-1} so all bits are repetitions of the sign. */
+    ctx->s_mask = -1;
+    return false;
+}
+
+
 static bool fold_setcond2(OptContext *ctx, TCGOp *op)
 {
     TCGCond cond = op->args[5];
@@ -2251,6 +2287,9 @@ void tcg_optimize(TCGContext *s)
         CASE_OP_32_64(setcond):
             done = fold_setcond(&ctx, op);
             break;
+        CASE_OP_32_64(negsetcond):
+            done = fold_negsetcond(&ctx, op);
+            break;
         case INDEX_op_setcond2_i32:
             done = fold_setcond2(&ctx, op);
             break;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..76d2377669 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -276,6 +276,21 @@ void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_setcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
+void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
+                            TCGv_i32 arg1, TCGv_i32 arg2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi_i32(ret, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi_i32(ret, 0);
+    } else if (TCG_TARGET_HAS_negsetcond_i32) {
+        tcg_gen_op4i_i32(INDEX_op_negsetcond_i32, ret, arg1, arg2, cond);
+    } else {
+        tcg_gen_setcond_i32(cond, ret, arg1, arg2);
+        tcg_gen_neg_i32(ret, ret);
+    }
+}
+
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 0) {
@@ -1567,6 +1582,27 @@ void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
+void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
+                            TCGv_i64 arg1, TCGv_i64 arg2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        tcg_gen_movi_i64(ret, -1);
+    } else if (cond == TCG_COND_NEVER) {
+        tcg_gen_movi_i64(ret, 0);
+    } else if (TCG_TARGET_HAS_negsetcond_i64) {
+        tcg_gen_op4i_i64(INDEX_op_negsetcond_i64, ret, arg1, arg2, cond);
+    } else if (TCG_TARGET_REG_BITS == 32) {
+        tcg_gen_op6i_i32(INDEX_op_setcond2_i32, TCGV_LOW(ret),
+                         TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                         TCGV_LOW(arg2), TCGV_HIGH(arg2), cond);
+        tcg_gen_neg_i32(TCGV_LOW(ret), TCGV_LOW(ret));
+        tcg_gen_mov_i32(TCGV_HIGH(ret), TCGV_LOW(ret));
+    } else {
+        tcg_gen_setcond_i64(cond, ret, arg1, arg2);
+        tcg_gen_neg_i64(ret, ret);
+    }
+}
+
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 0) {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ddfe9a96cb..b7f8f007ca 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1879,6 +1879,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_sar_i32:
         return true;
 
+    case INDEX_op_negsetcond_i32:
+        return TCG_TARGET_HAS_negsetcond_i32;
     case INDEX_op_movcond_i32:
         return TCG_TARGET_HAS_movcond_i32;
     case INDEX_op_div_i32:
@@ -1977,6 +1979,8 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_extu_i32_i64:
         return TCG_TARGET_REG_BITS == 64;
 
+    case INDEX_op_negsetcond_i64:
+        return TCG_TARGET_HAS_negsetcond_i64;
     case INDEX_op_movcond_i64:
         return TCG_TARGET_HAS_movcond_i64;
     case INDEX_op_div_i64:
@@ -2510,11 +2514,13 @@ static void tcg_dump_ops(TCGContext *s, FILE *f, bool have_prefs)
             switch (c) {
             case INDEX_op_brcond_i32:
             case INDEX_op_setcond_i32:
+            case INDEX_op_negsetcond_i32:
             case INDEX_op_movcond_i32:
             case INDEX_op_brcond2_i32:
             case INDEX_op_setcond2_i32:
             case INDEX_op_brcond_i64:
             case INDEX_op_setcond_i64:
+            case INDEX_op_negsetcond_i64:
             case INDEX_op_movcond_i64:
             case INDEX_op_cmp_vec:
             case INDEX_op_cmpsel_vec:
-- 
2.34.1


