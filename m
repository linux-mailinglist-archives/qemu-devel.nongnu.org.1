Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C20C7E1AF1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzte2-0002m1-A8; Mon, 06 Nov 2023 02:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cR-4K
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcp-00020A-MP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so27834235ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254134; x=1699858934; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gzTsJ6K1nw0Zy/fJftmC2YcCKcWj6RFNhGWd23UeCQI=;
 b=bIqTm3PD4byvmsBujclpSpLGb8qnUrfyhjjh7ahYVnbyp2z4d8Y1ajThENU67Y0Z+E
 AH1Ing4HgjAlcEQ9IGAMBIoC2rq52VYVLVjwNm4uhV2X3K+9ndW94W+Ot8Sogg0NOcwo
 VfPJM1n/GcqjgRQpkCOtd1Xzu9vpDvd7ReL73nWrnQPC8IPWagh3kUL1+0k7lEN4355B
 jnkehTjCezJKNMW2j77Pn6Dm1m46EszFq/FFtiEDGYFu6n+FOX5oxzLn7CTsC0jJui5x
 1TFwXAkaj/Si/VesUo/CRUDR0/8d4l1MBY0U7ribbPmyh1dioyrYhlrbtaOKc8sYyo3w
 lHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254134; x=1699858934;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gzTsJ6K1nw0Zy/fJftmC2YcCKcWj6RFNhGWd23UeCQI=;
 b=qR8p1u8aSy2Vps4mSsR1aGcB5P+yF6sjrGbCL5OghTEhl14Cyw7L+IWO3qlqLxUiCF
 q6bQD81+cZ2oZksZ1IhGCOm23GcwMNUFETMeSu1V5PdN9JH0g6GLLz9BQU2Pkg+IaSWk
 AMbhR0tk1xstevbjQiKdFTc8lD+bp04rPs48QjRiMapNqaJwEl1sLyO2bQUa4dbqh6Lt
 1IYuDKJpwpMKsal+v+AG72Vhh/A1+hG1uCbyfwHpebbMl+Y1gpWugro15xg0OKda/zZs
 +71MvFcZyCBunpPIOJp83uUdob9JPSwF2Hqecc8R998I3Q2RgEXAGmTBxHAMXiC8CcKj
 3ivQ==
X-Gm-Message-State: AOJu0Yzz+5AI8HZOZ76zdewqK3LDjB4AOSqYcZQTCbTjyV1DyD3JLar0
 UrcBTZeE8HxWIJcqcty5UqoWvRvYu3jR5oopFRs=
X-Google-Smtp-Source: AGHT+IHWF4Kqy2/VqRWnArLO90YyYv1sFOIpIhvHVnaEH+HeextzhtGfTKy/TRNz9E00GDKOk7jbMQ==
X-Received: by 2002:a17:90b:38cf:b0:281:b6e:22cd with SMTP id
 nn15-20020a17090b38cf00b002810b6e22cdmr834440pjb.20.1699254134626; 
 Sun, 05 Nov 2023 23:02:14 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 52/71] hw/sd: Constify VMState
Date: Sun,  5 Nov 2023 22:58:08 -0800
Message-Id: <20231106065827.543129-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
index be8cafd65f..025c90f0ff 100644
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
index 9431c35914..b01bf85cc7 100644
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
index 75db34befe..69edc7d330 100644
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
index b2f5b4a542..8e4b526e15 100644
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
index 5e554bd467..1b33ff09cc 100644
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
index 4749e935d8..f29bd031e8 100644
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
index 4823befdef..040ce9b4de 100644
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
index 167c03b780..c3b2735a32 100644
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


