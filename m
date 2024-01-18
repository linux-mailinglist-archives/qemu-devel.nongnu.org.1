Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B99831591
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 10:12:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQORG-0006x2-18; Thu, 18 Jan 2024 04:11:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rQOR3-0006mD-31; Thu, 18 Jan 2024 04:11:41 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arnaud.minier@telecom-paris.fr>)
 id 1rQOR1-0004qs-Bn; Thu, 18 Jan 2024 04:11:40 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id C42E02069C;
 Thu, 18 Jan 2024 10:11:31 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id g7r9mJVYHeD5; Thu, 18 Jan 2024 10:11:31 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 2B431205CE;
 Thu, 18 Jan 2024 10:11:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 2B431205CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1705569091;
 bh=1tz0czNF2n8hyttE+zic+p5UxdQaBdUgktrpXzBfUCw=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=7W0UklSS0ikiS/Z4oPs2W/9h+8i22cjdAY1Z7yMp8cBzEsmzEGqlk8GHOE6vfIYgJ
 Hha4NsCH0sTeFOJel79ccwmYRtUMBxvkAkhPhLeNz1FmtIm+p6tlcEyUFTq+ASFNKh
 Klqdr20F/zZFiDzcd+/+EgbPFOfsTpN71eQMaSDo=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id Ht_HlPP0apLQ; Thu, 18 Jan 2024 10:11:31 +0100 (CET)
Received: from AM-Inspiron-3585.numericable.fr (38.162.10.109.rev.sfr.net
 [109.10.162.38])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 8BFF820557;
 Thu, 18 Jan 2024 10:11:30 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, samuel.tardieu@telecom-paris.fr,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 6/7] STM32L4x5: Use the RCC Sysclk
Date: Thu, 18 Jan 2024 10:11:06 +0100
Message-Id: <20240118091107.87831-7-arnaud.minier@telecom-paris.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118091107.87831-1-arnaud.minier@telecom-paris.fr>
References: <20240118091107.87831-1-arnaud.minier@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=arnaud.minier@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Arnaud Minier <arnaud.minier@telecom-paris.fr>
Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
---
 hw/arm/b-l475e-iot01a.c        | 10 +---------
 hw/arm/stm32l4x5_soc.c         | 33 ++++-----------------------------
 include/hw/arm/stm32l4x5_soc.h |  3 ---
 3 files changed, 5 insertions(+), 41 deletions(-)

diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 6ecde2db15..d862aa43fc 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -26,27 +26,19 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/qdev-properties.h"
-#include "hw/qdev-clock.h"
 #include "qemu/error-report.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/arm/boot.h"
=20
-/* Main SYSCLK frequency in Hz (80MHz) */
-#define MAIN_SYSCLK_FREQ_HZ 80000000ULL
+/* B-L475E-IOT01A implementation is derived from netduinoplus2 */
=20
 static void b_l475e_iot01a_init(MachineState *machine)
 {
     const Stm32l4x5SocClass *sc;
     DeviceState *dev;
-    Clock *sysclk;
-
-    /* This clock doesn't need migration because it is fixed-frequency *=
/
-    sysclk =3D clock_new(OBJECT(machine), "SYSCLK");
-    clock_set_hz(sysclk, MAIN_SYSCLK_FREQ_HZ);
=20
     dev =3D qdev_new(TYPE_STM32L4X5XG_SOC);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(dev));
-    qdev_connect_clock_in(dev, "sysclk", sysclk);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
=20
     sc =3D STM32L4X5_SOC_GET_CLASS(dev);
diff --git a/hw/arm/stm32l4x5_soc.c b/hw/arm/stm32l4x5_soc.c
index 2538165af6..bcdad69e92 100644
--- a/hw/arm/stm32l4x5_soc.c
+++ b/hw/arm/stm32l4x5_soc.c
@@ -84,9 +84,6 @@ static void stm32l4x5_soc_initfn(Object *obj)
=20
     object_initialize_child(obj, "exti", &s->exti, TYPE_STM32L4X5_EXTI);
     object_initialize_child(obj, "syscfg", &s->syscfg, TYPE_STM32L4X5_SY=
SCFG);
-
-    s->sysclk =3D qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0)=
;
-    s->refclk =3D qdev_init_clock_in(DEVICE(s), "refclk", NULL, NULL, 0)=
;
     object_initialize_child(obj, "rcc", &s->rcc, TYPE_STM32L4X5_RCC);
 }
=20
@@ -99,30 +96,6 @@ static void stm32l4x5_soc_realize(DeviceState *dev_soc=
, Error **errp)
     DeviceState *armv7m;
     SysBusDevice *busdev;
=20
-    /*
-     * We use s->refclk internally and only define it with qdev_init_clo=
ck_in()
-     * so it is correctly parented and not leaked on an init/deinit; it =
is not
-     * intended as an externally exposed clock.
-     */
-    if (clock_has_source(s->refclk)) {
-        error_setg(errp, "refclk clock must not be wired up by the board=
 code");
-        return;
-    }
-
-    if (!clock_has_source(s->sysclk)) {
-        error_setg(errp, "sysclk clock must be wired up by the board cod=
e");
-        return;
-    }
-
-    /*
-     * TODO: ideally we should model the SoC RCC and its ability to
-     * change the sysclk frequency and define different sysclk sources.
-     */
-
-    /* The refclk always runs at frequency HCLK / 8 */
-    clock_set_mul_div(s->refclk, 8, 1);
-    clock_set_source(s->refclk, s->sysclk);
-
     if (!memory_region_init_rom(&s->flash, OBJECT(dev_soc), "flash",
                                 sc->flash_size, errp)) {
         return;
@@ -151,8 +124,10 @@ static void stm32l4x5_soc_realize(DeviceState *dev_s=
oc, Error **errp)
     qdev_prop_set_uint32(armv7m, "num-irq", 96);
     qdev_prop_set_string(armv7m, "cpu-type", ARM_CPU_TYPE_NAME("cortex-m=
4"));
     qdev_prop_set_bit(armv7m, "enable-bitband", true);
-    qdev_connect_clock_in(armv7m, "cpuclk", s->sysclk);
-    qdev_connect_clock_in(armv7m, "refclk", s->refclk);
+    qdev_connect_clock_in(armv7m, "cpuclk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-fclk-out"));
+    qdev_connect_clock_in(armv7m, "refclk",
+        qdev_get_clock_out(DEVICE(&(s->rcc)), "cortex-refclk-out"));
     object_property_set_link(OBJECT(&s->armv7m), "memory",
                              OBJECT(system_memory), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->armv7m), errp)) {
diff --git a/include/hw/arm/stm32l4x5_soc.h b/include/hw/arm/stm32l4x5_so=
c.h
index e480fcc976..1f71298b45 100644
--- a/include/hw/arm/stm32l4x5_soc.h
+++ b/include/hw/arm/stm32l4x5_soc.h
@@ -50,9 +50,6 @@ struct Stm32l4x5SocState {
     MemoryRegion sram2;
     MemoryRegion flash;
     MemoryRegion flash_alias;
-
-    Clock *sysclk;
-    Clock *refclk;
 };
=20
 struct Stm32l4x5SocClass {
--=20
2.34.1


