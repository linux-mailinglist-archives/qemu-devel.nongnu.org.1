Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6D67CFA85
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSmv-00054Y-99; Thu, 19 Oct 2023 09:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSmn-0004qZ-EA
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:01 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSml-0007lr-6c
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:00 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5046bf37ec1so10019963e87.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697720997; x=1698325797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kCYRI8Q1kvi4VpcB4GZtS6fXIL0c6XiuN6TOx6QUjpw=;
 b=XeP2VzGjGC5sm1fK9s87Nzoq2buKj95HByZEIs9Jctr+TkbyFYtmxE+WEDcRILUTuC
 maHMhc9wLUPFTkSiRm2Gkum/YBOVa5Sf/O5fMI/2XXKmhUgEaBZDIHT6pkIbHs0ZMv5m
 HcG6Euz+x0VzQTyQvh9ObWCpOTcNejMmXLftlDQ3VwsfUn6E4sig8XcUqhH1v1gisE+k
 Y0oD1uvqcPi83Y6OnoDlm3VerffpMMsoaDibDD8KH/hAEErIcJZ6PfJ3+EwqqBPW4iL7
 rBrorCy+we2cpQiDtVUK8ZH66eSMYkq/pFTT8cP9isIpxZavFuJxAIRkyBfZBeSJysFK
 jgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697720997; x=1698325797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kCYRI8Q1kvi4VpcB4GZtS6fXIL0c6XiuN6TOx6QUjpw=;
 b=sg/C29TN1WtkrHZvZZU0b3/MnEebn+INTAx9ChgfQzuG5MIVmz8IV54SJ239TRMG0k
 LBhRN60QwZ2D9TH1uJR3l6aPXui3FrhyIBki/YcwFmeQkioDhhk7hMmN5NOe2z81EN9v
 j944K/YYye9gbeMZthYouA0W79mSNWi3je8udeLIfl+N9u+ftnSOxRk980WgxI6HV89c
 lRAASTESb/QGjKQnmIi+LN01RusDEhpdU5TRuisJLGnZZ2nc+mNx5fLZhKFUpbIOOJuZ
 UtlUO587A4CjRyh5VUD88BgSX+If/85N9JYDvfMEF+DhE0sRFu0/0lhK6MSBwesmbkxW
 wy9A==
X-Gm-Message-State: AOJu0Yyh7MwDne1AmwZYDZGiwcg0K7walmoiHBCMXSsVNVB4afwW/0XX
 f/g3yrMo9FQvFFFdCXxS6KYmg0A7NOudpM/O6ptlsA==
X-Google-Smtp-Source: AGHT+IGKqZhrC4uIaxxygIUsEn80aumRdNA4GEhb9YrxQmStgs/fpTFAeTuAeTht03bqPTfkWNEy/A==
X-Received: by 2002:a05:6512:b9f:b0:507:a650:991d with SMTP id
 b31-20020a0565120b9f00b00507a650991dmr1840661lfv.58.1697720997128; 
 Thu, 19 Oct 2023 06:09:57 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c028100b004077219aed5sm4324781wmk.6.2023.10.19.06.09.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:09:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 5/9] hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
Date: Thu, 19 Oct 2023 15:09:20 +0200
Message-ID: <20231019130925.18744-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/pxa.h |  2 --
 hw/arm/pxa2xx.c      | 12 ++++++++----
 hw/pcmcia/pxa2xx.c   |  6 ------
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index a2ab96d749..e3111fdf1a 100644
--- a/hw/pcmcia/pxa2xx.c
+++ b/hw/pcmcia/pxa2xx.c
@@ -138,12 +138,6 @@ static void pxa2xx_pcmcia_set_irq(void *opaque, int line, int level)
     qemu_set_irq(s->irq, level);
 }
 
-PXA2xxPCMCIAState *pxa2xx_pcmcia_init(MemoryRegion *sysmem,
-                                      hwaddr base)
-{
-    return PXA2XX_PCMCIA(sysbus_create_simple(TYPE_PXA2XX_PCMCIA, base, NULL));
-}
-
 static void pxa2xx_pcmcia_initfn(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-- 
2.41.0


