Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC447E9100
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 14:40:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2AgG-0001aW-39; Sun, 12 Nov 2023 08:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r26g8-0001Ox-G2; Sun, 12 Nov 2023 04:22:52 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r26g6-0000Aa-Lf; Sun, 12 Nov 2023 04:22:52 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50930f126b1so4458636e87.3; 
 Sun, 12 Nov 2023 01:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699780967; x=1700385767; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dn8sFdrNh1zP2jVY+bjdGxxC7Y8WQQgSOU942meXeaw=;
 b=jopbjy85OFj0k7h0MmSJbYaeHuR51ehVgbd3aVzCOeWjuQpadrRKkVT1pG8+aZIdJu
 DI93IpxQGtzP2RtuY7S8L5alCehu/JLJ05Gd9B/IS+MPAftKPjVVa0KUMl/6kHxumEvE
 3TbWOOC1EbJf2QDs+s5UtmNbApFlAExSKkszan7lknJyVErVs8BmLk2axVkVONAQRoL7
 uoXZ4sEjtdY5tsZWw7E9yEmEFaQFoNX8MgsdS2YDarhLNNVSxs5SIaeomxrbnOnVBB5l
 rhXfAxsGKXE9oziqtMlMCjngAxjXvR1LB27eFSrF9PurcaPPzsh1mJHY1ojxhOCo3JZ0
 cYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699780967; x=1700385767;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dn8sFdrNh1zP2jVY+bjdGxxC7Y8WQQgSOU942meXeaw=;
 b=kH8kaM4urJS90tMRfWvNb/yXd3BShikZbOiSnL49MUG4dbQQN14wxGUHAnxEqxKssg
 2ufUKkcmbyxiQ5tGy6FGXWlSKk3iKXR5XOv1ZVEPpBOm05FmD3DaeaTEVuR986ENsLJE
 h8jx5zH8RpYiIUjpIyDtHeCwH0VAls6+WaDmVdejxZsSW1SfnMAM8QccAIVMzlP0GJX4
 aRC6I2fJKrV+1ozcBTX2T5DnsRhLQFKy16rySvmNDY2c3o30po+9W3w4CRy59m5B25Y1
 yX36JxkdUaOJXORlXb0q5NM5tuUxLw3gExM8YEA23RYxM9wZsdjsrHakAskc3FaZIl0q
 f5sQ==
X-Gm-Message-State: AOJu0Yw8H0VKpVS/3Bqf+WPyiLvpJUcL2EeFJ6+PfWEsIu1xxVLZ/1B/
 bXQQo+ivKF6dqxyVaggbTVy7oW3n9HgpgRKz
X-Google-Smtp-Source: AGHT+IE7RkDl+SuxOBBRzhfFlPy8f/wz5ZY3NejUBYjbRbZrKO8qrEZ4EUhwT7BqGdKd6xbhIG9+yA==
X-Received: by 2002:a05:6512:3d24:b0:509:8f66:2617 with SMTP id
 d36-20020a0565123d2400b005098f662617mr2968603lfv.42.1699780966748; 
 Sun, 12 Nov 2023 01:22:46 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 e26-20020ac2547a000000b005042ae2baf8sm557371lfn.258.2023.11.12.01.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 01:22:46 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH] fsl-imx: Add simple RTC emulation for i.MX6 and i.MX7 boards
Date: Sun, 12 Nov 2023 09:22:32 +0000
Message-Id: <20231112092232.131-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 12 Nov 2023 08:39:14 -0500
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

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 hw/misc/imx7_snvs.c         | 59 ++++++++++++++++++++++++++++++++-----
 hw/misc/trace-events        |  4 +--
 include/hw/misc/imx7_snvs.h | 14 ++++++++-
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index a245f96cd4..7ef3e4901a 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -13,29 +13,74 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/timer.h"
 #include "hw/misc/imx7_snvs.h"
 #include "qemu/module.h"
+#include "sysemu/sysemu.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 
+#define RTC_FREQ    32768ULL
+
+static uint64_t imx7_snvs_get_count(IMX7SNVSState *s)
+{
+    int64_t now_ms = qemu_clock_get_ns(rtc_clock) / 1000000;
+    return s->tick_offset + now_ms * RTC_FREQ / 1000;
+}
+
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
 {
-    trace_imx7_snvs_read(offset, 0);
+    IMX7SNVSState *s = opaque;
+    uint64_t ret = 0;
+
+    switch (offset) {
+    case SNVS_LPSRTCMR:
+        ret = (imx7_snvs_get_count(s) >> 32) & 0x7fffU;
+        break;
+    case SNVS_LPSRTCLR:
+        ret = imx7_snvs_get_count(s) & 0xffffffffU;
+        break;
+    case SNVS_LPCR:
+        ret = s->lpcr;
+        break;
+    }
+
+    trace_imx7_snvs_read(offset, ret, size);
 
-    return 0;
+    return ret;
 }
 
 static void imx7_snvs_write(void *opaque, hwaddr offset,
                             uint64_t v, unsigned size)
 {
-    const uint32_t value = v;
-    const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
+    trace_imx7_snvs_write(offset, v, size);
 
-    trace_imx7_snvs_write(offset, value);
+    IMX7SNVSState *s = opaque;
 
-    if (offset == SNVS_LPCR && ((value & mask) == mask)) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    uint64_t new_value = 0;
+
+    switch (offset) {
+    case SNVS_LPSRTCMR:
+        new_value = (imx7_snvs_get_count(s) & 0xffffffffU) | (v << 32);
+        break;
+    case SNVS_LPSRTCLR:
+        new_value = (imx7_snvs_get_count(s) & 0x7fff00000000ULL) | v;
+        break;
+    case SNVS_LPCR: {
+        s->lpcr = v;
+
+        const uint32_t value = v;
+        const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
+
+        if ((value & mask) == mask)
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+
+        break;
+    }
     }
+
+    if (offset == SNVS_LPSRTCMR || offset == SNVS_LPSRTCLR)
+        s->tick_offset += new_value - imx7_snvs_get_count(s);
 }
 
 static const struct MemoryRegionOps imx7_snvs_ops = {
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 05ff692441..85725506bf 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -116,8 +116,8 @@ imx7_gpr_read(uint64_t offset) "addr 0x%08" PRIx64
 imx7_gpr_write(uint64_t offset, uint64_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx64
 
 # imx7_snvs.c
-imx7_snvs_read(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
-imx7_snvs_write(uint64_t offset, uint32_t value) "addr 0x%08" PRIx64 "value 0x%08" PRIx32
+imx7_snvs_read(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS read: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
+imx7_snvs_write(uint64_t offset, uint64_t value, unsigned size) "i.MX SNVS write: offset 0x%08" PRIx64 " value 0x%08" PRIx64 " size %u"
 
 # mos6522.c
 mos6522_set_counter(int index, unsigned int val) "T%d.counter=%d"
diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
index 14a1d6fe6b..406c1fe97f 100644
--- a/include/hw/misc/imx7_snvs.h
+++ b/include/hw/misc/imx7_snvs.h
@@ -20,7 +20,9 @@
 enum IMX7SNVSRegisters {
     SNVS_LPCR = 0x38,
     SNVS_LPCR_TOP   = BIT(6),
-    SNVS_LPCR_DP_EN = BIT(5)
+    SNVS_LPCR_DP_EN = BIT(5),
+    SNVS_LPSRTCMR = 0x050, /* Secure Real Time Counter MSB Register */
+    SNVS_LPSRTCLR = 0x054, /* Secure Real Time Counter LSB Register */
 };
 
 #define TYPE_IMX7_SNVS "imx7.snvs"
@@ -31,6 +33,16 @@ struct IMX7SNVSState {
     SysBusDevice parent_obj;
 
     MemoryRegion mmio;
+
+    /*
+     * Needed to preserve the tick_count across migration, even if the
+     * absolute value of the rtc_clock is different on the source and
+     * destination.
+     */
+    int64_t tick_offset_vmstate;
+    int64_t tick_offset;
+
+    uint64_t lpcr;
 };
 
 #endif /* IMX7_SNVS_H */
-- 
2.34.1


