Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA12E752C03
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eI-0000Hz-Jn; Thu, 13 Jul 2023 17:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eE-0000HN-Dk
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eB-000164-OC
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3fc04692e20so11243125e9.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282885; x=1691874885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H93abcQMfpcVmKf+SmjckREj83SkP9I5kccuQ+f4FCc=;
 b=vsG2NBtkBSfDV6qbPry0b/iRTj8SvYNpBk5CQwGPL5EFCbtfu3JWS11JZb5/u0kgTW
 Xdws6eXl+CV+IIoHhLiD6QPdGvppTYCOIw6zZvPqKtuJok0Ee1Y1LfhtY5YOSFD6OCOy
 YNqOadonC7Fg0Wp52Ti1F/4q7wmzAdyYAW5s30v2h7eG/Uy9GgF+tUHg6IO7ZA6Cj1vG
 KRT6btxSJ4nTiAJ/1yPGUoIr0Vyiyu3yO4I2D2k9/SpJWFVI1SPy+WPI9fKTEckOXC+o
 ewz8V/kCRKsHciyFfI8dARxo+K0ktc0TL0CyuGXT/iQvGJPMcQXhN0eIuMQLxNXyOXQ7
 GlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282885; x=1691874885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H93abcQMfpcVmKf+SmjckREj83SkP9I5kccuQ+f4FCc=;
 b=IaWOGogMPftK8MH70dTd65mFSH01vHvUVl/u8Y9W6wVvfQpHwa+jF+iSHZ1zwpMAje
 y37U9P+YbNbz+uyyQUDguJgn6oAMGbNYf5TezhYAYtH4LLDU3aVzv5a1cnwk6LhTs6MA
 2rGcCQkkR1KmZd6d9nN2kDHD/kUa0tYiN79zBBz0zKCgt9FMykTmRCoc+5B+vIbf1r+N
 9uZMtfobzz6/+/H39mubm0ezX7kzzMyzk7CtYCfRSDEPogh2w2kM/n4+JxQI/k/ZgrSb
 q/c0TPFtN8GVmALEXsxvcfOwLp0/+xrkJwQVx1bWyLLKgTVBbCyLFARAIpwyWodgmo2m
 rSkg==
X-Gm-Message-State: ABy/qLZRMpJsVEq7TKQDWAAjqUYAGNqGYF0xtTl62x7+Wk1KZVPLrKpb
 YEvp9ug31nOAtU5ZbDsRu9bhVFd4Y+euUnM7P9pcKhhe
X-Google-Smtp-Source: APBJJlHH6P0+nBbiHfOJz5IZy9/y3c8Ck3KvQdih/zUCOA19uJfvRIkldk2O6vCwLFrbsAccFzOgyQ==
X-Received: by 2002:a5d:5650:0:b0:313:e88d:e6cf with SMTP id
 j16-20020a5d5650000000b00313e88de6cfmr2256359wrw.69.1689282885052; 
 Thu, 13 Jul 2023 14:14:45 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 03/18] target/s390x: Use clmul_8* routines
Date: Thu, 13 Jul 2023 22:14:20 +0100
Message-Id: <20230713211435.13505-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x331.google.com
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

Use generic routines for 8-bit carry-less multiply.
Remove our local version of galois_multiply8.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index 53ab5c5eb3..e110a7581a 100644
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
 
@@ -203,6 +203,29 @@ static S390Vector galois_multiply64(uint64_t a, uint64_t b)
     return res;
 }
 
+static Int128 do_gfm8(Int128 n, Int128 m)
+{
+    Int128 e = clmul_8x8_even(n, m);
+    Int128 o = clmul_8x8_odd(n, m);
+    return int128_xor(e, o);
+}
+
+void HELPER(gvec_vgfm8)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    /*
+     * There is no carry across the two doublewords, so their order
+     * does not matter, so we need not care for host endianness.
+     */
+    *(Int128 *)v1 = do_gfm8(*(const Int128 *)v2, *(const Int128 *)v3);
+}
+
+void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    Int128 r = do_gfm8(*(const Int128 *)v2, *(const Int128 *)v3);
+    *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -220,7 +243,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(8, 16)
 DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
@@ -257,7 +279,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(8, 16)
 DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
-- 
2.34.1


