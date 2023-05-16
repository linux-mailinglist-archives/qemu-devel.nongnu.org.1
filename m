Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 577407058F6
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1ND-0006Bz-7h; Tue, 16 May 2023 16:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3vuhjZAgKCkk3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1pz1NA-00069h-Bi
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:16 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3vuhjZAgKCkk3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com>)
 id 1pz1N7-0006hn-CJ
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:15 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-560def4d06dso142333687b3.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684269246; x=1686861246;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=iY0995RQ8jCjDU0WT84AxkGIAMrTFCXeFLA0eDg4Z+o=;
 b=HDlcGGnHy7z5qhG4HpaLk6SY8jKDIOqa4APme5QQljDgni3aqOgaEhjdsbBsqrboJe
 F8rJqJqz5iuloRoftppk8NcHidsAw1LaDnASJJScAAO0Exi+Ix2716pY2DflnSlg7soY
 UxA69dId1t83OdwTOKhodlK3/HuZjOoj5CjeQ/vQERQjeQBE81xg+0+X3xL133ausOF3
 j51bXofesZtqpeOYlUfSgo7jSRPhLZ7uX6J2OoNoOlJx2vbAPiFdH86l1+HOPnLZFmbi
 WRxE/X9Md6PBBEryKaRGKa6633Hnd+qgtjaUoorDPCcf2YEAEfyNH6XUfIViY41KJupQ
 FooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269246; x=1686861246;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iY0995RQ8jCjDU0WT84AxkGIAMrTFCXeFLA0eDg4Z+o=;
 b=jvqflQl7eKm+79O1LZu3pKD49y2n7ZHg1geCtu2wUtXpojYFawD++svahtESXMSlxt
 ItpDiYftRgs9AChlFgkExNTUx2N8THyY7q1+QzOViiaAixQzr8l9nl33bwJ7QbHXbREt
 u27p4SIB0xy/M6VJKhPt8+3lAfIu/W4csr4nu2oIlMLQ38qiOVZPvj1TJtwsvrvzn5V6
 xJlR1shz8JxKvhLeX+MFIaPcLgTIYz7EKj8f4v8G5UE8n/yVhEnewGTwb/99OOAzQXt+
 Mole45lcBkVQD8FyWDgklPjvECavThj1+174GmovWX55uxtWLJj8tMIiXaG7Ejd4R1Sh
 0JcA==
X-Gm-Message-State: AC+VfDzq5rHOqJLxMN2ND4Z32hxj4Wjb+ZrnWgPGCkTddGjGTyLAjVXC
 iVXYy9RynTYxam3xAAA7lmF0uxWkxCXKDqcfIKlU8t6BuxfrfpjUdH4WJNgQlbrX2LQVqkkytUy
 Z789LhlEvtSD3QrRV3+bHohpO6lZ5GB0icmiwNm8LWze+GhAKIeUMvNRV5RyBAivwkA==
X-Google-Smtp-Source: ACHHUZ58lDYMLNm2HVL8KrInxNOMuMrCU4jp/JMCQvGzyyVX9SN8kOzYUiR78Xl8oeuXtMvosqPv1z+/XItSBw==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a81:ac5c:0:b0:561:a64c:3d60 with SMTP id
 z28-20020a81ac5c000000b00561a64c3d60mr1383294ywj.1.1684269246396; Tue, 16 May
 2023 13:34:06 -0700 (PDT)
Date: Tue, 16 May 2023 20:33:13 +0000
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Mime-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516203327.2051088-7-smostafa@google.com>
Subject: [PATCH v4 06/10] hw/arm/smmuv3: Make TLB lookup work for stage-2
From: Mostafa Saleh <smostafa@google.com>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3vuhjZAgKCkk3xz34lqlrzzrwp.nzx1px5-op6pwyzyry5.z2r@flex--smostafa.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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
---
Changes in v3:
- Rename temp to tt_combined and move to top.
- Collected Reviewed-by tag.
Changes in v2:
- check if S1 is enabled(not supported) when reading S1 TT.
---
 hw/arm/smmuv3.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 27840f2d66..a6714e0420 100644
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
2.40.1.606.ga4b1b128d6-goog


