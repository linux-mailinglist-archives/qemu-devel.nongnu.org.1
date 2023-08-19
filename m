Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2D078163C
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMO-0008WB-SZ; Fri, 18 Aug 2023 21:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMM-0008Ty-P0
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:34 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMK-0007N4-Fa
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:34 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bdcb800594so12031905ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406951; x=1693011751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47nFV1aM9JE1wMIAXCDJba3wZ1tlxMIcg3CYQKdGdcE=;
 b=HsRBblDc/DT4SvE7vRSfwkYQa4f/+zjvf6D7JWCOFtStkhNYMpjuEyB0mw+LQN0qjP
 0DWfkfIfjJYBOO4zHOtMz/PPdMu6UDS/ws11fhrb49+yqjp+qeycmVyqQiPY2TfwX9fR
 NHlDJNpQR2CIbxOkTcSuyYWNZ0maXKIcTR0dLk7JgCrK1E1+DuKuIMRXAyK2dqWcb6xj
 vCYMFyCQySa9izxGjGKRL4GXel2tEPQ3yIMDrU3Kpo6JnzKlqEcNLR2qrmX12AbyyMaJ
 PjPaVQNoTPH38rluohmYmJa4njKcdny/91HQ9A4EROFBNUDldr+QtAAYY2PrMzeRdL37
 p4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406951; x=1693011751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47nFV1aM9JE1wMIAXCDJba3wZ1tlxMIcg3CYQKdGdcE=;
 b=bbFzD44VMd3icHWO6Ihg6CoX5YvM5kEHj+yagRRcfTuZK8enV6JFBMdK4mVLIQ939Y
 SEyqYMZ4wE0WIU24sewBjFEP6u79+c+RXq1G8s6uCXxCctFFNHYDBi0rYur7arZhlc09
 XQwzZ/C1LfUd8yMCYH0ORxTvzqzsUxbknC6lqEotZb/vHVLaLcHVzLyB5RH+e/4xQQ+3
 q3CmwVzF/M240jeD8I6Y7WvyW9pHvgD5VJ0y9RMSq4gNVczukSqfI1EQFq7iEevwQCKX
 imMv75zSNhAQDUTbTe7sImKq93dzjY1bP6NnU5P7Gu3nrcY0PteasKpJvf9SG98V99U5
 yZZw==
X-Gm-Message-State: AOJu0YzVCOG9bT/u//ed9JNSosb8fRfnonYg8quyBxSv7cgnod3lyHiO
 L54pjURd7h4axQDOkv8Idut+NnuREJ6k/5jrvRc=
X-Google-Smtp-Source: AGHT+IElGy2NpWXs0P8bbH81x6ARZWEHI/tAMCsN24jiGoJIaUTnGCeBb8uWfjW9V8/wMm1p+6mpFg==
X-Received: by 2002:a17:902:f684:b0:1bc:25ed:374 with SMTP id
 l4-20020a170902f68400b001bc25ed0374mr817370plg.49.1692406951158; 
 Fri, 18 Aug 2023 18:02:31 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 12/18] target/ppc: Use clmul_32* routines
Date: Fri, 18 Aug 2023 18:02:12 -0700
Message-Id: <20230819010218.192706-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Use generic routines for 32-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 10e19d8c9b..ce793cf163 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1446,28 +1446,14 @@ void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
-#define PMSUM(name, srcfld, trgfld, trgtyp)                   \
-void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
-{                                                             \
-    int i, j;                                                 \
-    trgtyp prod[sizeof(ppc_avr_t) / sizeof(a->srcfld[0])];    \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, srcfld) {                         \
-        prod[i] = 0;                                          \
-        for (j = 0; j < sizeof(a->srcfld[0]) * 8; j++) {      \
-            if (a->srcfld[i] & (1ull << j)) {                 \
-                prod[i] ^= ((trgtyp)b->srcfld[i] << j);       \
-            }                                                 \
-        }                                                     \
-    }                                                         \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, trgfld) {                         \
-        r->trgfld[i] = prod[2 * i] ^ prod[2 * i + 1];         \
-    }                                                         \
+void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    for (int i = 0; i < 2; ++i) {
+        uint64_t aa = a->u64[i], bb = b->u64[i];
+        r->u64[i] = clmul_32(aa, bb) ^ clmul_32(aa >> 32, bb >> 32);
+    }
 }
 
-PMSUM(vpmsumw, u32, u64, uint64_t)
-
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
-- 
2.34.1


