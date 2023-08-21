Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F23782E43
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:20:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cp-0001jf-Ov; Mon, 21 Aug 2023 12:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cP-0001UE-Sn
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:05 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cN-0005cD-I9
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bd9b4f8e0eso21234505ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634742; x=1693239542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjJiUhlPai6mmk7xoBYCGw+/59480gYFwt2JNZw/Qk4=;
 b=CesaKTvzUC/8eEwCu7nznCGFFyf6iaJqRk9V4r0aj+u3K4iXLHf/6ElY1y+HSkmauw
 sc68m2ZEBzg/bflvu14xEDyyn+kEW5ufb3l+xb4uv0ajwgnr7zoaQ6qZhyNQfi6I7X4b
 jOy4D8/EzpWK71LXLfNXg8RfXu4mjPusFYvtMimHMPdLYgN+Oxq3QMhBQY7glX6T45+e
 81VEgkhCGpZ7KtHdqE+cr/RLIgLQaCLhm/eA96G/1nL3ut7f2AjnD0oKNSQhNpdcamGQ
 rfNUvCwqScoj18MuoZJrQanItTgLAeOu3K4LXwQlsuJ+jAXEPOmiHHqV0TScipe91MX1
 7RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634742; x=1693239542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjJiUhlPai6mmk7xoBYCGw+/59480gYFwt2JNZw/Qk4=;
 b=cZ+rABt12FDHAlEJcE9fM8b1MsEZA3jVpPGTBCAgeH134SzZEdUz1Xr/RysCjwB6RC
 NidgbDbRCjIOnNZ/6jmIfYkqlOwjmULg4M64dLr5jKWrZTP3VL3WlMrpl+KxR2Aqkq6t
 GNNs8MnlLqfbV5p1bIXOaDv8nqPOoI70aXiWB65GGH+TARolQ+5DKE6kOLPPQSQD/dQi
 lLNcrOxKozvqU3GLcTvBc/lrxVkTMLmuvnOtF8qy7j9/58geguYmmxtU3FzpntMM0d+Y
 cKrwoyEnaoBVtRCS7XrOEId7Z1cRucAl+eBsGp3L2SKOWdpBkWznDJcKtP7jlb5G76yJ
 bXkQ==
X-Gm-Message-State: AOJu0YxAFGDlBDCWrlThPZGxE4epg0ypyLw4KQfeQ9aLgpvUK1Bm2X/7
 /RJkSVmDCJoekfS3JAM5zfZyk+x4GOYUPAsonbI=
X-Google-Smtp-Source: AGHT+IGu/wnggifij+HViI04ZX7iwOewmPWfEk6G3ZxoImHscvs/IUm97mLjfM6c90mse7MH+PPoHA==
X-Received: by 2002:a17:902:dac2:b0:1bb:99d3:6a53 with SMTP id
 q2-20020a170902dac200b001bb99d36a53mr5721262plx.20.1692634742149; 
 Mon, 21 Aug 2023 09:19:02 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 07/19] target/s390x: Use clmul_16* routines
Date: Mon, 21 Aug 2023 09:18:41 -0700
Message-Id: <20230821161854.419893-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Use generic routines for 16-bit carry-less multiply.
Remove our local version of galois_multiply16.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index edff4d6b2b..11477556e5 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -180,7 +180,6 @@ static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
     }                                                                          \
     return res;                                                                \
 }
-DEF_GALOIS_MULTIPLY(16, 32)
 DEF_GALOIS_MULTIPLY(32, 64)
 
 static S390Vector galois_multiply64(uint64_t a, uint64_t b)
@@ -231,6 +230,30 @@ void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
     q1[1] = do_gfma8(q2[1], q3[1], q4[1]);
 }
 
+static inline uint64_t do_gfma16(uint64_t n, uint64_t m, uint64_t a)
+{
+    return clmul_16x2_even(n, m) ^ clmul_16x2_odd(n, m) ^ a;
+}
+
+void HELPER(gvec_vgfm16)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+
+    q1[0] = do_gfma16(q2[0], q3[0], 0);
+    q1[1] = do_gfma16(q2[1], q3[1], 0);
+}
+
+void HELPER(gvec_vgfma16)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+
+    q1[0] = do_gfma16(q2[0], q3[0], q4[0]);
+    q1[1] = do_gfma16(q2[1], q3[1], q4[1]);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -248,7 +271,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
@@ -284,7 +306,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
-- 
2.34.1


