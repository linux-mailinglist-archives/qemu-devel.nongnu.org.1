Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBE3753F45
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:48:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0e-0007Lx-Uc; Fri, 14 Jul 2023 11:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0c-0007KV-8j
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0U-00077H-3k
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3144098df56so2284112f8f.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349617; x=1691941617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zHxdCpbn/xikj26GCA5/nQ2FBBTjRyE6yEPZb7eG12g=;
 b=ipnxl87x549TRe9EtTjHYF2xm42ZgXqEq8ek6wx3n03IvK4SsqMDWJcCZVY9G/RhFJ
 s+IM6A9RxATPwiqoizS7n3rI/DnecPCrHmG8k+Tvr99LDaz+EsdvGq74JOUC9GVuO/UE
 P7xNMTECYBcGkkloTIDoMdMdlRZY6jDaDhFOKcEYtB6hknL7afVx35qlJ1HNfXxJlasE
 iNw0M+ZGxa/sO8vrSJDa4RlWAljKyD8sqFQ8W/9BrYQ1sBOc/gO+m90vYYL7bZPVstW+
 LsRUYqtUIB33b8HVMeiBTtGIeYIegRo2tw7Uf5xUz173l6EDEg35JNG/rUeO8i+u889l
 PcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349617; x=1691941617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHxdCpbn/xikj26GCA5/nQ2FBBTjRyE6yEPZb7eG12g=;
 b=D3o4IJtLUHj5WLTGx7LbqDSyMB4hDwVoRkQQLBzhDplLBeV6+x0Y5A+s6GsyIPPMW2
 h/tcWcz2+n3DfVMhrHbp0GTY/hkyaScOC+xb3g7qzaGXzrJKPhewaMkfrv9F+jTv/v+H
 tvvt2NNA9FwwuUiacffyDYz11yXdrNCsnT44m/E6PHRI614B1LLCTW8tmWi7ZB+gsfLa
 HSTSF6w595fz1BXaaPGJtg/M7qguyNNooW54eBF5tYkvH9r/0z2HLOXn6TJN1vNPzU1R
 YAnOxzGaufhp2FOv/Vsj2KTW2a9qWb9g+ndnlpzptRNUROeHohI6Fo/GKY5e+nT0VVsa
 1BXg==
X-Gm-Message-State: ABy/qLbkMjU6LhuX1Hr6/zgbSbNge41STDJfIV9N2+R6vu1ELlrNWrRa
 PUuapIJ/ztLnQJPtoB4jXFWKznNjeNrR4RC3ovc=
X-Google-Smtp-Source: APBJJlHGV+DQYAhV0CzissAvxJwaPx/kEaJ/a/Tk1HgyxZbfXWjID0lx4+IFAji0OSjRuuIOBlDxHQ==
X-Received: by 2002:adf:d088:0:b0:313:ee2e:dae5 with SMTP id
 y8-20020adfd088000000b00313ee2edae5mr4133319wrh.21.1689349616826; 
 Fri, 14 Jul 2023 08:46:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 12/14] target/arm/ptw: Check for block descriptors at invalid
 levels
Date: Fri, 14 Jul 2023 16:46:46 +0100
Message-Id: <20230714154648.327466-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

The architecture doesn't permit block descriptors at any arbitrary
level of the page table walk; it depends on the granule size which
levels are permitted.  We implemented only a partial version of this
check which assumes that block descriptors are valid at all levels
except level 3, which meant that we wouldn't deliver the Translation
fault for all cases of this sort of guest page table error.

Implement the logic corresponding to the pseudocode
AArch64.DecodeDescriptorType() and AArch64.BlockDescSupported().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index e4210abc148..ed46bb82a75 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1549,6 +1549,25 @@ static int check_s2_mmu_setup(ARMCPU *cpu, bool is_aa64, uint64_t tcr,
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
@@ -1784,8 +1803,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
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


