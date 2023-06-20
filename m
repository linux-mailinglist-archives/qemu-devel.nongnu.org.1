Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4E2736ABB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDv-0006Nb-Oj; Tue, 20 Jun 2023 07:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDt-0006L3-DI
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:33 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDp-0004PE-TI
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:33 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98746d7f35dso571535866b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259308; x=1689851308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F8c22mTwcbWMs129JigZzKtfDDKQP2XGxgtoSuBUoiE=;
 b=pSW2jGWC7cy2tlM5GqSFsYGBfxsPtlVB4p1yLFb8QtE+6JTXrR9Z9YsD77svtkLyv1
 3PRpZLXSNJ0ySP5HQ0zuV4a1RArnbsh1WekZbP0DRIbMzYov9jP9JPnmnobWfkYlBGok
 TwQPDjrr+wXWG9+HvnDGLlMwjH4aQrtZ9gdranoXXJ9HmpMxrowL07AxEgDRy/Z6E+mD
 NzyHdR0vEpV8U4lDZFf3C3nIimDj9SknY9c31rCL4vD7xWfvmpMkYMI08z6ERuQuRJi2
 Ya1IcFBCLjalyygHQnyQw+0RHlCkgeWRdb96U08LYzaGIWOuA0runag6TfE+fuEWa17K
 xnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259308; x=1689851308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F8c22mTwcbWMs129JigZzKtfDDKQP2XGxgtoSuBUoiE=;
 b=cXLoNbIwoFk+MpMJOyQrqm+TAttPyp2UzH4IeHlQxel+DYeFdIESzGPFtEej2b/HNh
 AfDuskcnz/ZI5LjLUYN7XcjYNRaDcG3KFwuifGsO6IX5iUj4Zi6kVXvzKJ8z7Cy6lCyD
 IR2zeYk1UQLF1p1/s9Q7kGQ05F3g5buE14vVu9EsXmmMBoldbXVM9MOQ7s1SorFhx/85
 Dsiq9eZuPaoOukVIfzYgpeEiumFVreC8gP27klNVfZOo8NVwvew9/kiZtDFDlOUdEHus
 bjc45yB6mh9wjuFHoXTM1T1J13W4A/efVWQGiMmjzIJ5eitgJ4vm+rBJIIDiRMDIVPuk
 YBgQ==
X-Gm-Message-State: AC+VfDwYyBw5PiMBvI7Jor2ami+0w3OOt0s4U34EjaoMj3F4lQI7rTdu
 pjv71/S4w6V7IRsudr9YKoAUxMcPkUpQDxWi+ndoBYPn
X-Google-Smtp-Source: ACHHUZ4rIAuUiGAefXyIIEauRMrGpYj13QPGMecBx2x6ldPd/n4PIoGrvkJEgUFMUmDQzazQTHmCMQ==
X-Received: by 2002:a17:907:9810:b0:96f:bcea:df87 with SMTP id
 ji16-20020a170907981000b0096fbceadf87mr12597242ejc.42.1687259308582; 
 Tue, 20 Jun 2023 04:08:28 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 20/37] target/arm: Use aesdec_IMC
Date: Tue, 20 Jun 2023 13:07:41 +0200
Message-Id: <20230620110758.787479-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This implements the AESIMC instruction.  We have converted everything
to crypto/aes-round.h; crypto/aes.h is no longer needed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 1952aaac58..fdd70abbfd 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -14,7 +14,6 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
-#include "crypto/aes.h"
 #include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
@@ -102,23 +101,6 @@ void HELPER(crypto_aesd)(void *vd, void *vn, void *vm, uint32_t desc)
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
 
-static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, const uint32_t *mc)
-{
-    union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
-    int i;
-
-    for (i = 0; i < 16; i += 4) {
-        CR_ST_WORD(st, i >> 2) =
-            mc[CR_ST_BYTE(st, i)] ^
-            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
-            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
-            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);
-    }
-
-    rd[0] = st.l[0];
-    rd[1] = st.l[1];
-}
-
 void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
 {
     intptr_t i, opr_sz = simd_oprsz(desc);
@@ -147,7 +129,20 @@ void HELPER(crypto_aesimc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_imc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesdec_IMC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesdec_IMC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


