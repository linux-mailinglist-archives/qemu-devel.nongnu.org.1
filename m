Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8515782E4C
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cp-0001jK-Lp; Mon, 21 Aug 2023 12:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cd-0001Xl-8Z
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cW-0005e3-VR
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bc83a96067so18880465ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634750; x=1693239550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mA3cEFgfatbmP6xNVJY+hnrvCkua8Jz5pM6YfngoFhc=;
 b=e5mmFuf+NIEuPC6VsBhFAkPw+4IGqOGBEoCYZj/CXsT8OBN/RTnqr/x0NroMLMpFPN
 3RS+mTLypgM9W9ifTfNCWGrxe78jXtnmujwjOvODYkhs81kmmfgHlh9rHD9D+XoqjHKo
 dCBZ1ta+gE5k3gljySPUXMLy5GC10e4E4E7/JzhoCNatgKfT9uXiPZe07U+bKqTZmAPt
 KTbvfl/OTWUI5gwsulnYZ+3v3g3b+3EM/8MfO2kxUizPPo+H5md3enYEemPZY0zmD63f
 ZR32IBUeKL3vbFAveTKgvgL/ljTj6QMlUGiCxmtwXVRqyxZKhiIFavBx06kgsbE5jp63
 1Wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634750; x=1693239550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mA3cEFgfatbmP6xNVJY+hnrvCkua8Jz5pM6YfngoFhc=;
 b=c7Hagr2bZi7VgLdGXLUTeYaJw3WdNXJaDUhjKHk+cJb+/PML7y0UTBaLAT0WJGhEy7
 fRdioOoOvJVklg3YLZzug5yKwBBnHWDDAvn87f6DsFrLuGox0jNxUPUxcYF7cKtuDhrF
 eZsP042GniX3sRVJPW07el1Z4SuxbDqOAuJnFWhrqsarmvSPN3JXfS8hsgLJqv20FTee
 WmJjGNAd4eIWs7LbiFktq/f19oru0aSm/LMhcLYZjyGUKaFl23o3GirffvYUmKR2V5nF
 jiaAY/+M+geuirKdKJ8DbQO650jgwVoC2PsRQXDOr5mODJGmjhSGzj2oKKeHGRW4MEh+
 +/jQ==
X-Gm-Message-State: AOJu0YxBvsDKYdNxbpqKYU/bgh4t5y68on0aiFRG+lEhfqLiFH2AMR/8
 ov8ojVt/cmUYxUEigbihZh64YQMFBr20G4grIF8=
X-Google-Smtp-Source: AGHT+IFwk76bBLEi4lKp/eNC5i6xQCSFsfI8PpjwphH05vKohw3t0eeKBzuvPGfnnwk4bxRL+054ig==
X-Received: by 2002:a17:903:124b:b0:1bb:a367:a70 with SMTP id
 u11-20020a170903124b00b001bba3670a70mr5715990plh.17.1692634750133; 
 Mon, 21 Aug 2023 09:19:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 16/19] target/s390x: Use clmul_64
Date: Mon, 21 Aug 2023 09:18:50 -0700
Message-Id: <20230821161854.419893-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


