Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DBEBA247F
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 05:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1yqB-0006VU-8Y; Thu, 25 Sep 2025 23:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1yq5-0006UR-Pq; Thu, 25 Sep 2025 23:09:41 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1v1ypw-0003jY-Le; Thu, 25 Sep 2025 23:09:41 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnbrbhA9ZowEE_CQ--.115S2;
 Fri, 26 Sep 2025 11:09:21 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwBXu+jKA9Zoee4gAA--.9761S4;
 Fri, 26 Sep 2025 11:09:11 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v2 13/14] hw/arm/smmuv3: Add property to enable Secure SMMU
 support
Date: Fri, 26 Sep 2025 11:08:30 +0800
Message-Id: <20250926030831.1067440-2-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
References: <20250925162618.191242-1-tangtao1634@phytium.com.cn>
 <20250926030831.1067440-1-tangtao1634@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXu+jKA9Zoee4gAA--.9761S4
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAFBWjVmkcBoQAAsB
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJrWkZw4xXryrXFW8Gry8Krg_yoW5JF43pF
 s3Ar15Kr45C3WfJ3y7Zr4xZay2v3yvq3ZxurW8G3Wru3WDAryDXr4vkr48GFZ8Xw1Fkayx
 WF409F48CF42vrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This commit completes the initial implementation of the Secure SMMUv3
model by making the feature user-configurable.

A new boolean property, "secure-impl", is introduced to the device.
This property defaults to false, ensuring backward compatibility for
existing machine types that do not expect the secure programming
interface.

When "secure-impl" is set to true, the smmuv3_init_regs function now
initializes the secure register bank (bank[SMMU_SEC_IDX_S]). Crucially,
the S_IDR1.SECURE_IMPL bit is set according to this property,
correctly advertising the presence of the secure functionality to the
guest.

This patch ties together all the previous refactoring work. With this
property enabled, the banked registers, security-aware queues, and
other secure features become active, allowing a guest to probe and
configure the Secure SMMU.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
---
 hw/arm/smmuv3.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c92cc0f06a..80fbc25cf5 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -351,6 +351,16 @@ static void smmuv3_init_regs(SMMUv3State *s)
     s->statusr = 0;
     s->bank[SMMU_SEC_IDX_NS].gbpa = SMMU_GBPA_RESET_VAL;

+    /* Initialize Secure bank (SMMU_SEC_IDX_S) */
+    memset(s->bank[SMMU_SEC_IDX_S].idr, 0, sizeof(s->bank[SMMU_SEC_IDX_S].idr));
+    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(s->bank[SMMU_SEC_IDX_S].idr[1],
+                                                S_IDR1, SECURE_IMPL,
+                                                s->secure_impl);
+    s->bank[SMMU_SEC_IDX_S].idr[1] = FIELD_DP32(
+        s->bank[SMMU_SEC_IDX_S].idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE);
+    s->bank[SMMU_SEC_IDX_S].gbpa = SMMU_GBPA_RESET_VAL;
+    s->bank[SMMU_SEC_IDX_S].cmdq.entry_size = sizeof(struct Cmd);
+    s->bank[SMMU_SEC_IDX_S].eventq.entry_size = sizeof(struct Evt);
 }

 static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
@@ -2505,6 +2515,12 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /*
+     * SECURE_IMPL field in S_IDR1 register.
+     * Indicates whether secure state is implemented.
+     * Defaults to false (0)
+     */
+    DEFINE_PROP_BOOL("secure-impl", SMMUv3State, secure_impl, false),
 };

 static void smmuv3_instance_init(Object *obj)
--
2.34.1


