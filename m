Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3F58201DC
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:33:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQJ-0000kS-8e; Fri, 29 Dec 2023 16:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPz-0008QI-J1
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:25 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPu-0000O6-7G
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:19 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3bbc648bed4so2175764b6e.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885356; x=1704490156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=t/iLSJsvUNqGmwk21ef6qw5I/mGLsPK8yQVUTzDeYUY=;
 b=S+MPuuUUGb32+OfHpN6EfgOgAqOFvrJdt6a+7mH2i/W9z+iFXhfhu0IiTkvX4jQMY0
 h9moJGZrJL/RLB5bBu9RwfzXA3FRf81fMAKGF/u56uhfrxLk4DjJr6c20kn1cRj0L9ss
 6JCH3VhPEOptO3aP+vyM8D1VfCrp9esUvIQ66tVjEVv8Osj+DCTpmNXrQZhBFQCJHTrs
 V+PowtDckjdpUu71SlwoWLkjb47EIqULaQiC4Dhv0x0ycIY+06IrqjbqwKP+l3JFMoay
 WQoOoQ7VbBhJinbUkBNYsbDB476YX+9baMRTQveBp5rCiEMcaJz31z3VtuWEBO8TniYv
 4EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885356; x=1704490156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t/iLSJsvUNqGmwk21ef6qw5I/mGLsPK8yQVUTzDeYUY=;
 b=JZVFob8Ud+0CJ9SXuegYlXi3FPjOsRhQNFruRFqdlRrTWkwfIoKc4sjeE8qcxqFzk9
 hk2P6oes92X8/ndsaP5Y5z3BZfebfXLP5cLtcgAtJi/ltRoFQyz5EQaMQt0+A/2HIClv
 e1S4aKcm3aUbQl3ynsT2cuPcVCG64wlYfKACgGYQDVsClEmk/fJ5XlMfXwvCYom9rcvt
 gq3LG2PB41f/WzG3RUhzkdkJHJcvpZ7m5lL/4PxzcvHraHBV6TmypjIu1mPgGMntaQ3w
 T/WPmf37Wih31dIEWp4fsSXcwIieYCSo5yXiA7f7uXkpMho9gt917KlLAXXBT1nm1ERQ
 QcUg==
X-Gm-Message-State: AOJu0YzomSlBnvASmaBdhXAM248H6trcwyB/3NdioY+f5fu3MFLmECOQ
 6boRk7XG0jmAEFT96egAhJyGEMR6eDRlD8ReL6EpX2Dimz5Bvg==
X-Google-Smtp-Source: AGHT+IEirLmd0R9IFh5zMgfJ6ZTaTcLCBoep3YArxUHa2M8PxEt0FoaSaMDjl/89MghmO05Og7NBrA==
X-Received: by 2002:a05:6808:338b:b0:3bb:c774:565e with SMTP id
 ce11-20020a056808338b00b003bbc774565emr4852067oib.24.1703885356114; 
 Fri, 29 Dec 2023 13:29:16 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/71] hw/watchdog: Constify VMState
Date: Sat, 30 Dec 2023 08:23:36 +1100
Message-Id: <20231229212346.147149-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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
Message-Id: <20231221031652.119827-62-richard.henderson@linaro.org>
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


