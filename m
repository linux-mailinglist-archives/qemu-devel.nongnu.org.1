Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30487D1786
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 22:51:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtwLp-0007hH-Pl; Fri, 20 Oct 2023 16:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLL-0007fP-Fb
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtwLJ-00088B-DD
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 16:43:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so1253114b3a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 13:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697834615; x=1698439415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2zsMSRhlbZwVzQVen6DKnQDDskBCrZAwA6YeAeDVn/c=;
 b=xYdEHX353qnw1YqndbLVA53rMSjfEm0aJfZHoW/8+UZvismFWM9wgN0GQPw/g2q/ci
 hJVwC6+GqhZUlMw3fckshKHDxBYEM94RLba2SmfFm34fzLm3cHYfUwWb5X64dC1QisnD
 GEUoPMpPrXJifYrgf3vJFWLCWPZHMXiwQgSPvY8hga2jddyFnRXP/leqRj8Zy/al4wO1
 mV+rmYrBxBAmw3PRiIsUL14Q2nSUkCYYbi7gDxIQjLHxw5e89fMDXyPSHMR7TPkQqw6E
 HeFhddoz6DkGeP3s32n7P6nCaqcEq1hXyqsL0dSdLqzDIFK4tCbKvmwaLwIScsv4jgBB
 NBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697834615; x=1698439415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zsMSRhlbZwVzQVen6DKnQDDskBCrZAwA6YeAeDVn/c=;
 b=wvlpSAVG/HU4LAHbDZMZQ2maHqlP8l/UVL8tvVb8BhVDehIH486L0Bgw3c4DCNGpbd
 +evkqGLsKyjL9iDFP7TrFJSqZTC0opXB6nVWb5rb2gVRi+n9ZjvoBHwex6RpZwyoG/2I
 moEf0wy37ICgLIQ02Zr6ZLsE8a15qTS2VXSVAzkblm2LB5eIXMi+VpWv4qexK8/vk7/R
 iBSnWX/2S9kB8MI3xiDMkerKObM8D1pz4XRAXHEXho/wdF7FCqpFclCT+v/ygETfdotp
 cGqgPwddTQrSqgvQcRp2Puywjdpk0YIWcrWqL7qLtzEOmdl3TsKau1PbAaKly0pyyAYl
 rkPQ==
X-Gm-Message-State: AOJu0YxBAv8GHpwEpFBDs52/iWk7W/p/61xGea7GyMuC7r37b0vgov3i
 nJQTr2+QFwBCnLYLnnxLYGysjrSiQ3Ym0sR+PW8=
X-Google-Smtp-Source: AGHT+IEjYQOMPArhPrF0UiRjWZYzveHBmKchjORI0BYG/7QnMb3N6Pedu7ntykgjquRMYWAQ9zwcSg==
X-Received: by 2002:a05:6a20:1604:b0:14e:43b0:5f99 with SMTP id
 l4-20020a056a20160400b0014e43b05f99mr2903499pzj.52.1697834615290; 
 Fri, 20 Oct 2023 13:43:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k15-20020aa7998f000000b00688965c5227sm1944975pfh.120.2023.10.20.13.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 13:43:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 02/65] tcg: Improve expansion of deposit into a constant
Date: Fri, 20 Oct 2023 13:42:28 -0700
Message-Id: <20231020204331.139847-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020204331.139847-1-richard.henderson@linaro.org>
References: <20231020204331.139847-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Generalize tcg_gen_deposit_z_* from 0 to any constant.
Use this to automatically simplify tcg_gen_deposit_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 295 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 174 insertions(+), 121 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2ef4b866e2..049b684ccc 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -597,6 +597,70 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
+static void tcg_gen_deposit_i_i32(TCGv_i32 ret, uint32_t i, TCGv_i32 arg,
+                                  unsigned int ofs, unsigned int len)
+{
+    i = deposit32(i, ofs, len, 0);
+
+    if (ofs + len == 32) {
+        tcg_gen_shli_i32(ret, arg, ofs);
+        goto finish;
+    }
+    if (ofs == 0) {
+        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+        goto finish;
+    }
+    if (TCG_TARGET_HAS_deposit_i32
+        && TCG_TARGET_deposit_i32_valid(ofs, len)) {
+        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret,
+                          tcg_constant_i32(i), arg, ofs, len);
+        return;
+    }
+
+    /*
+     * To help two-operand hosts we prefer to zero-extend first,
+     * which allows ARG to stay live.
+     */
+    switch (len) {
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i32) {
+            tcg_gen_ext16u_i32(ret, arg);
+            tcg_gen_shli_i32(ret, ret, ofs);
+            goto finish;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i32) {
+            tcg_gen_ext8u_i32(ret, arg);
+            tcg_gen_shli_i32(ret, ret, ofs);
+            goto finish;
+        }
+        break;
+    }
+    /* Otherwise prefer zero-extension over AND for code size.  */
+    switch (ofs + len) {
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i32) {
+            tcg_gen_shli_i32(ret, arg, ofs);
+            tcg_gen_ext16u_i32(ret, ret);
+            goto finish;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i32) {
+            tcg_gen_shli_i32(ret, arg, ofs);
+            tcg_gen_ext8u_i32(ret, ret);
+            goto finish;
+        }
+        break;
+    }
+    tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
+    tcg_gen_shli_i32(ret, ret, ofs);
+
+ finish:
+    tcg_gen_ori_i32(ret, ret, i);
+}
+
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -613,6 +677,14 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
         tcg_gen_mov_i32(ret, arg2);
         return;
     }
+
+    /* Deposit of a value into a constant. */
+    ts = tcgv_i32_temp(arg1);
+    if (ts->kind == TEMP_CONST) {
+        tcg_gen_deposit_i_i32(ret, ts->val, arg2, ofs, len);
+        return;
+    }
+
     if (TCG_TARGET_HAS_deposit_i32 && TCG_TARGET_deposit_i32_valid(ofs, len)) {
         tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, arg1, arg2, ofs, len);
         return;
@@ -667,53 +739,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
     tcg_debug_assert(len <= 32);
     tcg_debug_assert(ofs + len <= 32);
 
-    if (ofs + len == 32) {
-        tcg_gen_shli_i32(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i32
-               && TCG_TARGET_deposit_i32_valid(ofs, len)) {
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5ii_i32(INDEX_op_deposit_i32, ret, zero, arg, ofs, len);
-    } else {
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_ext16u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_ext8u_i32(ret, arg);
-                tcg_gen_shli_i32(ret, ret, ofs);
-                return;
-            }
-            break;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext16u_i32(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i32) {
-                tcg_gen_shli_i32(ret, arg, ofs);
-                tcg_gen_ext8u_i32(ret, ret);
-                return;
-            }
-            break;
-        }
-        tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
-        tcg_gen_shli_i32(ret, ret, ofs);
-    }
+    tcg_gen_deposit_i_i32(ret, 0, arg, ofs, len);
 }
 
 void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
@@ -2226,6 +2252,98 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
+static void tcg_gen_deposit_i_i64(TCGv_i64 ret, uint64_t i, TCGv_i64 arg,
+                                  unsigned int ofs, unsigned int len)
+{
+    i = deposit64(i, ofs, len, 0);
+
+    if (ofs + len == 64) {
+        tcg_gen_shli_i64(ret, arg, ofs);
+        goto finish;
+    }
+    if (ofs == 0) {
+        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+        goto finish;
+    }
+    if (TCG_TARGET_HAS_deposit_i64
+        && TCG_TARGET_deposit_i64_valid(ofs, len)) {
+        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret,
+                          tcg_constant_i64(i), arg, ofs, len);
+        return;
+    }
+
+    if (TCG_TARGET_REG_BITS == 32) {
+        if (ofs >= 32) {
+            tcg_gen_deposit_i_i32(TCGV_HIGH(ret), i >> 32,
+                                  TCGV_LOW(arg), ofs - 32, len);
+            tcg_gen_movi_i32(TCGV_LOW(ret), i);
+            return;
+        }
+        if (ofs + len <= 32) {
+            tcg_gen_deposit_i_i32(TCGV_LOW(ret), i, TCGV_LOW(arg), ofs, len);
+            tcg_gen_movi_i32(TCGV_HIGH(ret), i >> 32);
+            return;
+        }
+    }
+
+    /*
+     * To help two-operand hosts we prefer to zero-extend first,
+     * which allows ARG to stay live.
+     */
+    switch (len) {
+    case 32:
+        if (TCG_TARGET_HAS_ext32u_i64) {
+            tcg_gen_ext32u_i64(ret, arg);
+            tcg_gen_shli_i64(ret, ret, ofs);
+            goto finish;
+        }
+        break;
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i64) {
+            tcg_gen_ext16u_i64(ret, arg);
+            tcg_gen_shli_i64(ret, ret, ofs);
+            goto finish;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i64) {
+            tcg_gen_ext8u_i64(ret, arg);
+            tcg_gen_shli_i64(ret, ret, ofs);
+            goto finish;
+        }
+        break;
+    }
+    /* Otherwise prefer zero-extension over AND for code size.  */
+    switch (ofs + len) {
+    case 32:
+        if (TCG_TARGET_HAS_ext32u_i64) {
+            tcg_gen_shli_i64(ret, arg, ofs);
+            tcg_gen_ext32u_i64(ret, ret);
+            goto finish;
+        }
+        break;
+    case 16:
+        if (TCG_TARGET_HAS_ext16u_i64) {
+            tcg_gen_shli_i64(ret, arg, ofs);
+            tcg_gen_ext16u_i64(ret, ret);
+            goto finish;
+        }
+        break;
+    case 8:
+        if (TCG_TARGET_HAS_ext8u_i64) {
+            tcg_gen_shli_i64(ret, arg, ofs);
+            tcg_gen_ext8u_i64(ret, ret);
+            goto finish;
+        }
+        break;
+    }
+    tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
+    tcg_gen_shli_i64(ret, ret, ofs);
+
+ finish:
+    tcg_gen_ori_i64(ret, ret, i);
+}
+
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len)
 {
@@ -2242,6 +2360,14 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
         tcg_gen_mov_i64(ret, arg2);
         return;
     }
+
+    /* Deposit of a value into a constant. */
+    ts = tcgv_i64_temp(arg1);
+    if (ts->kind == TEMP_CONST) {
+        tcg_gen_deposit_i_i64(ret, ts->val, arg2, ofs, len);
+        return;
+    }
+
     if (TCG_TARGET_HAS_deposit_i64 && TCG_TARGET_deposit_i64_valid(ofs, len)) {
         tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, arg1, arg2, ofs, len);
         return;
@@ -2311,80 +2437,7 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
     tcg_debug_assert(len <= 64);
     tcg_debug_assert(ofs + len <= 64);
 
-    if (ofs + len == 64) {
-        tcg_gen_shli_i64(ret, arg, ofs);
-    } else if (ofs == 0) {
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-    } else if (TCG_TARGET_HAS_deposit_i64
-               && TCG_TARGET_deposit_i64_valid(ofs, len)) {
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5ii_i64(INDEX_op_deposit_i64, ret, zero, arg, ofs, len);
-    } else {
-        if (TCG_TARGET_REG_BITS == 32) {
-            if (ofs >= 32) {
-                tcg_gen_deposit_z_i32(TCGV_HIGH(ret), TCGV_LOW(arg),
-                                      ofs - 32, len);
-                tcg_gen_movi_i32(TCGV_LOW(ret), 0);
-                return;
-            }
-            if (ofs + len <= 32) {
-                tcg_gen_deposit_z_i32(TCGV_LOW(ret), TCGV_LOW(arg), ofs, len);
-                tcg_gen_movi_i32(TCGV_HIGH(ret), 0);
-                return;
-            }
-        }
-        /* To help two-operand hosts we prefer to zero-extend first,
-           which allows ARG to stay live.  */
-        switch (len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_ext32u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_ext16u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_ext8u_i64(ret, arg);
-                tcg_gen_shli_i64(ret, ret, ofs);
-                return;
-            }
-            break;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        switch (ofs + len) {
-        case 32:
-            if (TCG_TARGET_HAS_ext32u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext32u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 16:
-            if (TCG_TARGET_HAS_ext16u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext16u_i64(ret, ret);
-                return;
-            }
-            break;
-        case 8:
-            if (TCG_TARGET_HAS_ext8u_i64) {
-                tcg_gen_shli_i64(ret, arg, ofs);
-                tcg_gen_ext8u_i64(ret, ret);
-                return;
-            }
-            break;
-        }
-        tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
-        tcg_gen_shli_i64(ret, ret, ofs);
-    }
+    tcg_gen_deposit_i_i64(ret, 0, arg, ofs, len);
 }
 
 void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
-- 
2.34.1


