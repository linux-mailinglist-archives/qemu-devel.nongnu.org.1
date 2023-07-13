Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6163752C09
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3ec-0000RD-MT; Thu, 13 Jul 2023 17:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eN-0000KF-C5
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:15:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eL-00018v-LW
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-314319c0d3eso1210573f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282896; x=1691874896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzKHXQvYOd2P2OgIBYbUsN5miYHmmP4uVxotaWuoE7o=;
 b=s8OMZUUakfW5G7zjXN29swx1Ay3uIIK8BcxyI9RnuOcLEqxHy8qsTek1EhEdHK50nr
 o0YxuuyR90jLnooRV+O1AyyDQwSj6Jh48crKu+BJRaN9Pq1n4P8NGkmgN2apUQEvY9wS
 V3xQ/j97QShn7mc5gHMiYUmTFUpuAoeXxF27562cZDja33mAjBBS9TGpKv3GPWK0SstD
 Jc6WxayijSlOezswgU6gzzmseLE/gXo6tZsoKyPaiUR/ga0ah+/rUbBDP5WDhgSwFeEA
 r4dUHY087GNfIIsbpdm3KR2G3xexVQ3M5FGlh18245nA8JD9EYQxGfQUZvX8g/9+P7XX
 2GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282896; x=1691874896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzKHXQvYOd2P2OgIBYbUsN5miYHmmP4uVxotaWuoE7o=;
 b=eSREaMz2GDW9LrINoIwZyrug4jK7roVgoGAK5COOGPfhUbMyeWdeHStVOEHOtY1zVA
 SNDXVc/rtdWrXfq0cZgT8TXIoU1CvxR6ZVPCnjemaqOY6m/ZfXL2spUVjK3TKOgvN+ny
 ALgur1DNZz3rrM9AqQo3kh2BGry7+NCBBU5IfQRWc1vld11Hbo/7zA+JI/L2G68W8qFc
 F9TaVoqMxg6/IU/lt2zTpiAh8zO13AYi9X+J6cyKhvxrtsUgbI9ydptoRh9mCrSCZ9KL
 +24PpepuDWFhX/Cn1+4kVH2VvwosW56ZtVWBW70WyvZYE4km+xhORE1JMvkW1cbbB3Cr
 QE/g==
X-Gm-Message-State: ABy/qLaKKKsjI/ekP6iOJ4a0470RWpd7UMfzN7w5x4lecFnROZeXnLKs
 tjwaJ+qlwHo47sDXRuhXKwEO0QLiAS3NabPzVl2KDSK3
X-Google-Smtp-Source: APBJJlGV0n8p0pNfZjVkuwzXH7ans5vZyjl9ug4+6K7EbIwil2nVKYv2m9CQeJsTxOyc/soriwbpwg==
X-Received: by 2002:adf:fe4c:0:b0:313:e8bf:a6e with SMTP id
 m12-20020adffe4c000000b00313e8bf0a6emr2761804wrs.21.1689282896404; 
 Thu, 13 Jul 2023 14:14:56 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 15/18] target/s390x: Use clmul_64
Date: Thu, 13 Jul 2023 22:14:32 +0100
Message-Id: <20230713211435.13505-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42d.google.com
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

Use the generic routine for 64-bit carry-less multiply.
Remove our local version of galois_multiply64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/vec_int_helper.c | 62 +++++++------------------------
 1 file changed, 14 insertions(+), 48 deletions(-)

diff --git a/target/s390x/tcg/vec_int_helper.c b/target/s390x/tcg/vec_int_helper.c
index f5eea2330a..002ba67b11 100644
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
 static Int128 do_gfm8(Int128 n, Int128 m)
 {
     Int128 e = clmul_8x8_even(n, m);
@@ -247,35 +220,28 @@ void HELPER(gvec_vgfma32)(void *v1, const void *v2, const void *v3,
     *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
 }
 
+static Int128 do_gfm64(Int128 n, Int128 m)
+{
+    /*
+     * The two 64-bit halves are treated identically,
+     * therefore host ordering does not matter.
+     */
+    Int128 e = clmul_64(int128_getlo(n), int128_getlo(m));
+    Int128 o = clmul_64(int128_gethi(n), int128_gethi(m));
+    return int128_xor(e, o);
+}
+
 void HELPER(gvec_vgfm64)(void *v1, const void *v2, const void *v3,
                          uint32_t desc)
 {
-    S390Vector tmp1, tmp2;
-    uint64_t a, b;
-
-    a = s390_vec_read_element64(v2, 0);
-    b = s390_vec_read_element64(v3, 0);
-    tmp1 = galois_multiply64(a, b);
-    a = s390_vec_read_element64(v2, 1);
-    b = s390_vec_read_element64(v3, 1);
-    tmp2 = galois_multiply64(a, b);
-    s390_vec_xor(v1, &tmp1, &tmp2);
+    *(Int128 *)v1 = do_gfm64(*(const Int128 *)v2, *(const Int128 *)v3);
 }
 
 void HELPER(gvec_vgfma64)(void *v1, const void *v2, const void *v3,
                           const void *v4, uint32_t desc)
 {
-    S390Vector tmp1, tmp2;
-    uint64_t a, b;
-
-    a = s390_vec_read_element64(v2, 0);
-    b = s390_vec_read_element64(v3, 0);
-    tmp1 = galois_multiply64(a, b);
-    a = s390_vec_read_element64(v2, 1);
-    b = s390_vec_read_element64(v3, 1);
-    tmp2 = galois_multiply64(a, b);
-    s390_vec_xor(&tmp1, &tmp1, &tmp2);
-    s390_vec_xor(v1, &tmp1, v4);
+    Int128 r = do_gfm64(*(const Int128 *)v2, *(const Int128 *)v3);
+    *(Int128 *)v1 = int128_xor(r, *(Int128 *)v4);
 }
 
 #define DEF_VMAL(BITS)                                                         \
-- 
2.34.1


