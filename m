Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61473BA2479
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 05:12:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yqM-0006pA-9U; Thu, 25 Sep 2025 23:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1yqF-0006iR-1W; Thu, 25 Sep 2025 23:09:51 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1yq3-0003jP-4l; Thu, 25 Sep 2025 23:09:50 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwAHD5flA9Zo5EE_CQ--.85S2;
 Fri, 26 Sep 2025 11:09:25 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXu+jKA9Zoee4gAA--.9761S5;
 Fri, 26 Sep 2025 11:09:25 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 14/14] hw/arm/smmuv3: Optional Secure bank migration via
 subsections
Date: Fri, 26 Sep 2025 11:08:31 +0800
Message-Id: <20250926030831.1067440-3-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXu+jKA9Zoee4gAA--.9761S5
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWjVmkcBowAAsD
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCF17uF4xuFy8JF18Gw45KFg_yoWruw4rpr
 s8G3Z8GryDGF4fZr4fJw4rCFs8CrWrGF4akrWDCa93ta1kJay2qrnFyFW8u3s5JrWjqa17
 uF1xuFZrJr47ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Resending patches 12–14/14 that were missing due to a send issue. Sorry
for the noise.

Introduce a generic vmstate_smmuv3_bank that serializes a single SMMUv3
bank (registers and queues). Add a 'smmuv3/bank_s' subsection guarded by
secure_impl and a new 'migrate-secure-bank' property; when enabled, the S
bank is migrated. Add a 'smmuv3/gbpa_secure' subsection which is only sent
when GBPA differs from its reset value.

This keeps the existing migration stream unchanged by default and remains
backward compatible: older QEMUs can ignore unknown subsections, and with
'migrate-secure-bank' defaulting to off, the stream is identical to before.

This also prepares for future RME extensions (Realm/Root) by reusing the
bank subsection pattern.

Usage:
  -global arm-smmuv3,secure-impl=on,migrate-secure-bank=on

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c         | 70 +++++++++++++++++++++++++++++++++++++++++
 include/hw/arm/smmuv3.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 80fbc25cf5..2a1e80d179 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2450,6 +2450,53 @@ static const VMStateDescription vmstate_smmuv3_queue = {
     },
 };

+static const VMStateDescription vmstate_smmuv3_bank = {
+    .name = "smmuv3_bank",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(features, SMMUv3RegBank),
+        VMSTATE_UINT8(sid_split, SMMUv3RegBank),
+        VMSTATE_UINT32_ARRAY(cr, SMMUv3RegBank, 3),
+        VMSTATE_UINT32(cr0ack, SMMUv3RegBank),
+        VMSTATE_UINT32(irq_ctrl, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror, SMMUv3RegBank),
+        VMSTATE_UINT32(gerrorn, SMMUv3RegBank),
+        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_UINT64(strtab_base, SMMUv3RegBank),
+        VMSTATE_UINT32(strtab_base_cfg, SMMUv3RegBank),
+        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3RegBank),
+        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3RegBank),
+        VMSTATE_STRUCT(cmdq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_STRUCT(eventq, SMMUv3RegBank, 0,
+                       vmstate_smmuv3_queue, SMMUQueue),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
+static bool smmuv3_secure_bank_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->secure_impl && s->migrate_secure_bank;
+}
+
+static const VMStateDescription vmstate_smmuv3_bank_s = {
+    .name = "smmuv3/bank_s",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_secure_bank_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_STRUCT(bank[SMMU_SEC_IDX_S], SMMUv3State, 0,
+                       vmstate_smmuv3_bank, SMMUv3RegBank),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static bool smmuv3_gbpa_needed(void *opaque)
 {
     SMMUv3State *s = opaque;
@@ -2469,6 +2516,25 @@ static const VMStateDescription vmstate_gbpa = {
     }
 };

+static bool smmuv3_gbpa_secure_needed(void *opaque)
+{
+    SMMUv3State *s = opaque;
+
+    return s->secure_impl && s->migrate_secure_bank &&
+           s->bank[SMMU_SEC_IDX_S].gbpa != SMMU_GBPA_RESET_VAL;
+}
+
+static const VMStateDescription vmstate_gbpa_secure = {
+    .name = "smmuv3/gbpa_secure",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = smmuv3_gbpa_secure_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(bank[SMMU_SEC_IDX_S].gbpa, SMMUv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_smmuv3 = {
     .name = "smmuv3",
     .version_id = 1,
@@ -2502,6 +2568,8 @@ static const VMStateDescription vmstate_smmuv3 = {
     },
     .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
+        &vmstate_smmuv3_bank_s,
+        &vmstate_gbpa_secure,
         NULL
     }
 };
@@ -2521,6 +2589,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to false (0)
      */
     DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
+    DEFINE_PROP_BOOL("migrate-secure-bank", SMMUv3State,
+                     migrate_secure_bank, false),
 };

 static void smmuv3_instance_init(Object *obj)
diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 572f15251e..5ffb609fa2 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -71,6 +71,7 @@ struct SMMUv3State {
     QemuMutex mutex;
     char *stage;
     bool secure_impl;
+    bool migrate_secure_bank;
 };

 typedef enum {
--
2.34.1


