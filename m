Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A1D782E3A
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:19:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cQ-0001Tc-0I; Mon, 21 Aug 2023 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cM-0001Ss-0D
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:02 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cJ-0005bL-Hp
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:01 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bf3a2f4528so25022475ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634738; x=1693239538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q1HqpqG1SCyo6N98nxssbdjX05tzqj9OxhfNx1abB4M=;
 b=NQupEBIYMzUZ0PkCl7sXjsjYb8gouT7klDTzuOxUIPBe3wEXlGfXXvQbU2StyL3gQE
 vGyX6Nay8o4t7WwslhI/YCR6+YOSJajq7ajCd5sp5t0boMKixASiljPTfDePsoPHRm6h
 6HbDchJRsSHt2LWuao3XRDu3ZDuJx1Xv9MP8JQau+DrnEyS7ADQ6jicv2PDOiClbii94
 O3GBRISV8wQYCsL/1rMjojF0/hFMY1hHjd912gVdofQNOyJvO33viuJMsnH1ehyIv8SI
 zY2Ac1GI071hrNkkLcRt9pMVTyJavvjkrSUhKVl1TeMhSg+wyfi/hDY2KCBn20LNIqVg
 m1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634738; x=1693239538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q1HqpqG1SCyo6N98nxssbdjX05tzqj9OxhfNx1abB4M=;
 b=hymrmUZUFwQ9vmrwlHaHTb66Fj59yJ/fmciFI8tpn5npUsPM/wCZfTE4aLg6mhrV9q
 77fNLPLn6CeMinEz0LMOZkzYNBBeBvuMyEkthAqatMbv3Fcf1kmWtJSBRjMU/KoZInbU
 3xkcz0risj0WBpoGJRYL0Kq+ORALXtbCTXCDmBRH5xCXpBKWhjjvNIhBA7K69wtybTra
 PI7QSFUQtdsN6xzyxwS1VeRKQtzHv0B/O92pv3y7N9hefO0yl8ieekb/eKdBz/g1aIr7
 WFaJAnP26C6b2vQ0YhHozu1XhIsx/uxS4/vSzj4pD3eODkSW3wnh9Pgu1z6fkLiKWSj1
 Fkew==
X-Gm-Message-State: AOJu0YzGMIl7qh3zgJgy/fqOAZz3sugYddMQujeNpOSf5tAI+GPBSOsc
 IOBCVFB/VCakL7COrWd8zsy/0/CVJ3AzoN3PWvY=
X-Google-Smtp-Source: AGHT+IERUmgXWtJe25h1ZLmg6rZo/sxlQgIGFm+hh0rlvJURqFG+I6Ask6xZ4Wcxti8iB4P76dYB/w==
X-Received: by 2002:a17:902:f681:b0:1bb:9c45:130f with SMTP id
 l1-20020a170902f68100b001bb9c45130fmr8156841plg.69.1692634738112; 
 Mon, 21 Aug 2023 09:18:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:18:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 03/19] target/s390x: Use clmul_8* routines
Date: Mon, 21 Aug 2023 09:18:37 -0700
Message-Id: <20230821161854.419893-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use generic routines for 8-bit carry-less multiply.
Remove our local version of galois_multiply8.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 32 ++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index 53ab5c5eb3..edff4d6b2b 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -14,6 +14,7 @@
 #include "vec.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "crypto/clmul.h"
 
 static bool s390_vec_is_zero(const S390Vector *v)
 {
@@ -179,7 +180,6 @@ static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
     }                                                                          \
     return res;                                                                \
 }
-DEF_GALOIS_MULTIPLY(8, 16)
 DEF_GALOIS_MULTIPLY(16, 32)
 DEF_GALOIS_MULTIPLY(32, 64)
 
@@ -203,6 +203,34 @@ static S390Vector galois_multiply64(uint64_t a, uint64_t b)
     return res;
 }
 
+/*
+ * There is no carry across the two doublewords, so their order does
+ * not matter.  Nor is there partial overlap between registers.
+ */
+static inline uint64_t do_gfma8(uint64_t n, uint64_t m, uint64_t a)
+{
+    return clmul_8x4_even(n, m) ^ clmul_8x4_odd(n, m) ^ a;
+}
+
+void HELPER(gvec_vgfm8)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+
+    q1[0] = do_gfma8(q2[0], q3[0], 0);
+    q1[1] = do_gfma8(q2[1], q3[1], 0);
+}
+
+void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t desc)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+
+    q1[0] = do_gfma8(q2[0], q3[0], q4[0]);
+    q1[1] = do_gfma8(q2[1], q3[1], q4[1]);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -220,7 +248,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(8, 16)
 DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
@@ -257,7 +284,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(8, 16)
 DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
-- 
2.34.1


