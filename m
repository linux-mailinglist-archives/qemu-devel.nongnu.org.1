Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 931187398A0
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 09:57:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCFAi-00044Q-Sf; Thu, 22 Jun 2023 03:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAb-0003yk-PO
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:56:00 -0400
Received: from mout.kundenserver.de ([212.227.126.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1qCFAY-0002rh-8O
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 03:55:57 -0400
Received: from quad ([82.142.8.70]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MQdtO-1qPtuE2odi-00NkVU; Thu, 22
 Jun 2023 09:55:48 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/24] q800: move CPU object into Q800MachineState
Date: Thu, 22 Jun 2023 09:55:25 +0200
Message-Id: <20230622075544.210899-6-laurent@vivier.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622075544.210899-1-laurent@vivier.eu>
References: <20230622075544.210899-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2a8xwGQld4SdRMFrDuktq0vClksm0MGLxxJy4dQWs0nckl6VWNw
 /D9ZxgjHg74t9YAUYWKKJHOwAC004kLYI9IIOuCtTFtN3mjiuJbbfoxchaYmjcXOfEksKZ8
 m4EnlD+XatHGvPgT4tOtKBx+c+hnzpX/hkxzedaPh4tYvnEWdJA1rRaO6J08s5dlxdBAOsh
 f3hYIYmGO64+Nd/yQgVXA==
UI-OutboundReport: notjunk:1;M01:P0:RgsqI9lrHfk=;X9vIn40SdYWg/GiMWNmuZ9ofkpA
 fIGH0nkk16ssi/34/I9xXzyKw6/ySeYpJM6UWV87S3me+6ypyJ3GUrd8LjBRXywjFQqVQQL9i
 WWd5rf0sO3OeBE5Clp0RfjFXLBvb30tW5d+TTG8aV1k9eKaqlVsls21CA/KKGQ33Km4LiL3Ra
 WBNRqlbIij9FcSZ3p8TU+u9kt5cofTV0epdMgU6NlmElhtviXSCTIU6V32uEc71mIiIBfmc7H
 iFh/CLYcoQ13oLI8MlwuNlMVuieYtM794A4BrHQwYoSXslmTYTTIT8qhIFVcmhxTJHc+iBcGj
 ig+8Mtwu7yQTi62tjh0FBG/0/U25n7dSWy1r/OZSPedbC6bB4gDhJP3XikAHuB2g0g2MpqMHl
 sMNgjOgVmp1pPWrEC10hbsz4EmXq9pBgXLVcTAEETGqdBwYfGRs9oRJGzE9aTuiVNwLwmHtEq
 5Q4XgHnNavCZhS2RP4kmqqDxhw4fHlBjhhWe4JZqYQisTQv5q1cN4zZm0Mef10YO1uENOia6+
 AMsrChMpoADd0OufMa24wgQ81Pe0p/JSVMsibEN3kS8b3tvwpQeUqSfMYAeB8c4+4RELvbRIL
 /7C/z94W7yAUW4RXG8JoHzCx00WAltjgpcQDT+JuOPIUy3Vnws4nDxco5olk/l/d/a/qqhkNj
 BFv56buR3Yy3nJtN6Br4OOX6YUKsSrDdOE3tL+0QMg==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Also change the instantiation of the CPU to use object_initialize_child()
followed by a separate realisation.
Restrict valid CPU types to m68040.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230621085353.113233-6-mark.cave-ayland@ilande.co.uk>
[lv: update commit message]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/hw/m68k/q800.h |  3 +++
 hw/m68k/q800.c         | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index f3bc17aa1bdc..4cb1a51dfe9d 100644
--- a/include/hw/m68k/q800.h
+++ b/include/hw/m68k/q800.h
@@ -25,6 +25,7 @@
 
 #include "hw/boards.h"
 #include "qom/object.h"
+#include "target/m68k/cpu-qom.h"
 
 /*
  * The main Q800 machine
@@ -32,6 +33,8 @@
 
 struct Q800MachineState {
     MachineState parent_obj;
+
+    M68kCPU cpu;
 };
 
 #define TYPE_Q800_MACHINE MACHINE_TYPE_NAME("q800")
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 062a3c6c7614..2b651de3c13b 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -364,7 +364,7 @@ static uint8_t fake_mac_rom[] = {
 
 static void q800_machine_init(MachineState *machine)
 {
-    M68kCPU *cpu = NULL;
+    Q800MachineState *m = Q800_MACHINE(machine);
     int linux_boot;
     int32_t kernel_size;
     uint64_t elf_entry;
@@ -407,8 +407,9 @@ static void q800_machine_init(MachineState *machine)
     }
 
     /* init CPUs */
-    cpu = M68K_CPU(cpu_create(machine->cpu_type));
-    qemu_register_reset(main_cpu_reset, cpu);
+    object_initialize_child(OBJECT(machine), "cpu", &m->cpu, machine->cpu_type);
+    qdev_realize(DEVICE(&m->cpu), NULL, &error_fatal);
+    qemu_register_reset(main_cpu_reset, &m->cpu);
 
     /* RAM */
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
@@ -430,7 +431,8 @@ static void q800_machine_init(MachineState *machine)
 
     /* IRQ Glue */
     glue = qdev_new(TYPE_GLUE);
-    object_property_set_link(OBJECT(glue), "cpu", OBJECT(cpu), &error_abort);
+    object_property_set_link(OBJECT(glue), "cpu", OBJECT(&m->cpu),
+                             &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(glue), &error_fatal);
 
     /* VIA 1 */
@@ -605,7 +607,7 @@ static void q800_machine_init(MachineState *machine)
 
     macfb_mode = (NUBUS_MACFB(dev)->macfb).mode;
 
-    cs = CPU(cpu);
+    cs = CPU(&m->cpu);
     if (linux_boot) {
         uint64_t high;
         void *param_blob, *param_ptr, *param_rng_seed;
@@ -735,6 +737,11 @@ static GlobalProperty hw_compat_q800[] = {
 };
 static const size_t hw_compat_q800_len = G_N_ELEMENTS(hw_compat_q800);
 
+static const char *q800_machine_valid_cpu_types[] = {
+    M68K_CPU_TYPE_NAME("m68040"),
+    NULL
+};
+
 static void q800_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -742,6 +749,7 @@ static void q800_machine_class_init(ObjectClass *oc, void *data)
     mc->desc = "Macintosh Quadra 800";
     mc->init = q800_machine_init;
     mc->default_cpu_type = M68K_CPU_TYPE_NAME("m68040");
+    mc->valid_cpu_types = q800_machine_valid_cpu_types;
     mc->max_cpus = 1;
     mc->block_default_type = IF_SCSI;
     mc->default_ram_id = "m68k_mac.ram";
-- 
2.40.1


