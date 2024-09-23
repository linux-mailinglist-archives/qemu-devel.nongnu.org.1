Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1D97DDE9
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Sep 2024 18:45:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ss3DI-00009m-V0; Sat, 21 Sep 2024 12:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1ss3DG-00008W-65
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 12:44:02 -0400
Received: from mail-4317.proton.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@nikitashushura.com>)
 id 1ss3DE-0004zC-Hq
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 12:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nikitashushura.com;
 s=protonmail; t=1726937037; x=1727196237;
 bh=Xx6Js4iGgbGQOsO4T0rtRdX9oAdowWMajldiUEcOs1I=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=Peogg5oUTIw11PU05vCva3MaayO7Vs8E4ZpSJiLNd3D+lxeVs5fY9RvFA4asofZ1o
 YepyunmQ5jngvVnGEiSIkanwwvKe9cK/8tHV/wntYA0lWkd8FtOCkf+j9epZEUu8oA
 ey1lK3iqD8xR1l3tQPyjh9dCo63ywEAwh+wFVdYZCZ9zZJpS62XjrUrUlnuXuXt/Tf
 TlbY/+BKZKuZwiIHNzAPsfqJ+C5cjlP6HrDe+e1/2rQFRvEqo5ploPmjqzzgWfsnks
 A4eyNX+in2ATBvRu+PF9qESUI2aw+n9/7nKI5zOnSPieiMncH1h2jrUONK15Ic0vuE
 Bxc1165tymmiw==
Date: Sat, 21 Sep 2024 16:43:51 +0000
To: qemu-devel@nongnu.org
From: Nikita Shushura <me@nikitashushura.com>
Cc: Nikita Shushura <me@nikitashushura.com>,
 =?utf-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH v2 2/2] hw/sparc/leon3: add second uart with extended
 interrupt usage
Message-ID: <20240921164322.1883-2-me@nikitashushura.com>
In-Reply-To: <20240921164322.1883-1-me@nikitashushura.com>
References: <20240921164322.1883-1-me@nikitashushura.com>
Feedback-ID: 120968030:user:proton
X-Pm-Message-ID: 86ea7e2cf6d3bf7a698856e714fb3bb140424ed6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=me@nikitashushura.com;
 helo=mail-4317.proton.ch
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_FMBLA_NEWDOM=1.499, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Nikita Shushura <me@nikitashushura.com>
---
 hw/sparc/leon3.c | 63 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 6aaa04cb19..c559854e5e 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -54,10 +54,14 @@
 #define LEON3_PROM_OFFSET    (0x00000000)
 #define LEON3_RAM_OFFSET     (0x40000000)
=20
-#define MAX_CPUS  4
+#define MAX_CPUS  (4)
+#define LEON3_EIRQ (12)
=20
-#define LEON3_UART_OFFSET  (0x80000100)
-#define LEON3_UART_IRQ     (3)
+#define LEON3_UART0_OFFSET  (0x80000100)
+#define LEON3_UART0_IRQ     (2)
+
+#define LEON3_UART1_OFFSET  (0x80100100)
+#define LEON3_UART1_IRQ     (17)
=20
 #define LEON3_IRQMP_OFFSET (0x80000200)
=20
@@ -65,7 +69,8 @@
 #define LEON3_TIMER_IRQ    (6)
 #define LEON3_TIMER_COUNT  (2)
=20
-#define LEON3_APB_PNP_OFFSET (0x800FF000)
+#define LEON3_APB1_PNP_OFFSET (0x800FF000)
+#define LEON3_APB2_PNP_OFFSET (0x801FF000)
 #define LEON3_AHB_PNP_OFFSET (0xFFFFF000)
=20
 typedef struct ResetData {
@@ -122,7 +127,8 @@ static void write_bootloader(void *ptr, hwaddr kernel_a=
ddr)
=20
     /* Initialize the UARTs                                        */
     /* *UART_CONTROL =3D UART_RECEIVE_ENABLE | UART_TRANSMIT_ENABLE; */
-    p =3D gen_store_u32(p, 0x80000108, 3);
+    p =3D gen_store_u32(p, LEON3_UART0_OFFSET + 0x8, 3);
+    p =3D gen_store_u32(p, LEON3_UART1_OFFSET + 0x8, 3);
=20
     /* Initialize the TIMER 0                                      */
     /* *GPTIMER_SCALER_RELOAD =3D 40 - 1;                            */
@@ -271,7 +277,8 @@ static void leon3_generic_hw_init(MachineState *machine=
)
     DeviceState *dev, *irqmpdev;
     int i;
     AHBPnp *ahb_pnp;
-    APBPnp *apb_pnp;
+    APBPnp *apb1_pnp;
+    APBPnp *apb2_pnp;
=20
     reset_info =3D g_malloc0(sizeof(ResetData));
=20
@@ -298,10 +305,19 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
                             GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
                             GRLIB_CPU_AREA);
=20
-    apb_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb_pnp), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
-    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
+    /* Initialize APB1 */
+    apb1_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb1_pnp), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(apb1_pnp), 0, LEON3_APB1_PNP_OFFSET);
+    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB1_PNP_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
+                            GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
+
+    /* Initialize APB2 */
+    apb2_pnp =3D GRLIB_APB_PNP(qdev_new(TYPE_GRLIB_APB_PNP));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(apb2_pnp), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(apb2_pnp), 0, LEON3_APB2_PNP_OFFSET);
+    grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB2_PNP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_APBMST_DEV,
                             GRLIB_AHB_SLAVE, GRLIB_AHBMEM_AREA);
=20
@@ -309,6 +325,8 @@ static void leon3_generic_hw_init(MachineState *machine=
)
     irqmpdev =3D qdev_new(TYPE_GRLIB_IRQMP);
     object_property_set_int(OBJECT(irqmpdev), "ncpus", machine->smp.cpus,
                             &error_fatal);
+    /*object_property_set_int(OBJECT(irqmpdev), "eirq", LEON3_EIRQ,*/
+    /*                        &error_fatal);*/
     sysbus_realize_and_unref(SYS_BUS_DEVICE(irqmpdev), &error_fatal);
=20
     for (i =3D 0; i < machine->smp.cpus; i++) {
@@ -325,7 +343,7 @@ static void leon3_generic_hw_init(MachineState *machine=
)
     }
=20
     sysbus_mmio_map(SYS_BUS_DEVICE(irqmpdev), 0, LEON3_IRQMP_OFFSET);
-    grlib_apb_pnp_add_entry(apb_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
+    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_IRQMP_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_IRQMP_DEV,
                             2, 0, GRLIB_APBIO_AREA);
=20
@@ -417,20 +435,31 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
                            qdev_get_gpio_in(irqmpdev, LEON3_TIMER_IRQ + i)=
);
     }
=20
-    grlib_apb_pnp_add_entry(apb_pnp, LEON3_TIMER_OFFSET, 0xFFF,
+    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_TIMER_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_GPTIMER_DEV,
                             0, LEON3_TIMER_IRQ, GRLIB_APBIO_AREA);
=20
-    /* Allocate uart */
+    /* Allocate UART0 */
     dev =3D qdev_new(TYPE_GRLIB_APB_UART);
     qdev_prop_set_chr(dev, "chrdev", serial_hd(0));
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART_OFFSET);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART0_OFFSET);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                       qdev_get_gpio_in(irqmpdev, LEON3_UART0_IRQ));
+    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_UART0_OFFSET, 0xFFF,
+                            GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
+                            LEON3_UART0_IRQ, GRLIB_APBIO_AREA);
+
+    /* Allocate UART1 */
+    dev =3D qdev_new(TYPE_GRLIB_APB_UART);
+    qdev_prop_set_chr(dev, "chrdev", serial_hd(1));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, LEON3_UART1_OFFSET);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
-                       qdev_get_gpio_in(irqmpdev, LEON3_UART_IRQ));
-    grlib_apb_pnp_add_entry(apb_pnp, LEON3_UART_OFFSET, 0xFFF,
+                       qdev_get_gpio_in(irqmpdev, LEON3_UART1_IRQ));
+    grlib_apb_pnp_add_entry(apb1_pnp, LEON3_UART1_OFFSET, 0xFFF,
                             GRLIB_VENDOR_GAISLER, GRLIB_APBUART_DEV, 1,
-                            LEON3_UART_IRQ, GRLIB_APBIO_AREA);
+                            LEON3_UART1_IRQ, GRLIB_APBIO_AREA);
 }
=20
 static void leon3_generic_machine_init(MachineClass *mc)
--=20
2.46.1



