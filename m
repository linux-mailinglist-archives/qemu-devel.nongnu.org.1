Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC05B1C986
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Aug 2025 18:00:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujgYE-0006wd-QR; Wed, 06 Aug 2025 11:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpe-00012c-Lg; Wed, 06 Aug 2025 11:13:39 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1ujfpW-0006EJ-4h; Wed, 06 Aug 2025 11:13:29 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD3_NQScZNonSnWBA--.59S2;
 Wed, 06 Aug 2025 23:13:22 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwCXIQnfcJNos_oJAA--.14849S9;
 Wed, 06 Aug 2025 23:13:21 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 06/11] hw/arm/smmuv3: Plumb security state through core functions
Date: Wed,  6 Aug 2025 23:11:29 +0800
Message-Id: <20250806151134.365755-7-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
References: <20250806151134.365755-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCXIQnfcJNos_oJAA--.14849S9
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAOBWiSXH8HKAAAs8
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvAXoWfZw17tF18Aw4fGFy7tFy8AFb_yoW8uFyrZo
 W8Kw4jqw45Ww43uFyqvr18Kay2vrn5Ww45Xw4Yqr4a93Z3Za45AFy8KanxXFs0gr45ur97
 Cr93A348ZFyDAF95n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
 J3UbIjqfuFe4nvWSU8nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UU
 UUUUUUU==
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 06 Aug 2025 11:27:14 -0400
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

To support parallel processing of secure and non-secure streams, the
SMMUv3 model needs to differentiate between the two contexts throughout
its core logic. This commit is the foundational step to make the code
security-state aware.

An is_secure flag, which will be used in subsequent patches to represent
the transaction's security state, is now plumbed through the main
processing paths.

This change is purely preparatory and introduces no functional changes
for the existing non-secure path. All current call sites are updated
to pass is_secure = false.

This refactoring paves the way for upcoming patches that will introduce
separate TLB entries for secure transactions and enable a fully
parallel secure/non-secure SMMU model.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         |  11 ++-
 hw/arm/smmuv3-internal.h     |  16 +++-
 hw/arm/smmuv3.c              | 160 ++++++++++++++++++++++++-----------
 hw/arm/trace-events          |   2 +-
 include/hw/arm/smmu-common.h |   1 +
 include/hw/arm/smmuv3.h      |   4 +
 6 files changed, 138 insertions(+), 56 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0dcaf2f589..28d6d1bc7f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -332,13 +332,16 @@ void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
  * @base_addr[@index]
  */
 static int get_pte(dma_addr_t baseaddr, uint32_t index, uint64_t *pte,
-                   SMMUPTWEventInfo *info)
+                   SMMUPTWEventInfo *info, bool is_secure)
 {
     int ret;
     dma_addr_t addr = baseaddr + index * sizeof(*pte);
+    MemTxAttrs attrs = is_secure ?
+        (MemTxAttrs) { .secure = 1 } :
+        (MemTxAttrs) { .unspecified = true };
 
     /* TODO: guarantee 64-bit single-copy atomicity */
-    ret = ldq_le_dma(&address_space_memory, addr, pte, MEMTXATTRS_UNSPECIFIED);
+    ret = ldq_le_dma(&address_space_memory, addr, pte, attrs);
 
     if (ret != MEMTX_OK) {
         info->type = SMMU_PTW_ERR_WALK_EABT;
@@ -485,7 +488,7 @@ static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        if (get_pte(baseaddr, offset, &pte, info, cfg->secure)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, iova, subpage_size,
@@ -621,7 +624,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
         dma_addr_t pte_addr = baseaddr + offset * sizeof(pte);
         uint8_t s2ap;
 
-        if (get_pte(baseaddr, offset, &pte, info)) {
+        if (get_pte(baseaddr, offset, &pte, info, cfg->secure)) {
                 goto error;
         }
         trace_smmu_ptw_level(stage, level, ipa, subpage_size,
diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 720d21652c..852186cea4 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -243,9 +243,13 @@ REG64(S_EVENTQ_IRQ_CFG0,    0x80b0)
 REG32(S_EVENTQ_IRQ_CFG1,    0x80b8)
 REG32(S_EVENTQ_IRQ_CFG2,    0x80bc)
 
-static inline int smmu_enabled(SMMUv3State *s)
+static inline int smmu_enabled(SMMUv3State *s, bool is_secure)
 {
-    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
+    if (is_secure) {
+        return FIELD_EX32(s->secure_cr[0], S_CR0, SMMUEN);
+    } else {
+        return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
+    }
 }
 
 /* Command Queue Entry */
@@ -661,6 +665,10 @@ typedef struct CD {
 #define STE_S2S(x)         extract32((x)->word[5], 25, 1)
 #define STE_S2R(x)         extract32((x)->word[5], 26, 1)
 
+#define STE_S_S2T0SZ(x)      extract32((x)->word[9], 0 , 6)
+#define STE_S_S2SL0(x)       extract32((x)->word[9], 6 , 2)
+#define STE_S_S2TG(x)        extract32((x)->word[9], 14, 2)
+
 #define STE_CTXPTR(x)                                   \
     ((extract64((x)->word[1], 0, 16) << 32) |           \
      ((x)->word[0] & 0xffffffc0))
@@ -669,6 +677,10 @@ typedef struct CD {
     ((extract64((x)->word[7], 0, 16) << 32) |           \
      ((x)->word[6] & 0xfffffff0))
 
+#define STE_S_S2TTB(x)                                  \
+    ((extract64((x)->word[13], 0, 16) << 32) |          \
+     ((x)->word[12] & 0xfffffff0))
+
 static inline int oas2bits(int oas_field)
 {
     switch (oas_field) {
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 1f05cc983b..bcf06679e1 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -354,14 +354,14 @@ static void smmuv3_init_regs(SMMUv3State *s)
 }
 
 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
-                        SMMUEventInfo *event)
+                        SMMUEventInfo *event, MemTxAttrs attrs)
 {
     int ret, i;
 
     trace_smmuv3_get_ste(addr);
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          MEMTXATTRS_UNSPECIFIED);
+                          attrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -390,6 +390,9 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
     int ret, i;
     SMMUTranslationStatus status;
     SMMUTLBEntry *entry;
+    MemTxAttrs attrs = cfg->secure ?
+        (MemTxAttrs) { .secure = 1 } :
+        (MemTxAttrs) { .unspecified = true };
 
     trace_smmuv3_get_cd(addr);
 
@@ -407,7 +410,7 @@ static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
 
     /* TODO: guarantee 64-bit single-copy atomicity */
     ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
-                          MEMTXATTRS_UNSPECIFIED);
+                          attrs);
     if (ret != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "Cannot fetch pte at address=0x%"PRIx64"\n", addr);
@@ -472,7 +475,8 @@ static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
         g_assert_not_reached();
     }
 
-    switch (STE_S2TG(ste)) {
+    uint32_t s2tg = cfg->secure ? STE_S_S2TG(ste) : STE_S2TG(ste);
+    switch (s2tg) {
     case 0x0: /* 4KB */
         cfg->s2cfg.granule_sz = 12;
         break;
@@ -484,13 +488,13 @@ static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "SMMUv3 bad STE S2TG: %x\n", STE_S2TG(ste));
+                      "SMMUv3 bad STE S2TG: %x\n", s2tg);
         goto bad_ste;
     }
 
-    cfg->s2cfg.vttb = STE_S2TTB(ste);
+    cfg->s2cfg.vttb = cfg->secure ? STE_S_S2TTB(ste) : STE_S2TTB(ste);
 
-    cfg->s2cfg.sl0 = STE_S2SL0(ste);
+    cfg->s2cfg.sl0 = cfg->secure ? STE_S_S2SL0(ste) : STE_S2SL0(ste);
     /* FEAT_TTST not supported. */
     if (cfg->s2cfg.sl0 == 0x3) {
         qemu_log_mask(LOG_UNIMP, "SMMUv3 S2SL0 = 0x3 has no meaning!\n");
@@ -519,7 +523,7 @@ static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
         goto bad_ste;
     }
 
-    cfg->s2cfg.tsz = STE_S2T0SZ(ste);
+    cfg->s2cfg.tsz = cfg->secure ? STE_S_S2T0SZ(ste) : STE_S2T0SZ(ste);
 
     if (!s2t0sz_valid(cfg)) {
         qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 bad STE S2T0SZ = %d\n",
@@ -599,21 +603,52 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
     if (cfg->aborted || cfg->bypassed) {
         return 0;
     }
+    bool is_secure = cfg->secure;
 
     /*
      * If a stage is enabled in SW while not advertised, throw bad ste
      * according to user manual(IHI0070E) "5.2 Stream Table Entry".
      */
-    if (!STAGE1_SUPPORTED(s) && STE_CFG_S1_ENABLED(config)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 S1 used but not supported.\n");
-        goto bad_ste;
-    }
-    if (!STAGE2_SUPPORTED(s) && STE_CFG_S2_ENABLED(config)) {
-        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 S2 used but not supported.\n");
-        goto bad_ste;
+    if (!is_secure) {
+        if (!STAGE1_SUPPORTED(s) && STE_CFG_S1_ENABLED(config)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "SMMUv3 S1 used but not supported.\n");
+            goto bad_ste;
+        }
+        if (!STAGE2_SUPPORTED(s) && STE_CFG_S2_ENABLED(config)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "SMMUv3 S2 used but not supported.\n");
+            goto bad_ste;
+        }
+    } else {
+        /*
+         * As described in user manual(IHI0070G.b) "3.10.2 Support for Secure
+         * state" , the SMMU supports stage 1 translation and might support
+         * stage 2 translation.
+         */
+        if (!SECURE_IMPLEMENTED(s) && STE_CFG_S1_ENABLED(config)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                "SMMUv3 S1 used but not supported in secure state.\n");
+            goto bad_ste;
+        }
+
+        /*
+         * IHI0070G.b "6.3.53 SMMU_S_IDR1": SEL2 == 0 if SMMU_IDR0.S1P == 0 or
+         * if SMMU_IDR0.S2P == 0.
+         */
+        if (STE_CFG_S2_ENABLED(config)) {
+            if (!SECURE_S2_SUPPORTED(s) ||
+                (SECURE_S2_SUPPORTED(s) &&
+                (!STAGE1_SUPPORTED(s) || !STAGE2_SUPPORTED(s)))) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                    "SMMUv3 S2 used but not supported in secure state.\n");
+                goto bad_ste;
+            }
+        }
     }
 
-    if (STAGE2_SUPPORTED(s)) {
+    if ((!is_secure && STAGE2_SUPPORTED(s)) ||
+        (is_secure && SECURE_S2_SUPPORTED(s))) {
         /* VMID is considered even if s2 is disabled. */
         cfg->s2cfg.vmid = STE_S2VMID(ste);
     } else {
@@ -659,20 +694,29 @@ bad_ste:
  * @sid: stream ID
  * @ste: returned stream table entry
  * @event: handle to an event info
+ * @is_secure: true if the translation is for a secure domain
  *
  * Supports linear and 2-level stream table
  * Return 0 on success, -EINVAL otherwise
  */
 static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
-                         SMMUEventInfo *event)
+                         SMMUEventInfo *event, bool is_secure)
 {
-    dma_addr_t addr, strtab_base;
+    dma_addr_t addr;
     uint32_t log2size;
     int strtab_size_shift;
     int ret;
+    uint32_t features = is_secure ? s->secure_features : s->features;
+    dma_addr_t strtab_base = is_secure ? s->secure_strtab_base : s->strtab_base;
+    uint8_t sid_split = is_secure ? s->secure_sid_split : s->sid_split;
+    MemTxAttrs attrs = is_secure ?
+        (MemTxAttrs) { .secure = 1 } :
+        (MemTxAttrs) { .unspecified = true };
 
-    trace_smmuv3_find_ste(sid, s->features, s->sid_split);
-    log2size = FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
+    trace_smmuv3_find_ste(sid, features, sid_split, is_secure);
+    log2size = is_secure
+        ? FIELD_EX32(s->secure_strtab_base_cfg, S_STRTAB_BASE_CFG, LOG2SIZE)
+        : FIELD_EX32(s->strtab_base_cfg, STRTAB_BASE_CFG, LOG2SIZE);
     /*
      * Check SID range against both guest-configured and implementation limits
      */
@@ -680,7 +724,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         event->type = SMMU_EVT_C_BAD_STREAMID;
         return -EINVAL;
     }
-    if (s->features & SMMU_FEATURE_2LVL_STE) {
+    if (features & SMMU_FEATURE_2LVL_STE) {
         int l1_ste_offset, l2_ste_offset, max_l2_ste, span, i;
         dma_addr_t l1ptr, l2ptr;
         STEDesc l1std;
@@ -689,15 +733,15 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
          * Align strtab base address to table size. For this purpose, assume it
          * is not bounded by SMMU_IDR1_SIDSIZE.
          */
-        strtab_size_shift = MAX(5, (int)log2size - s->sid_split - 1 + 3);
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_size_shift = MAX(5, (int)log2size - sid_split - 1 + 3);
+        strtab_base = strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
-        l1_ste_offset = sid >> s->sid_split;
-        l2_ste_offset = sid & ((1 << s->sid_split) - 1);
+        l1_ste_offset = sid >> sid_split;
+        l2_ste_offset = sid & ((1 << sid_split) - 1);
         l1ptr = (dma_addr_t)(strtab_base + l1_ste_offset * sizeof(l1std));
         /* TODO: guarantee 64-bit single-copy atomicity */
         ret = dma_memory_read(&address_space_memory, l1ptr, &l1std,
-                              sizeof(l1std), MEMTXATTRS_UNSPECIFIED);
+                              sizeof(l1std), attrs);
         if (ret != MEMTX_OK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "Could not read L1PTR at 0X%"PRIx64"\n", l1ptr);
@@ -722,7 +766,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         }
         max_l2_ste = (1 << span) - 1;
         l2ptr = l1std_l2ptr(&l1std);
-        trace_smmuv3_find_ste_2lvl(s->strtab_base, l1ptr, l1_ste_offset,
+        trace_smmuv3_find_ste_2lvl(strtab_base, l1ptr, l1_ste_offset,
                                    l2ptr, l2_ste_offset, max_l2_ste);
         if (l2_ste_offset > max_l2_ste) {
             qemu_log_mask(LOG_GUEST_ERROR,
@@ -734,12 +778,12 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
         addr = l2ptr + l2_ste_offset * sizeof(*ste);
     } else {
         strtab_size_shift = log2size + 5;
-        strtab_base = s->strtab_base & SMMU_BASE_ADDR_MASK &
+        strtab_base = strtab_base & SMMU_BASE_ADDR_MASK &
                       ~MAKE_64BIT_MASK(0, strtab_size_shift);
         addr = strtab_base + sid * sizeof(*ste);
     }
 
-    if (smmu_get_ste(s, addr, ste, event)) {
+    if (smmu_get_ste(s, addr, ste, event, attrs)) {
         return -EINVAL;
     }
 
@@ -868,7 +912,7 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
     /* ASID defaults to -1 (if s1 is not supported). */
     cfg->asid = -1;
 
-    ret = smmu_find_ste(s, sid, &ste, event);
+    ret = smmu_find_ste(s, sid, &ste, event, cfg->secure);
     if (ret) {
         return ret;
     }
@@ -897,12 +941,14 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  *
  * @sdev: SMMUDevice handle
  * @event: output event info
+ * @is_secure: true if the translation is for a secure domain
  *
  * The configuration cache contains data resulting from both STE and CD
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
  * by the SMMUDevice handle.
  */
-static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
+static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
+                                       bool is_secure)
 {
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
@@ -922,6 +968,7 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event)
                             100 * sdev->cfg_cache_hits /
                             (sdev->cfg_cache_hits + sdev->cfg_cache_misses));
         cfg = g_new0(SMMUTransCfg, 1);
+        cfg->secure = is_secure;
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
             g_hash_table_insert(bc->configs, sdev, cfg);
@@ -1103,19 +1150,25 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
         .perm = IOMMU_NONE,
     };
     SMMUTLBEntry *cached_entry = NULL;
+    /* We don't support secure translation for now */
+    bool is_secure = false;
 
     qemu_mutex_lock(&s->mutex);
 
-    if (!smmu_enabled(s)) {
-        if (FIELD_EX32(s->gbpa, GBPA, ABORT)) {
-            status = SMMU_TRANS_ABORT;
+    if (!smmu_enabled(s, is_secure)) {
+        bool abort_flag;
+
+        if (is_secure) {
+            abort_flag = FIELD_EX32(s->secure_gbpa, S_GBPA, ABORT);
         } else {
-            status = SMMU_TRANS_DISABLE;
+            abort_flag = FIELD_EX32(s->gbpa, GBPA, ABORT);
         }
+
+        status = abort_flag ? SMMU_TRANS_ABORT : SMMU_TRANS_DISABLE;
         goto epilogue;
     }
 
-    cfg = smmuv3_get_config(sdev, &event);
+    cfg = smmuv3_get_config(sdev, &event, is_secure);
     if (!cfg) {
         status = SMMU_TRANS_ERROR;
         goto epilogue;
@@ -1167,7 +1220,7 @@ epilogue:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s translation failed for iova=0x%"PRIx64" (%s)\n",
                       mr->parent_obj.name, addr, smmu_event_string(event.type));
-        smmuv3_record_event(s, &event, false);
+        smmuv3_record_event(s, &event, cfg->secure);
         break;
     }
 
@@ -1186,16 +1239,18 @@ epilogue:
  * @tg: translation granule (if communicated through range invalidation)
  * @num_pages: number of @granule sized pages (if tg != 0), otherwise 1
  * @stage: Which stage(1 or 2) is used
+ * @is_secure: true if the translation is for a secure domain
  */
 static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
                                IOMMUNotifier *n,
                                int asid, int vmid,
                                dma_addr_t iova, uint8_t tg,
-                               uint64_t num_pages, int stage)
+                               uint64_t num_pages, int stage,
+                               bool is_secure)
 {
     SMMUDevice *sdev = container_of(mr, SMMUDevice, iommu);
     SMMUEventInfo eventinfo = {.inval_ste_allowed = true};
-    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo);
+    SMMUTransCfg *cfg = smmuv3_get_config(sdev, &eventinfo, is_secure);
     IOMMUTLBEvent event;
     uint8_t granule;
 
@@ -1251,7 +1306,8 @@ static void smmuv3_notify_iova(IOMMUMemoryRegion *mr,
 /* invalidate an asid/vmid/iova range tuple in all mr's */
 static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                       dma_addr_t iova, uint8_t tg,
-                                      uint64_t num_pages, int stage)
+                                      uint64_t num_pages, int stage,
+                                      bool is_secure)
 {
     SMMUDevice *sdev;
 
@@ -1263,12 +1319,14 @@ static void smmuv3_inv_notifiers_iova(SMMUState *s, int asid, int vmid,
                                         iova, tg, num_pages, stage);
 
         IOMMU_NOTIFIER_FOREACH(n, mr) {
-            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg, num_pages, stage);
+            smmuv3_notify_iova(mr, n, asid, vmid, iova, tg,
+                               num_pages, stage, is_secure);
         }
     }
 }
 
-static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
+static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage,
+                               bool is_secure)
 {
     dma_addr_t end, addr = CMD_ADDR(cmd);
     uint8_t type = CMD_TYPE(cmd);
@@ -1284,7 +1342,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
     SMMUv3State *smmuv3 = ARM_SMMUV3(s);
 
     /* Only consider VMID if stage-2 is supported. */
-    if (STAGE2_SUPPORTED(smmuv3)) {
+    if (STAGE2_SUPPORTED(smmuv3) ||
+        (SECURE_IMPLEMENTED(smmuv3) && SECURE_S2_SUPPORTED(smmuv3))) {
         vmid = CMD_VMID(cmd);
     }
 
@@ -1294,7 +1353,7 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
 
     if (!tg) {
         trace_smmuv3_range_inval(vmid, asid, addr, tg, 1, ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, 1, stage, is_secure);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, 1, ttl);
         } else {
@@ -1317,7 +1376,8 @@ static void smmuv3_range_inval(SMMUState *s, Cmd *cmd, SMMUStage stage)
         num_pages = (mask + 1) >> granule;
         trace_smmuv3_range_inval(vmid, asid, addr, tg, num_pages,
                                  ttl, leaf, stage);
-        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg, num_pages, stage);
+        smmuv3_inv_notifiers_iova(s, asid, vmid, addr, tg,
+                                  num_pages, stage, is_secure);
         if (stage == SMMU_STAGE_1) {
             smmu_iotlb_inv_iova(s, asid, vmid, addr, tg, num_pages, ttl);
         } else {
@@ -1461,7 +1521,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
              * VMID is only matched when stage 2 is supported, otherwise set it
              * to -1 as the value used for stage-1 only VMIDs.
              */
-            if (STAGE2_SUPPORTED(s)) {
+            if (STAGE2_SUPPORTED(s) ||
+                (SECURE_IMPLEMENTED(s) && SECURE_S2_SUPPORTED(s))) {
                 vmid = CMD_VMID(&cmd);
             }
 
@@ -1483,7 +1544,8 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
              * If stage-2 is supported, invalidate for this VMID only, otherwise
              * invalidate the whole thing.
              */
-            if (STAGE2_SUPPORTED(s)) {
+            if (STAGE2_SUPPORTED(s) ||
+                (SECURE_IMPLEMENTED(s) && SECURE_S2_SUPPORTED(s))) {
                 vmid = CMD_VMID(&cmd);
                 trace_smmuv3_cmdq_tlbi_nh(vmid);
                 smmu_iotlb_inv_vmid_s1(bs, vmid);
@@ -1502,7 +1564,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
                 cmd_error = SMMU_CERROR_ILL;
                 break;
             }
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_1, false);
             break;
         case SMMU_CMD_TLBI_S12_VMALL:
         {
@@ -1527,7 +1589,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, bool is_secure)
              * As currently only either s1 or s2 are supported
              * we can reuse same function for s2.
              */
-            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
+            smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2, false);
             break;
         case SMMU_CMD_TLBI_EL3_ALL:
         case SMMU_CMD_TLBI_EL3_VA:
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 7bb0bd0cc5..92c87f0b9e 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -41,7 +41,7 @@ smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t
 smmuv3_cmdq_consume_error(const char *cmd_name, uint8_t cmd_error) "Error on %s command execution: %d"
 smmuv3_write_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
 smmuv3_record_event(const char *type, uint32_t sid, bool is_secure) "%s sid=0x%x is_secure=%d"
-smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split) "sid=0x%x features:0x%x, sid_split:0x%x"
+smmuv3_find_ste(uint16_t sid, uint32_t features, uint16_t sid_split, bool is_secure) "sid=0x%x features:0x%x, sid_split:0x%x is_secure=%d"
 smmuv3_find_ste_2lvl(uint64_t strtab_base, uint64_t l1ptr, int l1_ste_offset, uint64_t l2ptr, int l2_ste_offset, int max_l2_ste) "strtab_base:0x%"PRIx64" l1ptr:0x%"PRIx64" l1_off:0x%x, l2ptr:0x%"PRIx64" l2_off:0x%x max_l2_ste:%d"
 smmuv3_get_ste(uint64_t addr) "STE addr: 0x%"PRIx64
 smmuv3_translate_disable(const char *n, uint16_t sid, uint64_t addr, bool is_write) "%s sid=0x%x bypass (smmu disabled) iova:0x%"PRIx64" is_write=%d"
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index e5e2d09294..5d15a1212b 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -116,6 +116,7 @@ typedef struct SMMUTransCfg {
     SMMUTransTableInfo tt[2];
     /* Used by stage-2 only. */
     struct SMMUS2Cfg s2cfg;
+    bool secure;
 } SMMUTransCfg;
 
 typedef struct SMMUDevice {
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 72ad042514..43c7289a43 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -110,4 +110,8 @@ OBJECT_DECLARE_TYPE(SMMUv3State, SMMUv3Class, ARM_SMMUV3)
 #define STAGE1_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S1P)
 #define STAGE2_SUPPORTED(s)      FIELD_EX32(s->idr[0], IDR0, S2P)
 
+#define SECURE_IMPLEMENTED(s)  \
+    FIELD_DP32(s->secure_idr[1], S_IDR1, SECURE_IMPL, 1)
+#define SECURE_S2_SUPPORTED(s) \
+    FIELD_DP32(s->secure_idr[1], S_IDR1, SEL2, 1)
 #endif
-- 
2.34.1


