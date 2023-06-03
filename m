Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFAD720D5F
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:37:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7g-0002iP-KV; Fri, 02 Jun 2023 22:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6U-0000WI-Q3
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:55 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6I-0004iW-K5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:34:53 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-25669acf1b0so2383103a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759681; x=1688351681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHMbOR1QTwjqbFmiHyO/57gsxTa7l7mfudPzWiBLsfE=;
 b=O2kQUFMAJssvVwjdVtP543asKyifbJiYycdkVPl+LZYcIhJF1fqerPkgNWxGM1XZuD
 6mVUtF1V9ahNEaLp0k8pqGKg31CdyO/ivX1u3LBpz+kknxm0njxuGI5DrPYOM0jehVjm
 wUZB05plRK+X1kC+r5uu4rEQUNVxbNYUiO5cFhxHYiSQiTlt5SjVHvjCpAl7iKf9jP5O
 G6M7sdgNUw0+J812mFTijS3ygJt9RGyCKKllwvilwyhnObYw70a1wMN7ycVkBML2iaxo
 gSp+GYhldBVRPfM/kaDwR/s1yansMNDpe5Eo3ooADUWVZR9GuwUAIBkbJPaJ6o/BkOyE
 zgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759681; x=1688351681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NHMbOR1QTwjqbFmiHyO/57gsxTa7l7mfudPzWiBLsfE=;
 b=SD2xLNtzGGomYfr1ZcJGkhRBD2cVoM1y1eUf6oSAYmH9jWqVAqKJ/Koc6ORhkIkMOz
 B7rPPsnBKEkTigak6K2t/QdA4DufbEddc3FNx+IN35LkVprYLkK6djmp3cBURwfRQ1eu
 3IfmmVvK4tYU+xRpftJJmWmNJ2R3d/NvQAaRa25MXwoqALvf+RqUsX5JKre7To74s5Zf
 08ifUwJ947OC7OnqvygkTAjW2/WbYcnM1W1bBVT9eVSzgtfK996eRPWZMKsokaePQF49
 v8KsSjY/URXXyzWHye4wCek669pVmpmF2dLfbpOPtrTMHr5wSdy1NurYC/9PJb+PvP9p
 Gg7A==
X-Gm-Message-State: AC+VfDwWd4Fp8s9AeF46oxJCjCq/UN2Rs6znF9HqX4mlm0+c1f8PTeAb
 nSyLtKgylvw2WbhzZ3hTRCbU2MykF7c7e3ap1bk=
X-Google-Smtp-Source: ACHHUZ5dFs35VUvuE694zuW0MPC2Zc3fUQY6PEC+/UQ/OYdlsdGEVzOhpD6AxsDSiChiHAuO0CLMOw==
X-Received: by 2002:a17:90a:de96:b0:258:b097:f692 with SMTP id
 n22-20020a17090ade9600b00258b097f692mr1512947pjv.43.1685759681615; 
 Fri, 02 Jun 2023 19:34:41 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 16/35] target/arm: Use aesenc_MC
Date: Fri,  2 Jun 2023 19:34:07 -0700
Message-Id: <20230603023426.1064431-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

This implements the AESMC instruction.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d7b644851f..a0fec08771 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -118,7 +118,20 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_mc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesenc_MC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesenc_MC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1


