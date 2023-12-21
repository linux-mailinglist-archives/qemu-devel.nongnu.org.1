Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4581AD54
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fF-0008LS-2c; Wed, 20 Dec 2023 22:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ev-0008FY-V0
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:42 -0500
Received: from mail-qv1-xf32.google.com ([2607:f8b0:4864:20::f32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9et-0007FT-Sz
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:41 -0500
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-67f0d22e4faso1790416d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129019; x=1703733819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jZc28KhfyAoIUW76Jt3JYRtP4Wj+aj533ydkiZKMpKw=;
 b=vqejYMbkVoqpCmTzQ8yGFPlBTHusJQTXGo0XnXFtDpvqQD2ss60KVRvJqrW2iRBjp5
 WRkLtlOKIJQdw4nnxZ537huiiNUfnfKIy3r/yzU7CYD/ZDpZqvFFzSWvPkyJixikSNA5
 ugdgU4HX1WRd3XiNCHFqwDc3BB7+zkZngR0NBbjGHzWqZqAX2yKUZYPVMDeDt8GJho1u
 j6oXL/MdBbdH24V5bnnt1kV726NuR16J/3DXvHyvsw2Pbx3n6fhh00gIw/YDoJFaLbn6
 Vd1utjvdQvTgNNehY1MCbexNwrw40veJkMSwH67xOc4zUPDUiwWs1anw02YEH+kDGS9f
 YSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129019; x=1703733819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZc28KhfyAoIUW76Jt3JYRtP4Wj+aj533ydkiZKMpKw=;
 b=ljqPYrGO1KmldMDnHsViUxa/CB5RASoXR0z8Nct2GJpRgOILq6MjlrJCUIE7algFw6
 JDq8T8Sz/BfO9DhRHvEposKLJDDimaNlZhy4AdB6GXl/Tx1DFCtAY+SJFU81CwU6ByIT
 jrq7lDKyvf+i30TqbMoFMJutG8QxHWF0kZlf8AOtANZh1ATl9/Ml9FyIKu1bsQwanNxe
 rytCiv83j1CX9vt1IXwKUteKV9Op8v0cyeO0yFH28FlQSIpmM2sNQkRgyRWd/yJAhGq4
 eg7vpKy6q0uxCN9H5aZPtbnA2yFT+VE9he4+r0HiPb1FGWZob7KTFsT+0LKw5aFVkcsE
 1/VA==
X-Gm-Message-State: AOJu0Yw7oiC+avvtfoI1UK2WlfO+U48M/cPB7VDPjVO6DqdjXVdE4x/d
 EyKeonRkEKVPkZcpy9caqHvSoRn0JcSPo2Ag8SiVcr2u
X-Google-Smtp-Source: AGHT+IH8nGO/wLPlZV+NaAfor99dRjrfQ/9tgzhbsSlfULeiqsU0O7cA5j6TGMiMxYJR/r4pSCMs7w==
X-Received: by 2002:ad4:5c4b:0:b0:67f:7e15:fc86 with SMTP id
 a11-20020ad45c4b000000b0067f7e15fc86mr1279650qva.17.1703129019042; 
 Wed, 20 Dec 2023 19:23:39 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 52/71] hw/sd: Constify VMState
Date: Thu, 21 Dec 2023 14:16:33 +1100
Message-Id: <20231221031652.119827-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f32;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf32.google.com
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
---
 hw/sd/allwinner-sdhost.c | 2 +-
 hw/sd/aspeed_sdhci.c     | 2 +-
 hw/sd/bcm2835_sdhost.c   | 2 +-
 hw/sd/cadence_sdhci.c    | 2 +-
 hw/sd/npcm7xx_sdhci.c    | 2 +-
 hw/sd/pl181.c            | 2 +-
 hw/sd/pxa2xx_mmci.c      | 2 +-
 hw/sd/sd.c               | 6 +++---
 hw/sd/sdhci.c            | 6 +++---
 hw/sd/ssi-sd.c           | 2 +-
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/sd/allwinner-sdhost.c b/hw/sd/allwinner-sdhost.c
index 1a576d62ae..a1b7230633 100644
--- a/hw/sd/allwinner-sdhost.c
+++ b/hw/sd/allwinner-sdhost.c
@@ -773,7 +773,7 @@ static const VMStateDescription vmstate_allwinner_sdhost = {
     .name = "allwinner-sdhost",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(global_ctl, AwSdHostState),
         VMSTATE_UINT32(clock_ctl, AwSdHostState),
         VMSTATE_UINT32(timeout, AwSdHostState),
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index e53206d959..3b63926c3a 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -177,7 +177,7 @@ static void aspeed_sdhci_reset(DeviceState *dev)
 static const VMStateDescription vmstate_aspeed_sdhci = {
     .name = TYPE_ASPEED_SDHCI,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSDHCIState, ASPEED_SDHCI_NUM_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
index a600cf39e2..11c54dd4a7 100644
--- a/hw/sd/bcm2835_sdhost.c
+++ b/hw/sd/bcm2835_sdhost.c
@@ -381,7 +381,7 @@ static const VMStateDescription vmstate_bcm2835_sdhost = {
     .name = TYPE_BCM2835_SDHOST,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cmd, BCM2835SDHostState),
         VMSTATE_UINT32(cmdarg, BCM2835SDHostState),
         VMSTATE_UINT32(status, BCM2835SDHostState),
diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
index ef4e0d74e3..7c8bc5464b 100644
--- a/hw/sd/cadence_sdhci.c
+++ b/hw/sd/cadence_sdhci.c
@@ -159,7 +159,7 @@ static void cadence_sdhci_realize(DeviceState *dev, Error **errp)
 static const VMStateDescription vmstate_cadence_sdhci = {
     .name = TYPE_CADENCE_SDHCI,
     .version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CadenceSDHCIState, CADENCE_SDHCI_NUM_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/sd/npcm7xx_sdhci.c b/hw/sd/npcm7xx_sdhci.c
index 9958680090..e93dab8dbd 100644
--- a/hw/sd/npcm7xx_sdhci.c
+++ b/hw/sd/npcm7xx_sdhci.c
@@ -142,7 +142,7 @@ static void npcm7xx_sdhci_reset(DeviceState *dev)
 static const VMStateDescription vmstate_npcm7xx_sdhci = {
     .name = TYPE_NPCM7XX_SDHCI,
     .version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(regs.boottoctrl, NPCM7xxSDHCIState),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
index 2b33814d83..e3633c2e6f 100644
--- a/hw/sd/pl181.c
+++ b/hw/sd/pl181.c
@@ -63,7 +63,7 @@ static const VMStateDescription vmstate_pl181 = {
     .name = "pl181",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(clock, PL181State),
         VMSTATE_UINT32(power, PL181State),
         VMSTATE_UINT32(cmdarg, PL181State),
diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 5e8ea69188..82529708c8 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -84,7 +84,7 @@ static const VMStateDescription vmstate_pxa2xx_mmci = {
     .name = "pxa2xx-mmci",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(status, PXA2xxMMCIState),
         VMSTATE_UINT32(clkrt, PXA2xxMMCIState),
         VMSTATE_UINT32(spi, PXA2xxMMCIState),
diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 1106ff7d78..807b5d3de3 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -681,7 +681,7 @@ static const VMStateDescription sd_ocr_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sd_ocr_vmstate_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ocr, SDState),
         VMSTATE_TIMER_PTR(ocr_power_timer, SDState),
         VMSTATE_END_OF_LIST()
@@ -706,7 +706,7 @@ static const VMStateDescription sd_vmstate = {
     .version_id = 2,
     .minimum_version_id = 2,
     .pre_load = sd_vmstate_pre_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(mode, SDState),
         VMSTATE_INT32(state, SDState),
         VMSTATE_UINT8_ARRAY(cid, SDState, 16),
@@ -733,7 +733,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
         NULL
     },
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 40473b0db0..c5e0bc018b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1457,7 +1457,7 @@ static const VMStateDescription sdhci_pending_insert_vmstate = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = sdhci_pending_insert_vmstate_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(pending_insert_state, SDHCIState),
         VMSTATE_END_OF_LIST()
     },
@@ -1467,7 +1467,7 @@ const VMStateDescription sdhci_vmstate = {
     .name = "sdhci",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sdmasysad, SDHCIState),
         VMSTATE_UINT16(blksize, SDHCIState),
         VMSTATE_UINT16(blkcnt, SDHCIState),
@@ -1498,7 +1498,7 @@ const VMStateDescription sdhci_vmstate = {
         VMSTATE_TIMER_PTR(transfer_timer, SDHCIState),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &sdhci_pending_insert_vmstate,
         NULL
     },
diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
index a6cc1ad6c8..2dd070f978 100644
--- a/hw/sd/ssi-sd.c
+++ b/hw/sd/ssi-sd.c
@@ -350,7 +350,7 @@ static const VMStateDescription vmstate_ssi_sd = {
     .version_id = 7,
     .minimum_version_id = 7,
     .post_load = ssi_sd_post_load,
-    .fields = (VMStateField []) {
+    .fields = (const VMStateField []) {
         VMSTATE_UINT32(mode, ssi_sd_state),
         VMSTATE_INT32(cmd, ssi_sd_state),
         VMSTATE_UINT8_ARRAY(cmdarg, ssi_sd_state, 4),
-- 
2.34.1


