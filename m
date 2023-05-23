Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8C770DE9D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 16:08:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST6-0006V2-Ng; Tue, 23 May 2023 09:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSM-0004x1-7b
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:43 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSJ-000337-E3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-64d24136663so4108452b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850016; x=1687442016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W2MnbR8ivtG8F9lQRbQhTVo1lYYIJENM+G2/D5KOadw=;
 b=oaovV4kt5ni/IweCdJTfci5GktCTph6BIEj1So+X0uTrUihfUr16ugT0oiuwil8ZfU
 DkzBl6m/FgsJnOv5ZlSxtwolX7c86HGyKYHd9pDksGAHz+G68U3RrmYfdhOjf/AzT6oC
 LtV12xQQFEsr7FNgrffCieYXjSZDJXTExBOrLYES5bE1N4OWOt+Cjct7x7XDjUrtpuHi
 8RriEyScn1jmzZTIlSsNBKI6aiSPD5tQyKrPcqOGWBRwH3CqIUsp66KKDTL8q/T/xNzX
 r6apXM+EdW4XUgQTisXY+X21li9GJcNFB85GhPLZkIr5Vjxa505IZbCc/Vrq2Iy+CsWe
 da/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850016; x=1687442016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W2MnbR8ivtG8F9lQRbQhTVo1lYYIJENM+G2/D5KOadw=;
 b=StvTfjXlh7ga0KZB9vMGaRDv3buN4g3C4vyKRu2m6FISra/V8p1Bi0PRk7sbGB2vtb
 azeJm4Lshg8DegqfhIvEhw5+g5I2YVAiVFCa3M3TNI+ZPT+PaItl2RKO2TnAA7b1J5a7
 7R1pIPIQJGp+51T2IxnYU7pjCeLIbR5/19QpJ6c0EuFe0M/4s2nqS3mKyq2YWKjXjXEU
 Sj6TXV0eJfz0a808eQ31RWYKU/ND7POGS3LKiStoQTKE1XalIge4ENumQPW6MZZketTK
 fPIkZVrE7d5ocJRd15fLjW5bXhZM7Vz1HOSEN/XXueGuZ3EtcRx3bDxoBuf9pWM+knYo
 Xyzg==
X-Gm-Message-State: AC+VfDyKNLjs4g78Hq14g6aSgGKYG2QUPD3gf5OJIojdBwRUafjO4J0U
 ij1HbbLX2UwGcZUm1LSbUVyQl0krp7UZg52/V00=
X-Google-Smtp-Source: ACHHUZ5hV0lMzqMw2vGYqdmRO1JTmpmyokdZbatnOevyPS5NZ/eg5q/V/JiQUbU3u716y0WOTF1RVw==
X-Received: by 2002:a05:6a20:4292:b0:10b:c7f4:66ee with SMTP id
 o18-20020a056a20429200b0010bc7f466eemr7076839pzj.42.1684850016459; 
 Tue, 23 May 2023 06:53:36 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/52] tcg: Move TCGv, dup_const_tl definitions to tcg-op.h
Date: Tue, 23 May 2023 06:52:45 -0700
Message-Id: <20230523135322.678948-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


