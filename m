Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7A7161D6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNS-0007AD-Eh; Tue, 30 May 2023 09:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0005fK-I1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMp-0001PS-Km
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:31 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f6da07feb2so45996825e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hpQfQe0Rvpz9BGWl2XoSPRw3htgGc2Dd8d6i0wviORk=;
 b=dv4P5ES8BjE6YmU889U5ybCKEoVPP22Ibm6qBKDH5h5Y0Eziqk9LbQZJkFe86qCPNl
 wold/mdHCUSm2isnnVfUpXYqN9UxLMtE4mUGPlcjJ5Lb21P8UFpHwYvijsrpBrFQ1nOh
 KbBGBTT3y4HPMNccolaIM/wb4/AdoBWrv9X/+9M4MZscsxTwW/iyqQlynPNXT7CLEhmO
 T+rUP55sHyCZDmVw6cMACZ0zNuQp9NKFxSnWCZKTpb/qpxnu47OLpl22Fx4rY+wNI/XR
 XSxt4nkqT74vYtHBHPwMSGOxvQCgx4iAHNCNR9k/NaaPfLXTu0hcII5Pz1SrgeNqBWFK
 /cGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpQfQe0Rvpz9BGWl2XoSPRw3htgGc2Dd8d6i0wviORk=;
 b=HZ8+SZQO23Ls4cIhqg3K5NO6Abm0ILCx2D5pd9lCuPks+xfeQd1zYY9Tnv8eKeUzD3
 FUoFOh1vMiIUSfNYL+OJe9RAZQer5cQ7SaRbQaodPU752ngZ3JpwiUEnlISvca/esMMp
 DShg0vUnbfquhrHTWXZLc3mz6p1kdoHhAr0V46Dgw2lXwMF2aANeo4C0SBgdh6V5BEDY
 jcfy85AZHUFXUgaxdgzdor7eoFsmtV9LsGOH/PfX3aeByErdnzdLZgVFIMe+l9WnuOX0
 nxn+ALX3q2AmbbaXi5Q8+UwsSF+erLuQjV3oN5Xw5euoXc9StRRXPgAkXfp3DrA2l/DP
 sE/A==
X-Gm-Message-State: AC+VfDwylQapF4MtSKeqkiPRS4OniFFoCXQqhYF+gfd+/j5lcrpnXKIp
 d9Djt9lu8ZbOQ0uHOxv4uAU4PUW7T4GZ9hPc/aM=
X-Google-Smtp-Source: ACHHUZ44aJUqr3OzFQbxyQQ1Y5c9v5p1BARJWW7JRvIYUi2ZB+sVaAQS63lEcLLrYIVU5fBvPD1S3A==
X-Received: by 2002:a05:600c:24c:b0:3f1:6fb3:ffcc with SMTP id
 12-20020a05600c024c00b003f16fb3ffccmr1757904wmj.22.1685453185909; 
 Tue, 30 May 2023 06:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] hw/arm/smmuv3: Add VMID to TLB tagging
Date: Tue, 30 May 2023 14:26:07 +0100
Message-Id: <20230530132620.1583658-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
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

Allow TLB to be tagged with VMID.

If stage-1 is only supported, VMID is set to -1 and ignored from STE
and CMD_TLBI_NH* cmds.

Update smmu_iotlb_insert trace event to have vmid.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-8-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmu-internal.h       |  2 ++
 include/hw/arm/smmu-common.h |  5 +++--
 hw/arm/smmu-common.c         | 36 ++++++++++++++++++++++--------------
 hw/arm/smmuv3.c              | 12 +++++++++---
 hw/arm/trace-events          |  6 +++---
 5 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/hw/arm/smmu-internal.h b/hw/arm/smmu-internal.h
index a9454f914e9..843bebb185d 100644
--- a/hw/arm/smmu-internal.h
+++ b/hw/arm/smmu-internal.h
@@ -132,9 +132,11 @@ static inline int pgd_concat_idx(int start_level, int granule_sz,
 }
 
 #define SMMU_IOTLB_ASID(key) ((key).asid)
+#define SMMU_IOTLB_VMID(key) ((key).vmid)
 
 typedef struct SMMUIOTLBPageInvInfo {
     int asid;
+    int vmid;
     uint64_t iova;
     uint64_t mask;
 } SMMUIOTLBPageInvInfo;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 4f1405d4e45..3cbb4998ad4 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -125,6 +125,7 @@ typedef struct SMMUPciBus {
 typedef struct SMMUIOTLBKey {
     uint64_t iova;
     uint16_t asid;
+    uint16_t vmid;
     uint8_t tg;
     uint8_t level;
 } SMMUIOTLBKey;
@@ -188,11 +189,11 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
 SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
                                 SMMUTransTableInfo *tt, hwaddr iova);
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
-void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 3e82eab741e..6109beaa703 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -38,7 +38,7 @@ static guint smmu_iotlb_key_hash(gconstpointer v)
 
     /* Jenkins hash */
     a = b = c = JHASH_INITVAL + sizeof(*key);
-    a += key->asid + key->level + key->tg;
+    a += key->asid + key->vmid + key->level + key->tg;
     b += extract64(key->iova, 0, 32);
     c += extract64(key->iova, 32, 32);
 
@@ -53,13 +53,15 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
     SMMUIOTLBKey *k1 = (SMMUIOTLBKey *)v1, *k2 = (SMMUIOTLBKey *)v2;
 
     return (k1->asid == k2->asid) && (k1->iova == k2->iova) &&
-           (k1->level == k2->level) && (k1->tg == k2->tg);
+           (k1->level == k2->level) && (k1->tg == k2->tg) &&
+           (k1->vmid == k2->vmid);
 }
 
-SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint64_t iova,
+SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level)
 {
-    SMMUIOTLBKey key = {.asid = asid, .iova = iova, .tg = tg, .level = level};
+    SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
+                        .tg = tg, .level = level};
 
     return key;
 }
@@ -78,7 +80,8 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
         uint64_t mask = subpage_size - 1;
         SMMUIOTLBKey key;
 
-        key = smmu_get_iotlb_key(cfg->asid, iova & ~mask, tg, level);
+        key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid,
+                                 iova & ~mask, tg, level);
         entry = g_hash_table_lookup(bs->iotlb, &key);
         if (entry) {
             break;
@@ -88,13 +91,13 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 
     if (entry) {
         cfg->iotlb_hits++;
-        trace_smmu_iotlb_lookup_hit(cfg->asid, iova,
+        trace_smmu_iotlb_lookup_hit(cfg->asid, cfg->s2cfg.vmid, iova,
                                     cfg->iotlb_hits, cfg->iotlb_misses,
                                     100 * cfg->iotlb_hits /
                                     (cfg->iotlb_hits + cfg->iotlb_misses));
     } else {
         cfg->iotlb_misses++;
-        trace_smmu_iotlb_lookup_miss(cfg->asid, iova,
+        trace_smmu_iotlb_lookup_miss(cfg->asid, cfg->s2cfg.vmid, iova,
                                      cfg->iotlb_hits, cfg->iotlb_misses,
                                      100 * cfg->iotlb_hits /
                                      (cfg->iotlb_hits + cfg->iotlb_misses));
@@ -111,8 +114,10 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
         smmu_iotlb_inv_all(bs);
     }
 
-    *key = smmu_get_iotlb_key(cfg->asid, new->entry.iova, tg, new->level);
-    trace_smmu_iotlb_insert(cfg->asid, new->entry.iova, tg, new->level);
+    *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
+                              tg, new->level);
+    trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
+                            tg, new->level);
     g_hash_table_insert(bs->iotlb, key, new);
 }
 
@@ -130,8 +135,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
 
     return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
-
-static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
+static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
                                               gpointer user_data)
 {
     SMMUTLBEntry *iter = (SMMUTLBEntry *)value;
@@ -142,18 +146,21 @@ static gboolean smmu_hash_remove_by_asid_iova(gpointer key, gpointer value,
     if (info->asid >= 0 && info->asid != SMMU_IOTLB_ASID(iotlb_key)) {
         return false;
     }
+    if (info->vmid >= 0 && info->vmid != SMMU_IOTLB_VMID(iotlb_key)) {
+        return false;
+    }
     return ((info->iova & ~entry->addr_mask) == entry->iova) ||
            ((entry->iova & ~info->mask) == info->iova);
 }
 
-void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
+void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
     /* if tg is not set we use 4KB range invalidation */
     uint8_t granule = tg ? tg * 2 + 10 : 12;
 
     if (ttl && (num_pages == 1) && (asid >= 0)) {
-        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, iova, tg, ttl);
+        SMMUIOTLBKey key = smmu_get_iotlb_key(asid, vmid, iova, tg, ttl);
 
         if (g_hash_table_remove(s->iotlb, &key)) {
             return;
@@ -166,10 +173,11 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, dma_addr_t iova,
 
     SMMUIOTLBPageInvInfo info = {
         .asid = asid, .iova = iova,
+        .vmid = vmid,
         .mask = (num_pages * 1 << granule) - 1};
 
     g_hash_table_foreach_remove(s->iotlb,
-                                smmu_hash_remove_by_asid_iova,
+                                smmu_hash_remove_by_asid_vmid_iova,
                                 &info);
 }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index a6714e04207..64284395c2d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1066,7 +1066,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
-    uint16_t vmid = CMD_VMID(cmd);
+    int vmid = -1;
     uint8_t scale = CMD_SCALE(cmd);
     uint8_t num = CMD_NUM(cmd);
     uint8_t ttl = CMD_TTL(cmd);
@@ -1075,6 +1075,12 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
     uint64_t num_pages;
     uint8_t granule;
     int asid = -1;
+    SMMUv3State *smmuv3 = ARM_SMMUV3(s);
+
+    /* Only consider VMID if stage-2 is supported. */
+    if (STAGE2_SUPPORTED(smmuv3)) {
+        vmid = CMD_VMID(cmd);
+    }
 
     if (type == SMMU_CMD_TLBI_NH_VA) {
         asid = CMD_ASID(cmd);
@@ -1083,7 +1089,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
     if (!tg) {
         trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, addr, tg, 1);
-        smmu_iotlb_inv_iova(s, asid, addr, tg, 1, ttl);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         return;
     }
 
@@ -1101,7 +1107,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
-        smmu_iotlb_inv_iova(s, asid, addr, tg, num_pages, ttl);
+        smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         addr += mask + 1;
     }
 }
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 205ac04573a..705104e58b7 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -14,9 +14,9 @@ smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
 smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
-smmu_iotlb_lookup_hit(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_lookup_miss(uint16_t asid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
-smmu_iotlb_insert(uint16_t asid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d addr=0x%"PRIx64" tg=%d level=%d"
+smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
+smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
 
 # smmuv3.c
 smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
-- 
2.34.1


