Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C130A81AD70
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:26:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fm-0002AC-Et; Wed, 20 Dec 2023 22:24:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fV-0001yg-7r
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:21 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fT-0000yI-CI
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:17 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67aa9a99915so2183056d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129054; x=1703733854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sHvK4ZNg8cbRoLs8vBJK0RjEWReX8kr5U6+I/TKxb+k=;
 b=T8GPuLK4JP1rTQogEHkNQ3qMBleEAXuwyzNHmXlTGKz+J12K52NRPhgYsgnRHeUs06
 mr74Cg2NtGtrYiOKVqSjYAos9WODYKq8aUiPXhrU6vDKkmuW+ZyY31aqv7dwIy5yty/Q
 mPTx1Xjqstl7rjPZvdmPLauPHilniBbt+cqEzlOK77Z7rCiAi9jFIzY3CYOLwxTF2pd+
 p6+RhajfNqYRFXPEXf5hpT3rlj+SPY7GgBSoh0q4AME/bZJc28+UcOOrrKdeKwqFVwmQ
 aMJeUbP3GxeyJPbxaxeLNzJlzhCzBBLvcZi1b2aGrEZwctPcYSt9JgQIZo1Qho6LzMoz
 OEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129054; x=1703733854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHvK4ZNg8cbRoLs8vBJK0RjEWReX8kr5U6+I/TKxb+k=;
 b=lKvoLQwHCO77NRdkBRlfCm3RsItWR6dJD91B6JyjlR343hK8ORDBqF1qzW12W0gUma
 daPvJVszP2h9ydPa8ah4vUBW8ZBAPLpRuK8/kUUodobbv5yENwedWGW6hslugcjfpRsr
 /TQnw/a1UACMq4PNSvSfkLR7kpYcWqKjNsM3w9XwqtybYRIKsmvdvrno7+Q/5FXplnT/
 r60yGTidGBe+X1nJqlh9EGvRrFhLJdJ2ds+QElTDdIlLaGYXmHjXHCGSBMaLvOxhI0fQ
 zG52I2SiLUCQ+sal1upmOiGQyQPxmHQo7XbxYMef0jKbY/x3PGuKktyg6u5W8yQpht0G
 KR+w==
X-Gm-Message-State: AOJu0Yx0OpltdTNoAv61AMKCyMENAJj8QcutCClgOFuxcJXOtmLy1XQo
 /JC42MAoJct4Ay2WTRfRoHHQ6bIGiHkPQRidVy136uRs
X-Google-Smtp-Source: AGHT+IGn3ybYCyd22C01baXaJyxYXu6/7jsIGEHg5CqNJRLDdvz9ezG7jLtURGK55rdbcg9oqElmyA==
X-Received: by 2002:ad4:5dc8:0:b0:67a:a721:d77c with SMTP id
 m8-20020ad45dc8000000b0067aa721d77cmr27782487qvh.98.1703129054454; 
 Wed, 20 Dec 2023 19:24:14 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 61/71] hw/watchdog: Constify VMState
Date: Thu, 21 Dec 2023 14:16:42 +1100
Message-Id: <20231221031652.119827-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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
 hw/watchdog/allwinner-wdt.c      | 2 +-
 hw/watchdog/cmsdk-apb-watchdog.c | 2 +-
 hw/watchdog/sbsa_gwdt.c          | 2 +-
 hw/watchdog/spapr_watchdog.c     | 2 +-
 hw/watchdog/wdt_aspeed.c         | 2 +-
 hw/watchdog/wdt_diag288.c        | 2 +-
 hw/watchdog/wdt_i6300esb.c       | 2 +-
 hw/watchdog/wdt_ib700.c          | 2 +-
 hw/watchdog/wdt_imx2.c           | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/watchdog/allwinner-wdt.c b/hw/watchdog/allwinner-wdt.c
index 6205765efe..d35711c7c5 100644
--- a/hw/watchdog/allwinner-wdt.c
+++ b/hw/watchdog/allwinner-wdt.c
@@ -313,7 +313,7 @@ static const VMStateDescription allwinner_wdt_vmstate = {
     .name = "allwinner-wdt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, AwWdtState),
         VMSTATE_UINT32_ARRAY(regs, AwWdtState, AW_WDT_REGS_NUM),
         VMSTATE_END_OF_LIST()
diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index 5a2cd46eb7..3091e5c3d5 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -361,7 +361,7 @@ static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
     .name = "cmsdk-apb-watchdog",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CLOCK(wdogclk, CMSDKAPBWatchdog),
         VMSTATE_PTIMER(timer, CMSDKAPBWatchdog),
         VMSTATE_UINT32(control, CMSDKAPBWatchdog),
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 7aa57a8c51..96895d7636 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -28,7 +28,7 @@ static const VMStateDescription vmstate_sbsa_gwdt = {
     .name = "sbsa-gwdt",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, SBSA_GWDTState),
         VMSTATE_UINT32(wcs, SBSA_GWDTState),
         VMSTATE_UINT32(worl, SBSA_GWDTState),
diff --git a/hw/watchdog/spapr_watchdog.c b/hw/watchdog/spapr_watchdog.c
index 55ff1f03c1..2bb1d3c532 100644
--- a/hw/watchdog/spapr_watchdog.c
+++ b/hw/watchdog/spapr_watchdog.c
@@ -226,7 +226,7 @@ static const VMStateDescription vmstate_wdt = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = watchdog_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER(timer, SpaprWatchdog),
         VMSTATE_UINT8(action, SpaprWatchdog),
         VMSTATE_UINT8(leave_others, SpaprWatchdog),
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index 273a49d360..d70b656f8e 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -218,7 +218,7 @@ static const VMStateDescription vmstate_aspeed_wdt = {
     .name = "vmstate_aspeed_wdt",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, AspeedWDTState),
         VMSTATE_UINT32_ARRAY(regs, AspeedWDTState, ASPEED_WDT_REGS_MAX),
         VMSTATE_END_OF_LIST()
diff --git a/hw/watchdog/wdt_diag288.c b/hw/watchdog/wdt_diag288.c
index 76d89fbf78..1b73b16fb3 100644
--- a/hw/watchdog/wdt_diag288.c
+++ b/hw/watchdog/wdt_diag288.c
@@ -23,7 +23,7 @@ static const VMStateDescription vmstate_diag288 = {
     .name = "vmstate_diag288",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, DIAG288State),
         VMSTATE_BOOL(enabled, DIAG288State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 54c167cd35..8bce0509cd 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -418,7 +418,7 @@ static const VMStateDescription vmstate_i6300esb = {
      */
     .version_id = 10000,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, I6300State),
         VMSTATE_INT32(reboot_enabled, I6300State),
         VMSTATE_INT32(clock_scale, I6300State),
diff --git a/hw/watchdog/wdt_ib700.c b/hw/watchdog/wdt_ib700.c
index a1750a4957..eea8da6059 100644
--- a/hw/watchdog/wdt_ib700.c
+++ b/hw/watchdog/wdt_ib700.c
@@ -95,7 +95,7 @@ static const VMStateDescription vmstate_ib700 = {
     .name = "ib700_wdt",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER_PTR(timer, IB700State),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index 891d7beb2a..6452fc4721 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -234,7 +234,7 @@ static const MemoryRegionOps imx2_wdt_ops = {
 
 static const VMStateDescription vmstate_imx2_wdt = {
     .name = "imx2.wdt",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PTIMER(timer, IMX2WdtState),
         VMSTATE_PTIMER(itimer, IMX2WdtState),
         VMSTATE_BOOL(wicr_locked, IMX2WdtState),
-- 
2.34.1


