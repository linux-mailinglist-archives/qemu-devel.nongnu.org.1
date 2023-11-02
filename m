Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF787DEA0E
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:33:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMXm-0005kV-QF; Wed, 01 Nov 2023 21:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXZ-0005Xd-ON
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:33 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXU-0001VC-8x
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:32 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so439726b3a.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888625; x=1699493425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BJlcx9oSMgaomOh7sPzTCOyXOzihSFEWq7bL9QPBTQ=;
 b=B+JQs8reI4GrYaj4IioPFzXB1LmosxX5bqNnYj7Kgm3Xn2innnYz7yI1DwA5eUO8Ye
 Jkw2AMIlbTsRk+epizx/2N3XdWXVWivSusTeX2bhy9DUTzSX4UA90uILKMbXabrEk7Li
 GZqtJ5jDpI7auH91n8sBpuMKb1btYPlWqEKeRk0QS4W04iuK/uy2EZle6nqMasTsv1gH
 eB3E0QeS7x8pqXNvIAqRv+Bi4tkiiN+bPCG+r1veNAN3SDbFCpiqdSez6naXJPOEvhue
 9ObhQi/Q+CpCdQZSYE75C1doRGT9P+6ViFfFj1Gjoz/ngw6HEgelHMbCG4qRfRFlOuOe
 YwIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888625; x=1699493425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BJlcx9oSMgaomOh7sPzTCOyXOzihSFEWq7bL9QPBTQ=;
 b=DiDlfs2pTnvzfWC85pDJp52rAOrZuAHRSZireitqPfkGzA8zzr8gBtpUyHYTjxFbiw
 bQRyPhvx5MuPOJD/XNUcIWO1HWQSxjqo0M5ujaffbPsPufUbeCfehJ2y/sRF6RZFa7EN
 UK6XiYgMuvD1kDzm+r8nmj3ROaP3mBoBuWM4azz/fax2g87saUZkh8y4VicW268yMxcE
 skz/pyoaAFtu3YdU905XzhpvHv1sl8uBQyvWYrw+5TW2I6oQZI/Qes6Y2LfSUsgvskG9
 hGvQ3kUycBUf8quZ049q72Kdxd+ATgTaNkSzh4rckZ3bhNHV6cj3Kb4p6Wp+eE8oGmkI
 zwfg==
X-Gm-Message-State: AOJu0Yxu+kHhZvJE+3mFkEsJSgDrVCk7M+Lout1X4IdWA705ukqvtDYL
 KcKWWCcsWYMop8VojGDKE8SlVYUFty6mhL6wtMI=
X-Google-Smtp-Source: AGHT+IGDMSrJzPz/Ofj/gwb8ke+LnOc66cvN8QY90nMAhm0LftaIULDDPGUM8hH8IwZxuXcnEz6u3Q==
X-Received: by 2002:a05:6a00:9a6:b0:6be:18a9:8f60 with SMTP id
 u38-20020a056a0009a600b006be18a98f60mr18378034pfg.16.1698888624315; 
 Wed, 01 Nov 2023 18:30:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 08/88] tcg: Improve expansion of deposit into a constant
Date: Wed,  1 Nov 2023 18:28:56 -0700
Message-Id: <20231102013016.369010-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Generalize tcg_gen_deposit_z_* from 0 to any constant.
Use this to automatically simplify tcg_gen_deposit_*.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 295 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 174 insertions(+), 121 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e305260099..e6bf942106 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -603,6 +603,70 @@ void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
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
@@ -619,6 +683,14 @@ void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
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
@@ -673,53 +745,7 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
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
@@ -2238,6 +2264,98 @@ void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
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
@@ -2254,6 +2372,14 @@ void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
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
@@ -2323,80 +2449,7 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
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


