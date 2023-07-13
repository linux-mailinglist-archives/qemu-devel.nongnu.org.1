Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D382752C04
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eL-0000J8-Vc; Thu, 13 Jul 2023 17:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eH-0000I3-CK
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:54 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eE-00016t-JZ
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:53 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3163eb69487so1259511f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282889; x=1691874889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rL0bmNffPB7WGyLli9yh/J2zSVJX7fi9BvkXQFIA5Kc=;
 b=eHSZynIwUPhXF+gDw9Jsj3l0JfmRCWB0/NyfL9zLrpISrxs7GKTMGNIARIUQNKbEd/
 JGMvtmKhsIfpsVPQG8lQwjqPG/SNdNgBZ/TSCTnM0t/WmQMt4yZha3G2N5ddnMPNrJ1O
 n7LnjZXqkEFJNBXQIwUbAO3kK/bf7R6aW1XMl+Mx4knnag1KdSWiA8Zs/Vsje7w7kNpn
 gQEYY5WOq67SmzsX8GqLfHRII+j9g8EVUT/pnclOsGfUH+rHnUyH0EWsohznkVqjpe5S
 eBfDpaB/PSTZE099/A7rrkynQkWg2NsvhyOqPu0cca5Gc9MEkDv+38bq7qILJ73CCNb4
 1r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282889; x=1691874889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rL0bmNffPB7WGyLli9yh/J2zSVJX7fi9BvkXQFIA5Kc=;
 b=gIgylqWXJ8n8ObBz/iYOvsZFDZzKad4VCZzPgmzngBjnlB9xKXDCZ5xxrKsFwUr287
 0l1h/yrNc9SPYBAiPmXyq4q0/EjcW7aXfhAUelIwnbtSjkwsQIag92l5a9hy74mOfMx0
 rmiqx27QSOypAwiTM/CE0UZ/jGI1J75gJCKZeBLTuP1FBqnWPI14qe2icHqx82dLH1We
 oGAuE8VVCYfuaMiwOs2ZUKA7amQnfU6ZNaoqRqabK3yrH0s5YMEB6JQKiewuBNfNoLXy
 q2vjsesmkM0NUPpIyBWQnABxlIDnqdPCUtHo5m36dkNbKGwFivEUejQDY+R0rttXPRuw
 nE5A==
X-Gm-Message-State: ABy/qLYy31bcJpsqCMHPdkk22pN7dlU+moeX6gieYoK2t6KwV6W3naAB
 yyNXWzGTzn8jML+k214BpELR5bn0vPPEFEolpkFvrxVr
X-Google-Smtp-Source: APBJJlE/qurVguVmdddEbzR88iFD/+snx+lafn+peayWFaB4huO2acsJtyOZPRCELDo7tGdAUfGAdA==
X-Received: by 2002:adf:f44d:0:b0:314:1d6:8aa7 with SMTP id
 f13-20020adff44d000000b0031401d68aa7mr595907wrp.29.1689282889209; 
 Thu, 13 Jul 2023 14:14:49 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 07/18] target/s390x: Use clmul_16* routines
Date: Thu, 13 Jul 2023 22:14:24 +0100
Message-Id: <20230713211435.13505-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

Use generic routines for 16-bit carry-less multiply.
Remove our local version of galois_multiply16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index e110a7581a..523d6375bb 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -180,7 +180,6 @@ static uint##TBITS##_t galois_multiply##BITS(uint##TBITS##_t a,                \
     }                                                                          \
     return res;                                                                \
 }
-DEF_GALOIS_MULTIPLY(16, 32)
 DEF_GALOIS_MULTIPLY(32, 64)
 
 static S390Vector galois_multiply64(uint64_t a, uint64_t b)
@@ -226,6 +225,25 @@ void HELPER(gvec_vgfma8)(void *v1, const void *v2, const void *v3,
     *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
 }
 
+static Int128 do_gfm16(Int128 n, Int128 m)
+{
+    Int128 e = clmul_16x4_even(n, m);
+    Int128 o = clmul_16x4_odd(n, m);
+    return int128_xor(e, o);
+}
+
+void HELPER(gvec_vgfm16)(void *v1, const void *v2, const void *v3, uint32_t d)
+{
+    *(Int128 *)v1 = do_gfm16(*(const Int128 *)v2, *(const Int128 *)v3);
+}
+
+void HELPER(gvec_vgfma16)(void *v1, const void *v2, const void *v3,
+                         const void *v4, uint32_t d)
+{
+    Int128 r = do_gfm16(*(const Int128 *)v2, *(const Int128 *)v3);
+    *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
+}
+
 #define DEF_VGFM(BITS, TBITS)                                                  \
 void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
                              uint32_t desc)                                    \
@@ -243,7 +261,6 @@ void HELPER(gvec_vgfm##BITS)(void *v1, const void *v2, const void *v3,         \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFM(16, 32)
 DEF_VGFM(32, 64)
 
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
@@ -279,7 +296,6 @@ void HELPER(gvec_vgfma##BITS)(void *v1, const void *v2, const void *v3,        \
         s390_vec_write_element##TBITS(v1, i, d);                               \
     }                                                                          \
 }
-DEF_VGFMA(16, 32)
 DEF_VGFMA(32, 64)
 
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
-- 
2.34.1


