Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BD38328A2
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 12:15:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQmpg-0007Yd-NN; Fri, 19 Jan 2024 06:14:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpZ-0007Vw-0R
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:37 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQmpU-0007Jg-2N
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 06:14:35 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a2d04888d3dso67953966b.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 03:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705662869; x=1706267669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ED7tv8DZ9a/S5xBH8be2DHeN5dwoaIIT6ClYiv99xYM=;
 b=RNokACRm2wUO1NoaBQ4SKO+Lmdp9BHOlFM/uI5HmhKxizcFaj06xmSAGObGJZlE0iL
 eCikGVTY8WDD3AyYFImj4zFDXcrawzM92SPjqS/3bHdMvoInGATX5/1K2XtjaTv3Dzk9
 S+IXriC+3Gk6cBHODiIN1JY1BT1Joa1H2IdIA7cvZL4tMggybf/yjntj/9f+cAitGX5b
 F1l0rH3uiZoEmpWPilbuMHLzZc51g3Ty0AhVtQi2EN6Z16ZwaRxGh9a1XWFS4+gF3Tk1
 7bXbjqiQ8ToJb41YYy6NkzKyH3nBknvUGo+2VxYlzr0MFUQI5ZA5UwWhnC5oTf7DFKHT
 Gk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705662869; x=1706267669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ED7tv8DZ9a/S5xBH8be2DHeN5dwoaIIT6ClYiv99xYM=;
 b=NGRkxfDuBjRC0EpzZW1gAMj5CjqUQCBd9iY223JCiKEOangmb1YpXgvFvnAzXccFWZ
 SAvHs/x0pYEOVpwBjOYYRkvx4bhl17Rxjt32Nsnahje8Jo5qJAhUH+UM9keeyXlzE0SF
 YpYqrIvaSYkDqMAVvp2Yd2b5yfxooJys1szu1P6pV37QHIYpebuMwuVr6vZMOZ2f230A
 mPr0MxShvRspL0W0W+HA74QSxwkfnHgG5QViS30nAapA+B35sUApSTjQ0q0HtBLSWwkp
 R08Ye+fZnTS9M8D2iNw4Sf5RTcSOwHYUj8+w+RkT47H7q17ZfcyUQ/0vi2jJPkLy1mpG
 N/5A==
X-Gm-Message-State: AOJu0YzyFljU416km0LQRVmxAP3AfLGWVmaRDSvYHx9UanpK2RSunOKq
 x5veAYY9pAsHgj2AJWuhJdielAnX69GShEgkyOkZ/mTyOTLSQqSbwhYqAlDXxVbBOQ/zxjMnH15
 Xg8Q=
X-Google-Smtp-Source: AGHT+IE4ZX4c14VUo3cfdAFEFLYoCf8R4yQDCgPLrWhSQEz6A2ZGyGtoFDzZNWCjT0SPwkPNbtqy2Q==
X-Received: by 2002:a17:907:7f02:b0:a2b:ca83:1576 with SMTP id
 qf2-20020a1709077f0200b00a2bca831576mr1691215ejc.85.1705662868760; 
 Fri, 19 Jan 2024 03:14:28 -0800 (PST)
Received: from localhost.localdomain (adsl-114.109.242.227.tellas.gr.
 [109.242.227.114]) by smtp.gmail.com with ESMTPSA id
 vq9-20020a170907a4c900b00a2ca97242d5sm9283321ejc.120.2024.01.19.03.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 03:14:28 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 1/6] hw/arm/z2: convert DPRINTF to tracepoints
Date: Fri, 19 Jan 2024 13:14:19 +0200
Message-Id: <021405f5ef53ebe80c7218e1df537635d34889b3.1705662313.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
References: <cover.1705662313.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62e.google.com
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on tracepoints should be able to opt-in to each tracepoint and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into tracepoints.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/arm/trace-events |  8 ++++++++
 hw/arm/z2.c         | 26 +++++++++-----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index cdc1ea06a8..a262ad2e6a 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -55,3 +55,11 @@ smmuv3_notify_flag_add(const char *iommu) "ADD SMMUNotifier node for iommu mr=%s
 smmuv3_notify_flag_del(const char *iommu) "DEL SMMUNotifier node for iommu mr=%s"
 smmuv3_inv_notifiers_iova(const char *name, uint16_t asid, uint16_t vmid, uint64_t iova, uint8_t tg, uint64_t num_pages) "iommu mr=%s asid=%d vmid=%d iova=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64
 
+# z2.c
+z2_lcd_cur_reg_update(uint8_t r) "reg: 0x%x"
+z2_lcd_enable_disable(uint16_t v) "value: 0x%x"
+z2_lcd_enable_disable_result(const char * result) "LCD %s"
+z2_lcd_invalid_command(uint8_t value) "0x%x"
+z2_aer915_send_too_log(int8_t msg) "message too long (%i bytes)"
+z2_aer915_send(uint8_t reg, uint8_t value) "reg %d value 0x%02x"
+z2_aer915_i2c_start_recv(uint16_t len) "I2C_START_RECV: short message with len %d"
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index 83741a4909..6c0889d698 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -28,13 +28,7 @@
 #include "cpu.h"
 #include "qom/object.h"
 #include "qapi/error.h"
-
-#ifdef DEBUG_Z2
-#define DPRINTF(fmt, ...) \
-        printf(fmt, ## __VA_ARGS__)
-#else
-#define DPRINTF(fmt, ...)
-#endif
+#include "trace.h"
 
 static const struct keymap map[0x100] = {
     [0 ... 0xff] = { -1, -1 },
@@ -127,22 +121,22 @@ static uint32_t zipit_lcd_transfer(SSIPeripheral *dev, uint32_t value)
     if (z->pos == 3) {
         switch (z->buf[0]) {
         case 0x74:
-            DPRINTF("%s: reg: 0x%.2x\n", __func__, z->buf[2]);
+            trace_z2_lcd_cur_reg_update(z->buf[2]);
             z->cur_reg = z->buf[2];
             break;
         case 0x76:
             val = z->buf[1] << 8 | z->buf[2];
-            DPRINTF("%s: value: 0x%.4x\n", __func__, val);
+            trace_z2_lcd_enable_disable(val);
             if (z->cur_reg == 0x22 && val == 0x0000) {
                 z->enabled = 1;
-                printf("%s: LCD enabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("enabled");
             } else if (z->cur_reg == 0x10 && val == 0x0000) {
                 z->enabled = 0;
-                printf("%s: LCD disabled\n", __func__);
+                trace_z2_lcd_enable_disable_result("disabled");
             }
             break;
         default:
-            DPRINTF("%s: unknown command!\n", __func__);
+            trace_z2_lcd_invalid_command(z->buf[0]);
             break;
         }
         z->pos = 0;
@@ -212,14 +206,12 @@ static int aer915_send(I2CSlave *i2c, uint8_t data)
 
     s->buf[s->len] = data;
     if (s->len++ > 2) {
-        DPRINTF("%s: message too long (%i bytes)\n",
-            __func__, s->len);
+        trace_z2_aer915_send_too_log(s->len);
         return 1;
     }
 
     if (s->len == 2) {
-        DPRINTF("%s: reg %d value 0x%02x\n", __func__,
-                s->buf[0], s->buf[1]);
+        trace_z2_aer915_send(s->buf[0], s->buf[1]);
     }
 
     return 0;
@@ -235,7 +227,7 @@ static int aer915_event(I2CSlave *i2c, enum i2c_event event)
         break;
     case I2C_START_RECV:
         if (s->len != 1) {
-            DPRINTF("%s: short message!?\n", __func__);
+            trace_z2_aer915_i2c_start_recv(s->len);
         }
         break;
     case I2C_FINISH:
-- 
γαῖα πυρί μιχθήτω


