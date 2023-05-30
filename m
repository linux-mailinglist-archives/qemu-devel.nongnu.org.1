Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB777161E8
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNP-0006wZ-PB; Tue, 30 May 2023 09:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMu-0005fO-Ic
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:32 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMp-0001PD-Km
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:31 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6d38a140bso32311495e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453185; x=1688045185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y8MSQfelnJ1s9vfU+Wn/xuvHIAzr4thxx6LBBAkNsOw=;
 b=WBn1J8u/Ry17lBEBPeTXPojz1VTgLUxqWRU5ABRYvcjCsaGGxgFxmCqrgVANG5ytIZ
 DtCUMApkRY2uuG9gPZQGhnQyH9FZmlgSqgpUpSV3w9BZiRAvRKqhAGlUlIuSX2W5M+Ra
 XvS+nLIYHZIZ1ev6TpNjO6XcykY0msXPMLI5avY5zX2veAw7P4mVrpqLmph9lhA+MjrX
 HJTLsnHvGNLw2gXXTv5kUT+UoH2jKMSt70oWdf3TorFR0M1+hf8uX/1Hsvjsz631FLqD
 604Fit8EzySU+sSvuultIUUgYSm62hNlZgQLGnFCaNNdi13/tsUoT1a+kQ579cI3xEqS
 wWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453185; x=1688045185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8MSQfelnJ1s9vfU+Wn/xuvHIAzr4thxx6LBBAkNsOw=;
 b=JHpyuZQKCnXPWlfMwbPVM6NcMXDRaVbYNP4BygL7frKwlzYwzhMao6RhMyGrMUoWwm
 LFymehChsyN4chrhe3eIzoLeXkkn4FmMPOYINpbFfQLr99hmCi9HU8/KzH8EO8fydIPj
 MuyiqKobSveImoUHNTSK7P80j0DYMA3ZjCwDIM673mZqwCrTlGVQ1cdJHVLwJcerEMUA
 Fvjsh2t/aOOsGqjwayVeFD/srdWRsOmr5Fo/EF+UGqHy+6trH2knc/sr7zO2p+7fgnJ0
 yKiDsORCUonfxYC/vmXSUWLDG+f+zXide0L8zkTAeZols2u79s6/+jJqr7G4qFYbPfot
 FTCA==
X-Gm-Message-State: AC+VfDxG7zIag8rht/sAbsRNOBQU+ixRzDXewHPfLgxIVvVekEcQH0TI
 QBTejs5kURRQwcPjfi+RCW2Itdx64fTSEA0X/sI=
X-Google-Smtp-Source: ACHHUZ49Rg61HjcykddFMg+zEve4dSpERjODRLJRFBHgoF/dfANScQsJQm98Q23l1XvTtW50/qtMbQ==
X-Received: by 2002:a7b:c407:0:b0:3f7:c92:57a0 with SMTP id
 k7-20020a7bc407000000b003f70c9257a0mr1989241wmi.14.1685453185054; 
 Tue, 30 May 2023 06:26:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/21] hw/arm/smmuv3: Parse STE config for stage-2
Date: Tue, 30 May 2023 14:26:05 +0100
Message-Id: <20230530132620.1583658-7-peter.maydell@linaro.org>
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

Parse stage-2 configuration from STE and populate it in SMMUS2Cfg.
Validity of field values are checked when possible.

Only AA64 tables are supported and Small Translation Tables (STT) are
not supported.

According to SMMUv3 UM(IHI0070E) "5.2 Stream Table Entry": All fields
with an S2 prefix (with the exception of S2VMID) are IGNORED when
stage-2 bypasses translation (Config[1] == 0).

Which means that VMID can be used(for TLB tagging) even if stage-2 is
bypassed, so we parse it unconditionally when S2P exists. Otherwise
it is set to -1.(only S1P)

As stall is not supported, if S2S is set the translation would abort.
For S2R, we reuse the same code used for stage-1 with flag
record_faults. However when nested translation is supported we would
need to separate stage-1 and stage-2 faults.

Fix wrong shift in STE_S2HD, STE_S2HA, STE_S2S.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20230516203327.2051088-6-smostafa@google.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h     |  10 +-
 include/hw/arm/smmu-common.h |   1 +
 include/hw/arm/smmuv3.h      |   3 +
 hw/arm/smmuv3.c              | 181 +++++++++++++++++++++++++++++++++--
 4 files changed, 185 insertions(+), 10 deletions(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 183d5ac8dca..6d1c1edab7b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -526,9 +526,13 @@ typedef struct CD {
 #define STE_S2TG(x)        extract32((x)->word[5], 14, 2)
 #define STE_S2PS(x)        extract32((x)->word[5], 16, 3)
 #define STE_S2AA64(x)      extract32((x)->word[5], 19, 1)
-#define STE_S2HD(x)        extract32((x)->word[5], 24, 1)
-#define STE_S2HA(x)        extract32((x)->word[5], 25, 1)
-#define STE_S2S(x)         extract32((x)->word[5], 26, 1)
+#define STE_S2ENDI(x)      extract32((x)->word[5], 20, 1)
+#define STE_S2AFFD(x)      extract32((x)->word[5], 21, 1)
+#define STE_S2HD(x)        extract32((x)->word[5], 23, 1)
+#define STE_S2HA(x)        extract32((x)->word[5], 24, 1)
+#define STE_S2S(x)         extract32((x)->word[5], 25, 1)
+#define STE_S2R(x)         extract32((x)->word[5], 26, 1)
+
 #define STE_CTXPTR(x)                                           \
     ({                                                          \
         unsigned long addr;                                     \
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 97cea8ea060..4f1405d4e45 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -29,6 +29,7 @@
 
 /* VMSAv8-64 Translation constants and functions */
 #define VMSA_LEVELS                         4
+#define VMSA_MAX_S2_CONCAT                  16
 
 #define VMSA_STRIDE(gran)                   ((gran) - VMSA_LEVELS + 1)
 #define VMSA_BIT_LVL(isz, strd, lvl)        ((isz) - (strd) * \
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index a0c026402e1..6031d7d325f 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -83,4 +83,7 @@ struct SMMUv3Class {
 #define TYPE_ARM_SMMUV3   "arm-smmuv3"
 OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 
+#define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
+#define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
+
 #endif
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4e90343996a..27840f2d666 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -33,6 +33,9 @@
 #include "smmuv3-internal.h"
 #include "smmu-internal.h"
 
+#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == 1) ? (cfg)->record_faults : \
+                                 (cfg)->s2cfg.record_faults)
+
 /**
  * smmuv3_trigger_irq - pulse @irq if enabled and update
  * GERROR register in case of GERROR interrupt
@@ -329,11 +332,141 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
     return 0;
 }
 
+/*
+ * Max valid value is 39 when SMMU_IDR3.STT == 0.
+ * In architectures after SMMUv3.0:
+ * - If STE.S2TG selects a 4KB or 16KB granule, the minimum valid value for this
+ *   field is MAX(16, 64-IAS)
+ * - If STE.S2TG selects a 64KB granule, the minimum valid value for this field
+ *   is (64-IAS).
+ * As we only support AA64, IAS = OAS.
+ */
+static bool s2t0sz_valid(SMMUTransCfg *cfg)
+{
+    if (cfg->s2cfg.tsz > 39) {
+        return false;
+    }
+
+    if (cfg->s2cfg.granule_sz == 16) {
+        return (cfg->s2cfg.tsz >= 64 - oas2bits(SMMU_IDR5_OAS));
+    }
+
+    return (cfg->s2cfg.tsz >= MAX(64 - oas2bits(SMMU_IDR5_OAS), 16));
+}
+
+/*
+ * Return true if s2 page table config is valid.
+ * This checks with the configured start level, ias_bits and granularity we can
+ * have a valid page table as described in ARM ARM D8.2 Translation process.
+ * The idea here is to see for the highest possible number of IPA bits, how
+ * many concatenated tables we would need, if it is more than 16, then this is
+ * not possible.
+ */
+static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
+{
+    int level = get_start_level(sl0, gran);
+    uint64_t ipa_bits = 64 - t0sz;
+    uint64_t max_ipa = (1ULL << ipa_bits) - 1;
+    int nr_concat = pgd_concat_idx(level, gran, max_ipa) + 1;
+
+    return nr_concat <= VMSA_MAX_S2_CONCAT;
+}
+
+static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
+{
+    cfg->stage = 2;
+
+    if (STE_S2AA64(ste) == 0x0) {
+        qemu_log_mask(LOG_UNIMP,
+                      "SMMUv3 AArch32 tables not supported\n");
+        g_assert_not_reached();
+    }
+
+    switch (STE_S2TG(ste)) {
+    case 0x0: /* 4KB */
+        cfg->s2cfg.granule_sz = 12;
+        break;
+    case 0x1: /* 64KB */
+        cfg->s2cfg.granule_sz = 16;
+        break;
+    case 0x2: /* 16KB */
+        cfg->s2cfg.granule_sz = 14;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 bad STE S2TG: %x\n", STE_S2TG(ste));
+        goto bad_ste;
+    }
+
+    cfg->s2cfg.vttb = STE_S2TTB(ste);
+
+    cfg->s2cfg.sl0 = STE_S2SL0(ste);
+    /* FEAT_TTST not supported. */
+    if (cfg->s2cfg.sl0 == 0x3) {
+        qemu_log_mask(LOG_UNIMP, "SMMUv3 S2SL0 = 0x3 has no meaning!\n");
+        goto bad_ste;
+    }
+
+    /* For AA64, The effective S2PS size is capped to the OAS. */
+    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
+    /*
+     * It is ILLEGAL for the address in S2TTB to be outside the range
+     * described by the effective S2PS value.
+     */
+    if (cfg->s2cfg.vttb & ~(MAKE_64BIT_MASK(0, cfg->s2cfg.eff_ps))) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 S2TTB too large 0x%lx, effective PS %d bits\n",
+                      cfg->s2cfg.vttb,  cfg->s2cfg.eff_ps);
+        goto bad_ste;
+    }
+
+    cfg->s2cfg.tsz = STE_S2T0SZ(ste);
+
+    if (!s2t0sz_valid(cfg)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 bad STE S2T0SZ = %d\n",
+                      cfg->s2cfg.tsz);
+        goto bad_ste;
+    }
+
+    if (!s2_pgtable_config_valid(cfg->s2cfg.sl0, cfg->s2cfg.tsz,
+                                    cfg->s2cfg.granule_sz)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 STE stage 2 config not valid!\n");
+        goto bad_ste;
+    }
+
+    /* Only LE supported(IDR0.TTENDIAN). */
+    if (STE_S2ENDI(ste)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "SMMUv3 STE_S2ENDI only supports LE!\n");
+        goto bad_ste;
+    }
+
+    cfg->s2cfg.affd = STE_S2AFFD(ste);
+
+    cfg->s2cfg.record_faults = STE_S2R(ste);
+    /* As stall is not supported. */
+    if (STE_S2S(ste)) {
+        qemu_log_mask(LOG_UNIMP, "SMMUv3 Stall not implemented!\n");
+        goto bad_ste;
+    }
+
+    /* This is still here as stage 2 has not been fully enabled yet. */
+    qemu_log_mask(LOG_UNIMP, "SMMUv3 does not support stage 2 yet\n");
+    goto bad_ste;
+
+    return 0;
+
+bad_ste:
+    return -EINVAL;
+}
+
 /* Returns < 0 in case of invalid STE, 0 otherwise */
 static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
                       STE *ste, SMMUEventInfo *event)
 {
     uint32_t config;
+    int ret;
 
     if (!STE_VALID(ste)) {
         if (!event->inval_ste_allowed) {
@@ -354,10 +487,38 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
         return 0;
     }
 
-    if (STE_CFG_S2_ENABLED(config)) {
-        qemu_log_mask(LOG_UNIMP, "SMMUv3 does not support stage 2 yet\n");
+    /*
+     * If a stage is enabled in SW while not advertised, throw bad ste
+     * according to user manual(IHI0070E) "5.2 Stream Table Entry".
+     */
+    if (!STAGE1_SUPPORTED(s) && STE_CFG_S1_ENABLED(config)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 S1 used but not supported.\n");
         goto bad_ste;
     }
+    if (!STAGE2_SUPPORTED(s) && STE_CFG_S2_ENABLED(config)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 S2 used but not supported.\n");
+        goto bad_ste;
+    }
+
+    if (STAGE2_SUPPORTED(s)) {
+        /* VMID is considered even if s2 is disabled. */
+        cfg->s2cfg.vmid = STE_S2VMID(ste);
+    } else {
+        /* Default to -1 */
+        cfg->s2cfg.vmid = -1;
+    }
+
+    if (STE_CFG_S2_ENABLED(config)) {
+        /*
+         * Stage-1 OAS defaults to OAS even if not enabled as it would be used
+         * in input address check for stage-2.
+         */
+        cfg->oas = oas2bits(SMMU_IDR5_OAS);
+        ret = decode_ste_s2_cfg(cfg, ste);
+        if (ret) {
+            goto bad_ste;
+        }
+    }
 
     if (STE_S1CDMAX(ste) != 0) {
         qemu_log_mask(LOG_UNIMP,
@@ -702,7 +863,13 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
     if (cached_entry) {
         if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
             status = SMMU_TRANS_ERROR;
-            if (cfg->record_faults) {
+            /*
+             * We know that the TLB only contains either stage-1 or stage-2 as
+             * nesting is not supported. So it is sufficient to check the
+             * translation stage to know the TLB stage for now.
+             */
+            event.u.f_walk_eabt.s2 = (cfg->stage == 2);
+            if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
                 event.u.f_permission.rnw = flag & 0x1;
@@ -728,28 +895,28 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
             event.u.f_walk_eabt.addr2 = ptw_info.addr;
             break;
         case SMMU_PTW_ERR_TRANSLATION:
-            if (cfg->record_faults) {
+            if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_TRANSLATION;
                 event.u.f_translation.addr = addr;
                 event.u.f_translation.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ADDR_SIZE:
-            if (cfg->record_faults) {
+            if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_ADDR_SIZE;
                 event.u.f_addr_size.addr = addr;
                 event.u.f_addr_size.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_ACCESS:
-            if (cfg->record_faults) {
+            if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_ACCESS;
                 event.u.f_access.addr = addr;
                 event.u.f_access.rnw = flag & 0x1;
             }
             break;
         case SMMU_PTW_ERR_PERMISSION:
-            if (cfg->record_faults) {
+            if (PTW_RECORD_FAULT(cfg)) {
                 event.type = SMMU_EVT_F_PERMISSION;
                 event.u.f_permission.addr = addr;
                 event.u.f_permission.rnw = flag & 0x1;
-- 
2.34.1


