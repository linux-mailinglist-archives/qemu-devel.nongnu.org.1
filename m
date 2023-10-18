Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD1C7CDD07
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6Mc-0007hN-Mw; Wed, 18 Oct 2023 09:13:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6MH-0007Vy-G0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:13:09 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qt6MF-0000np-Gw
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:13:08 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9bf0ac97fdeso629287966b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697634785; x=1698239585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=Y40qUJpsJNbgIx7vMG4lVxRCHty9Ljn6M0yZK+HaEQAypC8qhPzq1UluE9H4t36JLD
 UOJa/+4sBIZCtt5jYosk+zkz6jlPq24GUzna2iYVu8RXY6L9c3QoSFLtbXvPdhq3k+aw
 lV1J1cKXn2OTzQeTlcL4ZuHi83Hj3d31zTOQ4nRhU+rGIzCSOCQ0yavFDcxG4ZSPiZKH
 Sua1K6hqVJ3K9cTo9Tb/dcXyyuzO0eQVXZGe8872SBrBA52Gt71RipA+tW9iFJ5rEK4j
 o9PpXBmNrZqg01gFK1i5CJN8AYbeoutckxjNJ6axNOuc8vrwT6IMvQI4XRWuVUUg2Afz
 cexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697634785; x=1698239585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=p+134V6PbtO2i7D0uHQjl5WWHwHI77mquGgghulbY4sYXg176QbjwqRywWgh7EtZ2C
 hbvoyv0oU/dhfJk2LXvpTGccYGAzvOI8/Lz8+PxvLHvEgYAe00ZpugcZ9vwUeotSmvEs
 K8jM13E6gmTtXmpVg133pVX6Rjsxi6Fq6eGRrd078/rjiNd37hYYhw52Yu86jm4ZZYAq
 w2V/WeYQkdD5NiipjradPApUY25hFxyAXYj6fu7CTkMKMdjXi68LvQGvMK3vT5QGHyTR
 F8ldSEg5Rrw+h59uNIKbUXjQsl74dDmpFDTRUpnA+fW/gYcHl2Zvf/Srr7I6aZfNCUxd
 bC9w==
X-Gm-Message-State: AOJu0Yy2foVQzydRSi3Tgj+0w2YvnmiepXh5zmeKkCepXmKAs+hUZo9w
 ZkSwibZzJEdYHA0HiqRVIeE94zPipJcoa6yyrWA=
X-Google-Smtp-Source: AGHT+IGtGtNUR8YRpNO306+BreZI4qPcjO2aL2779WmqHWTW2wxjTHwL99N0WF+xh4/6nuhjLp8ORA==
X-Received: by 2002:a17:907:d48d:b0:9c6:7ec2:e129 with SMTP id
 vj13-20020a170907d48d00b009c67ec2e129mr2603043ejc.42.1697634784797; 
 Wed, 18 Oct 2023 06:13:04 -0700 (PDT)
Received: from m1x-phil.lan (gyl59-h01-176-171-218-149.dsl.sta.abo.bbox.fr.
 [176.171.218.149]) by smtp.gmail.com with ESMTPSA id
 z6-20020a17090674c600b00992e14af9c3sm1686110ejl.143.2023.10.18.06.13.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 18 Oct 2023 06:13:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 7/8] hw/intc/pxa2xx: Pass CPU reference using QOM link property
Date: Wed, 18 Oct 2023 15:12:19 +0200
Message-ID: <20231018131220.84380-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018131220.84380-1-philmd@linaro.org>
References: <20231018131220.84380-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/pxa2xx_pic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/arm/pxa2xx_pic.c b/hw/arm/pxa2xx_pic.c
index 2eb869a605..7e180635c2 100644
--- a/hw/arm/pxa2xx_pic.c
+++ b/hw/arm/pxa2xx_pic.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/arm/pxa.h"
 #include "hw/sysbus.h"
+#include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
@@ -288,7 +289,8 @@ DeviceState *pxa2xx_pic_init(hwaddr base, ARMCPU *cpu)
     DeviceState *dev = qdev_new(TYPE_PXA2XX_PIC);
     PXA2xxPICState *s = PXA2XX_PIC(dev);
 
-    s->cpu = cpu;
+    object_property_set_link(OBJECT(dev), "arm-cpu",
+                             OBJECT(cpu), &error_abort);
 
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
 
@@ -321,11 +323,18 @@ static const VMStateDescription vmstate_pxa2xx_pic_regs = {
     },
 };
 
+static Property pxa2xx_pic_properties[] = {
+    DEFINE_PROP_LINK("arm-cpu", PXA2xxPICState, cpu,
+                     TYPE_ARM_CPU, ARMCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void pxa2xx_pic_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    device_class_set_props(dc, pxa2xx_pic_properties);
     dc->desc = "PXA2xx PIC";
     dc->vmsd = &vmstate_pxa2xx_pic_regs;
     rc->phases.hold = pxa2xx_pic_reset_hold;
-- 
2.41.0


