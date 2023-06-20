Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C27E2737540
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhIc-0008Mo-6o; Tue, 20 Jun 2023 15:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7U-0004FL-PD
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:22 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qBf7S-0006ak-Bl
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 13:26:19 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5700e993f37so88806187b3.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 10:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687281963; x=1689873963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=98CA7lLEMGNe6uPK4y6DFRxPGjtanCJWers3tXfWNss=;
 b=KEm8u3HNoBCh8Ams4Jm2tWL53OKtDGJwom8MNIkGBbjFyRKdETs0gUtyzjnbbOF3G1
 Xa+tI/iyZQo9lwq9USajyGpYf1wYZybofbe/UkjBYoEYMXL0HbHRwtADK3sShnjNo5xP
 kWnqBi+teZkzKVeYEIgsjhBYoMgj35PI78Jepv6qQGK2uusG6nbH6whX7SpC6DF8dvFD
 xJufD86kFpaVt4jXpZLH2JNN11tdqPLrDfdmHIea+e5WkRTUlQeGUoH/hvihkeeRW+au
 9CgnkM/MK9YloaOW3PgAeWl35/y9BKZTNE7oizvLE1u6AXjbvIVk99ISPs1SPMf1PIT9
 rF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687281963; x=1689873963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=98CA7lLEMGNe6uPK4y6DFRxPGjtanCJWers3tXfWNss=;
 b=Z+A/yAaxIOlszZGmaCjEdM1gEKTg01aeUVRTFNE48pgA0q3L52QJIPAOJoJ1CkhEdq
 9b1vIljle2o082LhX/nrvAHFXy/buc2Er/iR0ER2PQAT/7Q+6eirSyjrWtqGXE2avaH9
 UB5qk/TktyXQRnGJW3OtwHbfLVHqrghpddjCYnE5E8bfCrTljhEr3yFXF7kGgJgEO9vb
 gm//bTW9zntU1tH7YE8XUEDhedxsGp2Rjz3/nM/HbH8DKAe+vj6Z15Mb3ZZs7UNKBQCZ
 0GPVKWGmEIigXIkilBGSHZZWdtmKRdhLw5uHPBP5gbZ334xLPZSIzX8vkT5FJf77X8uZ
 M3VA==
X-Gm-Message-State: AC+VfDw3qh/xkJ8U2fZZGCp9mMfIVuMTYdlK0JThvTeObqtuxK2z0xnf
 WF23LcGXMKltM/+qfnxMw+Sa47u9YffrAg==
X-Google-Smtp-Source: ACHHUZ69YM7F2vA3a9pNKFWNP3WhYpqVWfoyGnJ/AAIu8IB3hZHTSuwoPUpwwff1xnAyfLfaa/1QZg==
X-Received: by 2002:a0d:df02:0:b0:570:2542:cc9b with SMTP id
 i2-20020a0ddf02000000b005702542cc9bmr14317530ywe.18.1687281963091; 
 Tue, 20 Jun 2023 10:26:03 -0700 (PDT)
Received: from joel-Precision-7920-Tower.. ([24.53.71.1])
 by smtp.gmail.com with ESMTPSA id
 e65-20020a0dc244000000b0056cffe97a11sm604604ywd.13.2023.06.20.10.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 10:26:02 -0700 (PDT)
From: Joel Upham <jupham125@gmail.com>
To: qemu-devel@nongnu.org
Cc: Joel Upham <jupham125@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v1 04/23] q35/xen: Add Xen platform device support for Q35
Date: Tue, 20 Jun 2023 13:24:38 -0400
Message-Id: <46c76ae21764ee6747ee42642ee98d981f42db61.1687278381.git.jupham125@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1687278381.git.jupham125@gmail.com>
References: <cover.1687278381.git.jupham125@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=jupham125@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Jun 2023 15:45:55 -0400
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

Current Xen/QEMU method to control Xen Platform device on i440 is a bit
odd -- enabling/disabling Xen platform device actually modifies the QEMU
emulated machine type, namely xenfv <--> pc.

In order to avoid multiplying machine types, use a new way to control Xen
Platform device for QEMU -- "xen-platform-dev" machine property (bool).
To maintain backward compatibility with existing Xen/QEMU setups, this
is only applicable to q35 machine currently. i440 emulation still uses the
old method (i.e. xenfv/pc machine selection) to control Xen Platform
device, this may be changed later to xen-platform-dev property as well.

This way we can use a single machine type (q35) and change just
xen-platform-dev value to on/off to control Xen platform device.

Signed-off-by: Alexey Gerasimenko <x1917x@xxxxxxxxx>
Signed-off-by: Joel Upham <jupham125@gmail.com>
---
 hw/core/machine.c   | 19 +++++++++++++++++++
 hw/i386/pc_q35.c    | 20 +++++++++++++++++++-
 include/hw/boards.h |  1 +
 qemu-options.hx     |  1 +
 4 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1000406211..703138d2ec 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -455,6 +455,20 @@ static void machine_set_graphics(Object *obj, bool value, Error **errp)
     ms->enable_graphics = value;
 }
 
+static bool machine_get_xen_platform_dev(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->xen_platform_dev;
+}
+
+static void machine_set_xen_platform_dev(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->xen_platform_dev = value;
+}
+
 static char *machine_get_firmware(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1004,6 +1018,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "graphics",
         "Set on/off to enable/disable graphics emulation");
 
+    object_class_property_add_bool(oc, "xen-platform-dev",
+        machine_get_xen_platform_dev, machine_set_xen_platform_dev);
+    object_class_property_set_description(oc, "xen-platform-dev",
+        "Set on/off to enable/disable Xen Platform device");
+
     object_class_property_add_str(oc, "firmware",
         machine_get_firmware, machine_set_firmware);
     object_class_property_set_description(oc, "firmware",
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 6155427e48..789a23ce6b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -57,10 +57,24 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
+#include "hw/xen/xen-x86.h"
+#include "sysemu/xen.h"
 
 /* ICH9 AHCI has 6 ports */
 #define MAX_SATA_PORTS     6
 
+static void q35_xen_hvm_init(MachineState *machine)
+{
+    PCMachineState *pcms = PC_MACHINE(machine);
+
+    if (xen_enabled()) {
+        /* check if Xen Platform device is enabled */
+        if (machine->xen_platform_dev) {
+            pci_create_simple(pcms->bus, -1, "xen-platform");
+        }
+    }
+}
+
 struct ehci_companions {
     const char *name;
     int func;
@@ -273,8 +287,12 @@ static void pc_q35_init(MachineState *machine)
     for (i = 0; i < IOAPIC_NUM_PINS; i++) {
         qdev_connect_gpio_out_named(lpc_dev, ICH9_GPIO_GSI, i, x86ms->gsi[i]);
     }
-    isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
 
+    if (xen_enabled()) {
+        q35_xen_hvm_init(machine);
+    }
+
+    isa_bus = ISA_BUS(qdev_get_child_bus(lpc_dev, "isa.0"));
     if (x86ms->pic == ON_OFF_AUTO_ON || x86ms->pic == ON_OFF_AUTO_AUTO) {
         pc_i8259_create(isa_bus, gsi_state->i8259_irq);
     }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index a385010909..0b021f0764 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -339,6 +339,7 @@ struct MachineState {
     bool mem_merge;
     bool usb;
     bool usb_disabled;
+    bool xen_platform_dev;
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
diff --git a/qemu-options.hx b/qemu-options.hx
index b37eb9662b..ea018257da 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -30,6 +30,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
     "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
     "                mem-merge=on|off controls memory merge support (default: on)\n"
+    "                xen-platform-dev=on|off controls Xen Platform device (default=off)\n"
     "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
     "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
     "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
-- 
2.34.1


