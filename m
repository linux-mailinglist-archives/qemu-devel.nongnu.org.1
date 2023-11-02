Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 588817DF900
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:42:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfH-0003TN-Kg; Thu, 02 Nov 2023 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybef-0003FM-Hq
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:53 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybeb-0002lP-Op
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:52 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40853c639abso8954925e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946727; x=1699551527; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OufKB18os/HPYVeDiWWwuMKqpNGGWOwdFVtfIjwPxs4=;
 b=uiwep+gxo5/Zlk+jrA/DtLTGNFb180/b59j6myLzJTgSd93z97x5Fe8OVTQPi2hFNG
 M/57+ZolPTYO9GkF5LpLZZOJCj2yfA7hEH0NmM9XUyjXXRnqo2zMWIsOalQCo/FJLJfM
 Z8jz0wIjG5+hzle8lusgMIOtrN9C8W7r5OdtMc7eMN9jOxrxtCH9Xyi/ds0VdtPG171m
 BIOC+WHADq4uSj/j5anR7Ypuus0/L7E0dqDMSjqSNH26VMU/UhLDGm6+QGAqSZQflMJq
 hq+HoajBjg4tvKC/H9NLF2T4HRAQDWxK4Nel+3WiUxyEegZWbARlsWwjBNvo9DRRKUJM
 LGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946727; x=1699551527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OufKB18os/HPYVeDiWWwuMKqpNGGWOwdFVtfIjwPxs4=;
 b=CO7xEPoRBX0gmbDrlhWtC0eX2axeSyrqw6hM+zVhUrH8q0tcoxEMYCfEh1WromRjYT
 Ar/WSwyijgSLMWzC3VoPzNl9Y60hGC8+al3UNSqfvhJJ9vF9W/41mpJoKF+FIC9wzIol
 o4Kbk1rdI25CF/1pWX0v4dgdyrya3yaq+mtp5iU3TmLgjka3d6vDRu4h29YB7K73zoCm
 LmEWVxIJr4w/HrlOdoHJETHPG7xOER1YcSr/X9KzsmRtkaiSoSoOTro0WXxfdVvX0VPE
 qGW5+1WAy5xJGnVWmL6fqtdNZOnrP8wXOMq5mZJfx7jPa5CmUO/7pItHGnFHw1zva7MV
 mpfg==
X-Gm-Message-State: AOJu0Yz4MBk1XRrl/S5nuWdm+BMDnj/+H0NHge+ZZoIPpQB9YIY2QU5S
 4RFKqM/GWgkafozuL7lAtKN6wKAZE1T0q3mQ4go=
X-Google-Smtp-Source: AGHT+IH7xisEN015V9C0X0XX01NbuLVmx3WppQlCldnqKei6YVQqNO55/DYCnyMY+W1AVjd8xt/wuQ==
X-Received: by 2002:a5d:5e87:0:b0:32d:a427:7fda with SMTP id
 ck7-20020a5d5e87000000b0032da4277fdamr17673036wrb.48.1698946727193; 
 Thu, 02 Nov 2023 10:38:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/33] hw/watchdog/wdt_imx2: Trace MMIO access
Date: Thu,  2 Nov 2023 17:38:20 +0000
Message-Id: <20231102173835.609985-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20231028122415.14869-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/wdt_imx2.c   | 24 ++++++++++++++++++------
 hw/watchdog/trace-events |  4 ++++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/hw/watchdog/wdt_imx2.c b/hw/watchdog/wdt_imx2.c
index e776a2fbd40..885ebd39787 100644
--- a/hw/watchdog/wdt_imx2.c
+++ b/hw/watchdog/wdt_imx2.c
@@ -17,6 +17,7 @@
 #include "hw/qdev-properties.h"
 
 #include "hw/watchdog/wdt_imx2.h"
+#include "trace.h"
 
 static void imx2_wdt_interrupt(void *opaque)
 {
@@ -67,20 +68,29 @@ static void imx2_wdt_reset(DeviceState *dev)
 static uint64_t imx2_wdt_read(void *opaque, hwaddr addr, unsigned int size)
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
+    uint16_t value = 0;
 
     switch (addr) {
     case IMX2_WDT_WCR:
-        return s->wcr;
+        value = s->wcr;
+        break;
     case IMX2_WDT_WSR:
-        return s->wsr;
+        value = s->wsr;
+        break;
     case IMX2_WDT_WRSR:
-        return s->wrsr;
+        value = s->wrsr;
+        break;
     case IMX2_WDT_WICR:
-        return s->wicr;
+        value = s->wicr;
+        break;
     case IMX2_WDT_WMCR:
-        return s->wmcr;
+        value = s->wmcr;
+        break;
     }
-    return 0;
+
+    trace_imx2_wdt_read(addr, value);
+
+    return value;
 }
 
 static void imx_wdt2_update_itimer(IMX2WdtState *s, bool start)
@@ -137,6 +147,8 @@ static void imx2_wdt_write(void *opaque, hwaddr addr,
 {
     IMX2WdtState *s = IMX2_WDT(opaque);
 
+    trace_imx2_wdt_write(addr, value);
+
     switch (addr) {
     case IMX2_WDT_WCR:
         if (s->wcr_locked) {
diff --git a/hw/watchdog/trace-events b/hw/watchdog/trace-events
index 2739570652b..874968cc06a 100644
--- a/hw/watchdog/trace-events
+++ b/hw/watchdog/trace-events
@@ -17,6 +17,10 @@ cmsdk_apb_watchdog_lock(uint32_t lock) "CMSDK APB watchdog: lock %" PRIu32
 aspeed_wdt_read(uint64_t addr, uint32_t size) "@0x%" PRIx64 " size=%d"
 aspeed_wdt_write(uint64_t addr, uint32_t size, uint64_t data) "@0x%" PRIx64 " size=%d value=0x%"PRIx64
 
+# wdt_imx2.c
+imx2_wdt_read(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] -> 0x%" PRIx16
+imx2_wdt_write(uint32_t addr, uint16_t data) "[0x%" PRIx32 "] <- 0x%" PRIx16
+
 # spapr_watchdog.c
 spapr_watchdog_start(uint64_t flags, uint64_t num, uint64_t timeout) "Flags 0x%" PRIx64 " num=%" PRId64 " %" PRIu64 "ms"
 spapr_watchdog_stop(uint64_t num, uint64_t ret) "num=%" PRIu64 " ret=%" PRId64
-- 
2.34.1


