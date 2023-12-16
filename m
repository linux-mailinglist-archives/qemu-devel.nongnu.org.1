Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A97815957
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 14:35:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEUoF-00058j-9A; Sat, 16 Dec 2023 08:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rEUoD-00058P-FS; Sat, 16 Dec 2023 08:34:25 -0500
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rEUoB-0001Me-LV; Sat, 16 Dec 2023 08:34:25 -0500
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2cc55698c81so11649411fa.0; 
 Sat, 16 Dec 2023 05:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702733661; x=1703338461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O2W0QElYAQhNmIc/YNz8sr3wa9RFaZ0en5zM9fmC/mo=;
 b=NG4caEATqeL3j8WpEYJxVi4vwwqoI1T1KSMFT5TucrXjinpzzo1xw69gnSjVGWVXq4
 6i7eZiHHcMeQ05p3hc4NjIHvRaXqQpgDa4mLAz4ETnacum3OnyN3KWdlR5anuYw2B4dn
 aV3EcauPyK2D0gBdmYfR4yUZQBH2ho/tIYYur/ehsdGAAS1pjdHAroWegR4t+2xhlsN8
 x3DfUHlponu6C3GyasG9RTOwYEOWmHJx+NB4dsWGPv/VTfS/pB6OL2c8jo75qyu33TDY
 MOvbPYjb3jVvqndGa2GU8ZNvqq8OqMBaPjKDICMYVg4D20RhDKJeMohKIt0oCdBcieic
 DbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702733661; x=1703338461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O2W0QElYAQhNmIc/YNz8sr3wa9RFaZ0en5zM9fmC/mo=;
 b=X/7EThnME69ioLTNfr07o9kCuDyyaBcVQPnK7KV4dY5L7w6/3OlE2VwdazsSqip4yq
 ekjaAEa6KxuOhElKX7yFuJuEKr9geiLoYpaeU9Icd2iwXZq5rHo+y505iIToYzNdPAb7
 MzC+dLu+haBOxp2aKR0m4Mi1TmV+PaVxmSwBIYSbs8P/e6/MLMngM76vnzKEWUxqIyzX
 T6j9gaD4A+ldDDdK184k8fH3XPpsRkx7tEI3IWmftUxnLhAuhSMdz0reRRdEprD45wwm
 EbNUaVDgXAWojUhL4Nbo5zYW69KaL9KSL839X3UaQ3pAyYkI5MW7ftJxbP79CdIYp8Ym
 R7gw==
X-Gm-Message-State: AOJu0Yx6JotWB4ue5dd086yuCsAe/92uF9g0glZtVDYuRgIBDg49nTuo
 iBQvVcrHLnrz7KQiwFRBVs4FLlRyA1kb833aDZE=
X-Google-Smtp-Source: AGHT+IE98a4NfgLzNIIymnDsJW/KJ4teiiqcbHKDX33TOq/0CzbdK+XNs++n0tzM5PtkyK5+YXvc9w==
X-Received: by 2002:a2e:22c4:0:b0:2cc:2853:fb82 with SMTP id
 i187-20020a2e22c4000000b002cc2853fb82mr4490859lji.58.1702733660746; 
 Sat, 16 Dec 2023 05:34:20 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 cy20-20020a2e9a14000000b002cc4ab0c174sm530021ljb.81.2023.12.16.05.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 05:34:20 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v5] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
Date: Sat, 16 Dec 2023 13:34:08 +0000
Message-Id: <20231216133408.2884-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lj1-x22d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 hw/misc/imx7_snvs.c         | 93 ++++++++++++++++++++++++++++++++++---
 hw/misc/trace-events        |  4 +-
 include/hw/misc/imx7_snvs.h |  7 ++-
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index a245f96cd4..8e7f43187f 100644
--- a/hw/misc/imx7_snvs.c
+++ b/hw/misc/imx7_snvs.c
@@ -13,28 +13,100 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bitops.h"
+#include "qemu/timer.h"
+#include "migration/vmstate.h"
 #include "hw/misc/imx7_snvs.h"
+#include "qemu/cutils.h"
 #include "qemu/module.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/rtc.h"
 #include "sysemu/runstate.h"
 #include "trace.h"
 
+#define RTC_FREQ    32768ULL
+
+static const VMStateDescription vmstate_imx7_snvs = {
+    .name = TYPE_IMX7_SNVS,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(tick_offset, IMX7SNVSState),
+        VMSTATE_UINT64(lpcr, IMX7SNVSState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static uint64_t imx7_snvs_get_count(IMX7SNVSState *s)
+{
+    uint64_t ticks = muldiv64(qemu_clock_get_ns(rtc_clock), RTC_FREQ,
+                              NANOSECONDS_PER_SECOND);
+    return s->tick_offset + ticks;
+}
+
 static uint64_t imx7_snvs_read(void *opaque, hwaddr offset, unsigned size)
 {
-    trace_imx7_snvs_read(offset, 0);
+    IMX7SNVSState *s = IMX7_SNVS(opaque);
+    uint64_t ret = 0;
+
+    switch (offset) {
+    case SNVS_LPSRTCMR:
+        ret = extract64(imx7_snvs_get_count(s), 32, 15);
+        break;
+    case SNVS_LPSRTCLR:
+        ret = extract64(imx7_snvs_get_count(s), 0, 32);
+        break;
+    case SNVS_LPCR:
+        ret = s->lpcr;
+        break;
+    }
 
-    return 0;
+    trace_imx7_snvs_read(offset, ret, size);
+
+    return ret;
+}
+
+static void imx7_snvs_reset(DeviceState *dev)
+{
+    IMX7SNVSState *s = IMX7_SNVS(dev);
+
+    s->lpcr = 0;
 }
 
 static void imx7_snvs_write(void *opaque, hwaddr offset,
                             uint64_t v, unsigned size)
 {
-    const uint32_t value = v;
-    const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
+    trace_imx7_snvs_write(offset, v, size);
+
+    IMX7SNVSState *s = IMX7_SNVS(opaque);
 
-    trace_imx7_snvs_write(offset, value);
+    uint64_t new_value = 0, snvs_count = 0;
 
-    if (offset == SNVS_LPCR && ((value & mask) == mask)) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    if (offset == SNVS_LPSRTCMR || offset == SNVS_LPSRTCLR) {
+        snvs_count = imx7_snvs_get_count(s);
+    }
+
+    switch (offset) {
+    case SNVS_LPSRTCMR:
+        new_value = deposit64(snvs_count, 32, 32, v);
+        break;
+    case SNVS_LPSRTCLR:
+        new_value = deposit64(snvs_count, 0, 32, v);
+        break;
+    case SNVS_LPCR: {
+        s->lpcr = v;
+
+        const uint32_t mask  = SNVS_LPCR_TOP | SNVS_LPCR_DP_EN;
+
+        if ((v & mask) == mask) {
+            qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+        }
+        break;
+    }
+    }
+
+    if (offset == SNVS_LPSRTCMR || offset == SNVS_LPSRTCLR) {
+        s->tick_offset += new_value - snvs_count;
     }
 }
 
@@ -59,17 +131,24 @@ static void imx7_snvs_init(Object *obj)
 {
     SysBusDevice *sd = SYS_BUS_DEVICE(obj);
     IMX7SNVSState *s = IMX7_SNVS(obj);
+    struct tm tm;
 
     memory_region_init_io(&s->mmio, obj, &imx7_snvs_ops, s,
                           TYPE_IMX7_SNVS, 0x1000);
 
     sysbus_init_mmio(sd, &s->mmio);
+
+    qemu_get_timedate(&tm, 0);
+    s->tick_offset = mktimegm(&tm) -
+        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
 }
 
 static void imx7_snvs_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
+    dc->reset = imx7_snvs_reset;
+    dc->vmsd = &vmstate_imx7_snvs;
     dc->desc  = "i.MX7 Secure Non-Volatile Storage Module";
 }
 
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
index 14a1d6fe6b..1272076086 100644
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
@@ -31,6 +33,9 @@ struct IMX7SNVSState {
     SysBusDevice parent_obj;
 
     MemoryRegion mmio;
+
+    uint64_t tick_offset;
+    uint64_t lpcr;
 };
 
 #endif /* IMX7_SNVS_H */
-- 
2.34.1


