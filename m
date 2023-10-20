Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6027D1039
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpB6-0001td-6t; Fri, 20 Oct 2023 09:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAv-0001Tj-87
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:25 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAt-0005O9-B9
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:24 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-53e855d7dacso1197152a12.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807061; x=1698411861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jWeKlxu/1oSXjew02PYYb/4LgtdqaZA73Poob6GIouM=;
 b=XIs5MwA96Z1GkELKWrGRCGQIwtM5xqQMwBunRMxLHBh2vqPMO8dHjjDM87iGe7ejIe
 U6o7czKjElGfPjvAWxtXECaRFSu3JqB0bYck0LdQ/xI72WyJCPUKndNfdeDSY/Dqa5lB
 ZEc9AizjrrGQAG8StbKoLENga7zD7pOgcZ6XEPW0nSkzb8QHGCrKxegdNUD53KUHjjDZ
 zszwyjcCS35XsyyaebksYOTkn09cidtxEi9YH5XjnU6rYSxcQeGoJ0iglKZ2+WQrd2mU
 ycnqnhlQTsad0/AvA8P+nThOcweYrF78V6WrW+rZxMEvRUQZ52c0dvsTF5BvznyQHnLW
 pKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807061; x=1698411861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jWeKlxu/1oSXjew02PYYb/4LgtdqaZA73Poob6GIouM=;
 b=TyginWVURyyAhmyGII5QwuSaVVxa1xWflt492S1lQgT6hE1YFcIMcHHbS0svPWtVOU
 RKnLeyFqgIR1/tKgm5GjuE15QbK1gaddm26KgoLxy3KTlB05YbBKZR9voxstRtQDHAOC
 EZBVSuLWbx8yOQTfTfSSYciHbz+0poGerA/ITfWPayO6fKN6OufUEUjfqrQiKGYOpvBb
 3ZEU4apzRo41fnWYiCrH5i58ZP3kk32+3+II5hxGRduySf9oZ44JuLkGkS2pB6CVt1OF
 tXCKAnZHdCiFsY9sWPMvwe9xLC2mVFoG6th7ZlljKH0YdYJxx9kiEPvuYpu5ZDIcVhd9
 XiQg==
X-Gm-Message-State: AOJu0YxBTg64sMFwZcPRNnZpSd44Gxt+gS1CjhUjDqsF5GWp0srpVJk7
 uy1h+TdPaWUHV8k0DbyZXmIqYuibZlrjJAgbV08=
X-Google-Smtp-Source: AGHT+IEHhXZ9JXIf20xmHmtBllQggfIQbznjJVlAf0EeoL03otCuzAqz00dhwWL2IR6mXUhG8b8MlQ==
X-Received: by 2002:a50:9519:0:b0:53e:2409:d6f3 with SMTP id
 u25-20020a509519000000b0053e2409d6f3mr1309839eda.6.1697807061542; 
 Fri, 20 Oct 2023 06:04:21 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 q20-20020aa7da94000000b0053e9352643csm1404589eds.62.2023.10.20.06.04.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:04:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 8/9] hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of
 pxa2xx_pic_init()
Date: Fri, 20 Oct 2023 15:03:29 +0200
Message-ID: <20231020130331.50048-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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


