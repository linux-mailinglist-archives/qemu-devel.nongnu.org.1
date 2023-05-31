Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D37174CE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D3t-000768-Pf; Wed, 31 May 2023 00:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3q-0006yB-MI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:47 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3o-0006BE-4N
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:46 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-19edebe85adso4798908fac.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505822; x=1688097822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2MnbR8ivtG8F9lQRbQhTVo1lYYIJENM+G2/D5KOadw=;
 b=fA7w1HbQ2+mwRqdLoAQfv2mevCdb1EFW7H8ooAGF5Kg0NR2w3tEJqGW3OTYoAx2Xli
 6Bkauy4dFh1Wh/0SrPqjRJ8H7P91LY/6g25pxyEg+3+rcWak9R0QUOL/VyunGlE5WnVT
 AJyY7Ce9WRjTvai6SDxpkGSH4nMIo2Q+oBuphaNXtW5RxhWDe31t+oX8uur1ge0vxhxg
 hedjM4QB5A9pq+qovi3tHVUNHNV2y2LNjCfCEmVEoPTQKb3MIrWJG70z3Vhw8Q7OLFK8
 mgoDUVGRFYHg0fan79wmOFTrsJa8dUVKyDRMWFlnadkoyZ6sF+O5rcsb/gSDZa7QW/N0
 KjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505822; x=1688097822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2MnbR8ivtG8F9lQRbQhTVo1lYYIJENM+G2/D5KOadw=;
 b=FpCYu8oVGpBEvyg2zRsamsbiPcBVEUUK0Bg4LO28uaGWSBsZDrE/zifK0vFxbHfaI/
 qqzR1ENxZAFHyJmL7XDbBZ7P/OiphIjwSoVvJhD1PPuyKuc4S8M4+eqSHuxKPZXv4nHN
 sfmdPV30yBaZwLK83dg+aQP5NRteUlR25USZuO98/RRJeNv6xWWL3a07x3tOLj+h26S8
 hC0SJ4RQT55rG/WIJtKs1k3gZQ7Dov15mHOhUOa7kXkX4az/K7yjvh0AI7FZOIJIQGzd
 8K5ht2XXGOclntLJKc2iu1qkrf3zv9FACkN463xCviDsyaNAeTqj6Lb7pih+10xJTIJA
 E10g==
X-Gm-Message-State: AC+VfDwU1bTitBLga0Lu0EfYeBzwlrr1TfI/ujJgCTYSbDQR5ry+aNth
 ZLUc9Tou/De+73RYKYpwN6rZV9D9kEYudHqQ+Vg=
X-Google-Smtp-Source: ACHHUZ4ihlqzIbmN9gKJicEs1T/Ee53+vgWVLaCd4UbDviyDAmXpjg5tpfDXufR7lzcdcxDOJkZBoA==
X-Received: by 2002:a05:6870:5316:b0:19f:4696:3233 with SMTP id
 j22-20020a056870531600b0019f46963233mr2916753oan.45.1685505822102; 
 Tue, 30 May 2023 21:03:42 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 14/48] tcg: Move TCGv, dup_const_tl definitions to tcg-op.h
Date: Tue, 30 May 2023 21:02:56 -0700
Message-Id: <20230531040330.8950-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

These two items are the last uses of TARGET_LONG_BITS within tcg.h,
and are more in common with the other "_tl" definitions within that file.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h        | 15 ++++++++++++++-
 include/tcg/tcg.h           | 19 -------------------
 target/mips/tcg/translate.h |  1 +
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 844c666374..b8f0599f3c 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -808,19 +808,23 @@ static inline void tcg_gen_plugin_cb_end(void)
 }
 
 #if TARGET_LONG_BITS == 32
+typedef TCGv_i32 TCGv;
 #define tcg_temp_new() tcg_temp_new_i32()
 #define tcg_global_mem_new tcg_global_mem_new_i32
 #define tcg_temp_free tcg_temp_free_i32
 #define tcgv_tl_temp tcgv_i32_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
-#else
+#elif TARGET_LONG_BITS == 64
+typedef TCGv_i64 TCGv;
 #define tcg_temp_new() tcg_temp_new_i64()
 #define tcg_global_mem_new tcg_global_mem_new_i64
 #define tcg_temp_free tcg_temp_free_i64
 #define tcgv_tl_temp tcgv_i64_temp
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
+#else
+#error Unhandled TARGET_LONG_BITS value
 #endif
 
 void tcg_gen_qemu_ld_i32_chk(TCGv_i32, TCGTemp *, TCGArg, MemOp, TCGType);
@@ -1182,6 +1186,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i64
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i64_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i64
+#define dup_const_tl dup_const
 #else
 #define tcg_gen_movi_tl tcg_gen_movi_i32
 #define tcg_gen_mov_tl tcg_gen_mov_i32
@@ -1296,6 +1301,14 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_atomic_umax_fetch_tl tcg_gen_atomic_umax_fetch_i32
 #define tcg_gen_dup_tl_vec  tcg_gen_dup_i32_vec
 #define tcg_gen_dup_tl tcg_gen_dup_i32
+
+#define dup_const_tl(VECE, C)                                      \
+    (__builtin_constant_p(VECE)                                    \
+     ? (  (VECE) == MO_8  ? 0x01010101ul * (uint8_t)(C)            \
+        : (VECE) == MO_16 ? 0x00010001ul * (uint16_t)(C)           \
+        : (VECE) == MO_32 ? 0x00000001ul * (uint32_t)(C)           \
+        : (qemu_build_not_reached_always(), 0))                    \
+     :  (target_long)dup_const(VECE, C))
 #endif
 
 #if UINTPTR_MAX == UINT32_MAX
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 021fc903ad..9b2833b31d 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -357,13 +357,6 @@ typedef struct TCGv_i128_d *TCGv_i128;
 typedef struct TCGv_ptr_d *TCGv_ptr;
 typedef struct TCGv_vec_d *TCGv_vec;
 typedef TCGv_ptr TCGv_env;
-#if TARGET_LONG_BITS == 32
-#define TCGv TCGv_i32
-#elif TARGET_LONG_BITS == 64
-#define TCGv TCGv_i64
-#else
-#error Unhandled TARGET_LONG_BITS value
-#endif
 
 /* call flags */
 /* Helper does not read globals (either directly or through an exception). It
@@ -1163,18 +1156,6 @@ uint64_t dup_const(unsigned vece, uint64_t c);
         : (qemu_build_not_reached_always(), 0))                    \
      : dup_const(VECE, C))
 
-#if TARGET_LONG_BITS == 64
-# define dup_const_tl  dup_const
-#else
-# define dup_const_tl(VECE, C)                                     \
-    (__builtin_constant_p(VECE)                                    \
-     ? (  (VECE) == MO_8  ? 0x01010101ul * (uint8_t)(C)            \
-        : (VECE) == MO_16 ? 0x00010001ul * (uint16_t)(C)           \
-        : (VECE) == MO_32 ? 0x00000001ul * (uint32_t)(C)           \
-        : (qemu_build_not_reached_always(), 0))                    \
-     :  (target_long)dup_const(VECE, C))
-#endif
-
 #ifdef CONFIG_DEBUG_TCG
 void tcg_assert_listed_vecop(TCGOpcode);
 #else
diff --git a/target/mips/tcg/translate.h b/target/mips/tcg/translate.h
index 69f85841d2..fa8bf55209 100644
--- a/target/mips/tcg/translate.h
+++ b/target/mips/tcg/translate.h
@@ -10,6 +10,7 @@
 
 #include "qemu/log.h"
 #include "exec/translator.h"
+#include "tcg/tcg-op.h"
 
 #define MIPS_DEBUG_DISAS 0
 
-- 
2.34.1


