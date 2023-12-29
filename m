Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD38201A6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLS-0007Cg-D5; Fri, 29 Dec 2023 16:24:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLQ-0007BQ-HB
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:40 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLN-0006lC-Ud
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:40 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6da16ec9be4so1554417b3a.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885076; x=1704489876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+rc1PcOkeKg5VLZFzRGj/U/rtJvZF1IpsUq8e3b5Odc=;
 b=YTHjwYSIAT07go967rSyNjx+vynDZXgp4BM7o+YHvwwYPytxI3+P3KOcU0CY70vKj+
 tpCxk3XVlfVjgbJHKLf9cxDdNRncoaBpW+9R3I/fYtx8/lju645n/DIFUW4jIwSQytrV
 eIMYvGQe5N/G5FYgkQAmNHbzFuhP6P/xWE/FWYX1A+HfNV6M5Iy3S2DroucJ3Sgz1Jzk
 yVBbRp6uVSESXzjE7Zs7fso43gK3Pl099dpYu1o8COcET+vSY/eAhGIvdjFAHNIFBUxH
 k6ZmQ9AKSoYEjmeafg0Z037WEvDRtvMqWjx57mDz1YgjOOUHcot2cJV+VadmLc5a4Ok/
 wfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885076; x=1704489876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+rc1PcOkeKg5VLZFzRGj/U/rtJvZF1IpsUq8e3b5Odc=;
 b=NsRIhhcPRCqwoeVHjAM2De49WL42DAA29FRtm7Aw7LuKa6zg5AsF6k2hlw798XBbJb
 uPLuHXaMOfNbTbdnRb7Gik+sv2E3QeQCLQ0U3XNsaFptP83Kmouk6f3SjOsYr96iDAOg
 kuxfBanqipF5+f4T5d8mC3/6IgSXnOYwZrdqFTtMZq+p1Ix9foqSepRDWj99D7vFNjGr
 f4UnXNSAe0NI9LozttPq0n03vcrprLCHP2bYw0nd9p36KECJS/4ZUI/PhArOaffFUmtH
 2+OrHuaKWU+qlA0VaNYq/I1/ofKNXx3U+jk7DDm1H7ZGDr6q31R8IKHl5lpMNV+e8mKq
 cT9g==
X-Gm-Message-State: AOJu0YzPyaTHcssXzIxONUeW77lNgPw7OLkplDj1X4Sh7bliE2UNQKo0
 jQdIBRFENP+2FIsiQmONsndh7VMKrVZGTWma1btnn+qahDsL7Q==
X-Google-Smtp-Source: AGHT+IGm9MDPxkZE49qr7zz8/WyBIOWapyAquCka1t2C53Dy1xtYGINDzXb8YCr/TzMtdBvfnJdrHw==
X-Received: by 2002:aa7:8c42:0:b0:6d9:ac6f:20b4 with SMTP id
 e2-20020aa78c42000000b006d9ac6f20b4mr8949565pfd.42.1703885076371; 
 Fri, 29 Dec 2023 13:24:36 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/71] hw/arm: Constify VMState
Date: Sat, 30 Dec 2023 08:22:53 +1100
Message-Id: <20231229212346.147149-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-19-richard.henderson@linaro.org>
---
 hw/arm/armsse.c          |  2 +-
 hw/arm/armv7m.c          |  2 +-
 hw/arm/highbank.c        |  2 +-
 hw/arm/integratorcp.c    |  6 +++---
 hw/arm/musicpal.c        | 14 +++++++-------
 hw/arm/pxa2xx.c          | 18 +++++++++---------
 hw/arm/pxa2xx_gpio.c     |  2 +-
 hw/arm/pxa2xx_pic.c      |  2 +-
 hw/arm/smmuv3.c          |  8 ++++----
 hw/arm/spitz.c           |  8 ++++----
 hw/arm/stellaris.c       |  6 +++---
 hw/arm/strongarm.c       | 12 ++++++------
 hw/arm/versatilepb.c     |  2 +-
 hw/arm/virt-acpi-build.c |  2 +-
 hw/arm/z2.c              |  4 ++--
 15 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
index 31acbf7347..02b4f6596f 100644
--- a/hw/arm/armsse.c
+++ b/hw/arm/armsse.c
@@ -1677,7 +1677,7 @@ static const VMStateDescription armsse_vmstate = {
     .name = "iotkit",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(mainclk, ARMSSE),
         VMSTATE_CLOCK(s32kclk, ARMSSE),
         VMSTATE_UINT32(nsccfg, ARMSSE),
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index d10abb36a8..375a40962f 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -559,7 +559,7 @@ static const VMStateDescription vmstate_armv7m = {
     .name = "armv7m",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(refclk, ARMv7MState),
         VMSTATE_CLOCK(cpuclk, ARMv7MState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index f12aacea6b..c21e18d08f 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -112,7 +112,7 @@ static const VMStateDescription vmstate_highbank_regs = {
     .name = "highbank-regs",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, HighbankRegsState, NUM_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index d176e9af7e..e602ca5e14 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -63,7 +63,7 @@ static const VMStateDescription vmstate_integratorcm = {
     .name = "integratorcm",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cm_osc, IntegratorCMState),
         VMSTATE_UINT32(cm_ctrl, IntegratorCMState),
         VMSTATE_UINT32(cm_lock, IntegratorCMState),
@@ -346,7 +346,7 @@ static const VMStateDescription vmstate_icp_pic = {
     .name = "icp_pic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, icp_pic_state),
         VMSTATE_UINT32(irq_enabled, icp_pic_state),
         VMSTATE_UINT32(fiq_enabled, icp_pic_state),
@@ -488,7 +488,7 @@ static const VMStateDescription vmstate_icp_control = {
     .name = "icp_control",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intreg_state, ICPCtrlRegsState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 9703bfb97f..3200c9f68a 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -275,7 +275,7 @@ static const VMStateDescription musicpal_lcd_vmsd = {
     .name = "musicpal_lcd",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(brightness, musicpal_lcd_state),
         VMSTATE_UINT32(mode, musicpal_lcd_state),
         VMSTATE_UINT32(irqctrl, musicpal_lcd_state),
@@ -400,7 +400,7 @@ static const VMStateDescription mv88w8618_pic_vmsd = {
     .name = "mv88w8618_pic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, mv88w8618_pic_state),
         VMSTATE_UINT32(enabled, mv88w8618_pic_state),
         VMSTATE_END_OF_LIST()
@@ -583,7 +583,7 @@ static const VMStateDescription mv88w8618_timer_vmsd = {
     .name = "timer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(ptimer, mv88w8618_timer_state),
         VMSTATE_UINT32(limit, mv88w8618_timer_state),
         VMSTATE_END_OF_LIST()
@@ -594,7 +594,7 @@ static const VMStateDescription mv88w8618_pit_vmsd = {
     .name = "mv88w8618_pit",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(timer, mv88w8618_pit_state, 4, 1,
                              mv88w8618_timer_vmsd, mv88w8618_timer_state),
         VMSTATE_END_OF_LIST()
@@ -681,7 +681,7 @@ static const VMStateDescription mv88w8618_flashcfg_vmsd = {
     .name = "mv88w8618_flashcfg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cfgr0, mv88w8618_flashcfg_state),
         VMSTATE_END_OF_LIST()
     }
@@ -1015,7 +1015,7 @@ static const VMStateDescription musicpal_gpio_vmsd = {
     .name = "musicpal_gpio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(lcd_brightness, musicpal_gpio_state),
         VMSTATE_UINT32(out_state, musicpal_gpio_state),
         VMSTATE_UINT32(in_state, musicpal_gpio_state),
@@ -1174,7 +1174,7 @@ static const VMStateDescription musicpal_key_vmsd = {
     .name = "musicpal_key",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(kbd_extended, musicpal_key_state),
         VMSTATE_UINT32(pressed_keys, musicpal_key_state),
         VMSTATE_END_OF_LIST()
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index f0bf407e66..6b2e54473b 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_pxa2xx_pm = {
     .name = "pxa2xx_pm",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(pm_regs, PXA2xxState, 0x40),
         VMSTATE_END_OF_LIST()
     }
@@ -238,7 +238,7 @@ static const VMStateDescription vmstate_pxa2xx_cm = {
     .name = "pxa2xx_cm",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(cm_regs, PXA2xxState, 4),
         VMSTATE_UINT32(clkcfg, PXA2xxState),
         VMSTATE_UINT32(pmnc, PXA2xxState),
@@ -465,7 +465,7 @@ static const VMStateDescription vmstate_pxa2xx_mm = {
     .name = "pxa2xx_mm",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(mm_regs, PXA2xxState, 0x1a),
         VMSTATE_END_OF_LIST()
     }
@@ -510,7 +510,7 @@ static const VMStateDescription vmstate_pxa2xx_ssp = {
     .name = "pxa2xx-ssp",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(enable, PXA2xxSSPState),
         VMSTATE_UINT32_ARRAY(sscr, PXA2xxSSPState, 2),
         VMSTATE_UINT32(sspsp, PXA2xxSSPState),
@@ -1200,7 +1200,7 @@ static const VMStateDescription vmstate_pxa2xx_rtc_regs = {
     .minimum_version_id = 0,
     .pre_save = pxa2xx_rtc_pre_save,
     .post_load = pxa2xx_rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rttr, PXA2xxRTCState),
         VMSTATE_UINT32(rtsr, PXA2xxRTCState),
         VMSTATE_UINT32(rtar, PXA2xxRTCState),
@@ -1464,7 +1464,7 @@ static const VMStateDescription vmstate_pxa2xx_i2c_slave = {
     .name = "pxa2xx_i2c_slave",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, PXA2xxI2CSlaveState),
         VMSTATE_END_OF_LIST()
     }
@@ -1474,7 +1474,7 @@ static const VMStateDescription vmstate_pxa2xx_i2c = {
     .name = "pxa2xx_i2c",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(control, PXA2xxI2CState),
         VMSTATE_UINT16(status, PXA2xxI2CState),
         VMSTATE_UINT8(ibmr, PXA2xxI2CState),
@@ -1728,7 +1728,7 @@ static const VMStateDescription vmstate_pxa2xx_i2s = {
     .name = "pxa2xx_i2s",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(control, PXA2xxI2SState, 2),
         VMSTATE_UINT32(status, PXA2xxI2SState),
         VMSTATE_UINT32(mask, PXA2xxI2SState),
@@ -2027,7 +2027,7 @@ static const VMStateDescription pxa2xx_fir_vmsd = {
     .name = "pxa2xx-fir",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(enable, PXA2xxFIrState),
         VMSTATE_UINT8_ARRAY(control, PXA2xxFIrState, 3),
         VMSTATE_UINT8_ARRAY(status, PXA2xxFIrState, 2),
diff --git a/hw/arm/pxa2xx_gpio.c b/hw/arm/pxa2xx_gpio.c
index c8db5e8e2b..41dca036fb 100644
--- a/hw/arm/pxa2xx_gpio.c
+++ b/hw/arm/pxa2xx_gpio.c
@@ -320,7 +320,7 @@ static const VMStateDescription vmstate_pxa2xx_gpio_regs = {
     .name = "pxa2xx-gpio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ilevel, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
         VMSTATE_UINT32_ARRAY(olevel, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
         VMSTATE_UINT32_ARRAY(dir, PXA2xxGPIOInfo, PXA2XX_GPIO_BANKS),
diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 1373a0d275..f54546cd4d 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -316,7 +316,7 @@ static const VMStateDescription vmstate_pxa2xx_pic_regs = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = pxa2xx_pic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(int_enabled, PXA2xxPICState, 2),
         VMSTATE_UINT32_ARRAY(int_pending, PXA2xxPICState, 2),
         VMSTATE_UINT32_ARRAY(is_fiq, PXA2xxPICState, 2),
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index c3871ae067..68eeef3e1d 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1768,7 +1768,7 @@ static const VMStateDescription vmstate_smmuv3_queue = {
     .name = "smmuv3_queue",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(base, SMMUQueue),
         VMSTATE_UINT32(prod, SMMUQueue),
         VMSTATE_UINT32(cons, SMMUQueue),
@@ -1790,7 +1790,7 @@ static const VMStateDescription vmstate_gbpa = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = smmuv3_gbpa_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(gbpa, SMMUv3State),
         VMSTATE_END_OF_LIST()
     }
@@ -1801,7 +1801,7 @@ static const VMStateDescription vmstate_smmuv3 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(features, SMMUv3State),
         VMSTATE_UINT8(sid_size, SMMUv3State),
         VMSTATE_UINT8(sid_split, SMMUv3State),
@@ -1826,7 +1826,7 @@ static const VMStateDescription vmstate_smmuv3 = {
 
         VMSTATE_END_OF_LIST(),
     },
-    .subsections = (const VMStateDescription * []) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_gbpa,
         NULL
     }
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index cc268c6ac0..1d680b61e2 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -1143,7 +1143,7 @@ static const VMStateDescription vmstate_sl_nand_info = {
     .name = "sl-nand",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(ctl, SLNANDState),
         VMSTATE_STRUCT(ecc, SLNANDState, 0, vmstate_ecc_state, ECCState),
         VMSTATE_END_OF_LIST(),
@@ -1180,7 +1180,7 @@ static const VMStateDescription vmstate_spitz_kbd = {
     .version_id = 1,
     .minimum_version_id = 0,
     .post_load = spitz_keyboard_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(sense_state, SpitzKeyboardState),
         VMSTATE_UINT16(strobe_state, SpitzKeyboardState),
         VMSTATE_UNUSED_TEST(is_version_0, 5),
@@ -1208,7 +1208,7 @@ static const VMStateDescription vmstate_corgi_ssp_regs = {
     .name = "corgi-ssp",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SSI_PERIPHERAL(ssidev, CorgiSSPState),
         VMSTATE_UINT32_ARRAY(enable, CorgiSSPState, 3),
         VMSTATE_END_OF_LIST(),
@@ -1236,7 +1236,7 @@ static const VMStateDescription vmstate_spitz_lcdtg_regs = {
     .name = "spitz-lcdtg",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SSI_PERIPHERAL(ssidev, SpitzLCDTG),
         VMSTATE_UINT32(bl_intensity, SpitzLCDTG),
         VMSTATE_UINT32(bl_power, SpitzLCDTG),
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index dd90f686bf..729a8bf569 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -419,7 +419,7 @@ static const VMStateDescription vmstate_stellaris_sys = {
     .version_id = 2,
     .minimum_version_id = 1,
     .post_load = stellaris_sys_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pborctl, ssys_state),
         VMSTATE_UINT32(ldopctl, ssys_state),
         VMSTATE_UINT32(int_mask, ssys_state),
@@ -631,7 +631,7 @@ static const VMStateDescription vmstate_stellaris_i2c = {
     .name = "stellaris_i2c",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(msa, stellaris_i2c_state),
         VMSTATE_UINT32(mcs, stellaris_i2c_state),
         VMSTATE_UINT32(mdr, stellaris_i2c_state),
@@ -901,7 +901,7 @@ static const VMStateDescription vmstate_stellaris_adc = {
     .name = "stellaris_adc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(actss, StellarisADCState),
         VMSTATE_UINT32(ris, StellarisADCState),
         VMSTATE_UINT32(im, StellarisADCState),
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index cc73145053..fef3638aca 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -211,7 +211,7 @@ static const VMStateDescription vmstate_strongarm_pic_regs = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = strongarm_pic_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pending, StrongARMPICState),
         VMSTATE_UINT32(enabled, StrongARMPICState),
         VMSTATE_UINT32(is_fiq, StrongARMPICState),
@@ -439,7 +439,7 @@ static const VMStateDescription vmstate_strongarm_rtc_regs = {
     .minimum_version_id = 0,
     .pre_save = strongarm_rtc_pre_save,
     .post_load = strongarm_rtc_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rttr, StrongARMRTCState),
         VMSTATE_UINT32(rtsr, StrongARMRTCState),
         VMSTATE_UINT32(rtar, StrongARMRTCState),
@@ -677,7 +677,7 @@ static const VMStateDescription vmstate_strongarm_gpio_regs = {
     .name = "strongarm-gpio",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ilevel, StrongARMGPIOInfo),
         VMSTATE_UINT32(olevel, StrongARMGPIOInfo),
         VMSTATE_UINT32(dir, StrongARMGPIOInfo),
@@ -846,7 +846,7 @@ static const VMStateDescription vmstate_strongarm_ppc_regs = {
     .name = "strongarm-ppc",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ilevel, StrongARMPPCInfo),
         VMSTATE_UINT32(olevel, StrongARMPPCInfo),
         VMSTATE_UINT32(dir, StrongARMPPCInfo),
@@ -1300,7 +1300,7 @@ static const VMStateDescription vmstate_strongarm_uart_regs = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = strongarm_uart_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(utcr0, StrongARMUARTState),
         VMSTATE_UINT16(brd, StrongARMUARTState),
         VMSTATE_UINT8(utcr3, StrongARMUARTState),
@@ -1558,7 +1558,7 @@ static const VMStateDescription vmstate_strongarm_ssp_regs = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = strongarm_ssp_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16_ARRAY(sscr, StrongARMSSPState, 2),
         VMSTATE_UINT16(sssr, StrongARMSSPState),
         VMSTATE_UINT16_ARRAY(rx_fifo, StrongARMSSPState, 8),
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 2f22dc890f..4b2257787b 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -52,7 +52,7 @@ static const VMStateDescription vmstate_vpb_sic = {
     .name = "versatilepb_sic",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(level, vpb_sic_state),
         VMSTATE_UINT32(mask, vpb_sic_state),
         VMSTATE_UINT32(pic_enable, vpb_sic_state),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bc35a483c..5e7cf6c6b3 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -1100,7 +1100,7 @@ static const VMStateDescription vmstate_virt_acpi_build = {
     .name = "virt_acpi_build",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(patched, AcpiBuildState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index d9a08fa67b..83741a4909 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -168,7 +168,7 @@ static const VMStateDescription vmstate_zipit_lcd_state = {
     .name = "zipit-lcd",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SSI_PERIPHERAL(ssidev, ZipitLCD),
         VMSTATE_INT32(selected, ZipitLCD),
         VMSTATE_INT32(enabled, ZipitLCD),
@@ -274,7 +274,7 @@ static const VMStateDescription vmstate_aer915_state = {
     .name = "aer915",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(len, AER915State),
         VMSTATE_BUFFER(buf, AER915State),
         VMSTATE_END_OF_LIST(),
-- 
2.34.1


