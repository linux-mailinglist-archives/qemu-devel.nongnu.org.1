Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC618201C7
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLr-0008LZ-Qw; Fri, 29 Dec 2023 16:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLn-0007xg-38
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:03 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLk-0007E5-PR
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:25:02 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35fd9e40039so36728915ab.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885099; x=1704489899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xQyRHBkLI0FgtPz8q8Pr42xSokamiCI15aesiSNpptA=;
 b=l5TckRjtIqr8RcsWpMm2f3m6h6Gw8K8dexk6LtaO7u3Dy/lRWWshJHxHHubg+VOVqP
 Kbhq/+v6BtyvNhNL74L1kPR7Sfx9SZ6JUlKe4NTwIdoUJ5wUaGpS/cHsfulwikxCyCXl
 qsenKYcpfuml0TyadeZArL6OSLzGysZbyeCibbHlq99/9SY23mC4uSxhl5S9wIln9kA5
 Zv6Z8xe83G/s1MSgC6x3OvTxNLvOyM9gelyedfywfsFbT89cqLp0V2nIlA7H0uX1yk2t
 /6+9Njcf/F92jNtgcjLsvppeAMeTRqFERvqnmK9FG3RRjAje0gez6PWxu2SU46PE9O8K
 OzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885099; x=1704489899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQyRHBkLI0FgtPz8q8Pr42xSokamiCI15aesiSNpptA=;
 b=puEKuq3Mol4D6IykUOCj3pxl70GjHttbSwH2yh6sDB6dVDwxMv70PSbKgu2hRnGi3U
 SQ+LYMgZsLVVkMi0DxdUx+cUmc5i9pkEUOA8PeK0rW1D9lzyUty2w1GpvKpM/CfLa0mH
 wK1InDgMZno/AE4ye5dI0dHJaUCsmCMGjviNpPPuesN0mtb9YwZKpGQRqWxx2RaMstaP
 EOwHmvtZoP3bPkHNqbOw3VEmjKlPtcvbGoT9lC6L2bFLL96EvGCOHCDPXV0Rckl+8KoI
 vIkkfzGRsF6wO1hGT0yg8J3ZFrtp9CH8Yqacmz1v3au2YPf+ZH/kgn4nfjuWmKiK72ZL
 +z3Q==
X-Gm-Message-State: AOJu0YwlFAegql5bJwm4c2fMBbFepdAvHABphJbN2FFyVj3xk6pCMhjk
 r4Bno3gX+gotrmxCrVhP/fK3E/82K4kwtHRuGr//t0QHcTgmsg==
X-Google-Smtp-Source: AGHT+IGJGbUuJw4Cy0BtngU6df5rokYfbfS2SajJ/IjnrKFGKWWIMH1KQ8P/I5CQ4mOYEXt9mYzZ0Q==
X-Received: by 2002:a05:6e02:1848:b0:360:de:3437 with SMTP id
 b8-20020a056e02184800b0036000de3437mr13450683ilv.26.1703885099530; 
 Fri, 29 Dec 2023 13:24:59 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:59 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/71] hw/gpio: Constify VMState
Date: Sat, 30 Dec 2023 08:23:03 +1100
Message-Id: <20231229212346.147149-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12c;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12c.google.com
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
Message-Id: <20231221031652.119827-29-richard.henderson@linaro.org>
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


