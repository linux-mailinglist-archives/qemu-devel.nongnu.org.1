Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0435781647
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:05:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMR-00005Y-G4; Fri, 18 Aug 2023 21:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMP-0008WQ-JO
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMN-0007No-A8
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68879c4cadeso1250788b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406954; x=1693011754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xb/RiA6QDgK0yKGdPpbNiiP/1RVfomObwJ/soV+H/NI=;
 b=U6llev1Tgms8+Ou53A/OT3AE6N5QTcKdGvI4MgGYBOuWxsW0wONp0/Jh6xdqPl55BT
 2Paf523cm0zjg6evM0FP+albVYb7KtYsGts2M640vWESfDogMP9CECYtoRCS4WL2P7fB
 xt8XKO1tvCvGWQkcTJ1D9BTtwSax08Hdj4XLxIHnS/F9K69q3mfryRiX1jzH++H38bPb
 yObNX5cjrJ4vHTdGcmFCbIuL8u9SNl+8ffCn5GSSZJ3yulnAC5DGr/Ij3E6JdGnWyD0w
 He/YThTK+ibiO1WI/xOLZVq1lglNOZurdUzhf0H8dFnOmRFHk56UjeVvi6ncWdSLD74A
 JdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406954; x=1693011754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xb/RiA6QDgK0yKGdPpbNiiP/1RVfomObwJ/soV+H/NI=;
 b=MchNeNQWSJbENRFtwXNe/gJQgmbKM2HJu0sByVcUzZKTmVnje5gomBrprZbNuRhVxh
 1REc90WG5ShCksCy576AwG2VbU+UcYsUKKxRVSF4/+To3sKF1hOkNEEOAWJy6sHhj63B
 TPYqt+JAlEMrXQWIkuBTkzbV9pUwEphVmZS0dsavr7NSh7p65QgE3GnkO1cK+JMLVd4P
 sUwGqg/KzlR3LRMoEJPmxVRFeC/1i3jG4lMjUXCp7+oxy4zxqvid6hzsWaewmy6HkpnL
 L9fU0l1kwXe9SeNxJJfU9oWp/Erft5mw6S5MOpvLGRDSmCx+pQWGxU5DQTi5sbS5/K/L
 oJag==
X-Gm-Message-State: AOJu0Yw1rAHaPhsyez3/XvYllDBF7nxsTA+oguk7Dy2pxTz54pJ3dH+1
 W9iqqnOHewK7Rj80li1Er79yyy6HG7yBmdnn5tE=
X-Google-Smtp-Source: AGHT+IEI0pptBdSNH9FEUKgv+Vks/fQcmY32O0g1JCbR/BCx1EFf1jZVuKb+IJ19PBES7foagVQJAw==
X-Received: by 2002:a05:6a21:4987:b0:13f:9b98:c416 with SMTP id
 ax7-20020a056a21498700b0013f9b98c416mr681706pzc.55.1692406953929; 
 Fri, 18 Aug 2023 18:02:33 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 15/18] target/s390x: Use clmul_64
Date: Fri, 18 Aug 2023 18:02:15 -0700
Message-Id: <20230819010218.192706-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Use the generic routine for 64-bit carry-less multiply.
Remove our local version of galois_multiply64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 58 +++++++------------------------
 1 file changed, 12 insertions(+), 46 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index ba284b5379..b18d8a6d16 100644
--- a/target/s390x/tcg/vec_int_helper.c
+++ b/target/s390x/tcg/vec_int_helper.c
@@ -21,13 +21,6 @@ static bool s390_vec_is_zero(const S390Vector *v)
     return !v->doubleword[0] && !v->doubleword[1];
 }
 
-static void s390_vec_xor(S390Vector *res, const S390Vector *a,
-                         const S390Vector *b)
-{
-    res->doubleword[0] = a->doubleword[0] ^ b->doubleword[0];
-    res->doubleword[1] = a->doubleword[1] ^ b->doubleword[1];
-}
-
 static void s390_vec_and(S390Vector *res, const S390Vector *a,
                          const S390Vector *b)
 {
@@ -166,26 +159,6 @@ DEF_VCTZ(16)
 
 /* like binary multiplication, but XOR instead of addition */
 
-static S390Vector galois_multiply64(uint64_t a, uint64_t b)
-{
-    S390Vector res = {};
-    S390Vector va = {
-        .doubleword[1] = a,
-    };
-    S390Vector vb = {
-        .doubleword[1] = b,
-    };
-
-    while (!s390_vec_is_zero(&vb)) {
-        if (vb.doubleword[1] & 0x1) {
-            s390_vec_xor(&res, &res, &va);
-        }
-        s390_vec_shl(&va, &va, 1);
-        s390_vec_shr(&vb, &vb, 1);
-    }
-    return res;
-}
-
 /*
  * There is no carry across the two doublewords, so their order does
  * not matter.  Nor is there partial overlap between registers.
@@ -265,32 +238,25 @@ void HELPER(gvec_vgfma32)(void *v1, const void *v2, const void *v3,
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
 {
-    S390Vector tmp1, tmp2;
-    uint64_t a, b;
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3;
+    Int128 r;
 
-    a = s390_vec_read_element64(v2, 0);
-    b = s390_vec_read_element64(v3, 0);
-    tmp1 = galois_multiply64(a, b);
-    a = s390_vec_read_element64(v2, 1);
-    b = s390_vec_read_element64(v3, 1);
-    tmp2 = galois_multiply64(a, b);
-    s390_vec_xor(v1, &tmp1, &tmp2);
+    r = int128_xor(clmul_64(q2[0], q3[0]), clmul_64(q2[1], q3[1]));
+    q1[0] = int128_gethi(r);
+    q1[1] = int128_getlo(r);
 }
 
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
                           const void *v4, uint32_t desc)
 {
-    S390Vector tmp1, tmp2;
-    uint64_t a, b;
+    uint64_t *q1 = v1;
+    const uint64_t *q2 = v2, *q3 = v3, *q4 = v4;
+    Int128 r;
 
-    a = s390_vec_read_element64(v2, 0);
-    b = s390_vec_read_element64(v3, 0);
-    tmp1 = galois_multiply64(a, b);
-    a = s390_vec_read_element64(v2, 1);
-    b = s390_vec_read_element64(v3, 1);
-    tmp2 = galois_multiply64(a, b);
-    s390_vec_xor(&tmp1, &tmp1, &tmp2);
-    s390_vec_xor(v1, &tmp1, v4);
+    r = int128_xor(clmul_64(q2[0], q3[0]), clmul_64(q2[1], q3[1]));
+    q1[0] = q4[0] ^ int128_gethi(r);
+    q1[1] = q4[1] ^ int128_getlo(r);
 }
 
 #define DEF_VMAL(BITS)                                                         \
-- 
2.34.1


