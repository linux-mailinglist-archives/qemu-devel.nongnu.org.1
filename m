Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8777A23CE
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu0-0004T4-EI; Fri, 15 Sep 2023 12:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBty-0004SS-60
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:42 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtw-0004uI-I4
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:41 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fc9e0e22eso1947060b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796159; x=1695400959; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rjJiUhlPai6mmk7xoBYCGw+/59480gYFwt2JNZw/Qk4=;
 b=HxRuXjvebGnRljb1E0EEDqebZiVoB76kgKh+dr9ErEL7LP1NabrrgxdkVERZESMjJ1
 AnSXj5Xe+OY4PcjUdicca3Di1CKR84D/Vp4WgVu3dWkQI7L1b21GPe7WNPqUaosT+J4I
 TaiE5tduR1AEFE3u4z437PtqBUdpY5MV5B9hbx2Sj9vtevzgNp093GY7HEOtumOjWeZA
 b3XdagyFxxQTfiF/rU0qWLTxzGO9PbnBPJFkiMTNUVMj4DyE5j/1gm0sjrzC5q3c1ygN
 rt5FQcPPYVVxWJalDJPYs5lZQWu89jt886g/ZID7Kk6MWbL+z6YEyOIaFULInBCDo5Yq
 inug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796159; x=1695400959;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rjJiUhlPai6mmk7xoBYCGw+/59480gYFwt2JNZw/Qk4=;
 b=hPMJ5DVJrzjXDx7VnoGX9IyApUKnE8r9igkmjt4Y2Ew2oxDpH6TqwJe52uHCb0/7+H
 oSP067DEEmpTlvDMtiM0JHTXBXoxr/03bUdseJKiJQyokzS6YF9Kn0zEXetAWwLPGQul
 gHgw+z+8/sWEgsz7wcld30cL0328ZSgqAsRK3E3xWbDqJTyx+LCYop21nbR1UN0G8MZl
 mGP9fhWxZeCJ6WhK5DZ5JIwoX8DOS1eXPaX4I6MzRXP/JEbcUhHWod39deoTWtIYKvEE
 vrMkYPC2U29CperXNMhWGkdBM9q1FzUcarZDdr9ohAEpZOrtu+dxm+cX7TnyYSswIIMI
 D3qA==
X-Gm-Message-State: AOJu0YzbvjHbxdikhgxriBhsRdVKPxTCHjpFZWmP3PaJo4PFfYGlIHst
 c4hFX+A5/9Vzkxv43JFXFr1JYOFZt/l3hBC12rA=
X-Google-Smtp-Source: AGHT+IG91HnUwpH3wpVpLldVCKAGfaOKsLz/ccS0w30e5LiNsw3IeEQJeWl7EXFy2sV7erkvrUZqkw==
X-Received: by 2002:aa7:88d6:0:b0:68e:4653:2a2b with SMTP id
 k22-20020aa788d6000000b0068e46532a2bmr2610222pff.24.1694796159188; 
 Fri, 15 Sep 2023 09:42:39 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 07/19] target/s390x: Use clmul_16* routines
Date: Fri, 15 Sep 2023 09:42:19 -0700
Message-Id: <20230915164231.123580-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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


