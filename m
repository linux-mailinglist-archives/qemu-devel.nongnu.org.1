Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE361BD04A8
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Oct 2025 17:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7xfk-0001ic-Ng; Sun, 12 Oct 2025 11:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfS-0001ff-Pp; Sun, 12 Oct 2025 11:07:27 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v7xfN-0001cs-Rt; Sun, 12 Oct 2025 11:07:26 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDn75sfxOtouE6gAA--.5S2;
 Sun, 12 Oct 2025 23:07:11 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwDXPOoXxOto33dMAA--.3068S13;
 Sun, 12 Oct 2025 23:07:10 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC v3 10/21] hw/arm/smmu-common: Key configuration cache on
 SMMUDevice and SEC_SID
Date: Sun, 12 Oct 2025 23:06:50 +0800
Message-Id: <20251012150701.4127034-11-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
References: <20251012150701.4127034-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXPOoXxOto33dMAA--.3068S13
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQABBWjqskUBZAAAsV
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxKFW7GFWUZw47Zr4xXFWUArb_yoWxCw1kpr
 W8JF98Jr4UGF1fGFsxXFWI93Z8Wwn29r1fGryagr9YyFyqyryUAF4DK3yYk3s3CrW8JF47
 ZaySgFyUCr17JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adapt the configuration cache to support multiple security states by
introducing a composite key, SMMUConfigKey. This key combines the
SMMUDevice with SEC_SID, preventing aliasing between Secure and
Non-secure configurations for the same device, also the future Realm and
Root configurations.

The cache lookup, insertion, and invalidation mechanisms are updated
to use this new keying infrastructure. This change is critical for
ensuring correct translation when a device is active in more than one
security world.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmu-common.c         | 45 ++++++++++++++++++++++++++++++++++--
 hw/arm/smmuv3.c              | 13 +++++++----
 include/hw/arm/smmu-common.h |  7 ++++++
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 82308f0e33..5fabe30c75 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -30,6 +30,26 @@
 #include "hw/arm/smmu-common.h"
 #include "smmu-internal.h"
 
+/* Configuration Cache Management */
+static guint smmu_config_key_hash(gconstpointer key)
+{
+    const SMMUConfigKey *k = key;
+    return g_direct_hash(k->sdev) ^ (guint)k->sec_sid;
+}
+
+static gboolean smmu_config_key_equal(gconstpointer a, gconstpointer b)
+{
+    const SMMUConfigKey *ka = a;
+    const SMMUConfigKey *kb = b;
+    return ka->sdev == kb->sdev && ka->sec_sid == kb->sec_sid;
+}
+
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid)
+{
+    SMMUConfigKey key = {.sdev = sdev, .sec_sid = sec_sid};
+    return key;
+}
+
 ARMSecuritySpace smmu_get_security_space(SMMUSecSID sec_sid)
 {
     switch (sec_sid) {
@@ -256,7 +276,8 @@ static gboolean smmu_hash_remove_by_vmid_ipa(gpointer key, gpointer value,
 static gboolean
 smmu_hash_remove_by_sid_range(gpointer key, gpointer value, gpointer user_data)
 {
-    SMMUDevice *sdev = (SMMUDevice *)key;
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *sdev = config_key->sdev;
     uint32_t sid = smmu_get_sid(sdev);
     SMMUSIDRange *sid_range = (SMMUSIDRange *)user_data;
 
@@ -274,6 +295,24 @@ void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range)
                                 &sid_range);
 }
 
+static gboolean smmu_hash_remove_by_sdev(gpointer key, gpointer value,
+                                         gpointer user_data)
+{
+    SMMUConfigKey *config_key = (SMMUConfigKey *)key;
+    SMMUDevice *target = (SMMUDevice *)user_data;
+
+    if (config_key->sdev != target) {
+        return false;
+    }
+    trace_smmu_config_cache_inv(smmu_get_sid(target));
+    return true;
+}
+
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev)
+{
+    g_hash_table_foreach_remove(s->configs, smmu_hash_remove_by_sdev, sdev);
+}
+
 void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
                          uint8_t tg, uint64_t num_pages, uint8_t ttl)
 {
@@ -961,7 +1000,9 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-    s->configs = g_hash_table_new_full(NULL, NULL, NULL, g_free);
+    s->configs = g_hash_table_new_full(smmu_config_key_hash,
+                                       smmu_config_key_equal,
+                                       g_free, g_free);
     s->iotlb = g_hash_table_new_full(smmu_iotlb_key_hash, smmu_iotlb_key_equal,
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 351bbf1ae9..55f4ad1757 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -878,10 +878,11 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
  *
  * @sdev: SMMUDevice handle
  * @event: output event info
+ * @sec_sid: StreamID Security state
  *
  * The configuration cache contains data resulting from both STE and CD
  * decoding under the form of an SMMUTransCfg struct. The hash table is indexed
- * by the SMMUDevice handle.
+ * by a composite key of the SMMUDevice and the sec_sid.
  */
 static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
                                        SMMUSecSID sec_sid)
@@ -889,8 +890,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
     SMMUTransCfg *cfg;
+    SMMUConfigKey lookup_key = smmu_get_config_key(sdev, sec_sid);
 
-    cfg = g_hash_table_lookup(bc->configs, sdev);
+    cfg = g_hash_table_lookup(bc->configs, &lookup_key);
     if (cfg) {
         sdev->cfg_cache_hits++;
         trace_smmuv3_config_cache_hit(smmu_get_sid(sdev),
@@ -915,7 +917,9 @@ static SMMUTransCfg *smmuv3_get_config(SMMUDevice *sdev, SMMUEventInfo *event,
         }
 
         if (!smmuv3_decode_config(&sdev->iommu, cfg, event)) {
-            g_hash_table_insert(bc->configs, sdev, cfg);
+            SMMUConfigKey *persistent_key = g_new(SMMUConfigKey, 1);
+            *persistent_key = lookup_key;
+            g_hash_table_insert(bc->configs, persistent_key, cfg);
         } else {
             g_free(cfg);
             cfg = NULL;
@@ -929,8 +933,7 @@ static void smmuv3_flush_config(SMMUDevice *sdev)
     SMMUv3State *s = sdev->smmu;
     SMMUState *bc = &s->smmu_state;
 
-    trace_smmu_config_cache_inv(smmu_get_sid(sdev));
-    g_hash_table_remove(bc->configs, sdev);
+    smmu_configs_inv_sdev(bc, sdev);
 }
 
 /* Do translation with TLB lookup. */
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index c17c7db6e5..bccbbe0115 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -182,6 +182,11 @@ typedef struct SMMUIOTLBKey {
     uint8_t level;
 } SMMUIOTLBKey;
 
+typedef struct SMMUConfigKey {
+    SMMUDevice *sdev;
+    SMMUSecSID sec_sid;
+} SMMUConfigKey;
+
 typedef struct SMMUSIDRange {
     uint32_t start;
     uint32_t end;
@@ -257,6 +262,7 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
 void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
 SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
                                 uint8_t tg, uint8_t level);
+SMMUConfigKey smmu_get_config_key(SMMUDevice *sdev, SMMUSecSID sec_sid);
 void smmu_iotlb_inv_all(SMMUState *s);
 void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
 void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
@@ -266,6 +272,7 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
 void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
                         uint64_t num_pages, uint8_t ttl);
 void smmu_configs_inv_sid_range(SMMUState *s, SMMUSIDRange sid_range);
+void smmu_configs_inv_sdev(SMMUState *s, SMMUDevice *sdev);
 /* Unmap the range of all the notifiers registered to any IOMMU mr */
 void smmu_inv_notifiers_all(SMMUState *s);
 
-- 
2.34.1


