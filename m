Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE67D1040
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:06:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAv-0001MA-Po; Fri, 20 Oct 2023 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAh-0000jg-2p
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAc-0005Kp-FN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:10 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso1167223a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807044; x=1698411844; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmDbO/dcRUqE0czIvHJsu49pLqguapp9vtFtJrgXUPM=;
 b=k2lBeoG910M0jYNxBlYsd7Xo0RPA2TJGgHN3ZlfloV6jh/xDTxeMGa2YqPRv/158s/
 fkxGTHNDeIPI0wbJ0YL5mCQFLJCMSTo2casywlQ6NMiHylMGG92KmbX9bZwL6BFJJN2j
 SnvYRe6c4t2kBaRF8lQ33DIXL/mcXGfp20GkrVHhBd1snEMFRk3THD4A35k2zDH/MAXz
 nLKAYM4zVUr+GfnLo6CvbshYeLlMAG7bz3U4K1U3D+2NzjbweuNM9GbCxVfKMJfE+nTW
 Q7e9+wRkMh36Ed68T0l9bBhs6uayqyDNJ5q5JBBSBY8WFCQdsOuBMrqwqQFal11BrQXR
 Pihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807044; x=1698411844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmDbO/dcRUqE0czIvHJsu49pLqguapp9vtFtJrgXUPM=;
 b=NVLTqJ4rvv+aFaHEOoHw8PDfx3ZwnAnYqs29gA/xh3GE87mSi5fXaNvbN+Y1a1SkiZ
 HcuC0JY/z4IlqArHj5elRVUXHVQpDwOOCEHLLufR6ckCTmclGQwrYY8xVcwMOfrPGHKJ
 ohedRflA+cRN4LK/wZN7pj1qIqit556cYx99ZwjCPIfhLsz8gyp4FnA5hBh+3tQ5FnyI
 sfeVSou26YqkzQgC1qpIMzubBlQ/kebwCfK7/GHIvBWcVcAKX1fPrS2UeXNVa3RbOLYf
 MO6vZNLohgxCIV0k++TpZTuwXMKHb/oWNCUSeJGJWE01Ph6D+AVSjextJbzZlLhS/Enl
 7j4Q==
X-Gm-Message-State: AOJu0YxbGOyxX9qDrEDAPfnlvycydKsy/cEXhK5DvbhNCjsCxzOToTfI
 uQeBiJJoi2VelLCICX0IAYhn1MkQz+FtO7tOuz8=
X-Google-Smtp-Source: AGHT+IFPx5MOeKfd5RN5WsHWGu4StzuG3bkMIGJvgsSaoJdGtx9W8enjTL4bGJN6UyhTL3mnFhsJvQ==
X-Received: by 2002:a50:9ecb:0:b0:53e:f9ef:ca6b with SMTP id
 a69-20020a509ecb000000b0053ef9efca6bmr1462884edf.7.1697807044042; 
 Fri, 20 Oct 2023 06:04:04 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 q28-20020a50cc9c000000b0053f84540db8sm1449027edi.17.2023.10.20.06.04.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:04:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 5/9] hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
Date: Fri, 20 Oct 2023 15:03:26 +0200
Message-ID: <20231020130331.50048-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/pxa.h |  2 --
 hw/arm/pxa2xx.c      | 12 ++++++++----
 hw/pcmcia/pxa2xx.c   | 10 ----------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/hw/arm/pxa.h b/include/hw/arm/pxa.h
index 54eb895e42..4c6caee113 100644
--- a/include/hw/arm/pxa.h
+++ b/include/hw/arm/pxa.h
@@ -100,8 +100,6 @@ void pxa2xx_mmci_handlers(PXA2xxMMCIState *s, qemu_irq readonly,
 #define TYPE_PXA2XX_PCMCIA "pxa2xx-pcmcia"
 OBJECT_DECLARE_SIMPLE_TYPE(PXA2xxPCMCIAState, PXA2XX_PCMCIA)
 
-PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
-                                      hwaddr base);
 int pxa2xx_pcmcia_attach(void *opaque, PCMCIACardState *card);
 int pxa2xx_pcmcia_detach(void *opaque);
 void pxa2xx_pcmcia_set_irq_cb(void *opaque, qemu_irq irq, qemu_irq cd_irq);
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 07d5dd8691..601ddd8766 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -2205,8 +2205,10 @@ PXA2xxState *pxa270_init(unsigned int sdram_size, const char *cpu_type)
     sysbus_create_simple("sysbus-ohci", 0x4c000000,
                          qdev_get_gpio_in(s->pic, PXA2XX_PIC_USBH1));
 
-    s->pcmcia[0] = pxa2xx_pcmcia_init(address_space, 0x20000000);
-    s->pcmcia[1] = pxa2xx_pcmcia_init(address_space, 0x30000000);
+    s->pcmcia[0] = PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA,
+                                                      0x20000000, NULL));
+    s->pcmcia[1] = PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA,
+                                                      0x30000000, NULL));
 
     sysbus_create_simple(TYPE_PXA2XX_RTC, 0x40900000,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_RTCALARM));
@@ -2338,8 +2340,10 @@ PXA2xxState *pxa255_init(unsigned int sdram_size)
         s->ssp[i] = (SSIBus *)qdev_get_child_bus(dev, "ssi");
     }
 
-    s->pcmcia[0] = pxa2xx_pcmcia_init(address_space, 0x20000000);
-    s->pcmcia[1] = pxa2xx_pcmcia_init(address_space, 0x30000000);
+    s->pcmcia[0] = PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA,
+                                                      0x20000000, NULL));
+    s->pcmcia[1] = PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA,
+                                                      0x30000000, NULL));
 
     sysbus_create_simple(TYPE_PXA2XX_RTC, 0x40900000,
                     qdev_get_gpio_in(s->pic, PXA2XX_PIC_RTCALARM));
diff --git a/hw/pcmcia/pxa2xx.c b/hw/pcmcia/pxa2xx.c
index 3d512a292c..e3111fdf1a 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -138,16 +138,6 @@ static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
     qemu_set_irq(s->irq, level);
 }
 
-PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
-                                      hwaddr base)
-{
-    DeviceState *dev;
-
-    dev = sysbus_create_simple(TYPE_PXA2XX_PCMCIA, base, NULL);
-
-    return PXA2XX_PCMCIA(dev);
-}
-
 static void pxa2xx_pcmcia_initfn(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-- 
2.41.0


