Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B35477275F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT11w-00010b-Uy; Mon, 07 Aug 2023 10:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT118-0000Av-T5
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005Uj-EK
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:30 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e58c0so9973055e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417723; x=1692022523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/yyxHEqA/6T1J8G7sWRRyJB/3QTMgoPg9dM02AxAbq0=;
 b=dCZeRDrJmVUKLL6uHLM8YCsUNdsXHez4T2u/PAmTSP44PeMCIMj3JtFpIc7//ogs1Q
 /NCSzTbZlR+oEG0taAPZhudx+98jILtmJ3ED7enzbogBxsLKPV2gX6su06p+b0qhbQCA
 XRmmWDOYKmU+UzUv148HIxBkCOJ9o+x9FpQ9qqdlpi/CXrlCZkB3bg8U59/sbxhTDrLA
 CpnwlDBpcZ5xXR4co3Hq1knujVK5cfYDSiLgX/qG0kcIajUtgwxJ8b37uESfMZOLVVrQ
 jADOedeACdU1Zo1P7CPWa1Ipln5mQkgVPJQvqWarRm91uNyYZEKvB8eVBcnsD2QHPuTO
 Mt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417723; x=1692022523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/yyxHEqA/6T1J8G7sWRRyJB/3QTMgoPg9dM02AxAbq0=;
 b=h4+mCzKklwNsOR7F1SodU8L0QG++RrslQTnp30ws5UGeqSioIXw3AKSO4SdqCgrX0Q
 nS3b+c8hwMLg7QPtXdCItr+bfGnAARmXAlppZm7bquigxYiHuktIAtDQn+fBuuF3/CYY
 NplmiRSUlRkrF/9305pymZUyrtv+UHvf6pRMnC66w2Y0wZZ0VJFGn/NDcedwBvqQgKcV
 6pmRYT3geNRKxz5gt0TW3mDX6F6adsMn3J3psNKN790kVyuDAFXcuDa0ZvY+bfrhw3I2
 NE0fuGZzmug45gxoqg2oB9+bSh6De65yKpFgTzGNMv67iQjVeZmufCrS76KgrY6u6GES
 cjEw==
X-Gm-Message-State: AOJu0YydG1g79/iT3b9p2PavntY55cEOrhSTkFcIYK5PzQsyzzVMP11W
 FPTxaGsTcMDrfrT/0d5TvCBXow==
X-Google-Smtp-Source: AGHT+IGcGzupSTuTY26GGHEUnNls9u4rTd1P9AfJtvrNCuGUUFvmGJAJzNpWANDgmkolMXbbR5/QIw==
X-Received: by 2002:adf:f60d:0:b0:317:6816:578c with SMTP id
 t13-20020adff60d000000b003176816578cmr7085387wrp.5.1691417722856; 
 Mon, 07 Aug 2023 07:15:22 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/15] target/arm/ptw: Set attributes correctly for MMU
 disabled data accesses
Date: Mon,  7 Aug 2023 15:15:11 +0100
Message-Id: <20230807141514.19075-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When the MMU is disabled, data accesses should be Device nGnRnE,
Outer Shareable, Untagged.  We handle the other cases from
AArch64.S1DisabledOutput() correctly but missed this one.
Device nGnRnE is memattr == 0, so the only part we were missing
was that shareability should be set to 2 for both insn fetches
and data accesses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 312ccabe92e..7f217a31895 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3108,11 +3108,13 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                 }
             }
         }
-        if (memattr == 0 && access_type == MMU_INST_FETCH) {
-            if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
-                memattr = 0xee;  /* Normal, WT, RA, NT */
-            } else {
-                memattr = 0x44;  /* Normal, NC, No */
+        if (memattr == 0) {
+            if (access_type == MMU_INST_FETCH) {
+                if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
+                    memattr = 0xee;  /* Normal, WT, RA, NT */
+                } else {
+                    memattr = 0x44;  /* Normal, NC, No */
+                }
             }
             shareability = 2; /* outer shareable */
         }
-- 
2.34.1


