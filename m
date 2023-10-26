Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EB57D7B6F
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:16:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrlA-0002X0-HY; Thu, 26 Oct 2023 00:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl8-0002WK-Fl
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:14 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrl5-0000jp-MX
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:14:14 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ca816f868fso3144165ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698293650; x=1698898450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bjZedkK0rhWtjOU1AHgb9FN6j8665Di15JYAcbx3Fw8=;
 b=bwcKXZBdmZFp7/Vrz6NK9sRwAtjiNXDVZC5eGN51Ipjzgr4vRz/MGLZcPe2Q/cszFV
 J++wJHGdpCSgqIj/xzyM6uznLM3UnE/akUCwX4FR6LgNYgwPaOsgghaFgI4CujuVLPbM
 K/AzZzyqlWyqDNizDIDSUhxmrCtM9ZuGaKY4u+OUhwhMc9aC5hjkx7cilNh/KMu+c+Wq
 9V+Vk9S26EtsQZ2etqR+jUW/74MF5A88pUUCzeHI5sANY4c8PGzsNvG8HOta6duLGxpf
 8WImPVU4C/42mmjo/zbwjpomFZC2DqOalHjN0KCJHRLlwB17rBCqQjN24xF3IodTPVrW
 AMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698293650; x=1698898450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bjZedkK0rhWtjOU1AHgb9FN6j8665Di15JYAcbx3Fw8=;
 b=WaElmJIPC4HJ5RPHtv6MZYOB85uVK7QCHH2tPoYrKiDfwkRl0m/s8NnJQ4K5tUrtmg
 0QLlCJLzct0IBRDl2anpZO1aGLIuvD5pSnM+MZnSrfwn//TYi3NMXTG5QC3m5gCD3CMU
 9R0ZpZS0xtDft5Y7HpOIXF7u9ZPULiyFWPTOxu3AL92PUv7TimRSq+mYNb2bWp0jWTvb
 h4OC+RnFfZz3trR/w8CXeqW3Vt8Jn8Myos3ZcHtJvE2IOEZHdrTJ4j5a5SqEtYDU+yF0
 PWHYYe2fjHcNA/7zpTTFl4Mjjl0EbC+2gc7C8K8cndjiSgY3rnqiUq/rY6eenGMvTvZc
 sA8g==
X-Gm-Message-State: AOJu0YyH5U2NF5QydiBpw9sqf6uxvIV9ufT25IMr70wEkd9hW64A0JfK
 p2cyN86YV9kEg/GKwaRA+0Pv47cz3fkJpNMftHA=
X-Google-Smtp-Source: AGHT+IGPK9gS9m5k1KYbEEidPW1dE5qKrMvJOmWmA60B7LrvLySK3O+PaejrDhw0K+VPiuAWPrrs/g==
X-Received: by 2002:a17:902:f9c3:b0:1c9:d948:33ea with SMTP id
 kz3-20020a170902f9c300b001c9d94833eamr12101303plb.21.1698293650186; 
 Wed, 25 Oct 2023 21:14:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 i12-20020a170902eb4c00b001b8b2b95068sm9953929pli.204.2023.10.25.21.14.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 21:14:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] tcg: Remove TCG_TARGET_HAS_neg_{i32,i64}
Date: Wed, 25 Oct 2023 21:14:04 -0700
Message-Id: <20231026041404.1229328-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

The movcond opcode is now mandatory for backends to implement.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  | 12 ++----------
 include/tcg/tcg-opc.h        |  4 ++--
 include/tcg/tcg.h            |  1 -
 tcg/aarch64/tcg-target.h     |  2 --
 tcg/arm/tcg-target.h         |  1 -
 tcg/i386/tcg-target.h        |  2 --
 tcg/loongarch64/tcg-target.h |  2 --
 tcg/mips/tcg-target.h        |  2 --
 tcg/ppc/tcg-target.h         |  2 --
 tcg/riscv/tcg-target.h       |  2 --
 tcg/s390x/tcg-target.h       |  2 --
 tcg/sparc64/tcg-target.h     |  2 --
 tcg/tci/tcg-target.h         |  2 --
 tcg/optimize.c               | 15 +++++----------
 tcg/tcg-op.c                 | 10 ++++------
 tcg/tcg.c                    |  6 ++----
 tcg/tci.c                    |  2 --
 17 files changed, 15 insertions(+), 54 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 677aea6dd1..7dc1184ba6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -481,11 +481,7 @@ static inline void tcg_gen_mul_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 static inline void tcg_gen_neg_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (TCG_TARGET_HAS_neg_i32) {
-        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
-    } else {
-        tcg_gen_subfi_i32(ret, 0, arg);
-    }
+    tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg);
 }
 
 static inline void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
@@ -732,11 +728,7 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 
 static inline void tcg_gen_neg_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (TCG_TARGET_HAS_neg_i64) {
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
-    } else {
-        tcg_gen_subfi_i64(ret, 0, arg);
-    }
+    tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg);
 }
 
 /* Size changing operations.  */
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index ecd08db0de..b80227fa1c 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -100,7 +100,7 @@ DEF(ext16u_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_ext16u_i32))
 DEF(bswap16_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap16_i32))
 DEF(bswap32_i32, 1, 1, 1, IMPL(TCG_TARGET_HAS_bswap32_i32))
 DEF(not_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_not_i32))
-DEF(neg_i32, 1, 1, 0, IMPL(TCG_TARGET_HAS_neg_i32))
+DEF(neg_i32, 1, 1, 0, 0)
 DEF(andc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_andc_i32))
 DEF(orc_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_orc_i32))
 DEF(eqv_i32, 1, 2, 0, IMPL(TCG_TARGET_HAS_eqv_i32))
@@ -171,7 +171,7 @@ DEF(bswap16_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap16_i64))
 DEF(bswap32_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap32_i64))
 DEF(bswap64_i64, 1, 1, 1, IMPL64 | IMPL(TCG_TARGET_HAS_bswap64_i64))
 DEF(not_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_not_i64))
-DEF(neg_i64, 1, 1, 0, IMPL64 | IMPL(TCG_TARGET_HAS_neg_i64))
+DEF(neg_i64, 1, 1, 0, IMPL64)
 DEF(andc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_andc_i64))
 DEF(orc_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_orc_i64))
 DEF(eqv_i64, 1, 2, 0, IMPL64 | IMPL(TCG_TARGET_HAS_eqv_i64))
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index bb522a865c..2a0893e0f7 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -82,7 +82,6 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_neg_i64          0
 #define TCG_TARGET_HAS_not_i64          0
 #define TCG_TARGET_HAS_andc_i64         0
 #define TCG_TARGET_HAS_orc_i64          0
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 352e19aba8..33f15a564a 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -71,7 +71,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
@@ -107,7 +106,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 439898efb3..a712cc80ad 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -101,7 +101,6 @@ extern bool use_neon_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          0
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index 7522ce7575..fa34deec47 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -135,7 +135,6 @@ typedef enum {
 #define TCG_TARGET_HAS_ext16u_i32       1
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_andc_i32         have_bmi1
 #define TCG_TARGET_HAS_orc_i32          0
@@ -171,7 +170,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i64      1
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_andc_i64         have_bmi1
 #define TCG_TARGET_HAS_orc_i64          0
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index d1c8e6d341..428098cbc0 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -119,7 +119,6 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          0
@@ -153,7 +152,6 @@ extern bool use_lsx_instructions;
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          0
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 20c14224fb..b98ffae1d0 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -184,12 +184,10 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions automatically implemented */
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_ext8u_i32        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i32       0 /* andi rt, rs, 0xffff */
 
 #if TCG_TARGET_REG_BITS == 64
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_ext8u_i64        0 /* andi rt, rs, 0xff   */
 #define TCG_TARGET_HAS_ext16u_i64       0 /* andi rt, rs, 0xffff */
 #endif
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index a2856afd4d..5295e4f9ab 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -83,7 +83,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap16_i32      1
 #define TCG_TARGET_HAS_bswap32_i32      1
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_eqv_i32          1
@@ -120,7 +119,6 @@ typedef enum {
 #define TCG_TARGET_HAS_bswap32_i64      1
 #define TCG_TARGET_HAS_bswap64_i64      1
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_eqv_i64          1
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index f3644a8bc1..a4edc3dc74 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -109,7 +109,6 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap16_i32      have_zbb
 #define TCG_TARGET_HAS_bswap32_i32      have_zbb
 #define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_andc_i32         have_zbb
 #define TCG_TARGET_HAS_orc_i32          have_zbb
 #define TCG_TARGET_HAS_eqv_i32          have_zbb
@@ -142,7 +141,6 @@ extern bool have_zbb;
 #define TCG_TARGET_HAS_bswap32_i64      have_zbb
 #define TCG_TARGET_HAS_bswap64_i64      have_zbb
 #define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_andc_i64         have_zbb
 #define TCG_TARGET_HAS_orc_i64          have_zbb
 #define TCG_TARGET_HAS_eqv_i64          have_zbb
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 2c936c1bcb..e69b0d2ddd 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -82,7 +82,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap16_i32    1
 #define TCG_TARGET_HAS_bswap32_i32    1
 #define TCG_TARGET_HAS_not_i32        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_neg_i32        1
 #define TCG_TARGET_HAS_andc_i32       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i32        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i32        HAVE_FACILITY(MISC_INSN_EXT3)
@@ -117,7 +116,6 @@ extern uint64_t s390_facilities[3];
 #define TCG_TARGET_HAS_bswap32_i64    1
 #define TCG_TARGET_HAS_bswap64_i64    1
 #define TCG_TARGET_HAS_not_i64        HAVE_FACILITY(MISC_INSN_EXT3)
-#define TCG_TARGET_HAS_neg_i64        1
 #define TCG_TARGET_HAS_andc_i64       HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_orc_i64        HAVE_FACILITY(MISC_INSN_EXT3)
 #define TCG_TARGET_HAS_eqv_i64        HAVE_FACILITY(MISC_INSN_EXT3)
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 4c286c6006..f8cf145266 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -91,7 +91,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_ext16u_i32       0
 #define TCG_TARGET_HAS_bswap16_i32      0
 #define TCG_TARGET_HAS_bswap32_i32      0
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_andc_i32         1
 #define TCG_TARGET_HAS_orc_i32          1
@@ -127,7 +126,6 @@ extern bool use_vis3_instructions;
 #define TCG_TARGET_HAS_bswap16_i64      0
 #define TCG_TARGET_HAS_bswap32_i64      0
 #define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_andc_i64         1
 #define TCG_TARGET_HAS_orc_i64          1
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 3503fc4a4c..2a13816c8e 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -65,7 +65,6 @@
 #define TCG_TARGET_HAS_clz_i32          1
 #define TCG_TARGET_HAS_ctz_i32          1
 #define TCG_TARGET_HAS_ctpop_i32        1
-#define TCG_TARGET_HAS_neg_i32          1
 #define TCG_TARGET_HAS_not_i32          1
 #define TCG_TARGET_HAS_orc_i32          1
 #define TCG_TARGET_HAS_rot_i32          1
@@ -99,7 +98,6 @@
 #define TCG_TARGET_HAS_clz_i64          1
 #define TCG_TARGET_HAS_ctz_i64          1
 #define TCG_TARGET_HAS_ctpop_i64        1
-#define TCG_TARGET_HAS_neg_i64          1
 #define TCG_TARGET_HAS_not_i64          1
 #define TCG_TARGET_HAS_orc_i64          1
 #define TCG_TARGET_HAS_rot_i64          1
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 27b1eaaa8d..5e16800cfa 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1930,7 +1930,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         sub_opc = INDEX_op_sub_i32;
         xor_opc = INDEX_op_xor_i32;
         shr_opc = INDEX_op_shr_i32;
-        neg_opc = TCG_TARGET_HAS_neg_i32 ? INDEX_op_neg_i32 : 0;
+        neg_opc = INDEX_op_neg_i32;
         uext_opc = TCG_TARGET_HAS_extract_i32 ? INDEX_op_extract_i32 : 0;
         sext_opc = TCG_TARGET_HAS_sextract_i32 ? INDEX_op_sextract_i32 : 0;
         break;
@@ -1939,7 +1939,7 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         sub_opc = INDEX_op_sub_i64;
         xor_opc = INDEX_op_xor_i64;
         shr_opc = INDEX_op_shr_i64;
-        neg_opc = TCG_TARGET_HAS_neg_i64 ? INDEX_op_neg_i64 : 0;
+        neg_opc = INDEX_op_neg_i64;
         uext_opc = TCG_TARGET_HAS_extract_i64 ? INDEX_op_extract_i64 : 0;
         sext_opc = TCG_TARGET_HAS_sextract_i64 ? INDEX_op_sextract_i64 : 0;
         break;
@@ -1986,15 +1986,10 @@ static void fold_setcond_tst_pow2(OptContext *ctx, TCGOp *op, bool neg)
         op2->args[0] = ret;
         op2->args[1] = ret;
         op2->args[2] = arg_new_constant(ctx, 1);
-    } else if (neg && neg_opc) {
+    } else if (neg) {
         op2 = tcg_op_insert_after(ctx->tcg, op, neg_opc, 2);
         op2->args[0] = ret;
         op2->args[1] = ret;
-    } else if (neg) {
-        op2 = tcg_op_insert_after(ctx->tcg, op, sub_opc, 3);
-        op2->args[0] = ret;
-        op2->args[1] = arg_new_constant(ctx, 0);
-        op2->args[2] = ret;
     }
 }
 
@@ -2205,11 +2200,11 @@ static bool fold_sub_to_neg(OptContext *ctx, TCGOp *op)
     switch (ctx->type) {
     case TCG_TYPE_I32:
         neg_op = INDEX_op_neg_i32;
-        have_neg = TCG_TARGET_HAS_neg_i32;
+        have_neg = true;
         break;
     case TCG_TYPE_I64:
         neg_op = INDEX_op_neg_i64;
-        have_neg = TCG_TARGET_HAS_neg_i64;
+        have_neg = true;
         break;
     case TCG_TYPE_V64:
     case TCG_TYPE_V128:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 51de796769..59deb3cbbb 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -138,9 +138,8 @@ void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2)
 {
-    if (arg1 == 0 && TCG_TARGET_HAS_neg_i32) {
-        /* Don't recurse with tcg_gen_neg_i32.  */
-        tcg_gen_op2_i32(INDEX_op_neg_i32, ret, arg2);
+    if (arg1 == 0) {
+        tcg_gen_neg_i32(ret, arg2);
     } else {
         tcg_gen_sub_i32(ret, tcg_constant_i32(arg1), arg2);
     }
@@ -1342,9 +1341,8 @@ void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
-    if (arg1 == 0 && TCG_TARGET_HAS_neg_i64) {
-        /* Don't recurse with tcg_gen_neg_i64.  */
-        tcg_gen_op2_i64(INDEX_op_neg_i64, ret, arg2);
+    if (arg1 == 0) {
+        tcg_gen_neg_i64(ret, arg2);
     } else if (TCG_TARGET_REG_BITS == 64) {
         tcg_gen_sub_i64(ret, tcg_constant_i64(arg1), arg2);
     } else {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 5da03ba11d..a507c111cf 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1885,6 +1885,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_st_i32:
     case INDEX_op_add_i32:
     case INDEX_op_sub_i32:
+    case INDEX_op_neg_i32:
     case INDEX_op_mul_i32:
     case INDEX_op_and_i32:
     case INDEX_op_or_i32:
@@ -1942,8 +1943,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_bswap32_i32;
     case INDEX_op_not_i32:
         return TCG_TARGET_HAS_not_i32;
-    case INDEX_op_neg_i32:
-        return TCG_TARGET_HAS_neg_i32;
     case INDEX_op_andc_i32:
         return TCG_TARGET_HAS_andc_i32;
     case INDEX_op_orc_i32:
@@ -1982,6 +1981,7 @@ bool tcg_op_supported(TCGOpcode op)
     case INDEX_op_st_i64:
     case INDEX_op_add_i64:
     case INDEX_op_sub_i64:
+    case INDEX_op_neg_i64:
     case INDEX_op_mul_i64:
     case INDEX_op_and_i64:
     case INDEX_op_or_i64:
@@ -2038,8 +2038,6 @@ bool tcg_op_supported(TCGOpcode op)
         return TCG_TARGET_HAS_bswap64_i64;
     case INDEX_op_not_i64:
         return TCG_TARGET_HAS_not_i64;
-    case INDEX_op_neg_i64:
-        return TCG_TARGET_HAS_neg_i64;
     case INDEX_op_andc_i64:
         return TCG_TARGET_HAS_andc_i64;
     case INDEX_op_orc_i64:
diff --git a/tcg/tci.c b/tcg/tci.c
index 5e1c4a491d..39adcb7d82 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -745,12 +745,10 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
             regs[r0] = ~regs[r1];
             break;
 #endif
-#if TCG_TARGET_HAS_neg_i32 || TCG_TARGET_HAS_neg_i64
         CASE_32_64(neg)
             tci_args_rr(insn, &r0, &r1);
             regs[r0] = -regs[r1];
             break;
-#endif
 #if TCG_TARGET_REG_BITS == 64
             /* Load/store operations (64 bit). */
 
-- 
2.34.1


