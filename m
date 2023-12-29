Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCCEC8201C3
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPX-0005ba-8g; Fri, 29 Dec 2023 16:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPF-00053u-ND
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:38 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPD-0000JY-C2
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:37 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2043e721daaso4745324fac.2
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885314; x=1704490114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Vyi0TP52JABfdyZHXUAPl05hmrQ+9G+rb9wPiULLeV0=;
 b=c7gzHZjBKrYgsCelADgQktqOxcrT3Pt0CBPNOeJ0iRfgu41ysLdyJoZs8b5aj1Usvm
 uRHGYBFeE7Qc5oTbgL/m4bq27nxQOu8uhbIuScT1Ffgv3lK8FFXQKJHjgIDh3mpaRIkr
 4IIc93hpjSfZm2bn3FWNN9D95vXRxS4z9hptIWnLYjV1jbCeMpnyDbL2VC+dO4/q4Piu
 5Xx1DlgdH4IAfWVWyr3Lr+YD4TmiKGE7jDtG4NdRkZ/ZHIf4cdbSnUml7GllyNHFEdLT
 x8U5EFWGHyPnPSsb/QsnAmzA6K50Sky45ksiKDzf/S6n/wdd7KxHSzJQo5/vhGrZB+Ep
 W+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885314; x=1704490114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Vyi0TP52JABfdyZHXUAPl05hmrQ+9G+rb9wPiULLeV0=;
 b=mtKv6KSY482GJwOLqmbxZhMhXVOD9upOgMg3MMSOPuccv6Os15Obk6KL/StBrmp47u
 OzAgRHcyisk9/6dsElPMjJ6DmnbiJxieUF5cKUF/XnQeWue8RfQOng9czryVvWw6HmSA
 gYrjYvTILkSKBv8d2tilbZBKfdQpcpL+A+6IvlEzIGXJ+fiUsjd62tfG7BoaVFZ43Ram
 iHB9794BcjiMc/u13z9tN6PbNaPM40ffRN7u8Y1qUZBC9TPTwSBOcVDHCCQwRcVKrROD
 yZcxhGGINoOUywVSS/qeAiMFjeeKN3VNoUYKIsKjqN6GswSv0DPsO+lzoNqNoBpxACbx
 I9UA==
X-Gm-Message-State: AOJu0YwKMMAQAzLedfsQwpSBB70T0z/F077HK1eVAkgkla4pmqUiiHHH
 a34Hai3kN6Hte3cy631oEfSjXMWvM1Sv/vQyCRt3bNRwzPDk+Q==
X-Google-Smtp-Source: AGHT+IELZ/b0VGNFFDlTcwETmc1h78YR0Gke3A3DILh/PCEVdbRCkWpVnhh8iB+L3UjSGeVMh65rsw==
X-Received: by 2002:a05:6870:355:b0:203:e0bc:5e11 with SMTP id
 n21-20020a056870035500b00203e0bc5e11mr13554325oaf.70.1703885314127; 
 Fri, 29 Dec 2023 13:28:34 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/71] hw/nvram: Constify VMState
Date: Sat, 30 Dec 2023 08:23:17 +1100
Message-Id: <20231229212346.147149-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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
Message-Id: <20231221031652.119827-43-richard.henderson@linaro.org>
---
 hw/nvram/ds1225y.c                | 2 +-
 hw/nvram/eeprom93xx.c             | 2 +-
 hw/nvram/fw_cfg.c                 | 8 ++++----
 hw/nvram/mac_nvram.c              | 2 +-
 hw/nvram/npcm7xx_otp.c            | 2 +-
 hw/nvram/nrf51_nvm.c              | 2 +-
 hw/nvram/spapr_nvram.c            | 2 +-
 hw/nvram/xlnx-bbram.c             | 2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c | 2 +-
 hw/nvram/xlnx-zynqmp-efuse.c      | 2 +-
 10 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 3660a47c51..6d510dcc68 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -102,7 +102,7 @@ static const VMStateDescription vmstate_nvram = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = nvram_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VARRAY_UINT32(contents, NvRamState, chip_size, 0,
                               vmstate_info_uint8, uint8_t),
         VMSTATE_END_OF_LIST()
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index 57d63638d7..a8fd60a8fb 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -131,7 +131,7 @@ static const VMStateDescription vmstate_eeprom = {
     .name = "eeprom",
     .version_id = EEPROM_VERSION,
     .minimum_version_id = OLD_EEPROM_VERSION,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(tick, eeprom_t),
         VMSTATE_UINT8(address, eeprom_t),
         VMSTATE_UINT8(command, eeprom_t),
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4e4524673a..e85493d513 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -656,7 +656,7 @@ static int fw_cfg_acpi_mr_restore_post_load(void *opaque, int version_id)
 static const VMStateDescription vmstate_fw_cfg_dma = {
     .name = "fw_cfg/dma",
     .needed = fw_cfg_dma_enabled,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(dma_addr, FWCfgState),
         VMSTATE_END_OF_LIST()
     },
@@ -668,7 +668,7 @@ static const VMStateDescription vmstate_fw_cfg_acpi_mr = {
     .minimum_version_id = 1,
     .needed = fw_cfg_acpi_mr_restore,
     .post_load = fw_cfg_acpi_mr_restore_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(table_mr_size, FWCfgState),
         VMSTATE_UINT64(linker_mr_size, FWCfgState),
         VMSTATE_UINT64(rsdp_mr_size, FWCfgState),
@@ -680,13 +680,13 @@ static const VMStateDescription vmstate_fw_cfg = {
     .name = "fw_cfg",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(cur_entry, FWCfgState),
         VMSTATE_UINT16_HACK(cur_offset, FWCfgState, is_version_1),
         VMSTATE_UINT32_V(cur_offset, FWCfgState, 2),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_fw_cfg_dma,
         &vmstate_fw_cfg_acpi_mr,
         NULL,
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 810e84f07e..5f9d16fb3e 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -79,7 +79,7 @@ static const VMStateDescription vmstate_macio_nvram = {
     .name = "macio_nvram",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_VBUFFER_UINT32(data, MacIONVRAMState, 0, NULL, size),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/nvram/npcm7xx_otp.c b/hw/nvram/npcm7xx_otp.c
index c61f2fc1aa..f00ebfa931 100644
--- a/hw/nvram/npcm7xx_otp.c
+++ b/hw/nvram/npcm7xx_otp.c
@@ -384,7 +384,7 @@ static const VMStateDescription vmstate_npcm7xx_otp = {
     .name = "npcm7xx-otp",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, NPCM7xxOTPState, NPCM7XX_OTP_NR_REGS),
         VMSTATE_UINT8_ARRAY(array, NPCM7xxOTPState, NPCM7XX_OTP_ARRAY_BYTES),
         VMSTATE_END_OF_LIST(),
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index 7f1db8c423..ed8b836074 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -366,7 +366,7 @@ static const VMStateDescription vmstate_nvm = {
     .name = "nrf51_soc.nvm",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(uicr_content, NRF51NVMState,
                 NRF51_UICR_FIXTURE_SIZE),
         VMSTATE_UINT32(config, NRF51NVMState),
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 2d72f30442..bfd8aa367e 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -245,7 +245,7 @@ static const VMStateDescription vmstate_spapr_nvram = {
     .minimum_version_id = 1,
     .pre_load = spapr_nvram_pre_load,
     .post_load = spapr_nvram_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(size, SpaprNvram),
         VMSTATE_VBUFFER_ALLOC_UINT32(buf, SpaprNvram, 1, NULL, size),
         VMSTATE_END_OF_LIST()
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index e18e7770e1..0a71a005c6 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -508,7 +508,7 @@ static const VMStateDescription vmstate_bbram_ctrl = {
     .name = TYPE_XLNX_BBRAM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxBBRam, R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 2480af35e1..e4b9e11a3d 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -737,7 +737,7 @@ static const VMStateDescription vmstate_efuse_ctrl = {
     .name = TYPE_XLNX_VERSAL_EFUSE_CTRL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxVersalEFuseCtrl, R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 3db5f98ec1..ec98456e5d 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -821,7 +821,7 @@ static const VMStateDescription vmstate_efuse = {
     .name = TYPE_XLNX_ZYNQMP_EFUSE,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPEFuse, R_MAX),
         VMSTATE_END_OF_LIST(),
     }
-- 
2.34.1


