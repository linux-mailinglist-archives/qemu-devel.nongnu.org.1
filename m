Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50E89C66B
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Apr 2024 16:10:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtpgd-0006z8-DQ; Mon, 08 Apr 2024 10:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gPoTZggKCvsvprvwdidjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--smostafa.bounces.google.com>)
 id 1rtpgP-0006xh-2p
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:13 -0400
Received: from mail-wr1-x44a.google.com ([2a00:1450:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gPoTZggKCvsvprvwdidjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--smostafa.bounces.google.com>)
 id 1rtpgI-0001Jx-Qh
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 10:09:12 -0400
Received: by mail-wr1-x44a.google.com with SMTP id
 ffacd0b85a97d-343e46df264so1707140f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 07:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1712585345; x=1713190145; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=R4YaXIvOkGVLITuL9p1CVWc9nnAfJHD4q+gC5uvDj9c=;
 b=NkOl/eCJTJYQ/msE60OjnfwaDbz4sTjo0ZyKnjaMIpOVQFvtoNWfZXglWz3HTGNYcv
 LNY1jdX2P6s/98gpUVdHw8yDGUFiujICMElnAHwWhdkppiWgr4RXP2nVnjxMIJoianiG
 o5rPF6o8hD+vAOolaKDy2KsnyenP0C1pPgRDMQ6bFQa26S/B98x+jNhzyueLoS9TBrN+
 A7EV7Z+1DD2pAr3xi2MAeWy+5cvQy1i/MMkj4HqJyuxzauBNQQvDLyCgVbOnBSBTRbb7
 ulM5HVsNIdTdGzoL7in1F+nDRJrLEVfQ/ceNOVCPtLGdo+oy8RKdnQDK74p3xDhkC9GX
 9hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712585345; x=1713190145;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R4YaXIvOkGVLITuL9p1CVWc9nnAfJHD4q+gC5uvDj9c=;
 b=viMYbxjmT/IPTl6hE2GOZdeSuYkoEwrh1uo1HkDrOBAHZfqlJsIexbAQzo/crGB+F/
 sDoGV7RRBiKeXrnpJ/5px4Ha3FOZiSWYp1l3P9KGdDBwCNYaAaQiLODpXQgy8d/Ohx5k
 /0WqMk/U+gqWo/ynwHDRSMaOTayoKI5ZyeyUR935FXIWwLqiNI9dCGrvGj9gaqzTWimK
 cGMV6E9n4BeA27l577bGFf7Rq96CzgdUkBIerwTgEDnkVXYJJkEyLy/hzS5AZQxx4gRf
 u1gIbRi25aj7ymxRP/6o9Wry35oeFvpmKyK5c3yMBI4oIVTm8wxyWqMcWupBTHoCM211
 JnWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQbrGxIUIzHMsjfBepcR3UbnUwKBFgs80a/H0RxosTiHO7l3QaOFaYBUHC94l9z0wNZGhX75gBTpS3j72RQbrSjJ5q2yw=
X-Gm-Message-State: AOJu0YztHtDqYMxYVqXwkxdUD769mjWO66UXX1Cb6r9N1CAhQsQQPKBy
 jGvolWyKLSajoDwHHw86Jov0v73h+S74BbGFJwgZaSb09uQegruOVcaFnp0WK9xwjGbQE4NQUdD
 VvmH8z/bigg==
X-Google-Smtp-Source: AGHT+IEVC1iuEuvPKWbdIOgEAgfS+vpjPNIpqOhwQK1r3sV1ug3BgEGBPeCZnh84UW04DaohHAc1DWkhK8oHag==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:b601:0:b0:343:b9e4:77d6 with SMTP id
 f1-20020adfb601000000b00343b9e477d6mr19951wre.11.1712585344489; Mon, 08 Apr
 2024 07:09:04 -0700 (PDT)
Date: Mon,  8 Apr 2024 14:08:07 +0000
In-Reply-To: <20240408140818.3799590-1-smostafa@google.com>
Mime-Version: 1.0
References: <20240408140818.3799590-1-smostafa@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408140818.3799590-3-smostafa@google.com>
Subject: [RFC PATCH v2 02/13] hw/arm/smmu: Split smmuv3_translate()
From: Mostafa Saleh <smostafa@google.com>
To: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org, 
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org, 
 marcin.juszkiewicz@linaro.org, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::44a;
 envelope-from=3gPoTZggKCvsvprvwdidjrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

smmuv3_translate() does everything from STE/CD parsing to TLB lookup
and PTW.

Soon, when nesting is supported, stage-1 data (tt, CD) needs to be
translated using stage-2.

Split smmuv3_translate() to 3 functions:

- smmu_translate(): in smmu-common.c, which does the TLB lookup, PTW,
  TLB insertion, all the functions are already there, this just puts
  them together.
  This also simplifies the code as it consolidates event generation
  in case of TLB lookup permission failure or in TT selection.

- smmuv3_do_translate(): in smmuv3.c, Calls smmu_translate() and does
  the event population in case of errors.

 - smmuv3_translate(), now calls smmuv3_do_translate() for
   translation while the rest is the same.

Also, add stage in trace_smmuv3_translate_success()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/smmu-common.c         |  59 ++++++++++++
 hw/arm/smmuv3.c              | 175 +++++++++++++----------------------
 hw/arm/trace-events          |   2 +-
 include/hw/arm/smmu-common.h |   8 ++
 4 files changed, 133 insertions(+), 111 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3a7c350aca..20630eb670 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -554,6 +554,65 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
     g_assert_not_reached();
 }
 
+SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
+                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
+{
+    uint64_t page_mask, aligned_addr;
+    SMMUTLBEntry *cached_entry = NULL;
+    SMMUTransTableInfo *tt;
+    int status;
+
+    /*
+     * Combined attributes used for TLB lookup, as only one stage is supported,
+     * it will hold attributes based on the enabled stage.
+     */
+    SMMUTransTableInfo tt_combined;
+
+    if (cfg->stage == SMMU_STAGE_1) {
+        /* Select stage1 translation table. */
+        tt = select_tt(cfg, addr);
+        if (!tt) {
+            info->type = SMMU_PTW_ERR_TRANSLATION;
+            info->stage = SMMU_STAGE_1;
+            return NULL;
+        }
+        tt_combined.granule_sz = tt->granule_sz;
+        tt_combined.tsz = tt->tsz;
+
+    } else {
+        /* Stage2. */
+        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
+        tt_combined.tsz = cfg->s2cfg.tsz;
+    }
+
+    /*
+     * TLB lookup looks for granule and input size for a translation stage,
+     * as only one stage is supported right now, choose the right values
+     * from the configuration.
+     */
+    page_mask = (1ULL << tt_combined.granule_sz) - 1;
+    aligned_addr = addr & ~page_mask;
+
+    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
+    if (cached_entry) {
+        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
+            info->type = SMMU_PTW_ERR_PERMISSION;
+            info->stage = cfg->stage;
+            return NULL;
+        }
+        return cached_entry;
+    }
+
+    cached_entry = g_new0(SMMUTLBEntry, 1);
+    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
+    if (status) {
+            g_free(cached_entry);
+            return NULL;
+    }
+    smmu_iotlb_insert(bs, cfg, cached_entry);
+    return cached_entry;
+}
+
 /**
  * The bus number is used for lookup when SID based invalidation occurs.
  * In that case we lazily populate the SMMUPciBus array from the bus hash
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 50e5a72d54..f081ff0cc4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -827,6 +827,67 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     g_hash_table_remove(bc->configs, sdev);
 }
 
+/* Do translation with TLB lookup. */
+static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
+                                                 SMMUTransCfg *cfg,
+                                                 SMMUEventInfo *event,
+                                                 IOMMUAccessFlags flag,
+                                                 SMMUTLBEntry **out_entry)
+{
+    SMMUPTWEventInfo ptw_info = {};
+    SMMUState *bs = ARM_SMMU(s);
+    SMMUTLBEntry *cached_entry = NULL;
+
+    cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
+    if (!cached_entry) {
+        /* All faults from PTW has S2 field. */
+        event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
+        switch (ptw_info.type) {
+        case SMMU_PTW_ERR_WALK_EABT:
+            event->type = SMMU_EVT_F_WALK_EABT;
+            event->u.f_walk_eabt.addr = addr;
+            event->u.f_walk_eabt.rnw = flag & 0x1;
+            event->u.f_walk_eabt.class = 0x1;
+            event->u.f_walk_eabt.addr2 = ptw_info.addr;
+            break;
+        case SMMU_PTW_ERR_TRANSLATION:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_TRANSLATION;
+                event->u.f_translation.addr = addr;
+                event->u.f_translation.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ADDR_SIZE:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_ADDR_SIZE;
+                event->u.f_addr_size.addr = addr;
+                event->u.f_addr_size.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_ACCESS:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_ACCESS;
+                event->u.f_access.addr = addr;
+                event->u.f_access.rnw = flag & 0x1;
+            }
+            break;
+        case SMMU_PTW_ERR_PERMISSION:
+            if (PTW_RECORD_FAULT(cfg)) {
+                event->type = SMMU_EVT_F_PERMISSION;
+                event->u.f_permission.addr = addr;
+                event->u.f_permission.rnw = flag & 0x1;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return SMMU_TRANS_ERROR;
+    }
+    *out_entry = cached_entry;
+    return SMMU_TRANS_SUCCESS;
+}
+
+/* Entry point to SMMU, does everything. */
 static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
                                       IOMMUAccessFlags flag, int iommu_idx)
 {
@@ -836,12 +897,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     SMMUEventInfo event = {.type = SMMU_EVT_NONE,
                            .sid = sid,
                            .inval_ste_allowed = false};
-    SMMUPTWEventInfo ptw_info = {};
     SMMUTranslationStatus status;
-    SMMUState *bs = ARM_SMMU(s);
-    uint64_t page_mask, aligned_addr;
-    SMMUTLBEntry *cached_entry = NULL;
-    SMMUTransTableInfo *tt;
     SMMUTransCfg *cfg = NULL;
     IOMMUTLBEntry entry = {
         .target_as = &address_space_memory,
@@ -850,11 +906,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .addr_mask = ~(hwaddr)0,
         .perm = IOMMU_NONE,
     };
-    /*
-     * Combined attributes used for TLB lookup, as only one stage is supported,
-     * it will hold attributes based on the enabled stage.
-     */
-    SMMUTransTableInfo tt_combined;
+    SMMUTLBEntry *cached_entry = NULL;
 
     qemu_mutex_lock(&s->mutex);
 
@@ -883,105 +935,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         goto epilogue;
     }
 
-    if (cfg->stage == SMMU_STAGE_1) {
-        /* Select stage1 translation table. */
-        tt = select_tt(cfg, addr);
-        if (!tt) {
-            if (cfg->record_faults) {
-                event.type = SMMU_EVT_F_TRANSLATION;
-                event.u.f_translation.addr = addr;
-                event.u.f_translation.rnw = flag & 0x1;
-            }
-            status = SMMU_TRANS_ERROR;
-            goto epilogue;
-        }
-        tt_combined.granule_sz = tt->granule_sz;
-        tt_combined.tsz = tt->tsz;
-
-    } else {
-        /* Stage2. */
-        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
-        tt_combined.tsz = cfg->s2cfg.tsz;
-    }
-    /*
-     * TLB lookup looks for granule and input size for a translation stage,
-     * as only one stage is supported right now, choose the right values
-     * from the configuration.
-     */
-    page_mask = (1ULL << tt_combined.granule_sz) - 1;
-    aligned_addr = addr & ~page_mask;
-
-    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
-    if (cached_entry) {
-        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
-            status = SMMU_TRANS_ERROR;
-            /*
-             * We know that the TLB only contains either stage-1 or stage-2 as
-             * nesting is not supported. So it is sufficient to check the
-             * translation stage to know the TLB stage for now.
-             */
-            event.u.f_walk_eabt.s2 = (cfg->stage == SMMU_STAGE_2);
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_PERMISSION;
-                event.u.f_permission.addr = addr;
-                event.u.f_permission.rnw = flag & 0x1;
-            }
-        } else {
-            status = SMMU_TRANS_SUCCESS;
-        }
-        goto epilogue;
-    }
-
-    cached_entry = g_new0(SMMUTLBEntry, 1);
-
-    if (smmu_ptw(cfg, aligned_addr, flag, cached_entry, &ptw_info)) {
-        /* All faults from PTW has S2 field. */
-        event.u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
-        g_free(cached_entry);
-        switch (ptw_info.type) {
-        case SMMU_PTW_ERR_WALK_EABT:
-            event.type = SMMU_EVT_F_WALK_EABT;
-            event.u.f_walk_eabt.addr = addr;
-            event.u.f_walk_eabt.rnw = flag & 0x1;
-            event.u.f_walk_eabt.class = 0x1;
-            event.u.f_walk_eabt.addr2 = ptw_info.addr;
-            break;
-        case SMMU_PTW_ERR_TRANSLATION:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_TRANSLATION;
-                event.u.f_translation.addr = addr;
-                event.u.f_translation.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_ADDR_SIZE:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_ADDR_SIZE;
-                event.u.f_addr_size.addr = addr;
-                event.u.f_addr_size.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_ACCESS:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_ACCESS;
-                event.u.f_access.addr = addr;
-                event.u.f_access.rnw = flag & 0x1;
-            }
-            break;
-        case SMMU_PTW_ERR_PERMISSION:
-            if (PTW_RECORD_FAULT(cfg)) {
-                event.type = SMMU_EVT_F_PERMISSION;
-                event.u.f_permission.addr = addr;
-                event.u.f_permission.rnw = flag & 0x1;
-            }
-            break;
-        default:
-            g_assert_not_reached();
-        }
-        status = SMMU_TRANS_ERROR;
-    } else {
-        smmu_iotlb_insert(bs, cfg, cached_entry);
-        status = SMMU_TRANS_SUCCESS;
-    }
+    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
 
 epilogue:
     qemu_mutex_unlock(&s->mutex);
@@ -992,7 +946,8 @@ epilogue:
                                     (addr & cached_entry->entry.addr_mask);
         entry.addr_mask = cached_entry->entry.addr_mask;
         trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
-                                       entry.translated_addr, entry.perm);
+                                       entry.translated_addr, entry.perm,
+                                       cfg->stage);
         break;
     case SMMU_TRANS_DISABLE:
         entry.perm = flag;
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index f1a54a02df..cc12924a84 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -37,7 +37,7 @@ smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
 smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
 smmuv3_translate_bypass(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x STE bypass iova:0x%"PRIx64" is_write=%d"
 smmuv3_translate_abort(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x abort on iova:0x%"PRIx64" is_write=%d"
-smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x"
+smmuv3_translate_success(const char *n, uint16_t sid, uint64_t iova, uint64_t translated, int perm, int stage) "%s sid=0x%x iova=0x%"PRIx64" translated=0x%"PRIx64" perm=0x%x stage=%d"
 smmuv3_get_cd(uint64_t addr) "CD addr: 0x%"PRIx64
 smmuv3_decode_cd(uint32_t oas) "oas=%d"
 smmuv3_decode_cd_tt(int i, uint32_t tsz, uint64_t ttb, uint32_t granule_sz, bool had) "TT[%d]:tsz:%d ttb:0x%"PRIx64" granule_sz:%d had:%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b3c881f0ee..5944735632 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -183,6 +183,14 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
              SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
 
+
+/*
+ * smmu_translate - Look for a translation in TLB, if not, do a PTW.
+ * Returns NULL on PTW error or incase of TLB permission errors.
+ */
+SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
+                             IOMMUAccessFlags flag, SMMUPTWEventInfo *info);
+
 /**
  * select_tt - compute which translation table shall be used according to
  * the input iova and translation config and return the TT specific info
-- 
2.44.0.478.gd926399ef9-goog


