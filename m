Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8C6781642
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMN-0008VY-NV; Fri, 18 Aug 2023 21:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAML-0008Ss-Tu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:34 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMJ-0007Mn-Hl
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:33 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bdf98a6086so12558985ad.0
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406950; x=1693011750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K0bXa9+pwNK5r/+j4mMdNNnTuQ3CG4xPOoFlK3zKTy0=;
 b=hBu6Xb06heDXO+hqL+WwmKwwyhJY59ZwFziIyGTJ4LGcBbAscDgTcbMh4Lup8iSCT8
 X1vwT5S9Y8ArHQbCtSYcSeoDmB1i9Lkmi98uWBewYzasY+oZnEHM1zoaFhKZrLQkMQGS
 JZ81Ju2O5f+Gj5UfmUA9GGuGDjr5gI6WDk0NTu+8PnblTqdqfHHEcih9CIjJBH2rk+02
 3kEXJwXscIZ+efiYw9BPvaVgGJBmDevK2Pr9U7nDgEqRI5Uil+PDn3bMU78KMRR5OYAo
 KZEaNHOUzG6kp8/vNsp1lBexEQmgLwAHLviZO0IutF/0InXqZyOPE833TyNTUY4wt6Vn
 Gr7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406950; x=1693011750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K0bXa9+pwNK5r/+j4mMdNNnTuQ3CG4xPOoFlK3zKTy0=;
 b=P9jH1XhOBSSIkuNgm+5blNfffkIHgEmdXz0qJIlvvVAWKi/OTpDAQ1UebpSDJ+fuFp
 E+30xHO2bDdOcL5x/xsvL277kAxGU9EIzpAev2PN2VU7jXYJNQf61XpmiXFwe3QjNt+B
 EsdfDrxNOm+oRULpzR0Oa0gsALnu51oyBSleASCiSc096dzyI4DyFimPyB1hu1WS9ckP
 3+gpsriLkge2SYd6hBqRdlqV281gvnWfaWeKTS/xXnCB8D3C9IM2bZkVL8WkCZeBEdXA
 BsqUCUXoVAD3/UsvcWc8aUBt1tfG16q9j2zMUU2k8u0RMpqPDcOINp2BC3jl5dkE/mfA
 weXg==
X-Gm-Message-State: AOJu0YyZBQuEIYO7ZWwxaZxh2aR2lurPYGO10DXFr1J++y1pJpIYkQcn
 b92ydSuNC/QsLSywutpamv6zF7ojTodxZ0bl/xw=
X-Google-Smtp-Source: AGHT+IFRCzlQ495U7YUkr+XXKr9AYuYvvJ2eETohwHU+R3ebaxgENX71yRP7sjqnpEzF3wNy+QWiuw==
X-Received: by 2002:a17:902:e984:b0:1bc:14f0:b76c with SMTP id
 f4-20020a170902e98400b001bc14f0b76cmr868598plb.65.1692406950328; 
 Fri, 18 Aug 2023 18:02:30 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 11/18] target/s390x: Use clmul_32* routines
Date: Fri, 18 Aug 2023 18:02:11 -0700
Message-Id: <20230819010218.192706-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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


