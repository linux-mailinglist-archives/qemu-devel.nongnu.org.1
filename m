Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E826E782E3E
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7co-0001h2-Kf; Mon, 21 Aug 2023 12:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cT-0001VH-FL
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cR-0005dA-4f
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:09 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf6ea270b2so8275155ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634746; x=1693239546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1FQxefxQxkmUZ1SixwcnXZvZP/IO9ZUpCwPt+2NITw=;
 b=QaUHdhM5BX0BweXF2swyVuViQLyHVeetSLreVhr/8erup89KfAGq70Vl+ItSFCYI4M
 VYjOe5oVwsbCoQIsaIOrY2u0kx0g5bsvompIcAsGGN1w77GWOXvxghX+lhDWsqvlQTQp
 QwO1hZvlqp5ZUCDADxzukS8/2JrxG6xpuSdaVQLyY5ds1pvMBz2WLUBsJEwCzKQW4ul5
 zBLb8GsX9jTFgKAfW54fHqulOao8atMk0mNbxtoyueSYGTsJq2OUBoq1Xl6rfm75s0Yw
 9b0bNboeNuxhrB/MyaSd1cl+ssyc8aCd2uLY/1fMDKHasx+vMxtnH0tetY/0q0KC360M
 qAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634746; x=1693239546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1FQxefxQxkmUZ1SixwcnXZvZP/IO9ZUpCwPt+2NITw=;
 b=GO9jZF96Eu2TncxL6MB/8XW949Qs9ViEmnvW76k1JdfGlyQL3h9MMhBQ+zJEanskWT
 5sSbuLl8R32NbEHP+7ZzBFDEkUzEQyS+fGltZQwWy7jppz5oBg7EhrkGpWzFvkl/XDx3
 eOeR/HyrWOeV/Rw0SozKAQdMytlqJu9Z9SnJyBt7t2XZpqpljajXYQpZpbiBpmXw8Zgd
 80bVgBrzK1izUYNjvsknGp0ro2u+UI6odmvg2EXZXHfzBoPGUrXIDcBVERvqBGcoQwa3
 AIeiYvNq12qFgkNRy3xTOw0dJvi1mzoA+8G4HRkHQfgYtmSWwxKT/F/OCxwXnG6TKOir
 3SnQ==
X-Gm-Message-State: AOJu0Yw+Rko806mBHI7LSey5wwjFNd3YQaycxxSkWDS0lP0ACpVZpUuU
 IJXHhlDjqSSMnVtgt9ONwSeN9cDB16cWQkW1EMY=
X-Google-Smtp-Source: AGHT+IHydmVqicAI73AbTfJI0I5nT57XYT35M+MXZwB2ZCPqJhZd8Gkx/raV/to22HDf5eWXZOOsPA==
X-Received: by 2002:a17:902:c101:b0:1bf:6cbc:6ead with SMTP id
 1-20020a170902c10100b001bf6cbc6eadmr3504244pli.22.1692634745828; 
 Mon, 21 Aug 2023 09:19:05 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/19] target/s390x: Use clmul_32* routines
Date: Mon, 21 Aug 2023 09:18:45 -0700
Message-Id: <20230821161854.419893-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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


