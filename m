Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D581AD58
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9aR-0003OZ-6J; Wed, 20 Dec 2023 22:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aO-00035b-5j
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:00 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aM-000417-36
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:59 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-78106c385a1so20237085a.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128737; x=1703733537; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ex0sMAx8rqtWa5iF1okc4nAfkaRkYqLLJJTlpZ+IXRU=;
 b=tz8p/yVURfk6ObbFHQwgDsD/uVn2OQC9Gw9oZetB1f9Kk9aIyLNJbtyZ1vq5jBM0uz
 ZTtzNtYVrr1w1zH+ZMeDUh7GGvQoFwxlU0t34md6irjh+zc7p7OnxZhxSqWuc9oVP1c3
 qjkp/by0lttup1DKI5/SSPWRx9Te0NBN4eSgU8uO4INteIC3Znl3cCMcovW6sD1XkgKy
 ACZxrTxu2C+q1Of7fuNiev77QLkM1bPaKzf8LVPlt5nGh4nAi1l1mjtx+g36dJKhKW0U
 oPRzTVJEIIORnG9c42OAK14uzG6tzl38zfUOFPfeqAEBpkyoujcEZdagzCVujSgrsfsq
 DDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128737; x=1703733537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ex0sMAx8rqtWa5iF1okc4nAfkaRkYqLLJJTlpZ+IXRU=;
 b=OzpLAaS0KIGZ5OjwDivi5Vq7dVgZCUOE1dQ4MscNYNw8pgsGzCENMDORJRZGZ1Xkh8
 KoZ40N00w8ULlefOFIld8OsEzvJkR9TrDSh9V8F+jmV3uILt3qbFsdPyY72FMiYc38pQ
 jC5oTJHTw65dFj4WIsA7gb4GBk0yly/ysmffX5bFS1Vy8coziLtywiRB20ER5HzNB3co
 wnDAD0wTZipRU9P5a/pW0q76d7pXa3ZHbKCyUcIKgcKLlcFAYGK3L4OtStrgvJFV/sJ3
 hQuuO6RAa7+6OsGfkc5ur1fn9ZqlHbn9kNMbVQwdbJGZNThOBBb+z+d86plTwFnHlcC4
 aOTQ==
X-Gm-Message-State: AOJu0YxS8KTo6PdzRpY9ew3KD0TpVxN17/jZ23yuEl1KK7AMmVL42aMr
 Kfhf7zawJnA8nYwnXI9UOJrAt7XOfDQfYBpwpkcESnuA
X-Google-Smtp-Source: AGHT+IFsC7QVPeOgWdb6IyRa43lBz+CFKfi+oG4SdQtDpJq8P9A+BrqgzCIqvUiteGU88NH9FBMIRA==
X-Received: by 2002:a05:620a:424f:b0:780:e4b3:7cd8 with SMTP id
 w15-20020a05620a424f00b00780e4b37cd8mr7505735qko.102.1703128737092; 
 Wed, 20 Dec 2023 19:18:57 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 28/71] hw/gpio: Constify VMState
Date: Thu, 21 Dec 2023 14:16:09 +1100
Message-Id: <20231221031652.119827-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72b.google.com
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


