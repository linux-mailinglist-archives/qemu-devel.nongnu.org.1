Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624774D5C9
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:38:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIq55-0002Hg-Dl; Mon, 10 Jul 2023 08:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq51-00026m-7b
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qIq4z-0004cD-DW
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:33:26 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-67ef5af0ce8so3834980b3a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688992402; x=1691584402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXtswMy9FjqX1K85Wns7oZp3S8x5Gt2BDOKWB257SPc=;
 b=Pr9TnyOmBDSPwvDA4YtnJpHev9Wm3ecrxGEsX92v+uGTzsE+/oLTnIWTTuk7UCse8a
 X56rFWEXQx+i7MopG06ojBj7oICPJd/2uSvxSBFw8aAVbPhChgAGIpKzUu1APcRT5cYH
 naDqACXRfIfSL9uMwXvIv2EgbsxUgsJeNH+jOvc2oq0iwDBnqIad7OTHY3QNtc5stqLj
 7JqldBUuAQNsecBaO0f0nCNkRvK9G2lTE7UZuR5NjILVzGyeax/8ZXYnFyGdthutUBag
 i1Gou3pOFtRDx/nhXdCHkFEcLXWMDoADKIzNzpiMMv+35yNX4V7crjpGGLembvKnbcJV
 ZRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688992402; x=1691584402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXtswMy9FjqX1K85Wns7oZp3S8x5Gt2BDOKWB257SPc=;
 b=NEbFhkJgvFWaVAgEROYSiqaFfVjneTiEfYv27hOXBL5VyZk9DUGbh+NjbOpVJ/wizt
 BadL5bZZMvDSsfCBL1pQJD3H8CtnDdTJKF/YlKA25zCnOWT8GQIoXsLGunC2s4DPeitu
 dKwTV2VNlBM9GP1X6EUysOrOwssI8ISLp+UoP7pLBcn+YQlZiv50xLqU7Izit6iQMVJT
 cOdIW+gzMajWMaPWPUFlSw1OqOiCLDP0PECONhwstIUROPGa5jY+UYyR9xk7WhdPJRix
 /lc1HKjlm59V9+87/CCzd91uhOj0Fhg2wncXTt7HH0oEf91JQs+gJcUhrTj6q0petezd
 ttrQ==
X-Gm-Message-State: ABy/qLb8sH8iS+P5cGdX3OjecX1mtziIkHZUhpdrPeMtZKiQZArE6fgL
 E/g1YNk9uAuiET+x4pLVLfoVpFgcJL6vKQ==
X-Google-Smtp-Source: APBJJlFrEK+/lJaYoubETJGTJz7Kpam0BpScFRoP4cWUD8XtUBWiZ2luT4vusF0qh0O4OyEWuY+vZQ==
X-Received: by 2002:a05:6a20:9689:b0:129:bf86:6ebb with SMTP id
 hp9-20020a056a20968900b00129bf866ebbmr12259957pzc.59.1688992402648; 
 Mon, 10 Jul 2023 05:33:22 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 i126-20020a639d84000000b0055b44a901absm181559pgd.70.2023.07.10.05.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 05:33:22 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Tommy Wu <tommy.wu@sifive.com>,
 Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 18/54] hw/riscv: sifive_e: Support the watchdog timer of HiFive
 1 rev b.
Date: Mon, 10 Jul 2023 22:31:29 +1000
Message-Id: <20230710123205.2441106-19-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230710123205.2441106-1-alistair.francis@wdc.com>
References: <20230710123205.2441106-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tommy Wu <tommy.wu@sifive.com>

Create the AON device when we realize the sifive_e machine.
This patch only implemented the functionality of the watchdog timer,
not all the functionality of the AON device.

Signed-off-by: Tommy Wu <tommy.wu@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230627141216.3962299-3-tommy.wu@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/riscv/sifive_e.h |  9 ++++++---
 hw/riscv/sifive_e.c         | 17 +++++++++++++++--
 hw/riscv/Kconfig            |  1 +
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/include/hw/riscv/sifive_e.h b/include/hw/riscv/sifive_e.h
index b824a79e2d..31180a680e 100644
--- a/include/hw/riscv/sifive_e.h
+++ b/include/hw/riscv/sifive_e.h
@@ -22,6 +22,7 @@
 #include "hw/riscv/riscv_hart.h"
 #include "hw/riscv/sifive_cpu.h"
 #include "hw/gpio/sifive_gpio.h"
+#include "hw/misc/sifive_e_aon.h"
 #include "hw/boards.h"
 
 #define TYPE_RISCV_E_SOC "riscv.sifive.e.soc"
@@ -35,6 +36,7 @@ typedef struct SiFiveESoCState {
     /*< public >*/
     RISCVHartArrayState cpus;
     DeviceState *plic;
+    SiFiveEAONState aon;
     SIFIVEGPIOState gpio;
     MemoryRegion xip_mem;
     MemoryRegion mask_rom;
@@ -76,9 +78,10 @@ enum {
 };
 
 enum {
-    SIFIVE_E_UART0_IRQ  = 3,
-    SIFIVE_E_UART1_IRQ  = 4,
-    SIFIVE_E_GPIO0_IRQ0 = 8
+    SIFIVE_E_AON_WDT_IRQ  = 1,
+    SIFIVE_E_UART0_IRQ    = 3,
+    SIFIVE_E_UART1_IRQ    = 4,
+    SIFIVE_E_GPIO0_IRQ0   = 8
 };
 
 #define SIFIVE_E_PLIC_HART_CONFIG "M"
diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 04939b60c3..0d37adc542 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -45,6 +45,7 @@
 #include "hw/intc/riscv_aclint.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_e_prci.h"
+#include "hw/misc/sifive_e_aon.h"
 #include "chardev/char.h"
 #include "sysemu/sysemu.h"
 
@@ -185,6 +186,8 @@ static void sifive_e_soc_init(Object *obj)
     object_property_set_int(OBJECT(&s->cpus), "resetvec", 0x1004, &error_abort);
     object_initialize_child(obj, "riscv.sifive.e.gpio0", &s->gpio,
                             TYPE_SIFIVE_GPIO);
+    object_initialize_child(obj, "riscv.sifive.e.aon", &s->aon,
+                            TYPE_SIFIVE_E_AON);
 }
 
 static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
@@ -223,10 +226,17 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
         RISCV_ACLINT_DEFAULT_MTIMER_SIZE, 0, ms->smp.cpus,
         RISCV_ACLINT_DEFAULT_MTIMECMP, RISCV_ACLINT_DEFAULT_MTIME,
         RISCV_ACLINT_DEFAULT_TIMEBASE_FREQ, false);
-    create_unimplemented_device("riscv.sifive.e.aon",
-        memmap[SIFIVE_E_DEV_AON].base, memmap[SIFIVE_E_DEV_AON].size);
     sifive_e_prci_create(memmap[SIFIVE_E_DEV_PRCI].base);
 
+    /* AON */
+
+    if (!sysbus_realize(SYS_BUS_DEVICE(&s->aon), errp)) {
+        return;
+    }
+
+    /* Map AON registers */
+    sysbus_mmio_map(SYS_BUS_DEVICE(&s->aon), 0, memmap[SIFIVE_E_DEV_AON].base);
+
     /* GPIO */
 
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->gpio), errp)) {
@@ -245,6 +255,9 @@ static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
                            qdev_get_gpio_in(DEVICE(s->plic),
                                             SIFIVE_E_GPIO0_IRQ0 + i));
     }
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->aon), 0,
+                       qdev_get_gpio_in(DEVICE(s->plic),
+                                        SIFIVE_E_AON_WDT_IRQ));
 
     sifive_uart_create(sys_mem, memmap[SIFIVE_E_DEV_UART0].base,
         serial_hd(0), qdev_get_gpio_in(DEVICE(s->plic), SIFIVE_E_UART0_IRQ));
diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 6528ebfa3a..b6a5eb4452 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -60,6 +60,7 @@ config SIFIVE_E
     select SIFIVE_PLIC
     select SIFIVE_UART
     select SIFIVE_E_PRCI
+    select SIFIVE_E_AON
     select UNIMP
 
 config SIFIVE_U
-- 
2.40.1


