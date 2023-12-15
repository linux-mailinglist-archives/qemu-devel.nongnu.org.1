Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AB38149F6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 15:05:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rE8nF-0000OA-Kr; Fri, 15 Dec 2023 09:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rE8nD-0000Nx-15; Fri, 15 Dec 2023 09:03:55 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rE8n9-0005HJ-MM; Fri, 15 Dec 2023 09:03:54 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50bfd7be487so730049e87.0; 
 Fri, 15 Dec 2023 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702649028; x=1703253828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Og75nzJUqr7aY5MfzChuNtBluhG+w+ZvrmwaurIZwUs=;
 b=lYfz3e23ssjO8bK/loPBoNgAGHGhSWSTrlkDeuKZiVGzSBuVcPJ1oNs10cwtlZvxhk
 K7gwEgbf/kxtpTyksqi8ST1jO1lCJT8m/I3kzoOJT3tQcw5SlOLbyb7k2BabvYrPjOBf
 keo6M7rHaOU7Z60NEj2/NEZaKDcjfOVfNnJryaNsDbG3K/qrUW74OGNug+e1YMr35/7J
 VEDwUlTT9SVWQ293Uy5h3zFn8+9fFJid9x5BJS/kJJQ9BRyEpo548dKV+Cc96dAgEozE
 uv8R35xf3TX6LpM2z2lu74yQNj41eRVdx+IhWfFKK5XdZA8SAfbMNTrW4YdJslYOPHLI
 sq2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702649028; x=1703253828;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Og75nzJUqr7aY5MfzChuNtBluhG+w+ZvrmwaurIZwUs=;
 b=SfQrJnCastRsHZRtlFL0HgyYaEr9Prh/7gx2nbaMyf0zycFCIBGA6P1+wwEVcwCN0r
 D02Tgb0JMswa3Gxss8wLquVC0O1J0wf59Hao9J04PcaRXIdj7Ep7M4kU2LNdlKYGzNu8
 ak0OQrsdJO/u1NgB/UsMwEaT++1LJITs5Q7YBHItZXZr0Tikq5hDl5YuTCNa+dy6TYpC
 zOP/2DmvJGuwy06LH8aGdsAY803EFn28UI2v/KiaFjDgTKdt+AMnmciT4PXks0sWUykp
 1aUsburLHlqeZtyorFrgBvv+HzM8kOO5XKz9MnsHnjzpvOh3ZzkoknTzQ30Hohk/kBia
 OYXQ==
X-Gm-Message-State: AOJu0YzJFchkuS47PSrJf6kEYH1gyswsT27gKzsgduyydeYMwQrTqokW
 ZMyeebwrYvU+R+h9dR8XcUlQEcrXi+ZWIiNl8s0=
X-Google-Smtp-Source: AGHT+IGmcG4UBsx+o6l5hpR6Qy4GPqwruCWSZYrCpxzuZoqezrhjkyX94oSywDON38qAXS5jkUqKlg==
X-Received: by 2002:a05:6512:3d91:b0:50d:1479:f9db with SMTP id
 k17-20020a0565123d9100b0050d1479f9dbmr7274712lfv.98.1702649027627; 
 Fri, 15 Dec 2023 06:03:47 -0800 (PST)
Received: from vm579946.eurodir.ru ([95.142.42.61])
 by smtp.gmail.com with ESMTPSA id
 i10-20020a056512340a00b0050be8d89aefsm2153306lfr.309.2023.12.15.06.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 06:03:47 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v4] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
Date: Fri, 15 Dec 2023 17:03:46 +0300
Message-Id: <20231215140346.3858-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x132.google.com
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
index a245f96cd4..711879e326 100644
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
+    int64_t ticks = muldiv64(qemu_clock_get_ns(rtc_clock), RTC_FREQ,
+                             NANOSECONDS_PER_SECOND);
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


