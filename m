Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A68081909B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfXH-00025J-SE; Tue, 19 Dec 2023 14:13:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX7-00021v-1t
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:37 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfX3-0001tV-PF
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:36 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-336695c4317so2493984f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013210; x=1703618010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=00hMtN5BXevzRJATDfX8VsM5S59s6M4RCIFrJXcR5Q4=;
 b=Vsq/aVVNTCHQva6gR9auQnKoDCn9aG3HnjrDZu0KYSgFKresk5LsV6bPQQSztQfKPF
 NAAzHbG/2nBR0bDK/wZ+GjQeWaZVkCfVf5hepam4PylduNB9xfDW0aieUDKkSdPFluvE
 NFQ+2jHmLxJ+M6L2crkSjxwNi63fms77N7YNdHyJqVsjwnE7X21QKqN53cnHmiXeqNId
 wIX9RwdOlmJ1Tf5PxYTxKZMZGiIl1y6+pp1kUKquv/7DuR6P+/so5Q9PFVkNAY/W/9s6
 0Jan7+PnigMJ+hnnL5O1+GzkzlTxCbLfEMo3E/SPmiXwE4hW+eIfVlO6LWryEUV9sWFI
 a2ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013210; x=1703618010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00hMtN5BXevzRJATDfX8VsM5S59s6M4RCIFrJXcR5Q4=;
 b=Sx4VY/MndMo1AFeee9OpHDAIcMEVE5eTbSLk1Pp786XoEQ/Y78jAnPrMYhwq85yXCc
 21NnR1P8vjRbHi2DMtof0UwstGYmnhiCvuZurlKAzHaJxJYYi2r3PSTmVYmyvf8/kms6
 QDw933/cXzIYHQPKZlHCiDR5uia3Gy0UwbNcHe3m8ll3SyU5uOmPxcs6NI06YtZDMGiM
 0O3+ufFrG4kd8p7h15wvvwLI2bbEyTb9zTzlO7O6FOMBW4lnbG/bPXknL+ROklucVf7P
 jzx/ITKbDqANchBwkKK63S/1hZzujY9FX6TNtNSmNJMBZtKxS3arIFVsagPmrhwbPCol
 hPiQ==
X-Gm-Message-State: AOJu0YyOvzca/iEO777LhHcsj6d048aISb8Qb7kM/WfBjO+fZ7KWbbGS
 Rn+sRW0Ynm+yN4mvkKnpkq6FBC7JQNB5X3v6EmY=
X-Google-Smtp-Source: AGHT+IEzdu85niLBI3wOTcYpG8eSBTBLsosNLrM4zK6Jyw39MB0DOnkarqgkqLOJW8+xzJ6pqnuQsg==
X-Received: by 2002:a05:6000:506:b0:333:6cf:2b5 with SMTP id
 a6-20020a056000050600b0033306cf02b5mr9921171wrf.46.1703013209869; 
 Tue, 19 Dec 2023 11:13:29 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 43/43] fsl-imx: add simple RTC emulation for i.MX6 and i.MX7
 boards
Date: Tue, 19 Dec 2023 19:13:07 +0000
Message-Id: <20231219191307.2895919-44-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Nikita Ostrenkov <n.ostrenkov@gmail.com>

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Message-id: 20231216133408.2884-1-n.ostrenkov@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/imx7_snvs.h |  7 ++-
 hw/misc/imx7_snvs.c         | 93 ++++++++++++++++++++++++++++++++++---
 hw/misc/trace-events        |  4 +-
 3 files changed, 94 insertions(+), 10 deletions(-)

diff --git a/include/hw/misc/imx7_snvs.h b/include/hw/misc/imx7_snvs.h
index 14a1d6fe6b0..1272076086a 100644
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
diff --git a/hw/misc/imx7_snvs.c b/hw/misc/imx7_snvs.c
index a245f96cd4e..8e7f43187f6 100644
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
 
-    return 0;
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
+
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
 
-    trace_imx7_snvs_write(offset, value);
+    IMX7SNVSState *s = IMX7_SNVS(opaque);
 
-    if (offset == SNVS_LPCR && ((value & mask) == mask)) {
-        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    uint64_t new_value = 0, snvs_count = 0;
+
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
index 05ff692441b..85725506bff 100644
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
-- 
2.34.1


