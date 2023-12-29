Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 945D48201B4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPf-0006gR-4s; Fri, 29 Dec 2023 16:29:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPc-0006Q9-5a
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:00 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPa-0000MF-6R
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:28:59 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6d9f94b9186so2216063b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885337; x=1704490137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ulGshSwG5KHuqNPfmNZqzOuiQN00QPV+I4fAymtm0Pc=;
 b=MCZPp4NRqBWfQOeSywjQMElpH0CZVmLpW2Gk5OH0b1d2VIR4Nk1N87G1iMkVcWYqeF
 U5reXuVIIGLeeC0wXfG4j4d8EL6cfuLkXQnp+7+dNsqtNB8UpJvwqmi37YOYNuP1ynMP
 bVi842fgwxbSYI+3hXU7TYGnCcKtgIZrZJ6vaF6fG53DmLiDLI5YBwORnZmr8FQzYqjP
 zBPAKS4BhKSkSm62LlCFoy3u6HfpijP19ZFhxp+4fmGIa7aV0+7W1+fvt6xIkzlvrlgA
 6zNh/95ZobFO9hAJYN6hhck4pjKxYVA/DZzqBQ62EiJSoArhKl4Om5J1v5uCP04ork9T
 FE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885337; x=1704490137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ulGshSwG5KHuqNPfmNZqzOuiQN00QPV+I4fAymtm0Pc=;
 b=IW4DPs7cci1rbviNXVEWXa2d8PeZJFupKhW93UqWLg/Heh1mq0Pk426CXV/6gk/wdx
 5tyE85yZf89t6HOPhmIQHOpzGexQfiE/yCOsxxUTg0kuizyrv6U8rBXF6v1fcMjSorI0
 w2EtuY2GVMdtxNZb0+GbUHY79RsXdauyRpyVie0T+CDycxTCRS9xzgnIArH3dI/+RGIx
 YmqiIRIvhMnYyr3UmdP4/0D+4AftpqBZ+yrr0YeiIotq/KjdVW2yoqrn/3d1eKATqeXo
 dfDbTDthxXOnKEsQyNdDjUoDX3JaUs6WXEkRcBlwdrrrK/D+hotJ/TM8k86ma1gli3Bi
 t/Yw==
X-Gm-Message-State: AOJu0Yxoq6HDBAutF+16mxOPMBGUczlxRf8duQa2SfubpNqQgngyK3S8
 x5W4ODv//EhrcHvynJbZ+7DK3rtcAy2i18nxILVCGN1mbRLd5A==
X-Google-Smtp-Source: AGHT+IEBc14V2fCsgsMOphkNiCRc+z2BHbTbXiyZV9seT3Ewm1aU7W7R5x4IGmoi2b4/HFhxsAulkw==
X-Received: by 2002:a05:6a00:4b8a:b0:6da:13b9:629f with SMTP id
 ks10-20020a056a004b8a00b006da13b9629fmr3570904pfb.11.1703885336815; 
 Fri, 29 Dec 2023 13:28:56 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 52/71] hw/sd: Constify VMState
Date: Sat, 30 Dec 2023 08:23:27 +1100
Message-Id: <20231229212346.147149-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
Message-Id: <20231221031652.119827-53-richard.henderson@linaro.org>
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


