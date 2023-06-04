Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDC3272174C
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:17:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nZr-0004xO-9Q; Sun, 04 Jun 2023 09:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZl-0004ww-KZ
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZj-0003CY-St
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uiA+iBrIUGwJgans3597z4RdyCllduP9PgIaDRs4FCY=; b=ISqYnIWLCb3jveLPAKx/82VQ3x
 IU+p1p10L9oUpS2qKL0724Gbb3BOqkc6R11FvJWOAYLuZ/9hbirQovOycQ+4+dOKrxEz31nqCWKNv
 s1dClSd6NjN4YoggKS8TbcKPswt1ICvNFu00OSWNliIFukjThC/egB+lxGBg8sjNXo4U5gboIzyjp
 Zvh8+aJtlTu+YYHpBqElUuhDhmmhHEROq+/DJ2V/KBiW3WhLLSnR72iIqv3A9d6e9ldkZcjp77yXk
 +LCRywJm41KXaKzOCQ16wyPG2a/m/RtXVWlnN0iMJik8RyMdB5Xa3K78kGW5lWPO7MQy4p+UrYXCN
 S5MkRYzls1YP6v8nJSOn3ffJw7Cb9JP0p1wH7WbpwSgkgl2728ty2h22SCBPtU0YdYfSLucpUiCGj
 7JrVXWbhGLFVYnfcQBRGp47Lciv90Vs1a58ik45JawOg/JL8lxFuu4AC5YSJ+SSd/jSzgnCaBEb2n
 MThBBNQjVFfmlNz7h7fyWZzTnlXbpqUPD3J5meJYpLd+9mpTZ9NhkUWL+ex+Um4mlr6NoiZm9Gw8w
 HdIp2Z1tSlzJ3VmXw8q/ZwqAz51CN4OxpWhxTH/zoO/doGm4w1VIOM54MRcqdEAZtJ4l9ceQ8LLt8
 psaKvwsP4nCPts0HMMt+Cj9bj5vZ7pUm9BA+lSv6c=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZY-0005pb-RC; Sun, 04 Jun 2023 14:15:08 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:32 +0100
Message-Id: <20230604131450.428797-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 05/23] q800: move CPU object into Q800MachineState
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

Also change the instantiation of the CPU to use object_initialize_child()
followed by a separate realisation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800.c         | 18 +++++++++++++-----
 include/hw/m68k/q800.h |  3 +++
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 3730b30dd1..d0ceb64b70 100644
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
+    object_property_set_bool(OBJECT(&m->cpu), "realized", true, &error_fatal);
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
diff --git a/include/hw/m68k/q800.h b/include/hw/m68k/q800.h
index f3bc17aa1b..4cb1a51dfe 100644
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
-- 
2.30.2


