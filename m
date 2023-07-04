Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA2B74747B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhNk-0007KV-0F; Tue, 04 Jul 2023 10:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNg-0007BK-Me
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:53 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhNd-0003Jd-Ia
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:51:50 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fbc54cab6fso49730015e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482308; x=1691074308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WVD5h3S/wXD+ivo8E/ihZP+IS9902/QRoD0axxhHzM=;
 b=meF2wC2VGEmyjNWlAdgFdYbc/KsIi6e87i2G7rYUKZA02OC1xtL6VzlJdBjmU4xALY
 JhB1juM7FNR9uyxIVefP5e4u3qOo9EwtmrXLy94BFwZ3mwfM1Oy6gtfGQzwdNP9jPp39
 mufaUN9vOWXu/LdeNf6a4wVbsBsxL8zGYXWJNi4P9GkIPmY/QhrhBAWA/USlXtxCRiVx
 9WsECgux3cYEeb9f1HqWfHQcBiQlBRl38RLim/donORD95eyAt5C8Igrt5X7P4fsFw41
 aprUMYpHBiW6ax7zdBkXWWry4jTGQFTvgx/RZ3xs1hBS1hv+eG7gvWdBc8ReEQ07tDQw
 8iWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482308; x=1691074308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WVD5h3S/wXD+ivo8E/ihZP+IS9902/QRoD0axxhHzM=;
 b=AwbRcRD2Zgpe8oHAGbst4Y4XB3dcA2aEDh72gqccYrRE6bp4VXDvBy8imGQEqJei1j
 76zninP5PInVnAseWKz/8Y7kIgmo7FVxqJbIc5j8hRt+ZhCWrLkCRgBZ5uW4z+Kigq7/
 bDm0M3f5/6DJmBy81tgNWkOl7w1RGRX4FUGcvp7gnvZvafuMklhxXSZFMLVZyl6ut3Ed
 sukTSzV8ChHaV0A2xdgz9c5PwOPVPUnWcrsWeakSBbED10a4zKZ2cGqYzZLYweLCiLtF
 BmZrtVdmNE5ta3tpBUW6vxCeWyhgUlhh+HVptbZtiL85cXdFwahSJb9ObrDfqhxg/P8/
 oaIw==
X-Gm-Message-State: AC+VfDyiAwsSmu4fc1P/w4luEBujOx/F/CLuq/sW+pdoiqOVlUTx4DcU
 ZNEHFXhSUNoYkeGT9eIXQzzWjnltH3v/bSOrlHM=
X-Google-Smtp-Source: ACHHUZ7UMDUXJ8qL+NXLBr2FRu/oiyE0GX1xWMgFbgFnlvxCHzIpERLaiHQKVBygf1l+XwBqQTRK8A==
X-Received: by 2002:a7b:cbd0:0:b0:3fa:8db4:91ec with SMTP id
 n16-20020a7bcbd0000000b003fa8db491ecmr10380467wmi.10.1688482308089; 
 Tue, 04 Jul 2023 07:51:48 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 o11-20020a05600c378b00b003fa95f328afsm25654281wmr.29.2023.07.04.07.51.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:51:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 18/19] hw/timer/arm_timer: Map ARM_TIMER MMIO regions into
 IntegratorPIT
Date: Tue,  4 Jul 2023 16:50:11 +0200
Message-Id: <20230704145012.49870-19-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230704145012.49870-1-philmd@linaro.org>
References: <20230704145012.49870-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Instead of manually forwarding MMIO accesses to each ARM_TIMER,
let have the generic memory code dispatch that for us.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/arm_timer.c | 43 ++++---------------------------------------
 1 file changed, 4 insertions(+), 39 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 8207723ab5..7b455aff4d 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -393,6 +393,7 @@ static void sp804_class_init(ObjectClass *klass, void *data)
 }
 
 /* Integrator/CP timer module.  */
+/* ??? Don't know the PrimeCell ID for this device.  */
 
 #define TYPE_INTEGRATOR_PIT "integrator_pit"
 OBJECT_DECLARE_SIMPLE_TYPE(IntegratorPIT, INTEGRATOR_PIT)
@@ -405,43 +406,6 @@ struct IntegratorPIT {
     qemu_irq irq[3];
 };
 
-static uint64_t icp_pit_read(void *opaque, hwaddr offset,
-                             unsigned size)
-{
-    IntegratorPIT *s = opaque;
-    int n;
-
-    /* ??? Don't know the PrimeCell ID for this device.  */
-    n = offset >> 8;
-    if (n > 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad timer %d\n", __func__, n);
-        return 0;
-    }
-
-    return arm_timer_read(&s->timer[n], offset & 0xff, size);
-}
-
-static void icp_pit_write(void *opaque, hwaddr offset,
-                          uint64_t value, unsigned size)
-{
-    IntegratorPIT *s = opaque;
-    int n;
-
-    n = offset >> 8;
-    if (n > 2) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad timer %d\n", __func__, n);
-        return;
-    }
-
-    arm_timer_write(&s->timer[n], offset & 0xff, value, size);
-}
-
-static const MemoryRegionOps icp_pit_ops = {
-    .read = icp_pit_read,
-    .write = icp_pit_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
-};
-
 static void icp_pit_fwd_irq(void *opaque, int n, int level)
 {
     IntegratorPIT *s = opaque;
@@ -469,8 +433,7 @@ static void icp_pit_init(Object *obj)
         sysbus_init_irq(dev, &s->irq[i]);
     }
 
-    memory_region_init_io(&s->iomem, obj, &icp_pit_ops, s,
-                          "icp_pit", 0x1000);
+    memory_region_init(&s->iomem, obj, "icp_pit", 0x1000);
     sysbus_init_mmio(dev, &s->iomem);
     /* This device has no state to save/restore.  The component timers will
        save themselves.  */
@@ -487,6 +450,8 @@ static void icp_pit_realize(DeviceState *dev, Error **errp)
             return;
         }
         sysbus_connect_irq(tmr, 0, qdev_get_gpio_in_named(dev, "timer-in", i));
+        memory_region_add_subregion(&s->iomem, 0x100 * i,
+                                    sysbus_mmio_get_region(tmr, 0));
     }
 }
 
-- 
2.38.1


