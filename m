Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F141F7DF901
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybff-0003wG-6N; Thu, 02 Nov 2023 13:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeh-0003H9-SZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybec-0002m0-L3
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:55 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-50939d39d0fso1531719e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946728; x=1699551528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yh53+flKs5wwSa/gf36dhongavYBcMPxUgxWx+dgFzI=;
 b=HU2uuGkNOc0/fmjvXYm/8xop5QF+EzXJp1DoIUaZvVAftfKpTGdkqr8ok+9A2SzQRN
 CYA0O1PRFf5BgWWcwApPck2P0OtRbXFXGti9+vbZuMg5FuSr9wJIJfJLEMIcXWHRj5YB
 TkaD69G3vAHzhvv/XQX7lkfEynEySosvHB9ufhDzdRJQ0CsqCL1AISMgEvO+jyPofNLa
 tOviSZCrZ8uPNB6y3vPpUCUXq0chrOMdphAPJVlx5T9b4PUD8tmDAjPSngmFMLRR+WsD
 FlhW5jSuUuDt9bttIaEu5IA0Ph3BBZE0Kdr4W9ZV5CDOqK65MN5z10pRu/aqnNF3O7K+
 RK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946728; x=1699551528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yh53+flKs5wwSa/gf36dhongavYBcMPxUgxWx+dgFzI=;
 b=RIxGOkswDwFaBEMEzCvbnovvn8sEXOnZ9sO04gOx3g9OVHzM97VmS9Bowpzu4q6MpR
 DhqomHhxVMllUn/ehW4wC480YSRSBq/zR2u3QpFfx9w3dMetrZdQrCBkxx0ZYsKgnd18
 HFnf309sP9twVDITDfRGG6zxz3uM/68bbPhTXKnc6XWoiCC8htOxOg+dokY2tw8ciMls
 rHMMSnm4uEohdGcgoa8ijoUPyFSJmmx8NrW9mUIL6mTWwKgdzTCVBcDH/G8FV2Qg5YD0
 S+C3hHn1ITfAwTfk14SR1OfEWeJJmBM850SauYImS0OEaWIJn7/1Mbtafrj7CEnGNDpm
 QYZw==
X-Gm-Message-State: AOJu0YyGlidES8qTWsp/+f8Q/8l7YJG+2inf6f46eIqhNNi9vSqEhWpg
 Pu9iQFyiS8baWZzQ4bPFSr9UxNtKCJCIMDlyOPA=
X-Google-Smtp-Source: AGHT+IHnfg6XNJ22Ne2bzaVSkJl5amhgWnhDJ/mUODehxm4VhaF1A1W9wG9JmXfxeq+ybCVsfQFnlg==
X-Received: by 2002:a05:6512:2037:b0:507:a1b3:2d47 with SMTP id
 s23-20020a056512203700b00507a1b32d47mr14290036lfs.17.1698946728482; 
 Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/33] hw/misc/imx6_ccm: Convert DPRINTF to trace events
Date: Thu,  2 Nov 2023 17:38:23 +0000
Message-Id: <20231102173835.609985-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231028122415.14869-5-shentey@gmail.com
[PMM: Add "Hz" unit indicator to frequency traces]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/imx6_ccm.c   | 41 ++++++++++++++---------------------------
 hw/misc/trace-events | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 4c830fd89ae..85af466c2be 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -15,18 +15,7 @@
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
-
-#ifndef DEBUG_IMX6_CCM
-#define DEBUG_IMX6_CCM 0
-#endif
-
-#define DPRINTF(fmt, args...) \
-    do { \
-        if (DEBUG_IMX6_CCM) { \
-            fprintf(stderr, "[%s]%s: " fmt , TYPE_IMX6_CCM, \
-                                             __func__, ##args); \
-        } \
-    } while (0)
+#include "trace.h"
 
 static const char *imx6_ccm_reg_name(uint32_t reg)
 {
@@ -263,7 +252,7 @@ static uint64_t imx6_analog_get_pll2_clk(IMX6CCMState *dev)
         freq *= 20;
     }
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_analog_get_pll2_clk(freq);
 
     return freq;
 }
@@ -275,7 +264,7 @@ static uint64_t imx6_analog_get_pll2_pfd0_clk(IMX6CCMState *dev)
     freq = imx6_analog_get_pll2_clk(dev) * 18
            / EXTRACT(dev->analog[CCM_ANALOG_PFD_528], PFD0_FRAC);
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_analog_get_pll2_pfd0_clk(freq);
 
     return freq;
 }
@@ -287,7 +276,7 @@ static uint64_t imx6_analog_get_pll2_pfd2_clk(IMX6CCMState *dev)
     freq = imx6_analog_get_pll2_clk(dev) * 18
            / EXTRACT(dev->analog[CCM_ANALOG_PFD_528], PFD2_FRAC);
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_analog_get_pll2_pfd2_clk(freq);
 
     return freq;
 }
@@ -315,7 +304,7 @@ static uint64_t imx6_analog_get_periph_clk(IMX6CCMState *dev)
         break;
     }
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_analog_get_periph_clk(freq);
 
     return freq;
 }
@@ -327,7 +316,7 @@ static uint64_t imx6_ccm_get_ahb_clk(IMX6CCMState *dev)
     freq = imx6_analog_get_periph_clk(dev)
            / (1 + EXTRACT(dev->ccm[CCM_CBCDR], AHB_PODF));
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_ccm_get_ahb_clk(freq);
 
     return freq;
 }
@@ -339,7 +328,7 @@ static uint64_t imx6_ccm_get_ipg_clk(IMX6CCMState *dev)
     freq = imx6_ccm_get_ahb_clk(dev)
            / (1 + EXTRACT(dev->ccm[CCM_CBCDR], IPG_PODF));
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_ccm_get_ipg_clk(freq);
 
     return freq;
 }
@@ -351,7 +340,7 @@ static uint64_t imx6_ccm_get_per_clk(IMX6CCMState *dev)
     freq = imx6_ccm_get_ipg_clk(dev)
            / (1 + EXTRACT(dev->ccm[CCM_CSCMR1], PERCLK_PODF));
 
-    DPRINTF("freq = %u\n", (uint32_t)freq);
+    trace_imx6_ccm_get_per_clk(freq);
 
     return freq;
 }
@@ -385,7 +374,7 @@ static uint32_t imx6_ccm_get_clock_frequency(IMXCCMState *dev, IMXClk clock)
         break;
     }
 
-    DPRINTF("Clock = %d) = %u\n", clock, freq);
+    trace_imx6_ccm_get_clock_frequency(clock, freq);
 
     return freq;
 }
@@ -394,7 +383,7 @@ static void imx6_ccm_reset(DeviceState *dev)
 {
     IMX6CCMState *s = IMX6_CCM(dev);
 
-    DPRINTF("\n");
+    trace_imx6_ccm_reset();
 
     s->ccm[CCM_CCR] = 0x040116FF;
     s->ccm[CCM_CCDR] = 0x00000000;
@@ -483,7 +472,7 @@ static uint64_t imx6_ccm_read(void *opaque, hwaddr offset, unsigned size)
 
     value = s->ccm[index];
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6_ccm_reg_name(index), value);
+    trace_imx6_ccm_read(imx6_ccm_reg_name(index), value);
 
     return (uint64_t)value;
 }
@@ -494,8 +483,7 @@ static void imx6_ccm_write(void *opaque, hwaddr offset, uint64_t value,
     uint32_t index = offset >> 2;
     IMX6CCMState *s = (IMX6CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx6_ccm_reg_name(index),
-            (uint32_t)value);
+    trace_imx6_ccm_write(imx6_ccm_reg_name(index), (uint32_t)value);
 
     /*
      * We will do a better implementation later. In particular some bits
@@ -591,7 +579,7 @@ static uint64_t imx6_analog_read(void *opaque, hwaddr offset, unsigned size)
         break;
     }
 
-    DPRINTF("reg[%s] => 0x%" PRIx32 "\n", imx6_analog_reg_name(index), value);
+    trace_imx6_analog_read(imx6_analog_reg_name(index), value);
 
     return (uint64_t)value;
 }
@@ -602,8 +590,7 @@ static void imx6_analog_write(void *opaque, hwaddr offset, uint64_t value,
     uint32_t index = offset >> 2;
     IMX6CCMState *s = (IMX6CCMState *)opaque;
 
-    DPRINTF("reg[%s] <= 0x%" PRIx32 "\n", imx6_analog_reg_name(index),
-            (uint32_t)value);
+    trace_imx6_analog_write(imx6_analog_reg_name(index), (uint32_t)value);
 
     switch (index) {
     case CCM_ANALOG_PLL_ARM_SET:
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 426a8472b69..05ff692441b 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -196,6 +196,21 @@ iotkit_secctl_s_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit Sec
 iotkit_secctl_ns_read(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs read: offset 0x%x data 0x%" PRIx64 " size %u"
 iotkit_secctl_ns_write(uint32_t offset, uint64_t data, unsigned size) "IoTKit SecCtl NS regs write: offset 0x%x data 0x%" PRIx64 " size %u"
 
+# imx6_ccm.c
+imx6_analog_get_periph_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll2_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll2_pfd0_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_get_pll2_pfd2_clk(uint32_t freq) "freq = %u Hz"
+imx6_analog_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx6_analog_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
+imx6_ccm_get_ahb_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_ipg_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_per_clk(uint32_t freq) "freq = %u Hz"
+imx6_ccm_get_clock_frequency(unsigned clock, uint32_t freq) "(Clock = %d) = %u"
+imx6_ccm_read(const char *reg, uint32_t value) "reg[%s] => 0x%" PRIx32
+imx6_ccm_reset(void) ""
+imx6_ccm_write(const char *reg, uint32_t value) "reg[%s] <= 0x%" PRIx32
+
 # imx6ul_ccm.c
 ccm_entry(void) ""
 ccm_freq(uint32_t freq) "freq = %d"
-- 
2.34.1


