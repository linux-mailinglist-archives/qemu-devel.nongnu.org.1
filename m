Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8039B54A4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Oct 2024 22:01:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5tJP-0003qd-2B; Tue, 29 Oct 2024 16:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5tJL-0003n6-2W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:59:31 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1t5tJI-0005eL-Ry
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 16:59:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so6460077a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1730235567; x=1730840367;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGTfcMFROhRF5TfeOW9h6tbzA4u4/LIcLKv/vv91UVY=;
 b=nfcnJeTXLO8azf1qoYx8mfkI0tZQEZb+v48eqfmLwji9AEz8L0v3TIRlFPOaIz3vLU
 b9A04PDG96ytOjKLzEZ5TpGX2nS5+1wKeggmdxWCtC0HFH1hqFVFleDVU4ngAbvVcYqQ
 F9XmPiXIfwQ8Qd9QG2DcmCfUhmnBx85FBwAAHj4n+eNb/aRGcBAY71wlHxVww/SBHNYY
 Ux540TZWYT5nVhBqT9BJAJ3nqq9yEgH6j576scakE5IvX/r2oT/HelOA0tlbbq7LV7Tm
 zh/L7pOY50RgzxhPP3ro2L25kCtBss+MhWGwnmxqmeYVB9UJOAn3Dae1qeBxci9txfds
 hygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730235567; x=1730840367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGTfcMFROhRF5TfeOW9h6tbzA4u4/LIcLKv/vv91UVY=;
 b=IHadRmM1NTx7mrl0QDmNye84MqfkUbil6wdOi2K+03RV8Mw4Kz0gEzB6w0I/hqH/pZ
 /VGFme/+rOCe3BZFiifgu65rttrucmJXMMSD+/zHR/lPH0ej4hEFwAAOxUdxmi+Luk2o
 fiA9rRf9de/Wa0zjlvmujH3ULn9tX8hkNtvlQq+0bLG0KchNtB0DfvNulKs2a0/x2e7F
 zcfGDrcdalw98+EhZ91IrtrVSgZxnq0CYQoaAF0neKJgyjL2ITMZPl6DrTgZMioUUDjO
 Es8n/ipjEuaoTq6+AG+WK3Xh+HHJXWHEVegiPvDJoer9d9aea51KKS+Xq7XU5H9ZKqSg
 /yiA==
X-Gm-Message-State: AOJu0YyxQ8rmRZsgvtuNSZ41cfVsZFABs77z1ZGuWdgqGcnKN6jdkWIH
 BxRcUJb9i401Lcsnkz45V7PdZKiXrdgYPQCjB9yLR5gMoHTza75pJoMxSK8yxo7HdptEiiFsTKt
 zgA==
X-Google-Smtp-Source: AGHT+IHAX0+HZfz8E3gdRcRkmEoMFuskx4hxlVwYP7iAR9G8HRhwx2RrBy3QxhIwgoIN8Zug/pQg0Q==
X-Received: by 2002:a05:6402:268a:b0:5c9:76b6:d14e with SMTP id
 4fb4d7f45d1cf-5cbbf8ca0dfmr11606869a12.16.1730235567113; 
 Tue, 29 Oct 2024 13:59:27 -0700 (PDT)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb629d5besm4217341a12.33.2024.10.29.13.58.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Oct 2024 13:59:03 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 marcin.juszkiewicz@linaro.org, stefanha@redhat.com, mst@redhat.com,
 slp@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, Alexander Graf <graf@amazon.com>
Subject: [PATCH v5 09/15] gpex: Allow more than 4 legacy IRQs
Date: Tue, 29 Oct 2024 21:58:13 +0100
Message-Id: <20241029205819.69888-10-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20241029205819.69888-1-phil@philjordan.eu>
References: <20241029205819.69888-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::533;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x533.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Some boards such as vmapple don't do real legacy PCI IRQ swizzling.
Instead, they just keep allocating more board IRQ lines for each new
legacy IRQ. Let's support that mode by giving instantiators a new
"nr_irqs" property they can use to support more than 4 legacy IRQ lines.
In this mode, GPEX will export more IRQ lines, one for each device.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v4:

 * Turned pair of IRQ arrays into array of structs.
 * Simplified swizzling logic selection.

 hw/arm/sbsa-ref.c          |  2 +-
 hw/arm/virt.c              |  2 +-
 hw/i386/microvm.c          |  2 +-
 hw/loongarch/virt.c        |  2 +-
 hw/mips/loongson3_virt.c   |  2 +-
 hw/openrisc/virt.c         | 12 +++++------
 hw/pci-host/gpex.c         | 43 ++++++++++++++++++++++++++++++--------
 hw/riscv/virt.c            | 12 +++++------
 hw/xtensa/virt.c           |  2 +-
 include/hw/pci-host/gpex.h |  7 +++----
 10 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e3195d54497..7e7322486c2 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -673,7 +673,7 @@ static void create_pcie(SBSAMachineState *sms)
     /* Map IO port space */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(sms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b2b991d978..bd3b17be2ea 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1547,7 +1547,7 @@ static void create_pcie(VirtMachineState *vms)
     /* Map IO port space */
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, base_pio);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            qdev_get_gpio_in(vms->gic, irq + i));
         gpex_set_irq_num(GPEX_HOST(dev), i, irq + i);
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 693099f2256..b3a348bee09 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -139,7 +139,7 @@ static void create_gpex(MicrovmMachineState *mms)
                                     mms->gpex.mmio64.base, mmio64_alias);
     }
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i,
                            x86ms->gsi[mms->gpex.irq + i]);
     }
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 9a635d1d3d3..50056384994 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -741,7 +741,7 @@ static void virt_devices_init(DeviceState *pch_pic,
     memory_region_add_subregion(get_system_memory(), VIRT_PCI_IO_BASE,
                                 pio_alias);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         sysbus_connect_irq(d, i,
                            qdev_get_gpio_in(pch_pic, 16 + i));
         gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index f3b6326cc59..884b5f23a99 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -458,7 +458,7 @@ static inline void loongson3_virt_devices_init(MachineState *machine,
                                 virt_memmap[VIRT_PCIE_PIO].base, s->pio_alias);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, virt_memmap[VIRT_PCIE_PIO].base);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         irq = qdev_get_gpio_in(pic, PCIE_IRQ_BASE + i);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
         gpex_set_irq_num(GPEX_HOST(dev), i, PCIE_IRQ_BASE + i);
diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
index 47d2c9bd3c7..6f053bf48e0 100644
--- a/hw/openrisc/virt.c
+++ b/hw/openrisc/virt.c
@@ -318,7 +318,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
 {
     int pin, dev;
     uint32_t irq_map_stride = 0;
-    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS * 6] = {};
+    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 6] = {};
     uint32_t *irq_map = full_irq_map;
 
     /*
@@ -330,11 +330,11 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
      * possible slot) seeing the interrupt-map-mask will allow the table
      * to wrap to any number of devices.
      */
-    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
+    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
         int devfn = dev << 3;
 
-        for (pin = 0; pin < GPEX_NUM_IRQS; pin++) {
-            int irq_nr = irq_base + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
+            int irq_nr = irq_base + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int i = 0;
 
             /* Fill PCI address cells */
@@ -357,7 +357,7 @@ static void create_pcie_irq_map(void *fdt, char *nodename, int irq_base,
     }
 
     qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
-                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
+                     PCI_NUM_PINS * PCI_NUM_PINS *
                      irq_map_stride * sizeof(uint32_t));
 
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
@@ -409,7 +409,7 @@ static void openrisc_virt_pcie_init(OR1KVirtState *state,
     memory_region_add_subregion(get_system_memory(), pio_base, alias);
 
     /* Connect IRQ lines. */
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         pcie_irq = get_per_cpu_irq(cpus, num_cpus, irq_base + i);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, pcie_irq);
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf52..cd63aa2d3cf 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -32,6 +32,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/irq.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
@@ -41,20 +42,25 @@
  * GPEX host
  */
 
+struct GPEXIrq {
+    qemu_irq irq;
+    int irq_num;
+};
+
 static void gpex_set_irq(void *opaque, int irq_num, int level)
 {
     GPEXHost *s = opaque;
 
-    qemu_set_irq(s->irq[irq_num], level);
+    qemu_set_irq(s->irq[irq_num].irq, level);
 }
 
 int gpex_set_irq_num(GPEXHost *s, int index, int gsi)
 {
-    if (index >= GPEX_NUM_IRQS) {
+    if (index >= s->num_irqs) {
         return -EINVAL;
     }
 
-    s->irq_num[index] = gsi;
+    s->irq[index].irq_num = gsi;
     return 0;
 }
 
@@ -62,7 +68,7 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
 {
     PCIINTxRoute route;
     GPEXHost *s = opaque;
-    int gsi = s->irq_num[pin];
+    int gsi = s->irq[pin].irq_num;
 
     route.irq = gsi;
     if (gsi < 0) {
@@ -74,6 +80,13 @@ static PCIINTxRoute gpex_route_intx_pin_to_irq(void *opaque, int pin)
     return route;
 }
 
+static int gpex_swizzle_map_irq_fn(PCIDevice *pci_dev, int pin)
+{
+    PCIBus *bus = pci_device_root_bus(pci_dev);
+
+    return (PCI_SLOT(pci_dev->devfn) + pin) % bus->nirq;
+}
+
 static void gpex_host_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *pci = PCI_HOST_BRIDGE(dev);
@@ -82,6 +95,8 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
     PCIExpressHost *pex = PCIE_HOST_BRIDGE(dev);
     int i;
 
+    s->irq = g_malloc0_n(s->num_irqs, sizeof(*s->irq));
+
     pcie_host_mmcfg_init(pex, PCIE_MMCFG_SIZE_MAX);
     sysbus_init_mmio(sbd, &pex->mmio);
 
@@ -128,19 +143,27 @@ static void gpex_host_realize(DeviceState *dev, Error **errp)
         sysbus_init_mmio(sbd, &s->io_ioport);
     }
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
-        sysbus_init_irq(sbd, &s->irq[i]);
-        s->irq_num[i] = -1;
+    for (i = 0; i < s->num_irqs; i++) {
+        sysbus_init_irq(sbd, &s->irq[i].irq);
+        s->irq[i].irq_num = -1;
     }
 
     pci->bus = pci_register_root_bus(dev, "pcie.0", gpex_set_irq,
-                                     pci_swizzle_map_irq_fn, s, &s->io_mmio,
-                                     &s->io_ioport, 0, 4, TYPE_PCIE_BUS);
+                                     gpex_swizzle_map_irq_fn,
+                                     s, &s->io_mmio, &s->io_ioport, 0,
+                                     s->num_irqs, TYPE_PCIE_BUS);
 
     pci_bus_set_route_irq_fn(pci->bus, gpex_route_intx_pin_to_irq);
     qdev_realize(DEVICE(&s->gpex_root), BUS(pci->bus), &error_fatal);
 }
 
+static void gpex_host_unrealize(DeviceState *dev)
+{
+    GPEXHost *s = GPEX_HOST(dev);
+
+    g_free(s->irq);
+}
+
 static const char *gpex_host_root_bus_path(PCIHostState *host_bridge,
                                           PCIBus *rootbus)
 {
@@ -166,6 +189,7 @@ static Property gpex_host_properties[] = {
                        gpex_cfg.mmio64.base, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
                      gpex_cfg.mmio64.size, 0),
+    DEFINE_PROP_UINT8("num-irqs", GPEXHost, num_irqs, PCI_NUM_PINS),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -176,6 +200,7 @@ static void gpex_host_class_init(ObjectClass *klass, void *data)
 
     hc->root_bus_path = gpex_host_root_bus_path;
     dc->realize = gpex_host_realize;
+    dc->unrealize = gpex_host_unrealize;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "pci";
     device_class_set_props(dc, gpex_host_properties);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ee3129f3b31..08832dc2359 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -167,7 +167,7 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
 {
     int pin, dev;
     uint32_t irq_map_stride = 0;
-    uint32_t full_irq_map[GPEX_NUM_IRQS * GPEX_NUM_IRQS *
+    uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS *
                           FDT_MAX_INT_MAP_WIDTH] = {};
     uint32_t *irq_map = full_irq_map;
 
@@ -179,11 +179,11 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
      * possible slot) seeing the interrupt-map-mask will allow the table
      * to wrap to any number of devices.
      */
-    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
+    for (dev = 0; dev < PCI_NUM_PINS; dev++) {
         int devfn = dev * 0x8;
 
-        for (pin = 0; pin < GPEX_NUM_IRQS; pin++) {
-            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
+        for (pin = 0; pin < PCI_NUM_PINS; pin++) {
+            int irq_nr = PCIE_IRQ + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
             int i = 0;
 
             /* Fill PCI address cells */
@@ -209,7 +209,7 @@ static void create_pcie_irq_map(RISCVVirtState *s, void *fdt, char *nodename,
     }
 
     qemu_fdt_setprop(fdt, nodename, "interrupt-map", full_irq_map,
-                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
+                     PCI_NUM_PINS * PCI_NUM_PINS *
                      irq_map_stride * sizeof(uint32_t));
 
     qemu_fdt_setprop_cells(fdt, nodename, "interrupt-map-mask",
@@ -1157,7 +1157,7 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
 
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 2, pio_base);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         irq = qdev_get_gpio_in(irqchip, PCIE_IRQ + i);
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, irq);
diff --git a/hw/xtensa/virt.c b/hw/xtensa/virt.c
index 5310a888613..8f5c2009d29 100644
--- a/hw/xtensa/virt.c
+++ b/hw/xtensa/virt.c
@@ -93,7 +93,7 @@ static void create_pcie(MachineState *ms, CPUXtensaState *env, int irq_base,
     /* Connect IRQ lines. */
     extints = xtensa_get_extints(env);
 
-    for (i = 0; i < GPEX_NUM_IRQS; i++) {
+    for (i = 0; i < PCI_NUM_PINS; i++) {
         void *q = extints[irq_base + i];
 
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), i, q);
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index dce883573ba..84471533af0 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -32,8 +32,6 @@ OBJECT_DECLARE_SIMPLE_TYPE(GPEXHost, GPEX_HOST)
 #define TYPE_GPEX_ROOT_DEVICE "gpex-root"
 OBJECT_DECLARE_SIMPLE_TYPE(GPEXRootState, GPEX_ROOT_DEVICE)
 
-#define GPEX_NUM_IRQS 4
-
 struct GPEXRootState {
     /*< private >*/
     PCIDevice parent_obj;
@@ -49,6 +47,7 @@ struct GPEXConfig {
     PCIBus      *bus;
 };
 
+typedef struct GPEXIrq GPEXIrq;
 struct GPEXHost {
     /*< private >*/
     PCIExpressHost parent_obj;
@@ -60,8 +59,8 @@ struct GPEXHost {
     MemoryRegion io_mmio;
     MemoryRegion io_ioport_window;
     MemoryRegion io_mmio_window;
-    qemu_irq irq[GPEX_NUM_IRQS];
-    int irq_num[GPEX_NUM_IRQS];
+    GPEXIrq *irq;
+    uint8_t num_irqs;
 
     bool allow_unmapped_accesses;
 
-- 
2.39.3 (Apple Git-145)


