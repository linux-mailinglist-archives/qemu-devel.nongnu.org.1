Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 866347E1AF6
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaA-0005aI-Pq; Mon, 06 Nov 2023 01:59:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZa-0004aG-E3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:59 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZY-0001RR-Fx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:58 -0500
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5b999980689so3178713a12.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253935; x=1699858735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ID3qCzKroqQKz9vHil653B6bXKD4UNzd4QGjW3be+wE=;
 b=RlJpEp8e+tUIFM8nX13265/Hs8elfGVOvQscgdQLygkB/nPnzUm6Mvcb823KEWEA+a
 dtTk69PU0lcNbsNcB2IMM+E6PsTTQNSaqVrrhotR352KkbHHS0DenXO0Y0d0P2GCqSGq
 JIh1aWnunniEyvNEntTFPo7vbdnjfCjaQlSdIeidIElI/xrERWh3xZYuunQnIQCAIW0m
 Vm5eBBSwfDFCQcQyNDXgWXsO7DkX3c0V/pl6rW05h/3NMAmSoaNpRf158BMW6Un7a+XA
 Y8Kicm5YaILnP0RZpjGB4MReYsbQVunwP0mfTFHYqI2WVNsRWOuE+4ZNNoLBWIFeqFve
 RT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253935; x=1699858735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ID3qCzKroqQKz9vHil653B6bXKD4UNzd4QGjW3be+wE=;
 b=SpRRZ/wE/RbogHBQR7iU2Vxo5FxAU/lesDN4QYkJDvM0Wbo9PRnPNgvCLbTHTd1UL9
 MDcttNwlZOrQBLAu3O4BnuKskjd0QL/Qz0M8960TsyAURxOxjuuCtJrRPbqPVBEzQDUH
 5elBsOS0G+8z/PcUixz0Mh/oWFahx2b7xxeGhbMmFHHa8V9ZdPAW+wVVu6gTVxYfFmYx
 FGv1UPki8dItEd/HxnH49dGz5IDKQu9Tagdz00De2vx/hdhNScbaq3Vrrw4SKhtZFIf7
 iexgUITSfO7issoswroOrTtrq7scBWY4lryp8ImzD3o1K8dFKKwEaLDOJTmAknPR1VSe
 BMwA==
X-Gm-Message-State: AOJu0YwAaeRd5QwqC2/Vx7XGIeCJnuqf2aA7EtO+LoBcLzcQa6ZcbgZJ
 GY34/mSezrhxtR1ZmRvu0QPubExjKAOFfSodkD0=
X-Google-Smtp-Source: AGHT+IG6LTblrY3BhodYjhovdnnQ7LqabITEzoAxJzKy8UGtsoqtRSaw9KQGQgo3UtxHb9qh030xNw==
X-Received: by 2002:a05:6a20:6a05:b0:17a:fcda:4a6b with SMTP id
 p5-20020a056a206a0500b0017afcda4a6bmr26188479pzk.13.1699253935019; 
 Sun, 05 Nov 2023 22:58:55 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 30/71] hw/i2c: Constify VMState
Date: Sun,  5 Nov 2023 22:57:46 -0800
Message-Id: <20231106065827.543129-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
index cef51663d0..e4172c289d 100644
--- a/hw/i2c/pmbus_device.c
+++ b/hw/i2c/pmbus_device.c
@@ -1669,7 +1669,7 @@ const VMStateDescription vmstate_pmbus_device = {
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


