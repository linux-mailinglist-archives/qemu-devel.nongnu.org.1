Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8BA81AD40
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:21:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9aX-0003wV-PV; Wed, 20 Dec 2023 22:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aV-0003ow-MF
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:07 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9aT-00042b-3t
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:19:07 -0500
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-42786514fe6so2238551cf.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128744; x=1703733544; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RJfHR2Na2UWlm5drR23MjyYo9yYaUkVNrNZjTQ9IZLU=;
 b=g3BfIeWAQvrHZgCmbV48Mo7q2tpJU4K5pn26Dwitm6f23ttDW2DQ7h03E0xAE54k9R
 uV0UCZHZE7cbpBnA08Lcxqf0YobT7tceah9Ogp4y/dEwUASfPJdj0feEN+8GyRFsJnF9
 VMB1MHti2BKEiNKNQIDGCWR/xhZRwIDqbKcJi6bidcVh0nYUQScvzEt0xw1BzgHf5mzv
 VpJljFmzo7SL7DIU3X6kIaXVpteSdnjMP+/vjEcrytnVX2QuTqxICUbuj0vpbisKo6YL
 0sf/CN+lDX+6aXS0ZIkRSiKBcvm+gBGzRF1zXUtGXGF6TvVZA52NBq1cJyVlYfdCbzsp
 ISCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128744; x=1703733544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RJfHR2Na2UWlm5drR23MjyYo9yYaUkVNrNZjTQ9IZLU=;
 b=l46shmmlBm0VndPqCRhvdEr6krRwZaId+mQrF2FLOW695yfI2zjxUedUWBHhNk9Fbd
 1JlHVHWPlZ1t9nOj75SEGTxpm/YvTKxzvH1E2Z4SInUtqC0Z1x9Vbq4NH8q3ShNofGzs
 G3ebUzyvOXbtOiw58ZrSNS3PFDHwY+aO9P/ziOOuvZETZgOwWA55Hg7cH4buNZfQKOB/
 4aAyJ2EsmWE1WXZYmNe/WJNFiDu43wHVYKmgG52SzzCcVh24MvWuGuKcQhP4Q4gyiPT6
 xrkfCIukMszLLEOGHnyg2fPQJPxa+i0E9s8ykxOxilJGd2pvgmWeuxmIQYPlFkrM778O
 VSxA==
X-Gm-Message-State: AOJu0YwIAV3ZEFp116Umd4kMak7w7bLGosNjqaqxSNPRqWN6l9VhZr7a
 5Odw+LDkbv1J6gskoxUuvJK28Stt2Rx5e6TXTYCqKRoF
X-Google-Smtp-Source: AGHT+IEBstdD2YiUUKFivPfFqbOyuINUF/O94DM1UQpdtrwrjPrZUa27k/OsPbLHh9afw+Kk9NVaYg==
X-Received: by 2002:a05:620a:1916:b0:781:1cd1:3ba3 with SMTP id
 bj22-20020a05620a191600b007811cd13ba3mr718273qkb.116.1703128744201; 
 Wed, 20 Dec 2023 19:19:04 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.19.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:19:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 30/71] hw/i2c: Constify VMState
Date: Thu, 21 Dec 2023 14:16:11 +1100
Message-Id: <20231221031652.119827-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x834.google.com
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
 hw/i2c/allwinner-i2c.c  | 2 +-
 hw/i2c/aspeed_i2c.c     | 4 ++--
 hw/i2c/core.c           | 4 ++--
 hw/i2c/exynos4210_i2c.c | 2 +-
 hw/i2c/imx_i2c.c        | 2 +-
 hw/i2c/microbit_i2c.c   | 2 +-
 hw/i2c/mpc_i2c.c        | 2 +-
 hw/i2c/npcm7xx_smbus.c  | 2 +-
 hw/i2c/pm_smbus.c       | 2 +-
 hw/i2c/pmbus_device.c   | 2 +-
 hw/i2c/smbus_eeprom.c   | 2 +-
 hw/i2c/smbus_ich9.c     | 2 +-
 hw/i2c/smbus_slave.c    | 2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/hw/i2c/allwinner-i2c.c b/hw/i2c/allwinner-i2c.c
index 9e8efa1d63..8abcc39a5c 100644
--- a/hw/i2c/allwinner-i2c.c
+++ b/hw/i2c/allwinner-i2c.c
@@ -415,7 +415,7 @@ static const VMStateDescription allwinner_i2c_vmstate = {
     .name = TYPE_AW_I2C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(addr, AWI2CState),
         VMSTATE_UINT8(xaddr, AWI2CState),
         VMSTATE_UINT8(data, AWI2CState),
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 1037c22b2f..b43afd250d 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -945,7 +945,7 @@ static const VMStateDescription aspeed_i2c_bus_vmstate = {
     .name = TYPE_ASPEED_I2C,
     .version_id = 5,
     .minimum_version_id = 5,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedI2CBus, ASPEED_I2C_NEW_NUM_REG),
         VMSTATE_END_OF_LIST()
     }
@@ -955,7 +955,7 @@ static const VMStateDescription aspeed_i2c_vmstate = {
     .name = TYPE_ASPEED_I2C,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(intr_status, AspeedI2CState),
         VMSTATE_STRUCT_ARRAY(busses, AspeedI2CState,
                              ASPEED_I2C_NR_BUSSES, 1, aspeed_i2c_bus_vmstate,
diff --git a/hw/i2c/core.c b/hw/i2c/core.c
index 879a1d45cb..4cf30b2c86 100644
--- a/hw/i2c/core.c
+++ b/hw/i2c/core.c
@@ -50,7 +50,7 @@ static const VMStateDescription vmstate_i2c_bus = {
     .version_id = 1,
     .minimum_version_id = 1,
     .pre_save = i2c_bus_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(saved_address, I2CBus),
         VMSTATE_END_OF_LIST()
     }
@@ -359,7 +359,7 @@ const VMStateDescription vmstate_i2c_slave = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = i2c_slave_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(address, I2CSlave),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/i2c/exynos4210_i2c.c b/hw/i2c/exynos4210_i2c.c
index b65a7d0222..9445424d5f 100644
--- a/hw/i2c/exynos4210_i2c.c
+++ b/hw/i2c/exynos4210_i2c.c
@@ -273,7 +273,7 @@ static const VMStateDescription exynos4210_i2c_vmstate = {
     .name = "exynos4210.i2c",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(i2ccon, Exynos4210I2CState),
         VMSTATE_UINT8(i2cstat, Exynos4210I2CState),
         VMSTATE_UINT8(i2cds, Exynos4210I2CState),
diff --git a/hw/i2c/imx_i2c.c b/hw/i2c/imx_i2c.c
index 9792583fea..a25676f025 100644
--- a/hw/i2c/imx_i2c.c
+++ b/hw/i2c/imx_i2c.c
@@ -285,7 +285,7 @@ static const VMStateDescription imx_i2c_vmstate = {
     .name = TYPE_IMX_I2C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(address, IMXI2CState),
         VMSTATE_UINT16(iadr, IMXI2CState),
         VMSTATE_UINT16(ifdr, IMXI2CState),
diff --git a/hw/i2c/microbit_i2c.c b/hw/i2c/microbit_i2c.c
index e92f9f84ea..24d36d15b0 100644
--- a/hw/i2c/microbit_i2c.c
+++ b/hw/i2c/microbit_i2c.c
@@ -80,7 +80,7 @@ static const VMStateDescription microbit_i2c_vmstate = {
     .name = TYPE_MICROBIT_I2C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, MicrobitI2CState, MICROBIT_I2C_NREGS),
         VMSTATE_UINT32(read_idx, MicrobitI2CState),
         VMSTATE_END_OF_LIST()
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 219c548402..cb051a520f 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -312,7 +312,7 @@ static const VMStateDescription mpc_i2c_vmstate = {
     .name = TYPE_MPC_I2C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(address, MPCI2CState),
         VMSTATE_UINT8(adr, MPCI2CState),
         VMSTATE_UINT8(fdr, MPCI2CState),
diff --git a/hw/i2c/npcm7xx_smbus.c b/hw/i2c/npcm7xx_smbus.c
index e7e0ba66fe..0ea3083bb6 100644
--- a/hw/i2c/npcm7xx_smbus.c
+++ b/hw/i2c/npcm7xx_smbus.c
@@ -1046,7 +1046,7 @@ static const VMStateDescription vmstate_npcm7xx_smbus = {
     .name = "npcm7xx-smbus",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(sda, NPCM7xxSMBusState),
         VMSTATE_UINT8(st, NPCM7xxSMBusState),
         VMSTATE_UINT8(cst, NPCM7xxSMBusState),
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 78e7c229a8..3eed8110b9 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -455,7 +455,7 @@ const VMStateDescription pmsmb_vmstate = {
     .name = "pmsmb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(smb_stat, PMSMBus),
         VMSTATE_UINT8(smb_ctl, PMSMBus),
         VMSTATE_UINT8(smb_cmd, PMSMBus),
diff --git a/hw/i2c/pmbus_device.c b/hw/i2c/pmbus_device.c
index 1b978e588f..ba1d2fd716 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1886,7 +1886,7 @@ const VMStateDescription vmstate_pmbus_device = {
     .name = TYPE_PMBUS_DEVICE,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SMBUS_DEVICE(smb, PMBusDevice),
         VMSTATE_UINT8(num_pages, PMBusDevice),
         VMSTATE_UINT8(code, PMBusDevice),
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index 12c5741f38..c42236bb13 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -100,7 +100,7 @@ static const VMStateDescription vmstate_smbus_eeprom = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = smbus_eeprom_vmstate_needed,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SMBUS_DEVICE(smbusdev, SMBusEEPROMDevice),
         VMSTATE_UINT8_ARRAY(data, SMBusEEPROMDevice, SMBUS_EEPROM_SIZE),
         VMSTATE_UINT8(offset, SMBusEEPROMDevice),
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 18d40e93c1..208f263ac5 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -50,7 +50,7 @@ static const VMStateDescription vmstate_ich9_smbus = {
     .name = "ich9_smb",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
         VMSTATE_BOOL_TEST(irq_enabled, ICH9SMBState, ich9_vmstate_need_smbus),
         VMSTATE_STRUCT_TEST(smb, ICH9SMBState, ich9_vmstate_need_smbus, 1,
diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 2ef2c7c5f6..1300c9ec72 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -215,7 +215,7 @@ const VMStateDescription vmstate_smbus_device = {
     .name = TYPE_SMBUS_DEVICE,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(i2c, SMBusDevice),
         VMSTATE_INT32(mode, SMBusDevice),
         VMSTATE_INT32(data_len, SMBusDevice),
-- 
2.34.1


