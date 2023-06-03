Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A068A720D6D
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7n-0003lM-Nz; Fri, 02 Jun 2023 22:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6t-0000oN-Rd
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:21 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6V-0004v8-Bl
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:17 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-256931ec244so2369561a91.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759693; x=1688351693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ALpb0XwJHZTdJw+MYvX3tX7xTZblIMqFiH2Syk8o8k=;
 b=syOQYYxoFafcm0mgy//b4KwRHZjTXdcHU6BREb/+K7hYw2acIudlHLyDz7b0nu0oRF
 jg394tecvc7Zp4rNdRSazXhaLmPdAYkl0noTpF+8h8WQuc/CL++d89namrZ5d/7haCLr
 SgO/GIIP+vif939cmCgZZ3PhwBKTdQkUpd7t9Vz/MhI2r1vRNz6Up2VGie3XooStuQsr
 lfVR6Kk4eMGnA07aFzcXEGFT0qwV2u0hn+MUSik7WMFe3gmDVGssBH9QXIwhHegTU+vw
 zxsYlar6+mymw6cG998XEKIIma2fFrE7yiRzV5zpaFHqzvqqA+TfkDbMEQ3yUDEHTMIP
 AuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759693; x=1688351693;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ALpb0XwJHZTdJw+MYvX3tX7xTZblIMqFiH2Syk8o8k=;
 b=W4vMMLKSTHr5kIN3KUNYxoglgQ+B+JjEu0SJElVHTp1MVaS8elGfGIZNzRTPPSvf6G
 diW5LboRrbWDvXalxleMbsS9h02MP8Igj8by+wrNn+ZuzLXaw/KTBzgMdMNs4MTEbCJg
 nU34BOgENMl/0NfGDj05Xoo3D6INpFEvudGFQkXD9Q9mP9binLJ6SwtnKIm9K2vK6nYJ
 AUo3rzQXIzukh8M531qKxECKWSlXDysz91sgHaMAbE3LbSm5/Tgrm31Vaizzklc3ilVG
 Tr8+G4dqqk0wLWuD3mmAKWSCiuFq3REA1Fpud+UwhQbTrkWVNexo9fYBxZSo6l3ESron
 RHZg==
X-Gm-Message-State: AC+VfDyOdtjVthv6KtqUSkQKw/tAMHnhNVg4YYvMg3N4BuwyIgZx+zbM
 tEjVZVYNgaqi5u/GLiip8TgM3HdGWQF0VEQsYoM=
X-Google-Smtp-Source: ACHHUZ6QAp/BiZ+IASgPWsUqCfp8a0cwDLEki5BE2AqHhBwAagcYP9zz2oyowCdXEE3fxZCUsTY2Vg==
X-Received: by 2002:a17:90a:9201:b0:255:cddf:a0c8 with SMTP id
 m1-20020a17090a920100b00255cddfa0c8mr1458511pjo.41.1685759693465; 
 Fri, 02 Jun 2023 19:34:53 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 28/35] crypto: Add aesdec_ISB_ISR_AK_IMC
Date: Fri,  2 Jun 2023 19:34:19 -0700
Message-Id: <20230603023426.1064431-29-richard.henderson@linaro.org>
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

Add a primitive for InvSubBytes + InvShiftRows +
AddRoundKey + InvMixColumns.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/generic/host/aes-round.h |  4 ++++
 include/crypto/aes-round.h            | 21 +++++++++++++++++++++
 crypto/aes.c                          | 20 ++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/host/include/generic/host/aes-round.h b/host/include/generic/host/aes-round.h
index 848436379d..84f82e53d8 100644
--- a/host/include/generic/host/aes-round.h
+++ b/host/include/generic/host/aes-round.h
@@ -25,6 +25,10 @@ void aesdec_IMC_accel(AESState *, const AESState *, bool)
 void aesdec_ISB_ISR_accel(AESState *, const AESState *, bool)
     QEMU_ERROR("unsupported accel");
 
+void aesdec_ISB_ISR_AK_IMC_accel(AESState *, const AESState *,
+                                 const AESState *, bool)
+    QEMU_ERROR("unsupported accel");
+
 void aesdec_ISB_ISR_IMC_AK_accel(AESState *, const AESState *,
                                  const AESState *, bool)
     QEMU_ERROR("unsupported accel");
diff --git a/include/crypto/aes-round.h b/include/crypto/aes-round.h
index 352687ce11..b48b87671c 100644
--- a/include/crypto/aes-round.h
+++ b/include/crypto/aes-round.h
@@ -113,6 +113,27 @@ static inline void aesdec_IMC(AESState *r, const AESState *st, bool be)
     }
 }
 
+/*
+ * Perform InvSubBytes + InvShiftRows + AddRoundKey + InvMixColumns.
+ */
+
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *ret, const AESState *st,
+                               const AESState *rk);
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *ret, const AESState *st,
+                                  const AESState *rk);
+
+static inline void aesdec_ISB_ISR_AK_IMC(AESState *r, const AESState *st,
+                                         const AESState *rk, bool be)
+{
+    if (HAVE_AES_ACCEL) {
+        aesdec_ISB_ISR_AK_IMC_accel(r, st, rk, be);
+    } else if (HOST_BIG_ENDIAN == be) {
+        aesdec_ISB_ISR_AK_IMC_gen(r, st, rk);
+    } else {
+        aesdec_ISB_ISR_AK_IMC_genrev(r, st, rk);
+    }
+}
+
 /*
  * Perform InvSubBytes + InvShiftRows + InvMixColumns + AddRoundKey.
  */
diff --git a/crypto/aes.c b/crypto/aes.c
index 1696086868..c0e4bc5580 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1571,6 +1571,26 @@ void aesdec_ISB_ISR_IMC_AK_genrev(AESState *r, const AESState *st,
     aesdec_ISB_ISR_IMC_AK_swap(r, st, rk, true);
 }
 
+void aesdec_ISB_ISR_AK_IMC_gen(AESState *r, const AESState *st,
+                               const AESState *rk)
+{
+    AESState t;
+
+    aesdec_ISB_ISR_gen(&t, st);
+    t.v ^= rk->v;
+    aesdec_IMC_gen(r, &t);
+}
+
+void aesdec_ISB_ISR_AK_IMC_genrev(AESState *r, const AESState *st,
+                                  const AESState *rk)
+{
+    AESState t;
+
+    aesdec_ISB_ISR_genrev(&t, st);
+    t.v ^= rk->v;
+    aesdec_IMC_genrev(r, &t);
+}
+
 /**
  * Expand the cipher key into the encryption key schedule.
  */
-- 
2.34.1


