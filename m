Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A218736AA2
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 13:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZDg-00063c-Ug; Tue, 20 Jun 2023 07:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDe-0005zl-CI
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:18 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBZDa-0004ET-FR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 07:08:18 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9829a5ae978so717136966b.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 04:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687259293; x=1689851293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mjZWs2Y+Z9mHPnjXNP6VJFYBwuCl2SNNXRyLlkiAXFM=;
 b=WtTpfhmL836K+SDKJZcnTDhDgLuRfsn2tUQaR+Ia6h+vYJ19/2sEg9HfMbl5DfxEAz
 mrQVHhwidUHoKlaKS+pS6yo/9BaxNdhFSgBUL4SCagAkRidQx+/CnFN4KhvH5/EnHVkr
 uOG7naBuHjCO0jQ9tN/R0Wak8YXWZ3M61uy3f1aFJ6pTZmBS3xpFHjgMbOw3eT6fOUbR
 5J13df0NCNGtD+U3jyWeHFCBYqomFY5/RclGg+4zfeRMhfTMgUYOLEh1LKnlYpzoUdi4
 2z2dLKhMIRltl3jikMstAWJo2OFkUDB82bco3eapx5xIH1nERF631xZ/qhSsQHziTenb
 GRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687259293; x=1689851293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mjZWs2Y+Z9mHPnjXNP6VJFYBwuCl2SNNXRyLlkiAXFM=;
 b=AwJrkOgSgw3Zfbe7G5Lv0i86DPPVmdTsmU2h+Xi8C6slm7rCm6B7QXTKATMLVf3/XR
 vSHLXKJTxkxDDb8X1Uq9ImvYHCzkYdTW0qcysZXP8wh0uRHd/1kMlfRDwnlr5hqmEPFH
 wBhDUdo6d09/0WDyB+PBt5N2EmYt7Ms87RN+HfbTdguJfsylNc82J1gsmM9g2v1Myu17
 yvWsD0KnmLwqYyzFcb9oJig+2ciC4uoB47w8LkNMjSbQWdGK9i7WS8fmrFGKT8UvgtoB
 syBYHHRQrK3jjcK/r8Q62Tz2xM+tJRfrDw7DaHbPO2Q+VvIvQA5U/ow0BcxoCAOQO0aK
 vLKg==
X-Gm-Message-State: AC+VfDywjyvqopH7Q3K+xVpm94ILe1+UcgMyNDQ2d7RBHGoWLl9iF1qr
 r9cLLCHsGrjXiVBZFvJmVecIah0A78KUi8b+XVenj2Ro
X-Google-Smtp-Source: ACHHUZ5Sqm+oo9A6uYB6PC1x2ALbDvbHT7S1U9fLyNhIdMdovsXwLNtnUgue8csdCmASa6cIC7QcvQ==
X-Received: by 2002:a17:907:6ea7:b0:988:9836:3fdb with SMTP id
 sh39-20020a1709076ea700b0098898363fdbmr6149505ejc.11.1687259293201; 
 Tue, 20 Jun 2023 04:08:13 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 x17-20020a170906711100b009884f015a44sm1170687ejj.49.2023.06.20.04.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 04:08:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH v3 08/37] target/arm: Use aesenc_SB_SR_AK
Date: Tue, 20 Jun 2023 13:07:29 +0200
Message-Id: <20230620110758.787479-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620110758.787479-1-richard.henderson@linaro.org>
References: <20230620110758.787479-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62e.google.com
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

This implements the AESE instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index 75882d9ea3..00f3b21507 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -15,6 +15,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "crypto/aes.h"
+#include "crypto/aes-round.h"
 #include "crypto/sm4.h"
 #include "vec_internal.h"
 
@@ -45,6 +46,8 @@ static void clear_tail_16(void *vd, uint32_t desc)
     clear_tail(vd, opr_sz, max_sz);
 }
 
+static const AESState aes_zero = { };
+
 static void do_crypto_aese(uint64_t *rd, uint64_t *rn, uint64_t *rm,
                            const uint8_t *sbox, const uint8_t *shift)
 {
@@ -70,7 +73,26 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aese(vd + i, vn + i, vm + i, AES_sbox, AES_shifts);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vn + i);
+        AESState *rk = (AESState *)(vm + i);
+        AESState t;
+
+        /*
+         * Our uint64_t are in the wrong order for big-endian.
+         * The Arm AddRoundKey comes first, while the API AddRoundKey
+         * comes last: perform the xor here, and provide zero to API.
+         */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1] ^ rk->d[1];
+            t.d[1] = st->d[0] ^ rk->d[0];
+            aesenc_SB_SR_AK(&t, &t, &aes_zero, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            t.v = st->v ^ rk->v;
+            aesenc_SB_SR_AK(ad, &t, &aes_zero, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


