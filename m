Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBC0811261
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 14:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDOrr-0008Cw-Sd; Wed, 13 Dec 2023 08:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrL-00083r-Fu; Wed, 13 Dec 2023 08:01:13 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rDOrI-0006xD-CH; Wed, 13 Dec 2023 08:01:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E051D3B436;
 Wed, 13 Dec 2023 16:01:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 823E63C8C7;
 Wed, 13 Dec 2023 16:00:41 +0300 (MSK)
Received: (nullmailer pid 1024702 invoked by uid 1000);
 Wed, 13 Dec 2023 13:00:41 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Alexander Bulekov <alxndr@bu.edu>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.8 03/24] net: Provide MemReentrancyGuard * to
 qemu_new_nic()
Date: Wed, 13 Dec 2023 16:00:12 +0300
Message-Id: <20231213130041.1024630-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
References: <qemu-stable-7.2.8-20231213160018@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

Recently MemReentrancyGuard was added to DeviceState to record that the
device is engaging in I/O. The network device backend needs to update it
when delivering a packet to a device.

In preparation for such a change, add MemReentrancyGuard * as a
parameter of qemu_new_nic().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 7d0fefdf81f5973334c344f6b8e1896c309dff66)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup in hw/net/xen_nic.c due to lack of v8.1.0-2771-g25967ff69f
 "hw/xen: update Xen PV NIC to XenDevice model"
 and removed hw/net/igb.c bits)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index c3fed5fcbe..1a6a79f5ae 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -824,7 +824,8 @@ static void allwinner_sun8i_emac_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_allwinner_sun8i_emac_info, &s->conf,
-                           object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/allwinner_emac.c b/hw/net/allwinner_emac.c
index ddddf35c45..b3d73143bf 100644
--- a/hw/net/allwinner_emac.c
+++ b/hw/net/allwinner_emac.c
@@ -453,7 +453,8 @@ static void aw_emac_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_aw_emac_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     fifo8_create(&s->rx_fifo, RX_FIFO_SIZE);
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 24b3a0ff66..cb61a76417 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1633,7 +1633,8 @@ static void gem_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_gem_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
 
     if (s->jumbo_max_len > MAX_FRAME_SIZE) {
         error_setg(errp, "jumbo-max-len is greater than %d",
diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 45b954e46c..abfcc6f69f 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -943,7 +943,8 @@ static void dp8393x_realize(DeviceState *dev, Error **errp)
                           "dp8393x-regs", SONIC_REG_COUNT << s->it_shift);
 
     s->nic = qemu_new_nic(&net_dp83932_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->watchdog = timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 0dfdf47313..0a78ad3a58 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1735,7 +1735,8 @@ static void pci_e1000_realize(PCIDevice *pci_dev, Error **errp)
                                macaddr);
 
     d->nic = qemu_new_nic(&net_e1000_info, &d->conf,
-                          object_get_typename(OBJECT(d)), dev->id, d);
+                          object_get_typename(OBJECT(d)), dev->id,
+                          &dev->mem_reentrancy_guard, d);
 
     qemu_format_nic_info_str(qemu_get_queue(d->nic), macaddr);
 
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 7523e9f5d2..6573cc3cc3 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -319,7 +319,7 @@ e1000e_init_net_peer(E1000EState *s, PCIDevice *pci_dev, uint8_t *macaddr)
     int i;
 
     s->nic = qemu_new_nic(&net_e1000e_info, &s->conf,
-        object_get_typename(OBJECT(s)), dev->id, s);
+        object_get_typename(OBJECT(s)), dev->id, &dev->mem_reentrancy_guard, s);
 
     s->core.max_queue_num = s->conf.peers.queues ? s->conf.peers.queues - 1 : 0;
 
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index 679f52f80f..871d9a0950 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -1874,7 +1874,9 @@ static void e100_nic_realize(PCIDevice *pci_dev, Error **errp)
     nic_reset(s);
 
     s->nic = qemu_new_nic(&net_eepro100_info, &s->conf,
-                          object_get_typename(OBJECT(pci_dev)), pci_dev->qdev.id, s);
+                          object_get_typename(OBJECT(pci_dev)),
+                          pci_dev->qdev.id,
+                          &pci_dev->qdev.mem_reentrancy_guard, s);
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     TRACE(OTHER, logout("%s\n", qemu_get_queue(s->nic)->info_str));
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 1b82aec794..ba57a978d1 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -618,7 +618,8 @@ static void etraxfs_eth_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_etraxfs_info, &s->conf,
-                          object_get_typename(OBJECT(s)), dev->id, s);
+                          object_get_typename(OBJECT(s)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->phy.read = tdk_read;
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index b75d8e3dce..102ba69658 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -390,7 +390,8 @@ static void etsec_realize(DeviceState *dev, Error **errp)
     eTSEC        *etsec = ETSEC_COMMON(dev);
 
     etsec->nic = qemu_new_nic(&net_etsec_info, &etsec->conf,
-                              object_get_typename(OBJECT(dev)), dev->id, etsec);
+                              object_get_typename(OBJECT(dev)), dev->id,
+                              &dev->mem_reentrancy_guard, etsec);
     qemu_format_nic_info_str(qemu_get_queue(etsec->nic), etsec->conf.macaddr.a);
 
     etsec->ptimer = ptimer_init(etsec_timer_hit, etsec, PTIMER_POLICY_LEGACY);
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 83ef0a783e..346485ab49 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1118,7 +1118,8 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_ftgmac100_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index ec21e2699a..dc64246f75 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -743,7 +743,7 @@ void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInfo *info)
         qemu_macaddr_default_if_unset(&s->conf.macaddr);
     }
     s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)),
-                dev->id, s);
+                dev->id, &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     if (USE_TIMER) {
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 8c11b237de..7eb2fef626 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -1318,7 +1318,7 @@ static void imx_eth_realize(DeviceState *dev, Error **errp)
 
     s->nic = qemu_new_nic(&imx_eth_net_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
-                          dev->id, s);
+                          dev->id, &dev->mem_reentrancy_guard, s);
 
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index f1cba55967..00a6d82efb 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -1362,7 +1362,8 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_lan9118_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     s->eeprom[0] = 0xa5;
     for (i = 0; i < 6; i++) {
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 8aa27bd322..57dd49abea 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -643,7 +643,8 @@ static void mcf_fec_realize(DeviceState *dev, Error **errp)
     mcf_fec_state *s = MCF_FEC_NET(dev);
 
     s->nic = qemu_new_nic(&net_mcf_fec_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 2ade72dea0..8e925de867 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -255,7 +255,8 @@ static void mipsnet_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     s->nic = qemu_new_nic(&net_mipsnet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/msf2-emac.c b/hw/net/msf2-emac.c
index db3a04deb1..145a5e46ab 100644
--- a/hw/net/msf2-emac.c
+++ b/hw/net/msf2-emac.c
@@ -530,7 +530,8 @@ static void msf2_emac_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_msf2_emac_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/mv88w8618_eth.c b/hw/net/mv88w8618_eth.c
index ef30b0d4a6..2185f1131a 100644
--- a/hw/net/mv88w8618_eth.c
+++ b/hw/net/mv88w8618_eth.c
@@ -350,7 +350,8 @@ static void mv88w8618_eth_realize(DeviceState *dev, Error **errp)
 
     address_space_init(&s->dma_as, s->dma_mr, "emac-dma");
     s->nic = qemu_new_nic(&net_mv88w8618_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
 }
 
 static const VMStateDescription mv88w8618_eth_vmsd = {
diff --git a/hw/net/ne2000-isa.c b/hw/net/ne2000-isa.c
index 6ced6775ff..a79f7fad1f 100644
--- a/hw/net/ne2000-isa.c
+++ b/hw/net/ne2000-isa.c
@@ -74,7 +74,8 @@ static void isa_ne2000_realizefn(DeviceState *dev, Error **errp)
     ne2000_reset(s);
 
     s->nic = qemu_new_nic(&net_ne2000_isa_info, &s->c,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
diff --git a/hw/net/ne2000-pci.c b/hw/net/ne2000-pci.c
index 9e5d10859a..4f8a699081 100644
--- a/hw/net/ne2000-pci.c
+++ b/hw/net/ne2000-pci.c
@@ -71,7 +71,8 @@ static void pci_ne2000_realize(PCIDevice *pci_dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_ne2000_info, &s->c,
                           object_get_typename(OBJECT(pci_dev)),
-                          pci_dev->qdev.id, s);
+                          pci_dev->qdev.id,
+                          &pci_dev->qdev.mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
index 7c86bb52e5..4bb4e7147d 100644
--- a/hw/net/npcm7xx_emc.c
+++ b/hw/net/npcm7xx_emc.c
@@ -803,7 +803,8 @@ static void npcm7xx_emc_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&emc->conf.macaddr);
     emc->nic = qemu_new_nic(&net_npcm7xx_emc_info, &emc->conf,
-                            object_get_typename(OBJECT(dev)), dev->id, emc);
+                            object_get_typename(OBJECT(dev)), dev->id,
+                            &dev->mem_reentrancy_guard, emc);
     qemu_format_nic_info_str(qemu_get_queue(emc->nic), emc->conf.macaddr.a);
 }
 
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 0b3dc3146e..f96d6ea2cc 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -732,7 +732,8 @@ static void sysbus_open_eth_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
 
     s->nic = qemu_new_nic(&net_open_eth_info, &s->conf,
-                          object_get_typename(OBJECT(s)), dev->id, s);
+                          object_get_typename(OBJECT(s)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
 }
 
 static void qdev_open_eth_reset(DeviceState *dev)
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index e63e524913..56c3d14ad6 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1718,7 +1718,8 @@ void pcnet_common_init(DeviceState *dev, PCNetState *s, NetClientInfo *info)
     s->poll_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pcnet_poll_timer, s);
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
-    s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)), dev->id, s);
+    s->nic = qemu_new_nic(info, &s->conf, object_get_typename(OBJECT(dev)),
+                          dev->id, &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     /* Initialize the PROM */
diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index cbeed65bd5..0d21948ada 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -241,8 +241,8 @@ FpPort *fp_port_alloc(Rocker *r, char *sw_name,
     port->conf.bootindex = -1;
     port->conf.peers = *peers;
 
-    port->nic = qemu_new_nic(&fp_port_info, &port->conf,
-                             sw_name, NULL, port);
+    port->nic = qemu_new_nic(&fp_port_info, &port->conf, sw_name, NULL,
+                             &DEVICE(r)->mem_reentrancy_guard, port);
     qemu_format_nic_info_str(qemu_get_queue(port->nic),
                              port->conf.macaddr.a);
 
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index eb679d7c40..a4462af431 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3400,7 +3400,8 @@ static void pci_rtl8139_realize(PCIDevice *dev, Error **errp)
     s->eeprom.contents[9] = s->conf.macaddr.a[4] | s->conf.macaddr.a[5] << 8;
 
     s->nic = qemu_new_nic(&net_rtl8139_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), d->id, s);
+                          object_get_typename(OBJECT(dev)), d->id,
+                          &d->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->cplus_txbuffer = NULL;
diff --git a/hw/net/smc91c111.c b/hw/net/smc91c111.c
index ad778cd8fc..4eda971ef3 100644
--- a/hw/net/smc91c111.c
+++ b/hw/net/smc91c111.c
@@ -783,7 +783,8 @@ static void smc91c111_realize(DeviceState *dev, Error **errp)
     sysbus_init_irq(sbd, &s->irq);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_smc91c111_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     /* ??? Save/restore.  */
 }
diff --git a/hw/net/spapr_llan.c b/hw/net/spapr_llan.c
index a6876a936d..475d5f3a34 100644
--- a/hw/net/spapr_llan.c
+++ b/hw/net/spapr_llan.c
@@ -325,7 +325,8 @@ static void spapr_vlan_realize(SpaprVioDevice *sdev, Error **errp)
     memcpy(&dev->perm_mac.a, &dev->nicconf.macaddr.a, sizeof(dev->perm_mac.a));
 
     dev->nic = qemu_new_nic(&net_spapr_vlan_info, &dev->nicconf,
-                            object_get_typename(OBJECT(sdev)), sdev->qdev.id, dev);
+                            object_get_typename(OBJECT(sdev)), sdev->qdev.id,
+                            &sdev->qdev.mem_reentrancy_guard, dev);
     qemu_format_nic_info_str(qemu_get_queue(dev->nic), dev->nicconf.macaddr.a);
 
     dev->rxp_timer = timer_new_us(QEMU_CLOCK_VIRTUAL, spapr_vlan_flush_rx_queue,
diff --git a/hw/net/stellaris_enet.c b/hw/net/stellaris_enet.c
index 8dd60783d8..6768a6912f 100644
--- a/hw/net/stellaris_enet.c
+++ b/hw/net/stellaris_enet.c
@@ -492,7 +492,8 @@ static void stellaris_enet_realize(DeviceState *dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
     s->nic = qemu_new_nic(&net_stellaris_enet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index 3684a4d733..c12d44e9dc 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1361,7 +1361,7 @@ static void sungem_realize(PCIDevice *pci_dev, Error **errp)
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_sungem_info, &s->conf,
                           object_get_typename(OBJECT(dev)),
-                          dev->id, s);
+                          dev->id, &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic),
                              s->conf.macaddr.a);
 }
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index fc34905f87..fa98528d71 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -892,7 +892,8 @@ static void sunhme_realize(PCIDevice *pci_dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_sunhme_info, &s->conf,
-                          object_get_typename(OBJECT(d)), d->id, s);
+                          object_get_typename(OBJECT(d)), d->id,
+                          &d->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index c2b3b1bdfa..956093abd7 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -983,7 +983,8 @@ static void pci_tulip_realize(PCIDevice *pci_dev, Error **errp)
 
     s->nic = qemu_new_nic(&net_tulip_info, &s->c,
                           object_get_typename(OBJECT(pci_dev)),
-                          pci_dev->qdev.id, s);
+                          pci_dev->qdev.id,
+                          &pci_dev->qdev.mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->c.macaddr.a);
 }
 
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1b10cdc127..06f35ac2d8 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -3633,10 +3633,12 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
          * Happen when virtio_net_set_netclient_name has been called.
          */
         n->nic = qemu_new_nic(&net_virtio_info, &n->nic_conf,
-                              n->netclient_type, n->netclient_name, n);
+                              n->netclient_type, n->netclient_name,
+                              &dev->mem_reentrancy_guard, n);
     } else {
         n->nic = qemu_new_nic(&net_virtio_info, &n->nic_conf,
-                              object_get_typename(OBJECT(dev)), dev->id, n);
+                              object_get_typename(OBJECT(dev)), dev->id,
+                              &dev->mem_reentrancy_guard, n);
     }
 
     for (i = 0; i < n->max_queue_pairs; i++) {
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 399fc14129..e49b4a7a6c 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2083,7 +2083,7 @@ static void vmxnet3_net_init(VMXNET3State *s)
 
     s->nic = qemu_new_nic(&net_vmxnet3_info, &s->conf,
                           object_get_typename(OBJECT(s)),
-                          d->id, s);
+                          d->id, &d->mem_reentrancy_guard, s);
 
     s->peer_has_vhdr = vmxnet3_peer_has_vnet_hdr(s);
     s->tx_sop = true;
diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index 7d92c2d022..1014e84518 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -294,7 +294,8 @@ static int net_init(struct XenLegacyDevice *xendev)
     }
 
     netdev->nic = qemu_new_nic(&net_xen_info, &netdev->conf,
-                               "xen", NULL, netdev);
+                               "xen", NULL,
+                               &xendev->qdev.mem_reentrancy_guard, netdev);
 
     qemu_set_info_str(qemu_get_queue(netdev->nic),
                       "nic: xenbus vif macaddr=%s", netdev->mac);
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 0ab6ae91aa..1f4f277d84 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -402,7 +402,8 @@ static void xgmac_enet_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xgmac_enet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     s->regs[XGMAC_ADDR_HIGH(0)] = (s->conf.macaddr.a[5] << 8) |
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 990ff3a1c2..8a34243803 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -968,7 +968,8 @@ static void xilinx_enet_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_enet_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 
     tdk_init(&s->TEMAC.phy);
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 6e09f7e422..80cb869e22 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -235,7 +235,8 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
-                          object_get_typename(OBJECT(dev)), dev->id, s);
+                          object_get_typename(OBJECT(dev)), dev->id,
+                          &dev->mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
 }
 
diff --git a/hw/usb/dev-network.c b/hw/usb/dev-network.c
index 5fff487ee5..2c33e36cad 100644
--- a/hw/usb/dev-network.c
+++ b/hw/usb/dev-network.c
@@ -1386,7 +1386,8 @@ static void usb_net_realize(USBDevice *dev, Error **errp)
 
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
     s->nic = qemu_new_nic(&net_usbnet_info, &s->conf,
-                          object_get_typename(OBJECT(s)), s->dev.qdev.id, s);
+                          object_get_typename(OBJECT(s)), s->dev.qdev.id,
+                          &s->dev.qdev.mem_reentrancy_guard, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);
     snprintf(s->usbstring_mac, sizeof(s->usbstring_mac),
              "%02x%02x%02x%02x%02x%02x",
diff --git a/include/net/net.h b/include/net/net.h
index dc20b31e9f..4f1b702f00 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -151,6 +151,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
                        NICConf *conf,
                        const char *model,
                        const char *name,
+                       MemReentrancyGuard *reentrancy_guard,
                        void *opaque);
 void qemu_del_nic(NICState *nic);
 NetClientState *qemu_get_subqueue(NICState *nic, int queue_index);
diff --git a/net/net.c b/net/net.c
index 840ad9dca5..716a29f5a5 100644
--- a/net/net.c
+++ b/net/net.c
@@ -319,6 +319,7 @@ NICState *qemu_new_nic(NetClientInfo *info,
                        NICConf *conf,
                        const char *model,
                        const char *name,
+                       MemReentrancyGuard *reentrancy_guard,
                        void *opaque)
 {
     NetClientState **peers = conf->peers.ncs;
-- 
2.39.2


