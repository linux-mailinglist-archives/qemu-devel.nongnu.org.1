Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B437DF917
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 18:46:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qybfO-0003gi-Be; Thu, 02 Nov 2023 13:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybek-0003Hj-8G
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:39:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qybei-0002zi-4N
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 13:38:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40859c464daso8981275e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 10:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698946735; x=1699551535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bw+NalypwIx1j4sKRcT1ebbMc0jvSR3eUfnw2LvsKB0=;
 b=a3HAL3CQ5tyXCntH1L+QJqHRV0lmnM40IvGQdD/zCmlMezn1gz7WEvhao/0/yrjgKa
 OWppC7480coI2FDSAjldbIQoBhFHycp5UZI4zZPDBAD5AAiaB2fnd1UIFPceoMUnaAXI
 X+mYVsZ6ZB9n4iD4hbzVV1oKoX92GCMUnhzdyJqI2JQYZm/1WoAKoVf0hhEb+NwKrRs2
 B8jaBY7yV5IeUEX5EDwIyGtk/OdVwpRnfmWn0YarztKRFyOBFYCQ6tYFQFavAQUpqd0T
 uKarY1rB8CF9OE7BKCM8RGVRjfxabQaBFC8yxWB65XwiNIOurfJL+Lsg1OM886YcW1vd
 XgWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698946735; x=1699551535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bw+NalypwIx1j4sKRcT1ebbMc0jvSR3eUfnw2LvsKB0=;
 b=Eg2e5UrB4600BTtitQpm8AFKI+dl52l/O2w6VEXhL49XPBay/rvhx33Owg1Gudv0x6
 3+EYzpRnfnFrc3Z/f/86JkFAZ8D4ZXEYj3/b5jbmJd73Msw/amfrWNm78f08WDNArOwE
 +UXK9RCgZEvv6hWcgEU1SqkSu98W3Fm5A9LfI3/MNr0GkMxO7uBpIZqAADJItfSIvg7Q
 2FF8sy6oN5pHIAuDDZK+6/2OkPAr9GdFFcGLvuBPbEfpcXUg7jWWk0Gl7s4SkXNy6CFV
 qpoQu2EW0P3fIHkyTvENkoR9zm17U8Z85U83CJPPXXF89IJfgRLYF9lnPTAGZpSrkyl3
 oAvA==
X-Gm-Message-State: AOJu0YzULEf1yQ9cbNadCi8Rjv05vYW1kGIVxaoQkbKVXqem4j/Fvcl9
 J4ZBMo6kZOAEN/nLHp2dIwDhjdJvRvHSm5zljIk=
X-Google-Smtp-Source: AGHT+IEXoc+ytXUUL/d4dsT/t9UYwGqNRnz+RGTLTkgMpXCdDXOUpWgtTTt3KWhPvvfaKRMS8MgcFg==
X-Received: by 2002:a5d:6d86:0:b0:32f:7f17:b049 with SMTP id
 l6-20020a5d6d86000000b0032f7f17b049mr12050011wrs.39.1698946734856; 
 Thu, 02 Nov 2023 10:38:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e16-20020adff350000000b003258934a4bcsm3046805wrp.42.2023.11.02.10.38.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 10:38:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/33] hw/arm: xlnx-versal-virt: Add AMD/Xilinx TRNG device
Date: Thu,  2 Nov 2023 17:38:34 +0000
Message-Id: <20231102173835.609985-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102173835.609985-1-peter.maydell@linaro.org>
References: <20231102173835.609985-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Tong Ho <tong.ho@amd.com>

Connect the support for Versal True Random Number Generator
(TRNG) device.

Warning: unlike the TRNG component in a real device from the
Versal device familiy, the connected TRNG model is not of
cryptographic grade and is not intended for use cases when
cryptograpically strong TRNG is needed.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20231031184611.3029156-3-tong.ho@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  5 +++++
 hw/arm/xlnx-versal.c         | 16 ++++++++++++++++
 hw/arm/Kconfig               |  1 +
 3 files changed, 22 insertions(+)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index b710d71fb08..b24fa64557f 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -30,6 +30,7 @@
 #include "hw/dma/xlnx_csu_dma.h"
 #include "hw/misc/xlnx-versal-crl.h"
 #include "hw/misc/xlnx-versal-pmc-iou-slcr.h"
+#include "hw/misc/xlnx-versal-trng.h"
 #include "hw/net/xlnx-versal-canfd.h"
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
@@ -115,6 +116,7 @@ struct Versal {
         } iou;
 
         XlnxZynqMPRTC rtc;
+        XlnxVersalTRng trng;
         XlnxBBRam bbram;
         XlnxEFuse efuse;
         XlnxVersalEFuseCtrl efuse_ctrl;
@@ -159,6 +161,7 @@ struct Versal {
 #define VERSAL_OSPI_IRQ            124
 #define VERSAL_SD0_IRQ_0           126
 #define VERSAL_EFUSE_IRQ           139
+#define VERSAL_TRNG_IRQ            141
 #define VERSAL_RTC_ALARM_IRQ       142
 #define VERSAL_RTC_SECONDS_IRQ     143
 
@@ -328,4 +331,6 @@ struct Versal {
 #define MM_PMC_CRP_SIZE             0x10000
 #define MM_PMC_RTC                  0xf12a0000
 #define MM_PMC_RTC_SIZE             0x10000
+#define MM_PMC_TRNG                 0xf1230000
+#define MM_PMC_TRNG_SIZE            0x10000
 #endif
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index fa556d8764b..4f74a64a0d7 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -373,6 +373,21 @@ static void versal_create_rtc(Versal *s, qemu_irq *pic)
                        qdev_get_gpio_in(DEVICE(&s->pmc.apb_irq_orgate), 0));
 }
 
+static void versal_create_trng(Versal *s, qemu_irq *pic)
+{
+    SysBusDevice *sbd;
+    MemoryRegion *mr;
+
+    object_initialize_child(OBJECT(s), "trng", &s->pmc.trng,
+                            TYPE_XLNX_VERSAL_TRNG);
+    sbd = SYS_BUS_DEVICE(&s->pmc.trng);
+    sysbus_realize(sbd, &error_fatal);
+
+    mr = sysbus_mmio_get_region(sbd, 0);
+    memory_region_add_subregion(&s->mr_ps, MM_PMC_TRNG, mr);
+    sysbus_connect_irq(sbd, 0, pic[VERSAL_TRNG_IRQ]);
+}
+
 static void versal_create_xrams(Versal *s, qemu_irq *pic)
 {
     int nr_xrams = ARRAY_SIZE(s->lpd.xram.ctrl);
@@ -909,6 +924,7 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_sds(s, pic);
     versal_create_pmc_apb_irq_orgate(s, pic);
     versal_create_rtc(s, pic);
+    versal_create_trng(s, pic);
     versal_create_xrams(s, pic);
     versal_create_bbram(s, pic);
     versal_create_efuse(s, pic);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 841f3131ea5..e35007ed413 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -482,6 +482,7 @@ config XLNX_VERSAL
     select XLNX_BBRAM
     select XLNX_EFUSE_VERSAL
     select XLNX_USB_SUBSYS
+    select XLNX_VERSAL_TRNG
 
 config NPCM7XX
     bool
-- 
2.34.1


