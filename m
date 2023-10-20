Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F867D103D
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:06:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtpAz-0001cy-Hx; Fri, 20 Oct 2023 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAr-0000xf-4X
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:22 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtpAn-0005N4-VO
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 09:04:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso173640766b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697807056; x=1698411856; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=LEz5uXfath7rEbO83c35/Oj3IIKvsGh54n6x23rKD0IQlgkDCWUhS9vFYWejXNP3VX
 n1japTovWUJOzG6NYZBkiAeZKUbPZfTx2wZRZace+8d1Vd2PdcXYrLzc9eHaDwWtLvCR
 hNxmM/gTdd7xQmO48Xl7TdXZzieECl4nFZgh8qekpYRY3jBUhbmzkwjm3NeRcxQ4czq+
 rbMHqABjjAqkMJOADXfKGxrzjB5gpwAgv+h7Th1LBxogLmDxxqKUd2u6AupRCyNzaL1g
 l3kaULXyjAT+Vf8EAZoIkLDqYFIDe5Oto42GzjOiByFo1zvEFl8rpvppGA1xQQqZMSlq
 wF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697807056; x=1698411856;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RG5zLlWN/LC4pJbPVJoFLnGQz4i0tpH2bVvTXsYTeOI=;
 b=IGlsMtEN7GK+QMqi1qalh6clZtEPH/SfaFET/DHL6MhMU+o/vJ3hS/TC9Bfbyristp
 qCrhPfo8AzmSXV4Ivg+p3crJ5/m6noE+tf92JNvthvH2hufcZ4E792IAcNy9nTxQkslz
 7JOkWYMSddkr9yZXcIUYqNxRdlNiOo7APWWOSL8HujPmelOe1nE12cIFLSAvchezQeEI
 yDWzUTMxWffW3kCuPg5Pk6VSbz2b4n7D6We8z7wn8zK/8VhhT6X0Z8SoC5zhsgOI0q9M
 c5y54UVqJhOmG0B1iLEMCag2iBVeU4pzJRg9OnfVQQ5kAfAHhWcL1muRgl8D9stBm075
 Lw8A==
X-Gm-Message-State: AOJu0YzVRF1CLGdwP41uy0vFaxULFpSfoW+FMLBnwJss/KLaScFtP2A7
 /5z6BT4PS6MEQv+yvZ2kFmTKoKfMi8Sp0jQ3ejM=
X-Google-Smtp-Source: AGHT+IFSyYr+QXqXHLdL+AzrN4GyBpfjG6T0Vk4sBiz6q53mPfqZZlbwtP1N+QytK2ENt5c73/lvpQ==
X-Received: by 2002:a17:907:3daa:b0:9bd:81c3:2a85 with SMTP id
 he42-20020a1709073daa00b009bd81c32a85mr4700129ejc.32.1697807055916; 
 Fri, 20 Oct 2023 06:04:15 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 x20-20020a170906149400b0098884f86e41sm1459879ejc.123.2023.10.20.06.04.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 06:04:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 7/9] hw/intc/pxa2xx: Pass CPU reference using QOM link
 property
Date: Fri, 20 Oct 2023 15:03:28 +0200
Message-ID: <20231020130331.50048-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020130331.50048-1-philmd@linaro.org>
References: <20231020130331.50048-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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


