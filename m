Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8834C7E1AD3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:13:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg0-0006EC-UF; Mon, 06 Nov 2023 02:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd5-0000nS-Ix
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:44 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcs-00021C-Vw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:35 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6b20577ef7bso3859604b3a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254141; x=1699858941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fy1/pxSKYPLnC7iC7jUDLvYtACSeBLVWlhtQd/mhggA=;
 b=cn/0zravhpXGx7le9LSiqOR7OttSzv7401rty11a6P6K4ua7M/8VwV+ydWguxyXHIV
 7wK7K5VaE0raMBtVUtVmmtZMwif48e0rIsIEl2OdGYyWst6und8aQ4AIkTNmBkLgAwvo
 IaImNlq8c1tKNHawFXeyMbLRJfe9M9SvBEqQVTbttHVgfgELdCWgkmKJo/+IRV0AqJAu
 o76AIFmkA3VlKtns+/ShffS/7hWBTeJ4ZtdqWFVnuP7aW8W0aFJ8zqRqkPi90iYhlEMS
 IHPgJD6HV/O2aDHfW8cJzFSbsJrigQBZ8JzC4EP0IiEa5rGIjF2Q7cAXsrlBse0gFMvg
 D2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254141; x=1699858941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fy1/pxSKYPLnC7iC7jUDLvYtACSeBLVWlhtQd/mhggA=;
 b=POeqfsm0XP8RxBxBYlwBQYrZNFnyt+ohvBTfHn24VZQJjWy5n42BkpmvVVHZwe845q
 7N0IhvxpTLhawjdBRX3Sgm9tYCHRNHvv3DZ1DjeXpppoAUujmuPoheUEnJMVjFGOp+g6
 9mihMoXQCEmKlM2nBFNwsQ3ixTSuEAcZb/Lj1S52lDIHnuGrvsmV2MReC0Rfz2z0KgAC
 X9wiIgkTSUahXhyooQIXCcAWMJGE8uWbUAbNz/GVxp4EBvmr+lhLUGx5Rg0b+4iKNvJb
 9a/nGhpHhxz9cAdDlSLytmMAw3Oqh2LpLtMKm0SeVayvuxa8pbZPpprQvC9c3sOrmnQG
 7JmQ==
X-Gm-Message-State: AOJu0Yz8lZZdCzTKKkwFumUzxi6CAqypgXy8s6CkWm+RxYOwwrBba6YO
 4FwWR+kEgGmq8qssItaiVNgkxKBYfPSe6ngEHjU=
X-Google-Smtp-Source: AGHT+IG9iGWJBPnbMG3gXFOYB/R1Pw1MGnbEDl16qeXICxeP5dFXbcclhmsjmt14Z1BeXuH8cxW+1w==
X-Received: by 2002:a05:6a20:1454:b0:16b:80f2:f30c with SMTP id
 a20-20020a056a20145400b0016b80f2f30cmr26554092pzi.26.1699254141508; 
 Sun, 05 Nov 2023 23:02:21 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 61/71] hw/watchdog: Constify VMState
Date: Sun,  5 Nov 2023 22:58:17 -0800
Message-Id: <20231106065827.543129-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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
index d267aa185c..3888438dff 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -219,7 +219,7 @@ static const VMStateDescription vmstate_aspeed_wdt = {
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


