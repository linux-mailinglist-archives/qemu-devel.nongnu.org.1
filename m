Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442E736A92
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDl-00069E-Vr; Tue, 20 Jun 2023 07:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDj-00067J-By
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDh-0004Jf-0g
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-987341238aeso542383566b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259299; x=1689851299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEsv77WByzgBc2oRedydI0QuEnu20ntgk1P70X2mStE=;
 b=ZwEB19DP0Y51HvcDx58pBIGaunhwqG0Iig5hiyxnmvTQbN3qvDT00cMtGJUIWLNARu
 UOV3epHi6fsBKOP+X1iw5k5UoCGhiRWeGZSIUiWrBhsu1kIpyIJhbDNXZQDaorSsfCau
 uI3Snu+9wae4lbTb3rKhWK9auoU/r/sPqX1/QUTz83Z30yIaB9CTAWhMucjzq7LI2zro
 9tPJOYgvL67s727uWY4xQdNqrlNDMlmwI/grJKl7n5Q3kBDEBfqu6Vez4Te+3gQjwATk
 YOnVMB+3PYsJ87nmvSPimR9j4cm3VC2fb1nsq0TaZgB7DavZQ72RB2FmEkMMQHllJeIE
 XkEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259299; x=1689851299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEsv77WByzgBc2oRedydI0QuEnu20ntgk1P70X2mStE=;
 b=VWM+3inXq75XTv/572dg7pgSVhi4YGuQyErtmp9ohHwkbFnMTU0iR7HxQG9FO9vSvv
 vrjM7rloJp1N3sngZfTmPuiCvmPL5u1VpamnDHxHOHUVs3cMUBv+uSxRRJB31Pmq9TWD
 0t8pRRySdwoqJ9666MvDnx9MooBgWph2xTbkjWfSN6rEOhabCH0T74fcOYT+t8WI6DWs
 Ts88aTHQf3kk13nQRIyoJa2IYA9VNSR/WsMpkQ2cM294Whsd7YwKphOyPhY5VerdMWVd
 ksMPLaf4hC0PmV8fSuBxYHlEf9XHJG7ZpA5vyF+cot9X/6rYtL2l/oXmyPCSeJr2ASxG
 1x8A==
X-Gm-Message-State: AC+VfDzJG586nI5KpJfWO+JiCYcJjJ1FA2EgPBDsN28jOFwF9Jyjt6ch
 N2qFUf8yQFS/qklYK3kGnsyS1cjuYZIRABPuVdppRUx/
X-Google-Smtp-Source: ACHHUZ55BsZ4oeymykRGAWRTaR+RjmSSH/deAYAaWZRELtzVdEwGjlkbkj3BX6lE9DynwBCML8KI5Q==
X-Received: by 2002:a17:907:2d91:b0:977:cbaf:bc56 with SMTP id
 gt17-20020a1709072d9100b00977cbafbc56mr12474904ejc.43.1687259299761; 
 Tue, 20 Jun 2023 04:08:19 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 13/37] target/arm: Use aesdec_ISB_ISR_AK
Date: Tue, 20 Jun 2023 13:07:34 +0200
Message-Id: <20230620110758.787479-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x632.google.com
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

This implements the AESD instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 37 +++++++++++++++-------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 00f3b21507..d2cb74e7fc 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -48,26 +48,6 @@ static void clear_tail_16(void *vd, uint32_t desc)
 
 static const AESState aes_zero = { };
 
-static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
-                           const uint8_t *sbox, const uint8_t *shift)
-{
-    union CRYPTO_STATE rk = { .l = { rm[0], rm[1] } };
-    union CRYPTO_STATE st = { .l = { rn[0], rn[1] } };
-    int i;
-
-    /* xor state vector with round key */
-    rk.l[0] ^= st.l[0];
-    rk.l[1] ^= st.l[1];
-
-    /* combine ShiftRows operation and sbox substitution */
-    for (i = 0; i < 16; i++) {
-        CR_ST_BYTE(st, i) = sbox[CR_ST_BYTE(rk, shift[i])];
-    }
-
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
-}
-
 void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -102,7 +82,22 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, AES_isbox, AES_ishifts);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vn + i);
+        AESState *rk = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1] ^ rk->d[1];
+            t.d[1] = st->d[0] ^ rk->d[0];
+            aesdec_ISB_ISR_AK(&t, &t, &aes_zero, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            t.v = st->v ^ rk->v;
+            aesdec_ISB_ISR_AK(ad, &t, &aes_zero, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


