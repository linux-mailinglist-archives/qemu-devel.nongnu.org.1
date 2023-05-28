Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5D713AB7
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 18:50:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3Jai-0000aQ-Br; Sun, 28 May 2023 12:50:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jag-0000aA-6U; Sun, 28 May 2023 12:49:58 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q3Jae-0003cm-JU; Sun, 28 May 2023 12:49:57 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3943fdc59f9so1588553b6e.0; 
 Sun, 28 May 2023 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685292595; x=1687884595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALaWyhMssmN731ytAfkeS5ozGxm5FcyKNJFkbSvsWgg=;
 b=hK8ZDRU3Z+l4oATu9o0LMnxN8Kmt6g8x6X+FvOKiF57lCNyEZwzZrz2YnQBFbmBp9s
 p377q9aURz8M8/0gBkrbTxH1upO7hj/w3SgRj25cOcVggKI9Qk2KnzAA5W2r5A6XOKuH
 0Waorfuw17hqJF2BmMMTIY5R8SmlHXTAYBjcnrvkis2KsmNd/IpK3/7P6C9zAgKdRael
 UWlrkzB4q4Qy6McQB2EVp+FqLuu4rAM21iYYcPEgZVPARn6/6stzUmjnp2i+d4dc844d
 S4kFYndtIYHklQWK1bFawIAtHnGn4JOfjWX7ZpXu+Q4wl6bReh6iB14pADku0NnIJRL5
 HiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685292595; x=1687884595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALaWyhMssmN731ytAfkeS5ozGxm5FcyKNJFkbSvsWgg=;
 b=jQqXICaT42L4h1a0uEMq6rhp26B9RqD01NjDQEBviiKfDg3hKz01/kaGHOW4f7UcWL
 naiSKqeudlhGJsW268/p/xrfWw+RluU1iHX15sle1n/q8Lg5mnPWpVmVBGm53wX9TkU1
 WpeB2wR9q79p31tdxeh8PxVzyzgIkHJ59kB5fqJxFG0vC3htTg/NkMhLcACHeaSPYmEW
 vktZlzlQodkDL+dIDbM2h9kGkujfpUY9s8YD2kLVjXQSspKCvc41vwaWKU1P/Ck57O8a
 lIjhfjpsDIJA9tWuWgJBL+kUUIO+ENL7cLk1Sr6NbuHjxKC2+HqhGCD5UO95epwOhOf8
 AH6A==
X-Gm-Message-State: AC+VfDwbcGh61yf0sGSEcyh+6fguV4ieaggvNkONVXWPh0Bl5UBw3ZG/
 YXVrVEs3UANAOKBVDMKetQJM/2x0jlI=
X-Google-Smtp-Source: ACHHUZ43O1AXnJz8tpCmxEizgYw/YaHyrBLqwvNC2xqXw+/eWlzYLsvfomdIHrJ1kvV/GVvBDjnq8Q==
X-Received: by 2002:a05:6808:2127:b0:399:b0ee:de1 with SMTP id
 r39-20020a056808212700b00399b0ee0de1mr4347646oiw.49.1685292594859; 
 Sun, 28 May 2023 09:49:54 -0700 (PDT)
Received: from grind.. (200-162-225-121.static-corp.ajato.com.br.
 [200.162.225.121]) by smtp.gmail.com with ESMTPSA id
 w4-20020a4adec4000000b0054f85f67f31sm3378830oou.46.2023.05.28.09.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 09:49:54 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 08/10] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
Date: Sun, 28 May 2023 13:49:20 -0300
Message-Id: <20230528164922.20364-9-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528164922.20364-1-danielhb413@gmail.com>
References: <20230528164922.20364-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Instead of computing an artificial "class" bitmask then converting that
to the fprf value, compute the final value from the start.

Reorder the tests to check the most likely cases first.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230523202507.688859-1-richard.henderson@linaro.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 target/ppc/fpu_helper.c | 78 ++++++++++++-----------------------------
 1 file changed, 22 insertions(+), 56 deletions(-)

diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
index a66e16c212..03150a0f10 100644
--- a/target/ppc/fpu_helper.c
+++ b/target/ppc/fpu_helper.c
@@ -141,62 +141,28 @@ static inline int ppc_float64_get_unbiased_exp(float64 f)
     return ((f >> 52) & 0x7FF) - 1023;
 }
 
-/* Classify a floating-point number.  */
-enum {
-    is_normal   = 1,
-    is_zero     = 2,
-    is_denormal = 4,
-    is_inf      = 8,
-    is_qnan     = 16,
-    is_snan     = 32,
-    is_neg      = 64,
-};
-
-#define COMPUTE_CLASS(tp)                                      \
-static int tp##_classify(tp arg)                               \
-{                                                              \
-    int ret = tp##_is_neg(arg) * is_neg;                       \
-    if (unlikely(tp##_is_any_nan(arg))) {                      \
-        float_status dummy = { };  /* snan_bit_is_one = 0 */   \
-        ret |= (tp##_is_signaling_nan(arg, &dummy)             \
-                ? is_snan : is_qnan);                          \
-    } else if (unlikely(tp##_is_infinity(arg))) {              \
-        ret |= is_inf;                                         \
-    } else if (tp##_is_zero(arg)) {                            \
-        ret |= is_zero;                                        \
-    } else if (tp##_is_zero_or_denormal(arg)) {                \
-        ret |= is_denormal;                                    \
-    } else {                                                   \
-        ret |= is_normal;                                      \
-    }                                                          \
-    return ret;                                                \
-}
-
-COMPUTE_CLASS(float16)
-COMPUTE_CLASS(float32)
-COMPUTE_CLASS(float64)
-COMPUTE_CLASS(float128)
-
-static void set_fprf_from_class(CPUPPCState *env, int class)
-{
-    static const uint8_t fprf[6][2] = {
-        { 0x04, 0x08 },  /* normalized */
-        { 0x02, 0x12 },  /* zero */
-        { 0x14, 0x18 },  /* denormalized */
-        { 0x05, 0x09 },  /* infinity */
-        { 0x11, 0x11 },  /* qnan */
-        { 0x00, 0x00 },  /* snan -- flags are undefined */
-    };
-    bool isneg = class & is_neg;
-
-    env->fpscr &= ~FP_FPRF;
-    env->fpscr |= fprf[ctz32(class)][isneg] << FPSCR_FPRF;
-}
-
-#define COMPUTE_FPRF(tp)                                \
-void helper_compute_fprf_##tp(CPUPPCState *env, tp arg) \
-{                                                       \
-    set_fprf_from_class(env, tp##_classify(arg));       \
+#define COMPUTE_FPRF(tp)                                          \
+void helper_compute_fprf_##tp(CPUPPCState *env, tp arg)           \
+{                                                                 \
+    bool neg = tp##_is_neg(arg);                                  \
+    target_ulong fprf;                                            \
+    if (likely(tp##_is_normal(arg))) {                            \
+        fprf = neg ? 0x08 << FPSCR_FPRF : 0x04 << FPSCR_FPRF;     \
+    } else if (tp##_is_zero(arg)) {                               \
+        fprf = neg ? 0x12 << FPSCR_FPRF : 0x02 << FPSCR_FPRF;     \
+    } else if (tp##_is_zero_or_denormal(arg)) {                   \
+        fprf = neg ? 0x18 << FPSCR_FPRF : 0x14 << FPSCR_FPRF;     \
+    } else if (tp##_is_infinity(arg)) {                           \
+        fprf = neg ? 0x09 << FPSCR_FPRF : 0x05 << FPSCR_FPRF;     \
+    } else {                                                      \
+        float_status dummy = { };  /* snan_bit_is_one = 0 */      \
+        if (tp##_is_signaling_nan(arg, &dummy)) {                 \
+            fprf = 0x00 << FPSCR_FPRF;                            \
+        } else {                                                  \
+            fprf = 0x11 << FPSCR_FPRF;                            \
+        }                                                         \
+    }                                                             \
+    env->fpscr = (env->fpscr & ~FP_FPRF) | fprf;                  \
 }
 
 COMPUTE_FPRF(float16)
-- 
2.40.1


