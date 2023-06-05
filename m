Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F067230F4
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gcb-0001rA-7h; Mon, 05 Jun 2023 16:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcZ-0001qc-3b
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:07 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6GcW-0003sa-9b
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-65311774e52so1935107b3a.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996163; x=1688588163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtX1Xou+g8BHGzx+Q/lku+gaQZV4Vw8c6hAcrxfkg1o=;
 b=izjz76llhWMubddICX+pREPbwqivkgBpvwzb9J3kBAYX183S4u8jbK8GcOQ2cvo+hK
 h3BKWeYSwGFDHX/0x1Au4HajpXLv07PGNnthUFj2pg/NqKBs+Zeuoy8qPMPu4SWloPoR
 yeL+Vb+w9d5brXc7+5H+DLrBVOug4pP8WZ+5DW55f4slK7RzNXD0UkMPJvj0BNvIJfDN
 067+ZDMMe6cHE7h686wCfOGdKdUo9ouHDznfmS/yOeQ7fRvXzWUBLpiL3zu7kT1bkY6q
 B7umvrnruUq6Mn6C9NplKTsutr/Je3zzNDfd4Hi60CEmULGGAOuH+xCOAqWJts+Brx86
 EFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996163; x=1688588163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtX1Xou+g8BHGzx+Q/lku+gaQZV4Vw8c6hAcrxfkg1o=;
 b=UNMcMzyB9c+GYRYUPAk1un7M0LdgsrtpvfOZ9FIG6PAjp6PJ9afj5dO3chKI+4EvwO
 0wUb+FKB4eJnqsWtNCc7Q6qeUl877cV8blNFrlAVlAfR564IMdffs44KX+L+T+2qBGwF
 bEAdME9fLjm2hUHpgMqX1P+S5wsj3+XVqn+LYqnt9YfFicYJNTgk/MZAmNLFHNMU0s3u
 1PYQVxZAv8a8km/XPwWCAuNm9GQwHswboOWJxvyrUdt5sZjWKTIuzZxvdyBYYAQsas25
 fP0+mEV3uPACb7fJxknkemL/irsZj+JL01w8e/G0oISR8O/vhFAbUX/zxyz5tgJWwU4C
 O3lg==
X-Gm-Message-State: AC+VfDzWFD8cwmMIm0eHLfIXpIxCjhsIR6l4DCkhunUPFM3R9VEYK8Yb
 RpGiRkTk3PrY5DeIjE/od6lk4LxM2gBTiXX9+qI=
X-Google-Smtp-Source: ACHHUZ7jwGQSNuWNrjrCpKrYS0PP9lK8BSkSjm/fg6zMheIfDay1qAR0sweei4FbhgcZJ6t17FUsyA==
X-Received: by 2002:a05:6a20:12d6:b0:10b:9dc1:c5e5 with SMTP id
 v22-20020a056a2012d600b0010b9dc1c5e5mr93114pzg.34.1685996162942; 
 Mon, 05 Jun 2023 13:16:02 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/52] tcg: Move TCGv, dup_const_tl definitions to tcg-op.h
Date: Mon,  5 Jun 2023 13:15:10 -0700
Message-Id: <20230605201548.1596865-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


