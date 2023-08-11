Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FC17799B0
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:42:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZsH-0003AD-Dq; Fri, 11 Aug 2023 17:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsF-00038J-EH
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:47 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUZsB-00028V-CF
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:40:46 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-26b138db5easo1134237a91.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691790037; x=1692394837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emLHA3f+Wn2jq9G0RLvSs1vgMZkWeXD5Jg3sAJA4IbI=;
 b=gs7SXGA/LyS09JXsGB0w1Na2zOFAo3AbLRybyxYYFpgQc3j+RPxD0tjpyoYg68cX/U
 T7aP/5f36ObZnXUoYm2Yv/sCDiu2BuI11YAt7griGfdQNOLAYud3QnGtNuckK0HWEMGY
 nUECksxfqsy+XXg2XXSp/JCqYwH3KOptKBPQgCE0DCi4zRocv3sv04t3XD9EMUk2LnZg
 oXj9vB1V0oen3EQ/jdSbuJFeqi2X6lKM2HyxszpS6+K17oj/lge+vudK6KSnDjzrbKxf
 RYkqpSQwoUkApId/t9d9G59JmfY2+u5KBvdCNQTesqoPLsajyS/J944hSq3o2k6Ou2Pd
 vdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691790037; x=1692394837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=emLHA3f+Wn2jq9G0RLvSs1vgMZkWeXD5Jg3sAJA4IbI=;
 b=UpBei7asH38eK8oCYxhEQ6brySnWLnacQm/l2QJ6vsBLj5MeeuIs9ZhvD6bs8ueCVx
 vBPnq2HXpcIYlpDde02LjB+lFO2rEuH9HLVZddUaOmbdtVCCakklBWLBMiCmy4PRcj0v
 yNxC7VhIb0JeCEjRO9pyzGndegSLqEdT6H4pgwAQcUCd5yN3UKResIuXu77LVl+XQ6tq
 594ahZNAE/AO/a9B9RP0NHnmnzP9zdi+3OuzGQGMstoac5nRVw3sEsxzDlb5e+5l2z8V
 9UrN1Rpsb11xre9aQkRK32tY4Kmnh5rMz9hDBXfG/mKcjb1YGst2PNTz/OjsWYelnb0g
 b2cA==
X-Gm-Message-State: AOJu0YwdIQemt96wM9syVOjHHTghQvlkIs/W78d+NnCwxsyWLSMAZZVL
 BaHO2iSwuApgrQB55uGJDNQilbjVrw6NMB+u1Wc=
X-Google-Smtp-Source: AGHT+IG49h9ksSoCaEyhB7s58mq0nguGzuV0UunC7YZwwnY57c+ZuHfszeWVk1HzeJ2PF5OcyZjb6g==
X-Received: by 2002:a17:90a:bd86:b0:26b:20cb:80d3 with SMTP id
 z6-20020a17090abd8600b0026b20cb80d3mr2119203pjr.36.1691790037476; 
 Fri, 11 Aug 2023 14:40:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 gk18-20020a17090b119200b00263ba6a248bsm5723840pjb.1.2023.08.11.14.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:40:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 05/11] target/arm: Introduce make_ccsidr64
Date: Fri, 11 Aug 2023 14:40:25 -0700
Message-Id: <20230811214031.171020-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811214031.171020-1-richard.henderson@linaro.org>
References: <20230811214031.171020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Do not hard-code the constants for Neoverse V1.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/cpu64.c | 48 ++++++++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 4cd73779c8..00f39d42a8 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -24,9 +24,36 @@
 #include "qemu/module.h"
 #include "qapi/visitor.h"
 #include "hw/qdev-properties.h"
+#include "qemu/units.h"
 #include "internals.h"
 #include "cpregs.h"
 
+static uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
+                              unsigned cachesize)
+{
+    unsigned lg_linesize = ctz32(linesize);
+    unsigned sets;
+
+    /*
+     * The 64-bit CCSIDR_EL1 format is:
+     *   [55:32] number of sets - 1
+     *   [23:3]  associativity - 1
+     *   [2:0]   log2(linesize) - 4
+     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
+     */
+    assert(assoc != 0);
+    assert(is_power_of_2(linesize));
+    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
+
+    /* sets * associativity * linesize == cachesize. */
+    sets = cachesize / (assoc * linesize);
+    assert(cachesize % (assoc * linesize) == 0);
+
+    return ((uint64_t)(sets - 1) << 32)
+         | ((assoc - 1) << 3)
+         | (lg_linesize - 4);
+}
+
 static void aarch64_a35_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -651,26 +678,15 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
      * The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values,
      * but also says it implements CCIDX, which means they should be
      * 64-bit format. So we here use values which are based on the textual
-     * information in chapter 2 of the TRM (and on the fact that
-     * sets * associativity * linesize == cachesize).
-     *
-     * The 64-bit CCSIDR_EL1 format is:
-     *   [55:32] number of sets - 1
-     *   [23:3]  associativity - 1
-     *   [2:0]   log2(linesize) - 4
-     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
-     *
-     * L1: 4-way set associative 64-byte line size, total size 64K,
-     * so sets is 256.
+     * information in chapter 2 of the TRM:
      *
+     * L1: 4-way set associative 64-byte line size, total size 64K.
      * L2: 8-way set associative, 64 byte line size, either 512K or 1MB.
-     * We pick 1MB, so this has 2048 sets.
-     *
      * L3: No L3 (this matches the CLIDR_EL1 value).
      */
-    cpu->ccsidr[0] = 0x000000ff0000001aull; /* 64KB L1 dcache */
-    cpu->ccsidr[1] = 0x000000ff0000001aull; /* 64KB L1 icache */
-    cpu->ccsidr[2] = 0x000007ff0000003aull; /* 1MB L2 cache */
+    cpu->ccsidr[0] = make_ccsidr64(4, 64, 64 * KiB); /* L1 dcache */
+    cpu->ccsidr[1] = cpu->ccsidr[0];                 /* L1 icache */
+    cpu->ccsidr[2] = make_ccsidr64(8, 64, 1 * MiB);  /* L2 cache */
 
     /* From 3.2.115 SCTLR_EL3 */
     cpu->reset_sctlr = 0x30c50838;
-- 
2.34.1


