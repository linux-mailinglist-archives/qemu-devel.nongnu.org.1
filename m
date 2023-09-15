Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D71857A23C4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu5-0004VW-Gp; Fri, 15 Sep 2023 12:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu2-0004UV-Me
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu1-0004w9-1e
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:46 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso2146752b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796162; x=1695400962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1FQxefxQxkmUZ1SixwcnXZvZP/IO9ZUpCwPt+2NITw=;
 b=PMWdIkfwC61+8PGZrE/P5bWc4p7fH3392/XU18lhRK4xO4P6ZJ2MGYxL6NhdMGKapn
 /n5KapAX8lF1ZXj9pUDtalmYPELYF/uTSe9P9A9Ju03IU3kWPBZRCEq3LmyFjZxNzASj
 33BhVhpXVqtEy1qv/0uVyN6pr5Futzm+Btv7FdLk0OlVFAnUwoCwGYDyvQfo5SyfWXZY
 C+9N/AD6Rl/qvA00vEqjec4oWEX9DTvWl5YWQYf6Zuv/kPumBy3rJMJL7nenmxu/2EWw
 ZsmyVSpC/8VKZyQRZ43VSRp1gM8ltvOLseEMu1rrZVJbd/jr4iI9rSfSUGY0BNMuWxnE
 3TOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796162; x=1695400962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1FQxefxQxkmUZ1SixwcnXZvZP/IO9ZUpCwPt+2NITw=;
 b=FD9lNuHUPe1AD1JyDQTOQuxTUNFLKkxSUmSQr1hwuLDiSSdTwldoroCbEWLqcDH48l
 AOymYdDUdqyn3qYLwEVjOgG/JYuCeUS0zNtzEDhrIqRZegj8jjjsABLBi/36RnCrExxh
 whlhUwb2kT2BvKGCeA5iFo2IQ9ZD7yOgDWQlQ95YOhQsIMwdRk/833QG0316f6L0+Pgp
 wg7yCsvhzvSudyDlij0A9w1NlH+ljrkj/wDS27R1apY+LLG3lFvtcm3AzI+8Kmt+KPKi
 5vVK9JGrtwgXg9GZAa8w6/vlPwQvFQSGYMybTXq9GN2h0eOMGkdyfiyLEJOeej1X0UBJ
 bX9Q==
X-Gm-Message-State: AOJu0YxCpDuI/BpY5eDukG0pgR7qIKu+fE+GtJirFhqUuHwD/wSu9uFr
 hHJxG7cxtq3RPqBxc0ZTwpyYqSSCY5tNwAI1nB4=
X-Google-Smtp-Source: AGHT+IF4t+SsMaogr17mQxO3gCidEyq2/PnZNaR8bNd2IT5rk9gtdTx9TUt3/i6zNZi7fPoxLacnfQ==
X-Received: by 2002:a05:6a20:8f01:b0:136:faec:a7dc with SMTP id
 b1-20020a056a208f0100b00136faeca7dcmr2989402pzk.11.1694796162576; 
 Fri, 15 Sep 2023 09:42:42 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/19] target/s390x: Use clmul_32* routines
Date: Fri, 15 Sep 2023 09:42:23 -0700
Message-Id: <20230915164231.123580-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of galois_multiply32.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 75 +++++++++----------------------
 1 file changed, 22 insertions(+), 53 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index 11477556e5..ba284b5379 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -165,22 +165,6 @@ DEF_VCTZ(8)
 DEF_VCTZ(16)
 
 /* like binary multiplication, but XOR instead of addition */
-#define DEF_GALOIS_MULTIPLY(BITS, TBITS)                                       \
-static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
-                                             uint##TBITS##_t b)                \
-{                                                                              \
-    uint##TBITS##_t res = 0;                                                   \
-                                                                               \
-    while (b) {                                                                \
-        if (b & 0x1) {                                                         \
-            res = res ^ a;                                                     \
-        }                                                                      \
-        a = a << 1;                                                            \
-        b = b >> 1;                                                            \
-    }                                                                          \
-    return res;                                                                \
-}
-DEF_GALOIS_MULTIPLY(32, 64)
 
 static S390Vector galois_multiply64(uint64_t a, uint64_t b)
 {
@@ -254,24 +238,29 @@ void HELPER(gvec_vgfma16)(void *v1, const void *v2, const void *v3,
     q1[1] = do_gfma16(q2[1], q3[1], q4[1]);
 }
 
-#define DEF_VGFM(BITS, TBITS)                                                  \
-void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
-                             uint32_t desc)                                    \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / TBITS); i++) {                                      \
-        uint##BITS##_t a = s390_vec_read_element##BITS(v2, i * 2);             \
-        uint##BITS##_t b = s390_vec_read_element##BITS(v3, i * 2);             \
-        uint##TBITS##_t d = galois_multiply##BITS(a, b);                       \
-                                                                               \
-        a = s390_vec_read_element##BITS(v2, i * 2 + 1);                        \
-        b = s390_vec_read_element##BITS(v3, i * 2 + 1);                        \
-        d = d ^ galois_multiply32(a, b);                                       \
-        s390_vec_write_element##TBITS(v1, i, d);                               \
-    }                                                                          \
+static inline uint64_t do_gfma32(uint64_t n, uint64_t m, uint64_t a)
+{
+    return clmul_32(n, m) ^ clmul_32(n >> 32, m >> 32) ^ a;
+}
+
+void HELPER(gvec_vgfm32)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+
+    q1[0] = do_gfma32(q2[0], q3[0], 0);
+    q1[1] = do_gfma32(q2[1], q3[1], 0);
+}
+
+void HELPER(gvec_vgfma32)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+
+    q1[0] = do_gfma32(q2[0], q3[0], q4[0]);
+    q1[1] = do_gfma32(q2[1], q3[1], q4[1]);
 }
-DEF_VGFM(32, 64)
 
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
@@ -288,26 +277,6 @@ void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
     s390_vec_xor(v1, &tmp1, &tmp2);
 }
 
-#define DEF_VGFMA(BITS, TBITS)                                                 \
-void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
-                              const void *v4, uint32_t desc)                   \
-{                                                                              \
-    int i;                                                                     \
-                                                                               \
-    for (i = 0; i < (128 / TBITS); i++) {                                      \
-        uint##BITS##_t a = s390_vec_read_element##BITS(v2, i * 2);             \
-        uint##BITS##_t b = s390_vec_read_element##BITS(v3, i * 2);             \
-        uint##TBITS##_t d = galois_multiply##BITS(a, b);                       \
-                                                                               \
-        a = s390_vec_read_element##BITS(v2, i * 2 + 1);                        \
-        b = s390_vec_read_element##BITS(v3, i * 2 + 1);                        \
-        d = d ^ galois_multiply32(a, b);                                       \
-        d = d ^ s390_vec_read_element##TBITS(v4, i);                           \
-        s390_vec_write_element##TBITS(v1, i, d);                               \
-    }                                                                          \
-}
-DEF_VGFMA(32, 64)
-
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
                           const void *v4, uint32_t desc)
 {
-- 
2.34.1


