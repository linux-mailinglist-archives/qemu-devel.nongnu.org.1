Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340780EBA0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:24:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD1kv-00087g-18; Tue, 12 Dec 2023 07:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1kW-0006vr-F4; Tue, 12 Dec 2023 07:20:34 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rD1kT-0000nR-Jp; Tue, 12 Dec 2023 07:20:32 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 624853AF0A;
 Tue, 12 Dec 2023 15:18:50 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 2819D3B958;
 Tue, 12 Dec 2023 15:18:33 +0300 (MSK)
Received: (nullmailer pid 1003466 invoked by uid 1000);
 Tue, 12 Dec 2023 12:18:31 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gihun Nam <gihun.nam@outlook.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.4 22/31] hw/avr/atmega: Fix wrong initial value of stack
 pointer
Date: Tue, 12 Dec 2023 15:18:10 +0300
Message-Id: <20231212121831.1003318-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
References: <qemu-stable-8.1.4-20231211211211@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Gihun Nam <gihun.nam@outlook.com>

The current implementation initializes the stack pointer of AVR devices
to 0. Although older AVR devices used to be like that, newer ones set
it to RAMEND.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1525
Signed-off-by: Gihun Nam <gihun.nam@outlook.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <PH0P222MB0010877445B594724D40C924DEBDA@PH0P222MB0010.NAMP222.PROD.OUTLOOK.COM>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 235948bf53860a1e2df5134eae7b0a30a971a124)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c
index a34803e642..31c8992d75 100644
--- a/hw/avr/atmega.c
+++ b/hw/avr/atmega.c
@@ -233,6 +233,10 @@ static void atmega_realize(DeviceState *dev, Error **errp)
 
     /* CPU */
     object_initialize_child(OBJECT(dev), "cpu", &s->cpu, mc->cpu_type);
+
+    object_property_set_uint(OBJECT(&s->cpu), "init-sp",
+                             mc->io_size + mc->sram_size - 1, &error_abort);
+
     qdev_realize(DEVICE(&s->cpu), NULL, &error_abort);
     cpudev = DEVICE(&s->cpu);
 
diff --git a/target/avr/cpu.c b/target/avr/cpu.c
index 8f741f258c..02d58484bb 100644
--- a/target/avr/cpu.c
+++ b/target/avr/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "disas/dis-asm.h"
 #include "tcg/debug-assert.h"
+#include "hw/qdev-properties.h"
 
 static void avr_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -95,7 +96,7 @@ static void avr_cpu_reset_hold(Object *obj)
     env->rampY = 0;
     env->rampZ = 0;
     env->eind = 0;
-    env->sp = 0;
+    env->sp = cpu->init_sp;
 
     env->skip = 0;
 
@@ -154,6 +155,11 @@ static void avr_cpu_initfn(Object *obj)
                       sizeof(cpu->env.intsrc) * 8);
 }
 
+static Property avr_cpu_properties[] = {
+    DEFINE_PROP_UINT32("init-sp", AVRCPU, init_sp, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
 static ObjectClass *avr_cpu_class_by_name(const char *cpu_model)
 {
     ObjectClass *oc;
@@ -231,6 +237,8 @@ static void avr_cpu_class_init(ObjectClass *oc, void *data)
 
     device_class_set_parent_realize(dc, avr_cpu_realizefn, &mcc->parent_realize);
 
+    device_class_set_props(dc, avr_cpu_properties);
+
     resettable_class_set_parent_phases(rc, NULL, avr_cpu_reset_hold, NULL,
                                        &mcc->parent_phases);
 
diff --git a/target/avr/cpu.h b/target/avr/cpu.h
index 7225174668..b73547deb2 100644
--- a/target/avr/cpu.h
+++ b/target/avr/cpu.h
@@ -150,6 +150,9 @@ struct ArchCPU {
 
     CPUNegativeOffsetState neg;
     CPUAVRState env;
+
+    /* Initial value of stack pointer */
+    uint32_t init_sp;
 };
 
 extern const struct VMStateDescription vms_avr_cpu;
-- 
2.39.2


