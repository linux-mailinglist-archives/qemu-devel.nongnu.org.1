Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FFA7058F5
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:36:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1ND-0006CY-Nl; Tue, 16 May 2023 16:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3w-hjZAgKCk482489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1pz1NB-0006B6-N7
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:17 -0400
Received: from mail-wr1-x449.google.com ([2a00:1450:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3w-hjZAgKCk482489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com>)
 id 1pz1N8-0006iI-JN
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:34:17 -0400
Received: by mail-wr1-x449.google.com with SMTP id
 ffacd0b85a97d-3078b9943d6so4386896f8f.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684269251; x=1686861251;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=mIeN7UmeW8jAM/Oz9ZdFYAKrLi0ludmOi5UVKC2id2Q=;
 b=zIZdiVGgKMDbvWeFhgvkE3z+1zPA7Dr18AIGVBNhX/7rSoUxgXfGygqFQhk1o7t3zk
 x8UH/Ki8iX24pVbgIN+oFpq6IUztG91Pi4DNQkirC0BUHW9Ht2FrOyuTDRS+XkvXWSuH
 m8qTq5Ruj4hZ3IuPjEx0RCfvO4m6hSHwz8wn4FxX2j1y8Fnpji2Y9DimzqY4D4sveA0c
 mZqOVs8xiISzbnTvuNsweItu0E/JDmiezMJ2X48HtZfG1J5bElobqr2Df7M9ecjfea8X
 IggRMzMkaAFIsg6Pe2Wv3sNkmyD60/vDRK0f3iJTKgtdduASEmVYzQFPSYwIbv4sJ8mN
 lGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269251; x=1686861251;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIeN7UmeW8jAM/Oz9ZdFYAKrLi0ludmOi5UVKC2id2Q=;
 b=M/LjdXGtcIYRxfaj0QXHsiYK+WI0713Y/4KK82hnA4XfW90kMO+JnBtoxNTB/8gpBb
 cjyaSY5CQs1uAyDeHXInqpceLdoqJrvCfE+pQx9TVo1sl8kjFha3m7er9lauyeZESPPX
 kZKqIL47mrDqLFbevksLcgsyvwnq7py+8L1KFAjwvInmQQTQiahzvfq6XQrWQtbr4waX
 MJ3rXvrUsgn2oTpLXVFNR1Bu4zlQfK5KwkHHZ8b8G3vQ4iGpTnbtGr97EgX6VuHwJlkg
 wIyblhl7rYR1b3AnXpWtZcgcknMgOlc52gvnWKmw0Rubu2s1/NcgwMB78O7PHby0//Gi
 X2bw==
X-Gm-Message-State: AC+VfDyn8M/dfZJExfjg9CW23Yr/8vWs5CAT+H7huTAm12ICA7ndWZ8P
 EW5Nk5a6+NTKA8zbDvRHARAZRrCj3Zh9Y/AcCPxjaTlj/h+XxLA7DkJFXXGsQDOhYknL2q7hWHs
 5H7ZnYIaAPzYiTbu8m1KzZAWrf+CoQABh2imCI+wPVgsoNbKOfpgdyYzrkbjB5OwXfQ==
X-Google-Smtp-Source: ACHHUZ5MhYZMFSZRUS2hUZePV2SOQldTLHwD4b6Vty5J3VE8Q5Ax84I3HfXFVC2JYtoGlM4+9AX4prolPZv2dA==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:adf:ef4c:0:b0:307:8681:a1f7 with SMTP id
 c12-20020adfef4c000000b003078681a1f7mr4672125wrp.11.1684269251167; Tue, 16
 May 2023 13:34:11 -0700 (PDT)
Date: Tue, 16 May 2023 20:33:15 +0000
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Mime-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516203327.2051088-9-smostafa@google.com>
Subject: [PATCH v4 08/10] hw/arm/smmuv3: Add CMDs related to stage-2
From: Mostafa Saleh <smostafa@google.com>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::449;
 envelope-from=3w-hjZAgKCk482489qvqw44w1u.s426u2A-tuBu1343w3A.47w@flex--smostafa.bounces.google.com;
 helo=mail-wr1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

CMD_TLBI_S2_IPA: As S1+S2 is not enabled, for now this can be the
same as CMD_TLBI_NH_VAA.

CMD_TLBI_S12_VMALL: Added new function to invalidate TLB by VMID.

For stage-1 only commands, add a check to throw CERROR_ILL if used
when stage-1 is not supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
Changes im v4:
- Collected Reviewed-by tag
- Add SMMU_CMD_TLBI_S12_VMALL in a block
Changes in v3:
- Log guest error for all illegal commands.
Changes in v2:
- Add checks for stage-1 only commands
- Rename smmuv3_s1_range_inval to smmuv3_range_inval
---
 hw/arm/smmu-common.c         | 16 +++++++++++
 hw/arm/smmuv3.c              | 55 ++++++++++++++++++++++++++++++------
 hw/arm/trace-events          |  4 ++-
 include/hw/arm/smmu-common.h |  1 +
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 6109beaa70..5ab9d45d58 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -135,6 +135,16 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
 
     return SMMU_IOTLB_ASID(*iotlb_key) == asid;
 }
+
+static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    uint16_t vmid = *(uint16_t *)user_data;
+    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
+
+    return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
+}
+
 static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
                                               gpointer user_data)
 {
@@ -187,6 +197,12 @@ void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
     g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
 }
 
+inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
+{
+    trace_smmu_iotlb_inv_vmid(vmid);
+    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
+}
+
 /* VMSAv8-64 Translation */
 
 /**
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 64284395c2..3643befc9e 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1062,7 +1062,7 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, dma_addr_t iova,
     }
 }
 
-static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1087,7 +1087,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
     }
 
     if (!tg) {
-        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, addr, tg, 1);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         return;
@@ -1105,7 +1105,7 @@ static void smmuv3_s1_range_inval(SMMUState *s, Cmd *cmd)
         uint64_t mask = dma_aligned_pow2_mask(addr, end, 64);
 
         num_pages = (mask + 1) >> granule;
-        trace_smmuv3_s1_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
+        trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages, ttl, leaf);
         smmuv3_inv_notifiers_iova(s, asid, addr, tg, num_pages);
         smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         addr += mask + 1;
@@ -1239,12 +1239,22 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         {
             uint16_t asid = CMD_ASID(&cmd);
 
+            if (!STAGE1_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
             trace_smmuv3_cmdq_tlbi_nh_asid(asid);
             smmu_inv_notifiers_all(&s->smmu_state);
             smmu_iotlb_inv_asid(bs, asid);
             break;
         }
         case SMMU_CMD_TLBI_NH_ALL:
+            if (!STAGE1_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            QEMU_FALLTHROUGH;
         case SMMU_CMD_TLBI_NSNH_ALL:
             trace_smmuv3_cmdq_tlbi_nh();
             smmu_inv_notifiers_all(&s->smmu_state);
@@ -1252,7 +1262,36 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             break;
         case SMMU_CMD_TLBI_NH_VAA:
         case SMMU_CMD_TLBI_NH_VA:
-            smmuv3_s1_range_inval(bs, &cmd);
+            if (!STAGE1_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            smmuv3_range_inval(bs, &cmd);
+            break;
+        case SMMU_CMD_TLBI_S12_VMALL:
+        {
+            uint16_t vmid = CMD_VMID(&cmd);
+
+            if (!STAGE2_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+
+            trace_smmuv3_cmdq_tlbi_s12_vmid(vmid);
+            smmu_inv_notifiers_all(&s->smmu_state);
+            smmu_iotlb_inv_vmid(bs, vmid);
+            break;
+        }
+        case SMMU_CMD_TLBI_S2_IPA:
+            if (!STAGE2_SUPPORTED(s)) {
+                cmd_error = SMMU_CERROR_ILL;
+                break;
+            }
+            /*
+             * As currently only either s1 or s2 are supported
+             * we can reuse same function for s2.
+             */
+            smmuv3_range_inval(bs, &cmd);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
@@ -1260,8 +1299,6 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
         case SMMU_CMD_TLBI_EL2_ASID:
         case SMMU_CMD_TLBI_EL2_VA:
         case SMMU_CMD_TLBI_EL2_VAA:
-        case SMMU_CMD_TLBI_S12_VMALL:
-        case SMMU_CMD_TLBI_S2_IPA:
         case SMMU_CMD_ATC_INV:
         case SMMU_CMD_PRI_RESP:
         case SMMU_CMD_RESUME:
@@ -1270,12 +1307,14 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
             break;
         default:
             cmd_error = SMMU_CERROR_ILL;
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "Illegal command type: %d\n", CMD_TYPE(&cmd));
             break;
         }
         qemu_mutex_unlock(&s->mutex);
         if (cmd_error) {
+            if (cmd_error == SMMU_CERROR_ILL) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "Illegal command type: %d\n", CMD_TYPE(&cmd));
+            }
             break;
         }
         /*
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 705104e58b..f8fdf1ca9f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -12,6 +12,7 @@ smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, ui
 smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
 smmu_iotlb_inv_all(void) "IOTLB invalidate all"
 smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
+smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
 smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
 smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
 smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
@@ -45,9 +46,10 @@ smmuv3_cmdq_cfgi_ste_range(int start, int end) "start=0x%x - end=0x%x"
 smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
 smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
 smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
-smmuv3_s1_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
+smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d"
 smmuv3_cmdq_tlbi_nh(void) ""
 smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
+smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
 smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
 smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s"
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 3cbb4998ad..fd8d772da1 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -193,6 +193,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
-- 
2.40.1.606.ga4b1b128d6-goog


