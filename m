Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 378947161B9
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:27:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNQ-00077B-TE; Tue, 30 May 2023 09:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hn-CH
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:38 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMq-0001Pl-En
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4effb818c37so4825823e87.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NXIsUkcYhmVyomGFNj4s2jt+jt/G/DuwsVM/3CK2mmU=;
 b=Xp6meIQE611Z0PJ1UIYOVwL7AMghXQQTbgXU6HheyZXsvxqQC/imMW27/EWLq0YGJB
 YwfmjXOlbDq24gSHzBPud14u0Cq9ee/XTB/tcB61bsXCYTVN9KBc5bnGPtgFNFCfIHLB
 MaD0HrsI89BhpkRD6Eak6rprEtJNO9KYnIHhe3uRnan+jq6ZaNzeEbFRseXKQRewgTEk
 SRNGF1Lddd9EA2NnBdyLjBNjtEKrsqHvzTtwNdIh3dlMYq5zsEw1TIZY7FJwoI6YSQWG
 9vmxorZlvN1njBuOisqlMBpWrzWshlQkvMvZtbhJ1zboSjf05xtoD9n7sEEBkkFqKT+6
 qkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NXIsUkcYhmVyomGFNj4s2jt+jt/G/DuwsVM/3CK2mmU=;
 b=fQQ4SF5OkpWBI0E4CG3kTi4TITyX70KHudFAI1D7mnB5x+vrSpCRURqiWuGusv1eBW
 8+x7gBuf63+uJZKjtS970uOPgJddqxEKMwjRx5VZEaBJWC3ZJReOcG36MrtT83pdvgRF
 KC2woNMhNqQnO+ZD1LcKuZYzQTzz4o74LPjUvS2+qJphz6g0Nw9BulyXVut6tBmEpt3u
 imzv8nqTz82Js8oE3z/Zz0rHtxJmLRXjxNSwE66csviqoMRF118LwxLPwIHJ9MY9ZhqO
 ziw5SMPv+mJ6oKSofB54oP8J4qIuTDBHJg4Odqs/X0pnfRc3bvt9kE3qrZVxOsQTCr6j
 Y+cw==
X-Gm-Message-State: AC+VfDxDQvn0o6y6xLjWdNWmpjd3qI49GYHjvpQWUdTFizHNWIBq99Cs
 491MGmVfsM4Et7Zn2wt5kV1xX0n9dhjYEFFdKYo=
X-Google-Smtp-Source: ACHHUZ66kdv8Sf9lzPvNrOj3i3iqrzO9YJgb3EOT6qRMxQOyDh3BYhYM49M3If9ObAt/Ajo5A9GpZg==
X-Received: by 2002:ac2:4c21:0:b0:4f2:502d:f6c9 with SMTP id
 u1-20020ac24c21000000b004f2502df6c9mr730746lfq.13.1685453186656; 
 Tue, 30 May 2023 06:26:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/21] hw/arm/smmuv3: Add stage-2 support in iova notifier
Date: Tue, 30 May 2023 14:26:09 +0100
Message-Id: <20230530132620.1583658-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

In smmuv3_notify_iova, read the granule based on translation stage
and use VMID if valid value is sent.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-10-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3.c     | 39 ++++++++++++++++++++++++++-------------
 hw/arm/trace-events |  2 +-
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 3643befc9ec..17e1359be47 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -999,18 +999,21 @@ epilogue:
  * @mr: IOMMU mr region handle
  * @n: notifier to be called
  * @asid: address space ID or negative value if we don't care
+ * @vmid: virtual machine ID or negative value if we don't care
  * @iova: iova
  * @tg: translation granule (if communicated through range invalidation)
  * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
-                               int asid, dma_addr_t iova,
-                               uint8_t tg, uint64_t num_pages)
+                               int asid, int vmid,
+                               dma_addr_t iova, uint8_t tg,
+                               uint64_t num_pages)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     IOMMUTLBEvent event;
     uint8_t granule;
+    SMMUv3State *s = sdev->smmu;
 
     if (!tg) {
         SMMUEventInfo event = {.inval_ste_allowed = true};
@@ -1025,11 +1028,20 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
             return;
         }
 
-        tt = select_tt(cfg, iova);
-        if (!tt) {
+        if (vmid >= 0 && cfg->s2cfg.vmid != vmid) {
             return;
         }
-        granule = tt->granule_sz;
+
+        if (STAGE1_SUPPORTED(s)) {
+            tt = select_tt(cfg, iova);
+            if (!tt) {
+                return;
+            }
+            granule = tt->granule_sz;
+        } else {
+            granule = cfg->s2cfg.granule_sz;
+        }
+
     } else {
         granule = tg * 2 + 10;
     }
@@ -1043,9 +1055,10 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
     memory_region_notify_iommu_one(n, &event);
 }
 
-/* invalidate an asid/iova range tuple in all mr's */
-static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
-                                      uint8_t tg, uint64_t num_pages)
+/* invalidate an asid/vmid/iova range tuple in all mr's */
+static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
+                                      dma_addr_t iova, uint8_t tg,
+                                      uint64_t num_pages)
 {
     SMMUDevice *sdev;
 
@@ -1053,11 +1066,11 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
         IOMMUMemoryRegion *mr = &sdev->iommu;
         IOMMUNotifier *n;
 
-        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, iova,
-                                        tg, num_pages);
+        trace_smmuv3_inv_notifiers_iova(mr->parent_obj.name, asid, vmid,
+                                        iova, tg, num_pages);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, iova, tg, num_pages);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages);
         }
     }
 }
@@ -1088,7 +1101,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
-        smmuv3_inv_notifiers_iova(s, asid, addr, tg, 1);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         return;
     }
@@ -1106,7 +1119,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
 
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
-        smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         addr += mask + 1;
     }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f8fdf1ca9f3..cdc1ea06a81 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -53,5 +53,5 @@ smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
-smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
+smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
-- 
2.34.1


