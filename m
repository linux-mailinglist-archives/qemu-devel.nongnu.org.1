Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E50AA82797E
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 21:52:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwZp-0003tf-FU; Mon, 08 Jan 2024 15:50:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rMwZU-0003lT-Qn; Mon, 08 Jan 2024 15:50:10 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rMwZD-0000v8-01; Mon, 08 Jan 2024 15:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=VTf9ESChukN9XGyPv1okfNdkBAYcUSzB3fr/CmKEMJg=; b=oxKakwKRBbdR5JESrinxxOmqFA
 Uh3CtKH69drB5Jwx5km4eFlyxBZ2n+IJmxkkjaOtxQ2p9wf9U0KyaDV83bWby21kGOlDSVeyW9DhV
 IlE5c4yG0NDJwmH/bjD8An2Y9c2JSGNzhTQXbmbh1BjH6EwJDTlN/DzyTgb55y0ILF9LpaoWH8E0u
 WAoh9nQSv6Y9yorUFp5XIvYPV6hEDFNG2dAQz+lH5DwfuWz0dUz5jHO9/cY63pvIgrKtBBnZhnswQ
 zPxYrWp/7JCb+47++eSPtjqpZvLzzo2HRKmOIUv5Rx4/5ts5bVOANCoZbE0jsvShSUOM9dLh+GxYH
 VkybhKfQ==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1rMwYk-008RQ0-9s; Mon, 08 Jan 2024 20:49:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1rMwYk-002NG7-2q; Mon, 08 Jan 2024 20:49:22 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 30/46] hw/arm: use qemu_configure_nic_device()
Date: Mon,  8 Jan 2024 20:26:59 +0000
Message-ID: <20240108204909.564514-31-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108204909.564514-1-dwmw2@infradead.org>
References: <20240108204909.564514-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/arm/mps2-tz.c     |  8 ++------
 hw/arm/msf2-soc.c    |  6 +-----
 hw/arm/musicpal.c    |  3 +--
 hw/arm/xilinx_zynq.c | 11 ++++-------
 hw/arm/xlnx-versal.c |  7 +------
 hw/arm/xlnx-zynqmp.c |  8 +-------
 6 files changed, 10 insertions(+), 33 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 5d8cdc1a4c..a2d18afd79 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -503,14 +503,12 @@ static MemoryRegion *make_eth_dev(MPS2TZMachineState *mms, void *opaque,
                                   const PPCExtraData *extradata)
 {
     SysBusDevice *s;
-    NICInfo *nd = &nd_table[0];
 
     /* In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    qemu_check_nic_model(nd, "lan9118");
     mms->lan9118 = qdev_new(TYPE_LAN9118);
-    qdev_set_nic_properties(mms->lan9118, nd);
+    qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -528,7 +526,6 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * irqs[] is the ethernet IRQ.
      */
     SysBusDevice *s;
-    NICInfo *nd = &nd_table[0];
 
     memory_region_init(&mms->eth_usb_container, OBJECT(mms),
                        "mps2-tz-eth-usb-container", 0x200000);
@@ -537,9 +534,8 @@ static MemoryRegion *make_eth_usb(MPS2TZMachineState *mms, void *opaque,
      * In hardware this is a LAN9220; the LAN9118 is software compatible
      * except that it doesn't support the checksum-offload feature.
      */
-    qemu_check_nic_model(nd, "lan9118");
     mms->lan9118 = qdev_new(TYPE_LAN9118);
-    qdev_set_nic_properties(mms->lan9118, nd);
+    qemu_configure_nic_device(mms->lan9118, true, NULL);
 
     s = SYS_BUS_DEVICE(mms->lan9118);
     sysbus_realize_and_unref(s, &error_fatal);
diff --git a/hw/arm/msf2-soc.c b/hw/arm/msf2-soc.c
index b5fe9f364d..35bf1d64e1 100644
--- a/hw/arm/msf2-soc.c
+++ b/hw/arm/msf2-soc.c
@@ -197,12 +197,8 @@ static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
         g_free(bus_name);
     }
 
-    /* FIXME use qdev NIC properties instead of nd_table[] */
-    if (nd_table[0].used) {
-        qemu_check_nic_model(&nd_table[0], TYPE_MSS_EMAC);
-        qdev_set_nic_properties(DEVICE(&s->emac), &nd_table[0]);
-    }
     dev = DEVICE(&s->emac);
+    qemu_configure_nic_device(dev, true, NULL);
     object_property_set_link(OBJECT(&s->emac), "ahb-bus",
                              OBJECT(get_system_memory()), &error_abort);
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->emac), errp)) {
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 3200c9f68a..8781e99d27 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1286,9 +1286,8 @@ static void musicpal_init(MachineState *machine)
     }
     sysbus_create_simple(TYPE_MV88W8618_FLASHCFG, MP_FLASHCFG_BASE, NULL);
 
-    qemu_check_nic_model(&nd_table[0], "mv88w8618");
     dev = qdev_new(TYPE_MV88W8618_ETH);
-    qdev_set_nic_properties(dev, &nd_table[0]);
+    qemu_configure_nic_device(dev, true, "mv88w8618");
     object_property_set_link(OBJECT(dev), "dma-memory",
                              OBJECT(get_system_memory()), &error_fatal);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index dbb9793aa1..73a6472b91 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -108,16 +108,13 @@ static void zynq_write_board_setup(ARMCPU *cpu,
 
 static struct arm_boot_info zynq_binfo = {};
 
-static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
+static void gem_init(uint32_t base, qemu_irq irq)
 {
     DeviceState *dev;
     SysBusDevice *s;
 
     dev = qdev_new(TYPE_CADENCE_GEM);
-    if (nd->used) {
-        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
-        qdev_set_nic_properties(dev, nd);
-    }
+    qemu_configure_nic_device(dev, true, NULL);
     object_property_set_int(OBJECT(dev), "phy-addr", 7, &error_abort);
     s = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(s, &error_fatal);
@@ -279,8 +276,8 @@ static void zynq_init(MachineState *machine)
     sysbus_create_varargs("cadence_ttc", 0xF8002000,
             pic[69-IRQ_OFFSET], pic[70-IRQ_OFFSET], pic[71-IRQ_OFFSET], NULL);
 
-    gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
-    gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
+    gem_init(0xE000B000, pic[54 - IRQ_OFFSET]);
+    gem_init(0xE000C000, pic[77 - IRQ_OFFSET]);
 
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 9600551c44..01965ddf99 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -254,18 +254,13 @@ static void versal_create_gems(Versal *s, qemu_irq *pic)
         static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
         static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
         char *name = g_strdup_printf("gem%d", i);
-        NICInfo *nd = &nd_table[i];
         DeviceState *dev;
         MemoryRegion *mr;
 
         object_initialize_child(OBJECT(s), name, &s->lpd.iou.gem[i],
                                 TYPE_CADENCE_GEM);
         dev = DEVICE(&s->lpd.iou.gem[i]);
-        /* FIXME use qdev NIC properties instead of nd_table[] */
-        if (nd->used) {
-            qemu_check_nic_model(nd, "cadence_gem");
-            qdev_set_nic_properties(dev, nd);
-        }
+        qemu_configure_nic_device(dev, true, NULL);
         object_property_set_int(OBJECT(dev), "phy-addr", 23, &error_abort);
         object_property_set_int(OBJECT(dev), "num-priority-queues", 2,
                                 &error_abort);
diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 5905a33015..4f1714e4a1 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -616,13 +616,7 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
     }
 
     for (i = 0; i < XLNX_ZYNQMP_NUM_GEMS; i++) {
-        NICInfo *nd = &nd_table[i];
-
-        /* FIXME use qdev NIC properties instead of nd_table[] */
-        if (nd->used) {
-            qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
-            qdev_set_nic_properties(DEVICE(&s->gem[i]), nd);
-        }
+        qemu_configure_nic_device(DEVICE(&s->gem[i]), true, NULL);
         object_property_set_int(OBJECT(&s->gem[i]), "revision", GEM_REVISION,
                                 &error_abort);
         object_property_set_int(OBJECT(&s->gem[i]), "phy-addr", 23,
-- 
2.41.0


