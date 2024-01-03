Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9778230D8
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 16:55:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rL3Z8-0004MQ-PA; Wed, 03 Jan 2024 10:53:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z6-0004L3-6F; Wed, 03 Jan 2024 10:53:56 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1rL3Z2-00052B-Lc; Wed, 03 Jan 2024 10:53:55 -0500
Received: from buffy.. (buffy [192.168.147.6])
 by zoidberg.rfc1149.net (Postfix) with ESMTP id 6C83380026;
 Wed,  3 Jan 2024 16:53:43 +0100 (CET)
Authentication-Results: zoidberg.rfc1149.net;
 dmarc=fail (p=none dis=none) header.from=rfc1149.net
Authentication-Results: zoidberg.rfc1149.net;
 spf=fail smtp.mailfrom=rfc1149.net
From: Samuel Tardieu <sam@rfc1149.net>
To: qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Anton Kochkov <anton.kochkov@proton.me>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Alexandre Iooss <erdnaxe@crans.org>, Samuel Tardieu <sam@rfc1149.net>
Subject: [PATCH v2 1/3] hw/intc/armv7m_nvic: add "num-prio-bits" property
Date: Wed,  3 Jan 2024 16:53:35 +0100
Message-ID: <20240103155337.2026946-2-sam@rfc1149.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240103155337.2026946-1-sam@rfc1149.net>
References: <20240103155337.2026946-1-sam@rfc1149.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Cortex-M NVIC can have a different number of priority bits.
Cortex-M0/M0+/M1 devices must use 2 or more bits, while devices based
on ARMv7m and up must use 3 or more bits.

This adds a "num-prio-bits" property which will get sensible default
values if unset (2 or 8 depending on the device). Unless a SOC
specifies the number of bits to use, the previous behavior is
maintained for backward compatibility.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Suggested-by: Anton Kochkov <anton.kochkov@proton.me>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1122
---
 hw/intc/armv7m_nvic.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 942be7bd11..82aacd7f22 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -2572,6 +2572,11 @@ static const VMStateDescription vmstate_nvic = {
 static Property props_nvic[] = {
     /* Number of external IRQ lines (so excluding the 16 internal exceptions) */
     DEFINE_PROP_UINT32("num-irq", NVICState, num_irq, 64),
+    /*
+     * Number of the maximum priority bits that can be used. 0 means
+     * to use a reasonable default.
+     */
+    DEFINE_PROP_UINT8("num-prio-bits", NVICState, num_prio_bits, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
@@ -2685,7 +2690,23 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
     /* include space for internal exception vectors */
     s->num_irq += NVIC_FIRST_IRQ;
 
-    s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
+    if (s->num_prio_bits == 0) {
+        /*
+         * If left unspecified, use 2 bits by default on Cortex-M0/M0+/M1
+         * and 8 bits otherwise.
+         */
+        s->num_prio_bits = arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 8 : 2;
+    } else {
+        uint8_t min_prio_bits =
+            arm_feature(&s->cpu->env, ARM_FEATURE_V7) ? 3 : 2;
+        if (s->num_prio_bits < min_prio_bits || s->num_prio_bits > 8) {
+            error_setg(errp,
+                       "num-prio-bits %d is outside "
+                       "NVIC acceptable range [%d-8]",
+                       s->num_prio_bits, min_prio_bits);
+            return;
+        }
+    }
 
     /*
      * This device provides a single memory region which covers the
-- 
2.42.0


