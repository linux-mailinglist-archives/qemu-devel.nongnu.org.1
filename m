Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5E782E46
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:22:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cu-0001vb-2i; Mon, 21 Aug 2023 12:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cZ-0001Va-5J
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cS-0005dV-A1
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so771010b3a.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634746; x=1693239546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47nFV1aM9JE1wMIAXCDJba3wZ1tlxMIcg3CYQKdGdcE=;
 b=nIeynuDEs0kpNs/miJbGhjMavgYqA1EgL+mcu36Sph9T0LJ1tODu7QwEHribXt06Wg
 ArEkEegk8s3VW3bas8d3962RTcT+T+7kJmxdxG/E2DEtc8yXG+p3VPKP86ePtZnT/FxK
 DEtZEBZhfsEqnnqZv2742ldxGazUQfeGYZHI7UpUkp1D4nU+iXQsZKEe4MZIIAGWxl5R
 ujDWwazdtJ54ci460Q89zf1pqu8JEm0dRt86LPf0/nYX71kUXZa09V9HzVklfnfVYhrt
 TLqzVMIQmIPtQiKRnZ+kblPbM7oVwmFgFtRjLloNPfXYBu+ZsGmJykT3O/sw1Ov+DdRg
 8kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634746; x=1693239546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47nFV1aM9JE1wMIAXCDJba3wZ1tlxMIcg3CYQKdGdcE=;
 b=VhbSNrrlRVCShl2pocCjPZaDyg5oidMvDhg0GjYsGKLdgzQk5Ep4EXiB0ghPu8e9xR
 cGeFqvwP54JwVl3YrWCJb9ercuZcCW2L85SEfBMatQdCtgw5VCtOEDXNT02G+E8K8Bph
 OcaMUqI7QiLmdDW0w3/DxT5dO30X0RozP2Bv2ZOf6ufLe7O06dRedH7UgStmzFZdIw3s
 da7LIFcDCXS3U9CZ3LqJkbyyOdbCwuG4HdthMXpIxQ1k1EjBlXJMgNhwDHSwepRpcd/R
 qQ8S3DCO6FTQEx1cm21GcT969GXHzESQBLKxucP6GWDOwBfPFZOjHM0u7DtFE2osxlCx
 OiEQ==
X-Gm-Message-State: AOJu0YyNHrgkzN20rfwYPWbu9uYD0k6fYl02hLg/T3igDtXZXGogwYkc
 eqYN5sCXdBR7iXMQ/A8AmWgL04O6QKS68A9571E=
X-Google-Smtp-Source: AGHT+IEMvN/5QgsxHmgMir5cI9Ju7eqqMcUpSxLJ4O5l+iuxcA4we7k6xDLIgReMr8n74e9yjfBFiw==
X-Received: by 2002:a05:6a20:dd9f:b0:137:9622:17b7 with SMTP id
 kw31-20020a056a20dd9f00b00137962217b7mr5003877pzb.25.1692634746644; 
 Mon, 21 Aug 2023 09:19:06 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v3 12/19] target/ppc: Use clmul_32* routines
Date: Mon, 21 Aug 2023 09:18:46 -0700
Message-Id: <20230821161854.419893-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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


