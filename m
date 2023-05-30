Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB6C7161E6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNR-00079D-Bx; Tue, 30 May 2023 09:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0005fM-IL
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMp-0001Pa-L2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2ebso31148605e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pEDniI4wNBoIBjFcQ9Dn7y0TasANeAc6/wFPNTsRj6I=;
 b=Bib9VwNqcFxrtUgNhwax7eUTCw/OPCAxDCj8JVBEUmTTizNCvXApWmJarAI80aneTw
 KUkQWz9kXM+rUIQ52bo1wjvTmiVZ8nrN5LI+TRXItI3pRpbKm3NfkBfn85xMDtqb+SdI
 OakmfKv5Oj3RDhsBKVuSL0RpIWyu5hvQtTKYeb0MFzG8YLJXwudVY8dtMkH2+a3uBBhE
 qn2LmmVz+vMpO5Imun3lHFFRkYSUfsKczytKsM3bhZpkHkJ2gv+eNjthOzH92Wh1xke4
 1wWaB8S+sTyzq1iaQITNPXTK98ZhNg32rFi47XhqFBfwpahcz8hD1BQb4OeiS+QTZMsy
 xuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453186; x=1688045186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pEDniI4wNBoIBjFcQ9Dn7y0TasANeAc6/wFPNTsRj6I=;
 b=I1mzimofrmbfKKIsKV/M+or/8hCaP+7pD1caOmL2kVhu5PrYh4Yf5FlDFpL5VwCyiX
 HFLdtN3N+Xcgt4LZ1dwYQfv6XW6V1VKNTJ2mFGNp8sMkQ7Qiq00b9Hmdq8NL+KcamKcq
 KjOqtvF48eCDRXcCnvTry5DcyR/jOh5SYjHkJ8gO9tbd0QF8PDBuX9LLUlE0SfAUKpWu
 MDGglVmTNdGM3ImznKy/RdM6eWNIq1dJLhYtSUEvGoGPH3BfngJ9d7wmL3EUSZm9asB0
 Nn/wf5JgfWN5KhmDF8JM76WRCesAZ/4mxGZ96ICHy9r7+vtfqlCpAFpDtCphb09LfLen
 hrtg==
X-Gm-Message-State: AC+VfDxymK1dEcNG5Aq5WhHB0ABtwD/AMb+MT5WMkS3GEhq+Mxh9QnCD
 adkAdy5byLm2tWevX45LLx/dkJpybbRUXNp7dVU=
X-Google-Smtp-Source: ACHHUZ7QpPPzusQCNo2ki4+Dg8uT5eEY/IXbNtXuFY+fSlIqayC64pk54KgLxlyXKmOwoKq0IPUKCA==
X-Received: by 2002:a1c:7918:0:b0:3f6:244:55e3 with SMTP id
 l24-20020a1c7918000000b003f6024455e3mr1551162wme.35.1685453186276; 
 Tue, 30 May 2023 06:26:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] hw/arm/smmuv3: Add CMDs related to stage-2
Date: Tue, 30 May 2023 14:26:08 +0100
Message-Id: <20230530132620.1583658-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

CMD_TLBI_S2_IPA: As S1+S2 is not enabled, for now this can be the
same as CMD_TLBI_NH_VAA.

CMD_TLBI_S12_VMALL: Added new function to invalidate TLB by VMID.

For stage-1 only commands, add a check to throw CERROR_ILL if used
when stage-1 is not supported.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-id: 20230516203327.2051088-9-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/smmu-common.h |  1 +
 hw/arm/smmu-common.c         | 16 +++++++++++
 hw/arm/smmuv3.c              | 55 ++++++++++++++++++++++++++++++------
 hw/arm/trace-events          |  4 ++-
 4 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 3cbb4998ad4..fd8d772da11 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -193,6 +193,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
+void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl);
 
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 6109beaa703..5ab9d45d58a 100644
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
index 64284395c2d..3643befc9ec 100644
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
index 705104e58b7..f8fdf1ca9f3 100644
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
-- 
2.34.1


