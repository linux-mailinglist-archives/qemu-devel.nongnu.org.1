Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DCD7CFA90
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:13:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSnA-0005h9-5u; Thu, 19 Oct 2023 09:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSn5-0005dJ-BD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:19 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtSn3-00085K-6K
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:10:18 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so6853312f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697721015; x=1698325815; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWeKlxu/1oSXjew02PYYb/4LgtdqaZA73Poob6GIouM=;
 b=RkTgFM8fg6H1DlCEBPBowU4aLivDDNyXf1c5QGyIjjhldO98ezgd4C+eSURS5cbq2x
 GNlifTc+fazdYfAN2tl6pg4Y6aATiEg1aB/WgWVSnvcDtBOs67QwfI1zmRmTdJJOQTEZ
 gVRycj/9Arw6t6JiBD2W6fiY0hdXJ/RqZPrmVnm+ckae9f+BuPh3Rv3IJ7ZnKQ5o+hDA
 PVXXm1Ur1K/Bq1QlZr31e+ekpwfT8PB34JLnBxlImHjqeULKyzWLFBbBlh59AMEkvrLJ
 vTHez2BNCHCJt73c3j22DDoRKXrjaw/qFtBpzvqK5+GnMC39lWmXUGnhZwqwXWtDzAPQ
 VgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697721015; x=1698325815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWeKlxu/1oSXjew02PYYb/4LgtdqaZA73Poob6GIouM=;
 b=ITePQk8wBGmHw/tB+NNXr4lzfM0dSnA666aa/gOVtPjLqZEW21kYZGZCeUYpRUhBtp
 u6//nyvD2Qk7riToRKFxi+lLXMnySG5AIoe8kQPOyc8ER6Q5ivNje785Aw9YZY7kStOc
 /PKLPO6QB6dcd4DhZY35mw6eNhNzjYEPU6Z1uooYyhaH5mSjZVpZ3JPFpisTLp4fExp4
 RoH8uxaYPLsjoyExgFQzFdtsqrH49EzAIdUgHyVQItf8dRs4SVd3d3qrPPkuqk+Qa4Ti
 5d03zlYMP9vOQvFANE9cD4jz9uTxCA+woO8p6XlBur2V3yEuENfwdMGx5LuWTqUn74fT
 Xytg==
X-Gm-Message-State: AOJu0Yze3jkCoi9eyd3Pz2MY40k0DWi6e3WmNn8CLNOzd3kfWNdoDQ2I
 xUzOKBi5/T+f3FqHh67c4hOn1OmN/SSsiLM27AVphQ==
X-Google-Smtp-Source: AGHT+IFo2GfT0l/Czer8nhIUVi1v8USqPk+tannTVKC/RkXgHd0jmsotxXsUqZsYqLSvDCMRCfDGLQ==
X-Received: by 2002:a5d:66cd:0:b0:321:677d:98b0 with SMTP id
 k13-20020a5d66cd000000b00321677d98b0mr1477106wrw.11.1697721015193; 
 Thu, 19 Oct 2023 06:10:15 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a5d4bd0000000b00323293bd023sm4461613wrt.6.2023.10.19.06.10.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 06:10:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of
 pxa2xx_pic_init()
Date: Thu, 19 Oct 2023 15:09:23 +0200
Message-ID: <20231019130925.18744-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019130925.18744-1-philmd@linaro.org>
References: <20231019130925.18744-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 hw/arm/pxa2xx_pic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 7e180635c2..1373a0d275 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -287,12 +287,18 @@ static void pxa2xx_pic_reset_hold(Object *obj)
 DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
 {
     DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
-    PXA2xxPICState *s = PXA2XX_PIC(dev);
 
     object_property_set_link(OBJECT(dev), "arm-cpu",
                              OBJECT(cpu), &error_abort);
-
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
+
+    return dev;
+}
+
+static void pxa2xx_pic_realize(DeviceState *dev, Error **errp)
+{
+    PXA2xxPICState *s = PXA2XX_PIC(dev);
 
     qdev_init_gpio_in(dev, pxa2xx_pic_set_irq, PXA2XX_PIC_SRCS);
 
@@ -300,12 +306,9 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     memory_region_init_io(&s->iomem, OBJECT(s), &pxa2xx_pic_ops, s,
                           "pxa2xx-pic", 0x00100000);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
 
     /* Enable IC coprocessor access.  */
-    define_arm_cp_regs_with_opaque(cpu, pxa_pic_cp_reginfo, s);
-
-    return dev;
+    define_arm_cp_regs_with_opaque(s->cpu, pxa_pic_cp_reginfo, s);
 }
 
 static const VMStateDescription vmstate_pxa2xx_pic_regs = {
@@ -335,6 +338,7 @@ static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, pxa2xx_pic_properties);
+    dc->realize = pxa2xx_pic_realize;
     dc->desc = "PXA2xx PIC";
     dc->vmsd = &vmstate_pxa2xx_pic_regs;
     rc->phases.hold = pxa2xx_pic_reset_hold;
-- 
2.41.0


