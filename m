Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2AD7E1ACF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:11:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZy-0004i0-AZ; Mon, 06 Nov 2023 01:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZY-0004Y2-G7
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:56 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZW-0001R1-L4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:56 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cc330e8f58so27758475ad.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253933; x=1699858733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ex0sMAx8rqtWa5iF1okc4nAfkaRkYqLLJJTlpZ+IXRU=;
 b=UA6hTXhHUAr1mpmKWVVIhflc0+n6TmB/l5yzwT4xLvAfCz2zxUm/1dxKV24JHtTN7w
 ONXvIhLl7I36Zq+kHHg7ff4GXnGamfhQPKEB5xXaiNbM3Va/8T4SpLw/PS/5e4fAxGZb
 NquzFSBkLQougwO17HEFndDZIk7ObyXw6vx0wxY7uKY1fioZHwS/x/oJpWvBLzSj4uGQ
 ocfeOY/e4c6po7SYJR3640Ih7FXl83ATzA2OfDGUllXGAqDg1njux6O2QRwiFSST7W9v
 g0/k9yFE/5MH1QRgS4Fca9RRRzgSk+XE580VyDfzgesbQJ2RpLmuyh4tIpv/ZDLlVxi7
 kyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253933; x=1699858733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ex0sMAx8rqtWa5iF1okc4nAfkaRkYqLLJJTlpZ+IXRU=;
 b=u5XDDOH1ZaeD2988SUc/X7wwht0kj9FZNRU9FHFNcbXn4NJMmuIbRf/nT8CCpLFdW4
 OQDbPx+Ls83GYtq3cftZv9xp20djxr9fUV2T3tX8rf/3Z/yKDONRysYZ4+OjOI6f4xEU
 X3PX6A8NnRl5v4pJBeIkmJGZaLThyCiyqKfkCO2RTnkYGU+jXo2PWWdz1PFR9vpKtaUk
 DaDetb0qE4a7yU4AcxgSKudpi9FDehrxJarLI0HPdU92kBVJudOw+cCZz14ZI/ziQ8f2
 RDv/MDAxEHpEhZvutNlk9hMWl+oIDepllIfHvs1k3DAPjs8CgDKiQkwmFrhTlvCg9DuT
 0iqg==
X-Gm-Message-State: AOJu0YyOai2V7K62dJdqgdxPFBe0zo7Vq9Kr5AN2+WSpXBbf1lFzboTW
 aP/Ed95t5t/44ttfSFkbb49/28FI5iGLwfaggC8=
X-Google-Smtp-Source: AGHT+IGGm5MzwFEULtv7qqoxyq6DgB0pjMBM1t30+NQg64qqF1hCpLRr7kqqM0xXJ/qK8xIXJ7hLWw==
X-Received: by 2002:a17:902:ea02:b0:1cc:5648:f15c with SMTP id
 s2-20020a170902ea0200b001cc5648f15cmr20296014plg.48.1699253933369; 
 Sun, 05 Nov 2023 22:58:53 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 28/71] hw/gpio: Constify VMState
Date: Sun,  5 Nov 2023 22:57:44 -0800
Message-Id: <20231106065827.543129-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/gpio/aspeed_gpio.c  | 4 ++--
 hw/gpio/bcm2835_gpio.c | 2 +-
 hw/gpio/gpio_key.c     | 2 +-
 hw/gpio/imx_gpio.c     | 2 +-
 hw/gpio/max7310.c      | 2 +-
 hw/gpio/mpc8xxx.c      | 2 +-
 hw/gpio/npcm7xx_gpio.c | 2 +-
 hw/gpio/nrf51_gpio.c   | 2 +-
 hw/gpio/pl061.c        | 2 +-
 hw/gpio/sifive_gpio.c  | 2 +-
 hw/gpio/zaurus.c       | 2 +-
 11 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index 1e267dd482..c1781e2ba3 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -1067,7 +1067,7 @@ static const VMStateDescription vmstate_gpio_regs = {
     .name = TYPE_ASPEED_GPIO"/regs",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(data_value,   GPIOSets),
         VMSTATE_UINT32(data_read,    GPIOSets),
         VMSTATE_UINT32(direction,    GPIOSets),
@@ -1090,7 +1090,7 @@ static const VMStateDescription vmstate_aspeed_gpio = {
     .name = TYPE_ASPEED_GPIO,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(sets, AspeedGPIOState, ASPEED_GPIO_MAX_NR_SETS,
                              1, vmstate_gpio_regs, GPIOSets),
         VMSTATE_UINT32_ARRAY(debounce_regs, AspeedGPIOState,
diff --git a/hw/gpio/bcm2835_gpio.c b/hw/gpio/bcm2835_gpio.c
index c995bba1d9..6bd50bb0b6 100644
--- a/hw/gpio/bcm2835_gpio.c
+++ b/hw/gpio/bcm2835_gpio.c
@@ -284,7 +284,7 @@ static const VMStateDescription vmstate_bcm2835_gpio = {
     .name = "bcm2835_gpio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(fsel, BCM2835GpioState, 54),
         VMSTATE_UINT32(lev0, BCM2835GpioState),
         VMSTATE_UINT32(lev1, BCM2835GpioState),
diff --git a/hw/gpio/gpio_key.c b/hw/gpio/gpio_key.c
index 74f6138356..61bb587058 100644
--- a/hw/gpio/gpio_key.c
+++ b/hw/gpio/gpio_key.c
@@ -45,7 +45,7 @@ static const VMStateDescription vmstate_gpio_key = {
     .name = "gpio-key",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, GPIOKEYState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index c7f98b7bb1..e53b00d951 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -277,7 +277,7 @@ static const VMStateDescription vmstate_imx_gpio = {
     .name = TYPE_IMX_GPIO,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dr, IMXGPIOState),
         VMSTATE_UINT32(gdir, IMXGPIOState),
         VMSTATE_UINT32(psr, IMXGPIOState),
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index 4470cfe985..86315714fb 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -155,7 +155,7 @@ static const VMStateDescription vmstate_max7310 = {
     .name = "max7310",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_INT32(i2c_command_byte, MAX7310State),
         VMSTATE_INT32(len, MAX7310State),
         VMSTATE_UINT8(level, MAX7310State),
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index cb42acb6da..0b3f9e516d 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -48,7 +48,7 @@ static const VMStateDescription vmstate_mpc8xxx_gpio = {
     .name = "mpc8xxx_gpio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(dir, MPC8XXXGPIOState),
         VMSTATE_UINT32(odr, MPC8XXXGPIOState),
         VMSTATE_UINT32(dat, MPC8XXXGPIOState),
diff --git a/hw/gpio/npcm7xx_gpio.c b/hw/gpio/npcm7xx_gpio.c
index 3376901ab1..6e70ac1f24 100644
--- a/hw/gpio/npcm7xx_gpio.c
+++ b/hw/gpio/npcm7xx_gpio.c
@@ -377,7 +377,7 @@ static const VMStateDescription vmstate_npcm7xx_gpio = {
     .name = "npcm7xx-gpio",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(pin_level, NPCM7xxGPIOState),
         VMSTATE_UINT32(ext_level, NPCM7xxGPIOState),
         VMSTATE_UINT32(ext_driven, NPCM7xxGPIOState),
diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index 08396c69a4..ffc7dff796 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -280,7 +280,7 @@ static const VMStateDescription vmstate_nrf51_gpio = {
     .name = TYPE_NRF51_GPIO,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(out, NRF51GPIOState),
         VMSTATE_UINT32(in, NRF51GPIOState),
         VMSTATE_UINT32(in_mask, NRF51GPIOState),
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 899be861cc..86f2383655 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -87,7 +87,7 @@ static const VMStateDescription vmstate_pl061 = {
     .name = "pl061",
     .version_id = 4,
     .minimum_version_id = 4,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(locked, PL061State),
         VMSTATE_UINT32(data, PL061State),
         VMSTATE_UINT32(old_out_data, PL061State),
diff --git a/hw/gpio/sifive_gpio.c b/hw/gpio/sifive_gpio.c
index 78bf29e996..995a43c795 100644
--- a/hw/gpio/sifive_gpio.c
+++ b/hw/gpio/sifive_gpio.c
@@ -326,7 +326,7 @@ static const VMStateDescription vmstate_sifive_gpio = {
     .name = TYPE_SIFIVE_GPIO,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(value,     SIFIVEGPIOState),
         VMSTATE_UINT32(input_en,  SIFIVEGPIOState),
         VMSTATE_UINT32(output_en, SIFIVEGPIOState),
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 7cf52a5041..5884804c58 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -222,7 +222,7 @@ static const VMStateDescription vmstate_scoop_regs = {
     .version_id = 1,
     .minimum_version_id = 0,
     .post_load = scoop_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(status, ScoopInfo),
         VMSTATE_UINT16(power, ScoopInfo),
         VMSTATE_UINT32(gpio_level, ScoopInfo),
-- 
2.34.1


