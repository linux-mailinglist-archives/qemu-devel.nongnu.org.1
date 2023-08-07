Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EA3772769
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 16:17:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT12l-0002vV-K2; Mon, 07 Aug 2023 10:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT118-0000B3-WE
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qT114-0005Ux-De
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 10:15:29 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fe5c0e5747so6150045e9.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691417723; x=1692022523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DFzTkjIJFWqjEqcRCrUZIPYv2Pvbteumi0MT6ZHxtV8=;
 b=tTeVrVunRFlq3yP/VXgTQ5dWYVYdt/sy7NvCm3fJDrGVtu9n/7/Sb26GFtTw9/YbGK
 bkS1WS9B+MrR1/e8Ka+QysnE5j5p1yAFRniGeEBNcRb8vewU/ISQmsDFfpAv/3YqJtmH
 +yeBUrmIoVGpXEW7KPNKl7xhEqRtofH4xm/7SjB3tZ2likXv7oWM579DFkGB08grH3AT
 FBgUkyHBfX+jsqyEm6fQX2r56JZps8CIxd3oWO/QhJ4kHskEtNXRVw4cUrcO18tBjMY+
 D4Zix0zuVfxAOfzLfMMyPepuT2x4pYUYEUnlQOMd3ap2i4nLux6QQxzz57yQvKhLYEUC
 xOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691417723; x=1692022523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DFzTkjIJFWqjEqcRCrUZIPYv2Pvbteumi0MT6ZHxtV8=;
 b=RFzdfiW2UJRHW+XEwKN7lbMed9U4cFEkyTLYXRZwzvMM1hLcxnuR2kfkoRzljJZRRV
 W/C2yRq13592UTOZeQ+ubU5Bu/2/sjW/Dsi67xndS+lt4phQdxcXD9vI2nzKgcTShXc9
 OYV9998MwOG3zGwU5XlHiQlymS5deSjX1e/X38Rx/Cp5Ry/Z/uTjVZsDEf7BLE3CbMLZ
 tsIoxhR9oNfuO5SCWXXdQ4tdszF5Mu1KltciVjlpBQviX3AmuejmfKjt04pMZno/MsKO
 0iiXYO+YwgiXrQZpYyKOYSpC/badRLO+Ob2rIIbshAdu/h5n5VIpN6o4/uk6gAErhS8a
 wMDg==
X-Gm-Message-State: AOJu0YzOTmKCuewCZhJrMwRofDq7X5PO2v2iTqtp/iMYBKZSNTPCiEZL
 cPujTF0yKTbTjPU5S3N3OrRIdg==
X-Google-Smtp-Source: AGHT+IEH9KLrgYpQ9nVi8lZNekInlmK6gzgI8Z7aSK371k2PXahbRTNG18LM9oo/0NURAtKzYOwEyw==
X-Received: by 2002:a7b:c8c4:0:b0:3fe:1c57:3be with SMTP id
 f4-20020a7bc8c4000000b003fe1c5703bemr5842847wml.8.1691417723392; 
 Mon, 07 Aug 2023 07:15:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c261400b003fe2ebf479fsm10835617wma.36.2023.08.07.07.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 07:15:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 13/15] target/arm/ptw: Check for block descriptors at
 invalid levels
Date: Mon,  7 Aug 2023 15:15:12 +0100
Message-Id: <20230807141514.19075-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807141514.19075-1-peter.maydell@linaro.org>
References: <20230807141514.19075-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

The architecture doesn't permit block descriptors at any arbitrary
level of the page table walk; it depends on the granule size which
levels are permitted.  We implemented only a partial version of this
check which assumes that block descriptors are valid at all levels
except level 3, which meant that we wouldn't deliver the Translation
fault for all cases of this sort of guest page table error.

Implement the logic corresponding to the pseudocode
AArch64.DecodeDescriptorType() and AArch64.BlockDescSupported().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 7f217a31895..fbb0f8a0bf2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1551,6 +1551,25 @@ static int check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, uint64_t tcr,
     return INT_MIN;
 }
 
+static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
+                                  ARMGranuleSize gran, int level)
+{
+    /*
+     * See pseudocode AArch46.BlockDescSupported(): block descriptors
+     * are not valid at all levels, depending on the page size.
+     */
+    switch (gran) {
+    case Gran4K:
+        return (level == 0 && ds) || level == 1 || level == 2;
+    case Gran16K:
+        return (level == 1 && ds) || level == 2;
+    case Gran64K:
+        return (level == 1 && arm_pamax(cpu) == 52) || level == 2;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1786,8 +1805,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     new_descriptor = descriptor;
 
  restart_atomic_update:
-    if (!(descriptor & 1) || (!(descriptor & 2) && (level == 3))) {
-        /* Invalid, or the Reserved level 3 encoding */
+    if (!(descriptor & 1) ||
+        (!(descriptor & 2) &&
+         !lpae_block_desc_valid(cpu, param.ds, param.gran, level))) {
+        /* Invalid, or a block descriptor at an invalid level */
         goto do_translation_fault;
     }
 
-- 
2.34.1


