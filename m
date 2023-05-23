Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE32170E66A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 22:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1YZL-000157-Fk; Tue, 23 May 2023 16:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YZI-00014G-4e
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:25:16 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1YZD-00037c-RW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 16:25:15 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d57cd373fso2457122b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 13:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684873509; x=1687465509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ueDoFO4GnmkKV3sF4IOXhhoY9okOdTr1M6goooR55Vo=;
 b=hj+07bsNcZnjPlEUe9tbjHF4sI4BICMvFcSHS2IsN6IQ90tOSMEi1E+8rwS95D6lqC
 SvXe91tTUFLthf+pKqB8hpgQ7cCiIp0krJKkd0h1hlnHBP7B3ZKwx2uKLis0yp+ioqDJ
 ONzPiy3BQ4yN6v+VYOOuCJlLKsr4QW4xiDv/z/CaQMRenTcLa3nrSSFqBClIchUSI6d/
 yUfGHdyi0qe6W7yoAEarhD16NcHHUu62blTem7nqQxT1rhwnrVcpnHPLkPwAi9D+3e3W
 LyMhmVgXAM+akxoH8l36IFv3Fpzqa+zhEA0gdR2/o2P5Xqo7/fOLAbInGstHCDWr4ueG
 uirw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684873509; x=1687465509;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ueDoFO4GnmkKV3sF4IOXhhoY9okOdTr1M6goooR55Vo=;
 b=GngPEcrr+mGWR3N2ISrBxU41mLh6u6OXHZQlfbaAZkKJOMZlcl47FllmNfe7M4m5p0
 eHyM+rDfpwYAPMNYcKU8blm2WMNyi/8heQZOGcAkvwF86At159AId8YnWT/swLptDE8e
 i/CJ5V8d9452a9aTUKCms7nxuC0PWENM1BQVX5FESICFglccfsN8+X2bQArgV9Myu40K
 ADy//1dbK4Uc1YRuEfvcuIz5vLklxXwMJV/+BvVIDwGczQs1zsYF5X931rAjjwgQIL4s
 +5SGY2tHVvbflJG+QN8hL9lAVfkvsBNLjS7X5HYS1J6GhbFZGbQ5eRb++O0ij86+3nTk
 Vnpg==
X-Gm-Message-State: AC+VfDxDnvUINR4080OJbOW6rSQOAQGfUrbn4oG8JOTwIBDz5Z5UiIHE
 TSjfPd5/Mn6MwZAZIys0Gn5ZX/ji1oTpNlsnO2w=
X-Google-Smtp-Source: ACHHUZ7/tbbzXneGzxje1cLYJQqLOwA33zM+U9Mv1QYKgl79tcJKVkM5oVOXJVam/VOjMMae3RhVdw==
X-Received: by 2002:a05:6a20:12d3:b0:103:3885:3738 with SMTP id
 v19-20020a056a2012d300b0010338853738mr16777796pzg.19.1684873508964; 
 Tue, 23 May 2023 13:25:08 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 u24-20020aa78498000000b0064dbf805ff7sm3178508pfn.72.2023.05.23.13.25.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 13:25:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-ppc@nongnu.org,
	balaton@eik.bme.hu
Subject: [PATCH] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
Date: Tue, 23 May 2023 13:25:07 -0700
Message-Id: <20230523202507.688859-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Instead of computing an artifical "class" bitmask then
converting that to the fprf value, compute the final
value from the start.

Reorder the tests to check the most likely cases first.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1


