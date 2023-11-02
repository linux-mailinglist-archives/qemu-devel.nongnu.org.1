Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB217DEF7B
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaO-0001oV-8F; Thu, 02 Nov 2023 06:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaM-0001np-06
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:58 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaK-0003GO-Dn
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:05:57 -0400
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-9d224dca585so110991766b.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919555; x=1699524355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b4aU3XAKLeX+XGRwvVl+KDuHHFhHb9tLltsT3xNn8sc=;
 b=XgoW3ISEbTnof3S9+0vOsUIyDpiHoC2tjynBpw4g3ac2E6eg38fJBtdJ2uQtJHK+70
 0iRDY7eVh2iOrbHJDcGaQfRsdd8w80AZepSZAJy7dcHHXq8qXmf1enVesBaxoh4mQldN
 psg6d05YntWlMvdDFY9cdFs06LBG2NKaAkMcnk7cpmwjKjXusI5hNlUHxjQseHV4kCYT
 /gOE7Ay3uRMPBM0NNN1tGwRvp1WfPYB896TJ0Ag5NtWaXGOQp6nqijj7dKL/YV2vHlVT
 +XZuDsWq+ZEpJw/0qlgh8uqr5Xr11LbrjmYEDs5uoPexn6UIojZTIChHH/eHVn/6apOb
 K8/g==
X-Gm-Message-State: AOJu0YxPIS3BuiQ0EhHvuDajw0zzHznraNneoDHykgRd3R1jIug0pDDs
 bhpBtSlIITFFyFeXy2B1OO0R7+0XnqQ=
X-Google-Smtp-Source: AGHT+IEvDdkjje8F5RzscU8q+3dHT2G0JrBOFk+8CZHY3PUaJcyJHW0tYVSl/XAN/DcvCV0kGALHjA==
X-Received: by 2002:a17:907:a45:b0:9a6:1446:852c with SMTP id
 be5-20020a1709070a4500b009a61446852cmr4074504ejc.27.1698919554884; 
 Thu, 02 Nov 2023 03:05:54 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:05:54 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/10] hw/m68k/mcf_intc: Pass CPU using QOM link property
Date: Thu,  2 Nov 2023 11:05:37 +0100
Message-ID: <20231102100543.4875-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.46; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f46.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

QOM objects shouldn't access each other internals fields
except using the QOM API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231024083010.12453-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf_intc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index 1f74ea0e14..1d3b34e18c 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -14,6 +14,7 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "hw/m68k/mcf.h"
+#include "hw/qdev-properties.h"
 #include "qom/object.h"
 
 #define TYPE_MCF_INTC "mcf-intc"
@@ -176,10 +177,17 @@ static void mcf_intc_instance_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->iomem);
 }
 
+static Property mcf_intc_properties[] = {
+    DEFINE_PROP_LINK("m68k-cpu", mcf_intc_state, cpu,
+                     TYPE_M68K_CPU, M68kCPU *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void mcf_intc_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
+    device_class_set_props(dc, mcf_intc_properties);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->reset = mcf_intc_reset;
 }
@@ -204,16 +212,13 @@ qemu_irq *mcf_intc_init(MemoryRegion *sysmem,
                         M68kCPU *cpu)
 {
     DeviceState  *dev;
-    mcf_intc_state *s;
 
     dev = qdev_new(TYPE_MCF_INTC);
+    object_property_set_link(OBJECT(dev), "m68k-cpu",
+                             OBJECT(cpu), &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-
-    s = MCF_INTC(dev);
-    s->cpu = cpu;
-
     memory_region_add_subregion(sysmem, base,
                                 sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
 
-    return qemu_allocate_irqs(mcf_intc_set_irq, s, 64);
+    return qemu_allocate_irqs(mcf_intc_set_irq, dev, 64);
 }
-- 
2.41.0


