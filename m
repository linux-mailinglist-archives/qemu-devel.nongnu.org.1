Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 247BA7AAE86
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:45:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjciw-00022E-DZ; Fri, 22 Sep 2023 05:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcit-00021Q-Ha
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcip-00066h-Tr
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+/IzdcCqyhRDfnS7CuZQ6lu5gH9OTyud0DDd7vzUSw=;
 b=VICDDw688O28Jjn60rGndd2p2iqHjBFgo1rhX9s0vfpeC9jPfESf7mcDkkbxegvL8vEqpA
 jXpsTBVYHYSgyYMpUrpKcjRLl/7KaTE6YFdDm35rHe5UaOadFUe3Lg8+NfMe/DPxUl1hDM
 D6ex6nz3rjnFjhilmFusjLOWgILjgpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-Moo2DJadMneU6-G2jhs8pw-1; Fri, 22 Sep 2023 05:45:11 -0400
X-MC-Unique: Moo2DJadMneU6-G2jhs8pw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-404fa5c1d99so14921665e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375909; x=1695980709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f+/IzdcCqyhRDfnS7CuZQ6lu5gH9OTyud0DDd7vzUSw=;
 b=W+NRNxdbQ7JrVdu6g5831HEfiIgbZI6XBG/FxC4TXXBkUq34ufrmfh0MfTOMI+CU7k
 odK3WHLlEIU+KHc9s+WaxtRdRX2FMS6MSLZI9WLywoEE+SRzFLpVEAp2fCkxAbnBxtGA
 gqO8zotamWZYDGmfc2iwWlQueejEYqL9hS3V9jqjWs2vffLdzn95VaPwMdiuCZBwV+UU
 JxCXd+Bbxt/qxUMVpfWuUgTMNyHZFVoZoB/bCTydSlnaFOe8Q8eTGfnJNJ83hmk6ECzh
 vs4EHCjeqUX2/Pg8AbdcF3tPxKFgQslp7UEiFecOOeuxzG9/esQGu9bKjRNPk+6OpeM2
 R23Q==
X-Gm-Message-State: AOJu0YzIP3plXIF88GdSdl15kZ9EYxmXv/q7qS4fHALZCoTECRB5/52j
 7GvKrmhKZ43Fl77wUB4oYl8tAAKteeMe4Hfhl0y5mkatg8leVuv2mX2l9GuZKPe10SyCZwWy6A5
 uKK9SeIbSdWd4IVwVE+rqsCjVozax0T8N5ixrQgZZue8BqDL/GkXvIAOnmqH8CbmKp4hs19JR9O
 Y=
X-Received: by 2002:a1c:f204:0:b0:401:bf87:9898 with SMTP id
 s4-20020a1cf204000000b00401bf879898mr7649152wmc.25.1695375909400; 
 Fri, 22 Sep 2023 02:45:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuLOvLVzbQBY5sMDjo3AHbjVc9LlNXdSkfUefsQ3YBEs0yicRVfVBiTNtRl7cI8QkjSNzeWA==
X-Received: by 2002:a1c:f204:0:b0:401:bf87:9898 with SMTP id
 s4-20020a1cf204000000b00401bf879898mr7649128wmc.25.1695375908852; 
 Fri, 22 Sep 2023 02:45:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 t10-20020adff60a000000b0031c5e9c2ed7sm3969386wrp.92.2023.09.22.02.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:45:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com
Subject: [PATCH 4/9] hw/arm: Support machine-default audiodev with fallback
Date: Fri, 22 Sep 2023 11:44:54 +0200
Message-ID: <20230922094459.265509-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922094459.265509-1-pbonzini@redhat.com>
References: <20230922094459.265509-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Martin Kletzander <mkletzan@redhat.com>

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/integratorcp.c | 10 +++++++++-
 hw/arm/musicpal.c     | 11 +++++++++--
 hw/arm/nseries.c      |  4 ++++
 hw/arm/omap2.c        |  8 ++++++++
 hw/arm/palm.c         |  2 ++
 hw/arm/realview.c     | 11 +++++++++++
 hw/arm/spitz.c        | 12 +++++++++---
 hw/arm/versatilepb.c  |  7 +++++++
 hw/arm/vexpress.c     |  4 ++++
 hw/arm/xlnx-zcu102.c  |  5 +++++
 hw/arm/z2.c           | 14 +++++++++++++-
 hw/input/tsc210x.c    |  8 ++++++++
 12 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index b109ece3ae0..8b4f8a1a36a 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
+#include "audio/audio.h"
 
 #define TYPE_INTEGRATOR_CM "integrator_core"
 OBJECT_DECLARE_SIMPLE_TYPE(IntegratorCMState, INTEGRATOR_CM)
@@ -660,7 +661,12 @@ static void integratorcp_init(MachineState *machine)
                                &error_fatal);
     }
 
-    sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
+    dev = qdev_new("pl041");
+    qdev_prop_set_string(dev, "audiodev",
+                         audio_maybe_init_dummy("integrator.defaudio"));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x1d000000);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[25]);
 
     if (nd_table[0].used)
         smc91c111_init(&nd_table[0], 0xc8000000, pic[27]);
@@ -678,6 +684,8 @@ static void integratorcp_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "integrator.ram";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("integratorcp", integratorcp_machine_init)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index dc4e43e0ee2..05c3f621954 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -37,9 +37,9 @@
 #include "qemu/cutils.h"
 #include "qom/object.h"
 #include "hw/net/mv88w8618_eth.h"
+#include "audio/audio.h"
 #include "qemu/error-report.h"
 
-
 #define MP_MISC_BASE            0x80002000
 #define MP_MISC_SIZE            0x00001000
 
@@ -1326,7 +1326,12 @@ static void musicpal_init(MachineState *machine)
         qdev_connect_gpio_out(key_dev, i, qdev_get_gpio_in(dev, i + 15));
     }
 
-    wm8750_dev = i2c_slave_create_simple(i2c, TYPE_WM8750, MP_WM_ADDR);
+    wm8750_dev = i2c_slave_new(TYPE_WM8750, MP_WM_ADDR);
+
+    qdev_prop_set_string(DEVICE(wm8750_dev), "audiodev",
+                         audio_maybe_init_dummy("musicpal.defaudio"));
+    i2c_slave_realize_and_unref(wm8750_dev, i2c, &error_abort);
+
     dev = qdev_new(TYPE_MV88W8618_AUDIO);
     s = SYS_BUS_DEVICE(dev);
     object_property_set_link(OBJECT(dev), "wm8750", OBJECT(wm8750_dev),
@@ -1347,6 +1352,8 @@ static void musicpal_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_size = MP_RAM_DEFAULT_SIZE;
     mc->default_ram_id = "musicpal.ram";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("musicpal", musicpal_machine_init)
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 9e49e9e1776..35aff46b4b4 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1432,6 +1432,8 @@ static void n800_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo n800_type = {
@@ -1452,6 +1454,8 @@ static void n810_class_init(ObjectClass *oc, void *data)
     /* Actually two chips of 0x4000000 bytes each */
     mc->default_ram_size = 0x08000000;
     mc->default_ram_id = "omap2.dram";
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo n810_type = {
diff --git a/hw/arm/omap2.c b/hw/arm/omap2.c
index d5a2ae7af6e..8b65c0b8ad6 100644
--- a/hw/arm/omap2.c
+++ b/hw/arm/omap2.c
@@ -603,12 +603,20 @@ static struct omap_eac_s *omap_eac_init(struct omap_target_agent_s *ta,
                 qemu_irq irq, qemu_irq *drq, omap_clk fclk, omap_clk iclk)
 {
     struct omap_eac_s *s = g_new0(struct omap_eac_s, 1);
+    const char *audiodev_id = audio_maybe_init_dummy("eac.defaudio");
 
     s->irq = irq;
     s->codec.rxdrq = *drq ++;
     s->codec.txdrq = *drq;
     omap_eac_reset(s);
 
+    s->codec.card.name = g_strdup(audiodev_id);
+    s->codec.card.state = audio_state_by_name(s->codec.card.name);
+    if (!s->codec.card.state) {
+        error_setg(&error_fatal, "Cannot find audiodev with id '%s'",
+                   s->codec.card.name);
+    }
+
     AUD_register_card("OMAP EAC", &s->codec.card);
 
     memory_region_init_io(&s->iomem, NULL, &omap_eac_ops, s, "omap.eac",
diff --git a/hw/arm/palm.c b/hw/arm/palm.c
index 17c11ac4cec..b86f2c331bb 100644
--- a/hw/arm/palm.c
+++ b/hw/arm/palm.c
@@ -310,6 +310,8 @@ static void palmte_machine_init(MachineClass *mc)
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("ti925t");
     mc->default_ram_size = 0x02000000;
     mc->default_ram_id = "omap1.dram";
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("cheetah", palmte_machine_init)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index a5aa2f046ae..ad677dd4d81 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -29,6 +29,7 @@
 #include "hw/irq.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
+#include "audio/audio.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -207,6 +208,8 @@ static void realview_init(MachineState *machine,
 
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
+    qdev_prop_set_string(pl041, "audiodev",
+                         audio_maybe_init_dummy("realview.defaudio"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[19]);
@@ -412,6 +415,8 @@ static void realview_eb_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_SCSI;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo realview_eb_type = {
@@ -430,6 +435,8 @@ static void realview_eb_mpcore_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm11mpcore");
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo realview_eb_mpcore_type = {
@@ -446,6 +453,8 @@ static void realview_pb_a8_class_init(ObjectClass *oc, void *data)
     mc->init = realview_pb_a8_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo realview_pb_a8_type = {
@@ -463,6 +472,8 @@ static void realview_pbx_a9_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 4;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo realview_pbx_a9_type = {
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index f732fe0acf9..3620bb63ea9 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -35,6 +35,7 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "qom/object.h"
+#include "audio/audio.h"
 
 enum spitz_model_e { spitz, akita, borzoi, terrier };
 
@@ -779,10 +780,13 @@ static void spitz_i2c_setup(PXA2xxState *cpu)
     /* Attach the CPU on one end of our I2C bus.  */
     I2CBus *bus = pxa2xx_i2c_bus(cpu->i2c[0]);
 
-    DeviceState *wm;
-
     /* Attach a WM8750 to the bus */
-    wm = DEVICE(i2c_slave_create_simple(bus, TYPE_WM8750, 0));
+    I2CSlave *i2c_dev = i2c_slave_new(TYPE_WM8750, 0);
+    DeviceState *wm = DEVICE(i2c_dev);
+
+    qdev_prop_set_string(wm, "audiodev",
+                         audio_maybe_init_dummy("spitz.defaudio"));
+    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
 
     spitz_wm8750_addr(wm, 0, 0);
     qdev_connect_gpio_out(cpu->gpio, SPITZ_GPIO_WM,
@@ -1037,6 +1041,8 @@ static void spitz_common_class_init(ObjectClass *oc, void *data)
     mc->block_default_type = IF_IDE;
     mc->ignore_memory_transaction_failures = true;
     mc->init = spitz_common_init;
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo spitz_common_info = {
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 05b9462a5b7..d10008dbd78 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -26,6 +26,7 @@
 #include "hw/char/pl011.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
+#include "audio/audio.h"
 
 #define VERSATILE_FLASH_ADDR 0x34000000
 #define VERSATILE_FLASH_SIZE (64 * 1024 * 1024)
@@ -343,6 +344,8 @@ static void versatile_init(MachineState *machine, int board_id)
     /* Add PL041 AACI Interface to the LM4549 codec */
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
+    qdev_prop_set_string(pl041, "audiodev",
+                         audio_maybe_init_dummy("versatilepb.defaudio"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, 0x10004000);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, sic[24]);
@@ -416,6 +419,8 @@ static void versatilepb_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo versatilepb_type = {
@@ -434,6 +439,8 @@ static void versatileab_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("arm926");
     mc->default_ram_id = "versatile.ram";
+
+    machine_add_audiodev_property(mc);
 }
 
 static const TypeInfo versatileab_type = {
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 56abadd9b8b..4dde7cf631a 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -44,6 +44,7 @@
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/sd/sd.h"
 #include "qom/object.h"
+#include "audio/audio.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -613,6 +614,8 @@ static void vexpress_common_init(MachineState *machine)
 
     pl041 = qdev_new("pl041");
     qdev_prop_set_uint32(pl041, "nc_fifo_depth", 512);
+    qdev_prop_set_string(pl041, "audiodev",
+                         audio_maybe_init_dummy("vexpress.defaudio"));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(pl041), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(pl041), 0, map[VE_PL041]);
     sysbus_connect_irq(SYS_BUS_DEVICE(pl041), 0, pic[11]);
@@ -776,6 +779,7 @@ static void vexpress_class_init(ObjectClass *oc, void *data)
     mc->ignore_memory_transaction_failures = true;
     mc->default_ram_id = "vexpress.highmem";
 
+    machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", vexpress_get_secure,
                                    vexpress_set_secure);
     object_class_property_set_description(oc, "secure",
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 21483f75fd9..d7ca2867fea 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -24,6 +24,7 @@
 #include "sysemu/device_tree.h"
 #include "qom/object.h"
 #include "net/can_emu.h"
+#include "audio/audio.h"
 
 struct XlnxZCU102 {
     MachineState parent_obj;
@@ -143,6 +144,9 @@ static void xlnx_zcu102_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_XLNX_ZYNQMP);
 
+    qdev_prop_set_string(DEVICE(&s->soc.dp), "audiodev",
+                         audio_maybe_init_dummy("zcu102.defaudio"));
+
     object_property_set_link(OBJECT(&s->soc), "ddr-ram", OBJECT(machine->ram),
                              &error_abort);
     object_property_set_bool(OBJECT(&s->soc), "secure", s->secure,
@@ -275,6 +279,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = XLNX_ZYNQMP_NUM_APU_CPUS;
     mc->default_ram_id = "ddr-ram";
 
+    machine_add_audiodev_property(mc);
     object_class_property_add_bool(oc, "secure", zcu102_get_secure,
                                    zcu102_set_secure);
     object_class_property_set_description(oc, "secure",
diff --git a/hw/arm/z2.c b/hw/arm/z2.c
index dc25304290a..745f5bfad94 100644
--- a/hw/arm/z2.c
+++ b/hw/arm/z2.c
@@ -27,6 +27,7 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "qom/object.h"
+#include "qapi/error.h"
 
 #ifdef DEBUG_Z2
 #define DPRINTF(fmt, ...) \
@@ -307,6 +308,7 @@ static void z2_init(MachineState *machine)
     void *z2_lcd;
     I2CBus *bus;
     DeviceState *wm;
+    I2CSlave *i2c_dev;
 
     /* Setup CPU & memory */
     mpu = pxa270_init(z2_binfo.ram_size, machine->cpu_type);
@@ -328,8 +330,16 @@ static void z2_init(MachineState *machine)
     type_register_static(&aer915_info);
     z2_lcd = ssi_create_peripheral(mpu->ssp[1], TYPE_ZIPIT_LCD);
     bus = pxa2xx_i2c_bus(mpu->i2c[0]);
+
     i2c_slave_create_simple(bus, TYPE_AER915, 0x55);
-    wm = DEVICE(i2c_slave_create_simple(bus, TYPE_WM8750, 0x1b));
+
+    i2c_dev = i2c_slave_new(TYPE_WM8750, 0x1b);
+    wm = DEVICE(i2c_dev);
+
+    qdev_prop_set_string(wm, "audiodev",
+                         audio_maybe_init_dummy("z2.defaudio"));
+    i2c_slave_realize_and_unref(i2c_dev, bus, &error_abort);
+
     mpu->i2s->opaque = wm;
     mpu->i2s->codec_out = wm8750_dac_dat;
     mpu->i2s->codec_in = wm8750_adc_dat;
@@ -348,6 +358,8 @@ static void z2_machine_init(MachineClass *mc)
     mc->init = z2_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("pxa270-c5");
+
+    machine_add_audiodev_property(mc);
 }
 
 DEFINE_MACHINE("z2", z2_machine_init)
diff --git a/hw/input/tsc210x.c b/hw/input/tsc210x.c
index f568759e05a..08935424630 100644
--- a/hw/input/tsc210x.c
+++ b/hw/input/tsc210x.c
@@ -1097,6 +1097,14 @@ static void tsc210x_init(TSC210xState *s,
 
     qemu_add_mouse_event_handler(tsc210x_touchscreen_event, s, 1, name);
 
+    const char *audiodev_id = audio_maybe_init_dummy("tsc.defaudio");
+    s->card.name = g_strdup(audiodev_id);
+    s->card.state = audio_state_by_name(s->card.name);
+    if (!s->card.state) {
+        error_setg(&error_fatal, "Cannot find audiodev with id '%s'",
+                   s->card.name);
+    }
+
     AUD_register_card(s->name, &s->card);
 
     qemu_register_reset((void *) tsc210x_reset, s);
-- 
2.41.0


