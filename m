Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C69DE7D9BF9
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 16:46:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwO0p-0008Nv-AT; Fri, 27 Oct 2023 10:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0I-0007LV-Jw
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:04 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qwO0F-0008BB-2f
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 10:40:02 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2c50ec238aeso30426801fa.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 07:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698417597; x=1699022397; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=my7OnQbRaZ6vmyGLjZG5PCWu8hQo8B8j0gxAVZuRna4=;
 b=ysaDrItfu3Qrmn7P71BGQAXv2R9aAyqI8CNyoJ3NWBCVBp6ez7iqMGJYRv0bga2Thz
 a8/Ule2h9kKHzIajU9G1ee+lh2/3BIYtg/67IFwdfenyXMv5OV3uCbSU5PO0lZ5uZT3c
 ZS0mFE+iLBbLttqt3CFqPp7/jxhckXCdadUKe+Bjbtvg94pHfGcyQj+RMQENIj2EaOaz
 Id0p8rAAqTWPP+gWFMySLY4ZxjRN8y7NeSClK1BWXnLOg8RcIH7qmsWqsY/bxvlqXO2I
 2F3IA3WgdemrnZL97H2Ys4ltyFmqcN/Un2aHKIw8WWnalZTxAOQTuOscx0kJwkRk79/h
 CfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698417597; x=1699022397;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=my7OnQbRaZ6vmyGLjZG5PCWu8hQo8B8j0gxAVZuRna4=;
 b=txoNj1H9KjbYQGmldZCQ0naH9OSWhpjZSZGULtNcMZknVhtjPy6G6uAx6mfJcyRM60
 TdRKhreMCTGsj+3o64Bf+uPERkoBoviVRc/SYTXQvK6G8x1Ot0dgCWwwkzfivf0wQPw3
 aKebcfpc19m+nFtBnFdpdiyBcEcYZWfazd85wgUh1akRLBG0iFi4CbuCLbyGyQYpKcBD
 QhRFemaRdatLnP+2gXM6OH2bMXzDF959rDHgDjHfbbty6yPs7zW7EK8prrMxwz8DeR4k
 E99+ubnkfRkqXBGx+v9mOTo6vALSKK2zvZXmJ0QHL3zQ5zXpSWEeUEOisdpIx5oByNjq
 HuyQ==
X-Gm-Message-State: AOJu0YyJ1h+WZ16ZkcHRSIxrrrLbxWVE99xosYOgfZzyOErUN/+JEnB2
 jKQwPFCWebaHwQgsOYLfUeTUFwwhBrFjJRgsOzA=
X-Google-Smtp-Source: AGHT+IGh0c4sw1HQJFfpH1Z/FQY7jod17HzV0NbU1j1+0ZmCqiaataY+yxRev3UKYqvOZxOkhxB+uQ==
X-Received: by 2002:a2e:958e:0:b0:2c5:115c:2d33 with SMTP id
 w14-20020a2e958e000000b002c5115c2d33mr2444580ljh.3.1698417597289; 
 Fri, 27 Oct 2023 07:39:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a5d5002000000b0031c6581d55esm1874123wrt.91.2023.10.27.07.39.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Oct 2023 07:39:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/41] hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of
 pxa2xx_pic_init()
Date: Fri, 27 Oct 2023 15:39:28 +0100
Message-Id: <20231027143942.3413881-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20231020130331.50048-9-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 7e180635c22..1373a0d275f 100644
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
2.34.1


