Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A84E7161F1
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zOE-0008VW-LE; Tue, 30 May 2023 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0005fN-Ht
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMp-0001PG-KX
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6042d605dso30601715e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453185; x=1688045185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eVnRT/EmF6YE28ZlNKe421+eyWbDMKext3Dg8ZblFco=;
 b=iGwPWROtaYX8c0nYEcfEotErkoob3iov0UJm290MWA8t5/U+/gBTY3EAEojKqgOSdw
 RaGTQHzSuZJB2OgdaWaqo8TGk310aiNcbPVGb8ksXKbJohrJf0WZ85QzPbhavBkIc+mQ
 g29/uJNWG2y8Xf/jEVtLHl5UFBM6jFZrkCB2xMaub+fKfDWe6SzsoPBCsSyHY4rbshtf
 MhmWIv9Z1RGkSqICPU24Q18GKmmGkqRdE9p/w4X4hdL2A7nSLdrjJxnpTXzpoi+6Rt5q
 enKsOGdX9qBguATYmN7EkcgO7G9+KbiC8cQ9kHYpycGeOpTC+bkW96vQebC8ZBWtKMWH
 G7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453185; x=1688045185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eVnRT/EmF6YE28ZlNKe421+eyWbDMKext3Dg8ZblFco=;
 b=XxrmDIqTRfVDx6VB8GB5kp6xKhrzp1rnBkHsaUEYvSbLH0Ai+UXfTe+iNi4NLVPCdE
 CAMrFahwYFFGmFRLr6PGPAWGTfsEwJxjIpYRcpjP6j8a+hZ5gq4n/kHA2Pn6YA1HR77S
 a3tOIkVJzxE/RCbZB7LXIyPuVxjr1YQJw8Rj5n4z83sSHc+EirTJyDHegjIXHosmEPcK
 RaYTgv/13FGu1zXB4Y0oKsuUGa1k//SwrNAIf6lm67yxweASifVNpz17KAwldnxsPTWp
 oToaIozSFc+yuDO0uaNvwBbenyGK/zuxyWvRxYe7lLJNNxKGGeEUUMnbho2GNxyOvXJ+
 fQeg==
X-Gm-Message-State: AC+VfDydIGKreuWoSbrm/j6r7UpOWmzk+hbcv5wgvw6rrrdHr3Bhj9xl
 xhefEVS/ApufLwYP5AOhm6RbCjKbOSLdjbpzAIQ=
X-Google-Smtp-Source: ACHHUZ4FpeU1gbuF+vx/WbGAxNKUcCAJFHZn+n3KyyTtFBhco22bv7APQC1evI+dxvXdyXDXxtVPRQ==
X-Received: by 2002:a05:600c:221a:b0:3f5:878:c0c2 with SMTP id
 z26-20020a05600c221a00b003f50878c0c2mr1647774wml.3.1685453185486; 
 Tue, 30 May 2023 06:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/21] hw/arm/smmuv3: Make TLB lookup work for stage-2
Date: Tue, 30 May 2023 14:26:06 +0100
Message-Id: <20230530132620.1583658-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Mostafa Saleh <smostafa@google.com>

Right now, either stage-1 or stage-2 are supported, this simplifies
how we can deal with TLBs.
This patch makes TLB lookup work if stage-2 is enabled instead of
stage-1.
TLB lookup is done before a PTW, if a valid entry is found we won't
do the PTW.
To be able to do TLB lookup, we need the correct tagging info, as
granularity and input size, so we get this based on the supported
translation stage. The TLB entries are added correctly from each
stage PTW.

When nested translation is supported, this would need to change, for
example if we go with a combined TLB implementation, we would need to
use the min of the granularities in TLB.

As stage-2 shouldn't be tagged by ASID, it will be set to -1 if S1P
is not enabled.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-7-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 27840f2d666..a6714e04207 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -720,6 +720,9 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
     STE ste;
     CD cd;
 
+    /* ASID defaults to -1 (if s1 is not supported). */
+    cfg->asid = -1;
+
     ret = smmu_find_ste(s, sid, &ste, event);
     if (ret) {
         return ret;
@@ -817,6 +820,11 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
+    /*
+     * Combined attributes used for TLB lookup, as only one stage is supported,
+     * it will hold attributes based on the enabled stage.
+     */
+    SMMUTransTableInfo tt_combined;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -845,21 +853,35 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    tt = select_tt(cfg, addr);
-    if (!tt) {
-        if (cfg->record_faults) {
-            event.type = SMMU_EVT_F_TRANSLATION;
-            event.u.f_translation.addr = addr;
-            event.u.f_translation.rnw = flag & 0x1;
+    if (cfg->stage == 1) {
+        /* Select stage1 translation table. */
+        tt = select_tt(cfg, addr);
+        if (!tt) {
+            if (cfg->record_faults) {
+                event.type = SMMU_EVT_F_TRANSLATION;
+                event.u.f_translation.addr = addr;
+                event.u.f_translation.rnw = flag & 0x1;
+            }
+            status = SMMU_TRANS_ERROR;
+            goto epilogue;
         }
-        status = SMMU_TRANS_ERROR;
-        goto epilogue;
-    }
+        tt_combined.granule_sz = tt->granule_sz;
+        tt_combined.tsz = tt->tsz;
 
-    page_mask = (1ULL << (tt->granule_sz)) - 1;
+    } else {
+        /* Stage2. */
+        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
+        tt_combined.tsz = cfg->s2cfg.tsz;
+    }
+    /*
+     * TLB lookup looks for granule and input size for a translation stage,
+     * as only one stage is supported right now, choose the right values
+     * from the configuration.
+     */
+    page_mask = (1ULL << tt_combined.granule_sz) - 1;
     aligned_addr = addr & ~page_mask;
 
-    cached_entry = smmu_iotlb_lookup(bs, cfg, tt, aligned_addr);
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
-- 
2.34.1


