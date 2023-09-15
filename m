Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFE97A23C1
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:43:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu8-0004Wv-M3; Fri, 15 Sep 2023 12:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu6-0004Ve-9A
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu4-0004x0-6M
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-68fb7074348so2162535b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796167; x=1695400967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mA3cEFgfatbmP6xNVJY+hnrvCkua8Jz5pM6YfngoFhc=;
 b=q2jbA0or9bLiKmnvehCglhM+gRZjrwGLNVEhIUfbgtz/gDNGPoEzYzgsqBeEI/B/SS
 MvWeJ8qjW0on6pyr5Wj43r75WwhbHkbjiibg6zaf3fHS1gho7BCZwVLty4x9RJCbgyw+
 4DlZvq/gHk3lr70QBCsjvgkWFwfb+LZmyKeLzoQEOPSayBpbF1SDojrzgNivuXFbPmMx
 hLqxFs1t2j2JyT1R6XfzdZP1oTswgI1pj1r2NfYv5aRpl6lRn06vdby5OhSol3uMY/nA
 nl0K6HO0LCmQbs3IVxDgJXsO6IyXydE2ZmXqpGfeYpcplqlS/kIBPp+tJb8O+sxk/uip
 C2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796167; x=1695400967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mA3cEFgfatbmP6xNVJY+hnrvCkua8Jz5pM6YfngoFhc=;
 b=eNuCAtjRM1UJLnxQruMn0Fgfsk6WeFwli8Dy60My1cKNa1lcOVVmttrC5NldA0up7a
 XMveBmo+rRbHWObiGOo5kmMjJgm22LmmCICw+5gUuaCfmD9Oo96jTFMWtWh9i5fNESmp
 m+Hl7Q7znfiNJmktTCTXBVATWnJQLp4Zmbyql63BPkuogtleXUxXRHJjjH3zpEdWsyuj
 n4kZdxFBi6DZhuzmfBeX3zudgmUbeiZaQASOXU73HaZ+/iJKdjhlGha7cYTuqkgpN0oq
 2ldfkIRLetsIG7fjKFUaW+gTquSLck/3Zeosd5a67QxvO2cYSUNnW+AZP2wDWtXOE8pk
 fxLA==
X-Gm-Message-State: AOJu0YzzKc8pxbk6YwzfypGkAlg87aHvoLZVhw04xfdDWp+X8M/aME5r
 E4bsiKDZYtV8b6bGx69ble+Fssd/2geFt9qxV8E=
X-Google-Smtp-Source: AGHT+IFl6TJZcSBal5yZaoaTLe1xJU+eipZ/bZ0fA/7qmkLlWLniU/zZXosqIXujwh3OlvH5pT//WA==
X-Received: by 2002:a05:6a20:1442:b0:14c:a53c:498e with SMTP id
 a2-20020a056a20144200b0014ca53c498emr2841900pzi.42.1694796166943; 
 Fri, 15 Sep 2023 09:42:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/19] target/s390x: Use clmul_64
Date: Fri, 15 Sep 2023 09:42:28 -0700
Message-Id: <20230915164231.123580-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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


